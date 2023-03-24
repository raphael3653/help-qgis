# -*- coding: utf-8 -*-
"""
/***************************************************************************
 DsgTools
                                 A QGIS plugin
 Brazilian Army Cartographic Production Tools
                              -------------------
        begin                : 2018-11-13
        git sha              : $Format:%H$
        copyright            : (C) 2018 by João P. Esperidião - Cartographic Engineer @ Brazilian Army
        email                : esperidiao.joao@eb.mil.br
 ***************************************************************************/

/***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 ***************************************************************************/
"""
import os, collections
import time

from qgis.PyQt.QtCore import QObject, pyqtSignal, QSettings
from qgis.core import QgsFeatureRequest, QgsProject, QgsProcessingContext, \
                      QgsProcessingMultiStepFeedback, QgsProcessingMultiStepFeedback, \
                      QgsTask, QgsProcessingFeedback

from DsgTools.core.dsgEnums import DsgEnums
from DsgTools.core.Factories.DbFactory.dbFactory import DbFactory
from DsgTools.core.Factories.LayerLoaderFactory.layerLoaderFactory import LayerLoaderFactory
from DsgTools.core.GeometricTools.layerHandler import LayerHandler
from DsgTools.core.GeometricTools.featureHandler import FeatureHandler
from DsgTools.core.Factories.DbCreatorFactory.dbCreatorFactory import DbCreatorFactory

class DbConverter(QgsTask):
    conversionUpdated = pyqtSignal(str)
    conversionFinished = pyqtSignal()
    """
    Class designed to manipulate the map generated by the Datasource Conversion tool.
    What it should be doing:
    1- read map;
    2- get layers ready;
        * in this step, layers are just supposed to be read, no filters applied, in order to be reused, if needed.
    3- prepare each conversion as 1 separately;
        3.a- apply filters for each layer - layer level;
        3.b- apply feature map to destination - feature level; and
    4- each successfully filtered and mapped layer will be then sent to be perpetuated to output - layer level.
    """
    def __init__(self, iface, conversionMap=None, description='', flags=QgsTask.CanCancel):
        """
        Class constructor.
        :param iface: (QgsInterface) QGIS interface object (for runtime operations).
        :param conversionMap: (dict) conversion map generated by Datasource Conversion tool.
        """
        super(DbConverter, self).__init__(description, flags)
        self.iface = iface
        self.conversionMap = conversionMap
        self.coordinateTransformers = {}
        self.output = {
            'creationErrors' : {},
            'successfulLayers' : {},
            'failedLayers' : {},
            'status' : False,
            'log' : ''
        }
        self.feedback = QgsProcessingFeedback()
        self.feedback.progressChanged.connect(self.setProgress)
        self.feedback.canceled.connect(self.cancel)

    def getConversionCount(self, conversionMap=None):
        """
        Gets how many conversion procedures are required.
        :param conversionMap: (dict) conversion map generated by Datasource Conversion tool.
        :return: (int) number of conversion cycles.
        """
        if conversionMap is None:
            conversionMap = self.conversionMap
        count = 0
        for outMaps in conversionMap.values():
            count += len(outMaps)
        return count

    def getAllUniqueInputDb(self, conversionMap=None):
        """
        Get a list of all UNIQUE input datasources.
        :param conversionMap: (dict) conversion map generated by Datasource Conversion tool.
        :return: (list-of-str) list of all input connections necessary.
        """
        if conversionMap is None:
            conversionMap = self.conversionMap
        dsList = []
        for ds in conversionMap:
            # datasources are key to conversion map dict
            if ds not in dsList:
                dsList.append(ds)
        return dsList

    def getAllUniqueOutputDb(self, conversionMap=None):
        """
        Get a list of all UNIQUE output datasources.
        :param conversionMap: (dict) conversion map generated by Datasource Conversion tool.
        :return: (list-of-str) list of all output connections necessary.
        """
        if conversionMap is None:
            conversionMap = self.conversionMap
        dsList = []
        for ds, convMaps in conversionMap.items():
            # datasources are key to conversion map dict
            for convMap in convMaps:
                ds = convMap['outDs']
                if ds not in dsList:
                    dsList.append(ds)
        return dsList

    def getDefaultPgDb(self, hostName):
        """
        Gets a standard PostGIS database object from a given host.
        :param hostName: (str) host name.
        :return: (AbstractDb) PostGIS database object.
        """
        abstractDb = DbFactory().createDbFactory(driver=DsgEnums.DriverPostGIS)
        (host, port, user, password) = abstractDb.getServerConfiguration(hostName)
        abstractDb.connectDatabaseWithParameters(host, port, 'postgres', user, password)
        return abstractDb

    def createDataset(self, parameters):
        """
        Creates a dataset from a set of parameters.
        :param parameters: (dict) dict with all necessary parameters for a supported drivers.
        """
        if self.connectToDb(parameters=parameters) is not None:
            raise Exception(self.tr("Dataset {0} already exists.").format(parameters["db"]))
        driverName, createParam = {
            DsgEnums.DriverPostGIS : lambda : ("QPSQL", self.getDefaultPgDb(parameters['host'])),
            DsgEnums.DriverSpatiaLite : lambda : ("QSQLITE", os.path.dirname(parameters["path"])),
            DsgEnums.DriverGeopackage : lambda : ("GPKG", os.path.dirname(parameters["path"])),
            DsgEnums.DriverShapefile : lambda : ("SHP", parameters["path"])
        }[parameters['driver']]()
        dbCreator = DbCreatorFactory().createDbCreatorFactory(driverName=driverName, createParam=createParam)
        return dbCreator.createDb(
                    dbName=parameters['db'],
                    srid=parameters['srid'],
                    paramDict=parameters,
                    parentWidget=None
                )

    def checkAndCreateDataset(self, conversionStepMap):
        """
        Checks conversion map for dataset creation necessity and creates it.
        :param conversionStepMap: (dict) conversion step map.
        :return: (tuple) new dataset (or None if failed) and failing message (empty, if successful).
        """
        output = conversionStepMap["outDs"]
        abstractDb = None
        try:
            parameters = self.parseDatasourcePath(datasource=output)
            # filling missing parameters as required by dbCreator
            parameters['srid'] = conversionStepMap['crs'].split(":")[-1]
            parameters['isTemplateEdgv'] = True
            parameters['version'], parameters['templateName'] = {
                "EDGV 2.1.3" : ("2.1.3", 'template_edgv_213'),
                "EDGV 2.1.3 F Ter" : ("FTer_2a_Ed", 'template_edgv_fter_2a_ed'),
                "EDGV 2.1.3 Pro" : ("2.1.3 Pro", 'template_edgv_213_pro'),
                "EDGV 3.0" : ("3.0", 'template_edgv_3')
                # "EDGV 3.0 Pro" : ("3.0", 'template_edgv_3_pro')
            }[conversionStepMap['edgv']]
            if 'path' in parameters:
                parameters['db'] = os.path.basename(os.path.splitext(parameters['path'])[0])
            abstractDb = self.createDataset(parameters=parameters)
            msg = ""
        except Exception as e:
            if abstractDb is not None:
                abstractDb.closeDatabase()
                abstractDb = None
            msg = "{0} dataset creation has failed: '{1}'".format(output, "; ".join(map(str, e.args)))
        return abstractDb, msg

    def getPgParamaters(self, parameters, conn):
        """
        Retrieves Postgres connection parameters from its connection string.
        :param parameters: (dict) parameter dict to have data saved at.
        :param conn: (str) connection string.
        """
        # connection string: USER@HOST:PORT.DATABASE
        parameters['username'], part = conn.split('@')
        parameters['host'], part = part.split(':')
        parameters['port'], parameters['db'] = part.split('.')

    def parseDatasourcePath(self, datasource):
        """
        Reads and identifies datasource's driver and separates it into connection parameters.
        :param datasouce: (str) datasource path string.
        :return: (dict) a dict containing all connection parameters.
        """
        drivers = {
            'pg' : DsgEnums.DriverPostGIS,
            'sqlite' : DsgEnums.DriverSpatiaLite,
            'shp' : DsgEnums.DriverShapefile,
            'gpkg' : DsgEnums.DriverGeopackage
            }
        parameters = dict()
        driver = datasource.split(':')[0]
        conn = datasource[len(driver) + 1:]
        if driver == 'pg':
            self.getPgParamaters(parameters=parameters, conn=conn)
        else:
            parameters['path'] = conn
        parameters['driver'] = drivers[driver]
        return parameters

    def userPasswordFromHost(self, hostname, username):
        """
        Gets the password of an user to a server from its name. 
        """
        settings = QSettings()
        settings.beginGroup('PostgreSQL/servers')
        connections = settings.childGroups()
        settings.endGroup()
        for connection in connections:
            settings.beginGroup('PostgreSQL/servers/{0}'.format(connection))
            host = settings.value('host')
            user = settings.value('username')
            password = settings.value('password')
            settings.endGroup()
            if host == hostname and username == user:
                return password
        return None

    def connectToPostgis(self, parameters):
        """
        Stablishes connection to a Postgis database.
        :param parameters: (dict) a dict containing all connection parameters.
        :return: (AbstractDb) returns the DSGTools database object.
        """
        user, host, port, db = parameters['username'], parameters['host'], parameters['port'], parameters['db']
        # initiate abstractDb
        abstractDb = DbFactory().createDbFactory(driver=DsgEnums.DriverPostGIS)
        # ignore all info except for the password
        password = self.userPasswordFromHost(hostname=host, username=user)
        return abstractDb if abstractDb.testCredentials(host, port, db, user, password) else None

    def connectToSpatialite(self, parameters):
        """
        Stablishes connection to a SpatiaLite database.
        :param parameters: (dict) a dict containing all connection parameters.
        :return: (AbstractDb) returns the DSGTools database object.
        """
        abstractDb = None
        if os.path.exists(parameters['path']):
            abstractDb = DbFactory().createDbFactory(driver=DsgEnums.DriverSpatiaLite)
            abstractDb.connectDatabase(conn=parameters['path'])
        return abstractDb

    def connectToGeopackage(self, parameters):
        """
        Stablishes connection to a Geopackage database.
        :param parameters: (dict) a dict containing all connection parameters.
        :return: (AbstractDb) returns the DSGTools database object.
        """
        abstractDb = None
        if os.path.exists(parameters['path']):
            abstractDb = DbFactory().createDbFactory(driver=DsgEnums.DriverGeopackage)
            abstractDb.connectDatabase(conn=parameters['path'])
        return abstractDb

    def connectToShapefile(self, parameters):
        """
        Stablishes connection to a Shapefile dataset.
        :param parameters: (dict) a dict containing all connection parameters.
        :return: (AbstractDb) returns the DSGTools database object.
        """
        abstractDb = DbFactory().createDbFactory(driver=DsgEnums.DriverShapefile)
        abstractDb.connectDatabase(conn=parameters['path'])
        return abstractDb if abstractDb.getDatabaseName() != '' else None

    def connectToDb(self, parameters):
        """
        Stablishes a connection to the datasource described by a set of connection parameters.
        :param parameters: (dict) a dict containing all connection parameters.
        :return: (AbstractDb) returns the DSGTools database object.
        """
        drivers = {
            DsgEnums.DriverPostGIS : lambda : self.connectToPostgis(parameters=parameters),
            DsgEnums.DriverSpatiaLite : lambda : self.connectToSpatialite(parameters=parameters),
            DsgEnums.DriverGeopackage : lambda : self.connectToGeopackage(parameters=parameters),
            DsgEnums.DriverShapefile : lambda : self.connectToShapefile(parameters=parameters)
        }
        driver = parameters['driver']
        return drivers[driver]() if driver in drivers else None

    def getSpatialFilterBehaviour(self, predicate):
        """
        Gets the spatial behaviour option from a given spatial filter set of options regarding
        modes defined in convertLayer2LayerAlgorithm.
        :param spatialFilter: (str) spatial predicate.
        :return: (int) behaviour code.
        """
        predicates = {
            "Intersects" : 1,
            "Clip" : 2,
            "Buffer" : 3
        }
        return predicates[predicate] if predicate in predicates else None

    def readInputLayers(self, datasourcePath, feedback=None):
        """
        Reads all input datasources and return its layers.
        :param datasourcePath: (str) input's datasource path.
        :param feedback: (QgsProcessingMultiStepFeedback) QGIS tool for progress tracking.
        :return: (dict) a map for input's layers.
        """
        inputLayerMap = dict()
        parameters = self.parseDatasourcePath(datasourcePath)
        abstractDb = self.connectToDb(parameters=parameters)
        if abstractDb is None:
            return {}
        layerLoader = LayerLoaderFactory().makeLoader(self.iface, abstractDb)

        geometricLayers = list(abstractDb.listClassesWithElementsFromDatabase([]).keys())
        complexLayers = abstractDb.listComplexClassesFromDatabase()

        if feedback is not None:
            stepSize = 100 / (len(geometricLayers) + len(complexLayers)) if len(geometricLayers) + len(complexLayers) else 0
        curr = 0
        for curr, l in enumerate(geometricLayers):
            if feedback is not None and feedback.isCanceled():
                return inputLayerMap
            vl = layerLoader.getLayerByName(l)
            inputLayerMap[vl.name()] = vl
            if feedback is not None:
                feedback.setProgress(curr * stepSize)
        
        for currComplex, l in enumerate(complexLayers):
            if feedback is not None and feedback.isCanceled():
                return inputLayerMap
            vl = layerLoader.getComplexLayerByName(l)
            if vl.featureCount() > 0:
                inputLayerMap[vl.name()] = vl
            if feedback is not None:
                feedback.setProgress((curr + currComplex) * stepSize)
        # after reading its layers, db connection will not be used again
        del abstractDb
        return inputLayerMap

    def readOutputLayers(self, datasourcePath, feedback=None):
        """
        Prepares output layers to be filled.
        :param datasourcePath: (str) output's datasource path.
        :param context: (QgsProcessingContext) environment parameters in which processing tools are used.
        :param feedback: (QgsProcessingMultiStepFeedback) QGIS tool for progress tracking.
        :return: (dict) a map for output's layers.
        """
        parameters = self.parseDatasourcePath(datasourcePath)
        abstractDb = self.connectToDb(parameters=parameters)
        if abstractDb is None:
            return {}
        layerLoader = LayerLoaderFactory().makeLoader(self.iface, abstractDb)
        outputLayerMap = dict()

        geometricLayers = abstractDb.listGeomClassesFromDatabase([])
        complexLayers = abstractDb.listComplexClassesFromDatabase()
        if feedback is not None:
            multiStepFeedback = QgsProcessingMultiStepFeedback(len(geometricLayers) + len(complexLayers), feedback)
        
        for  curr, l in enumerate(geometricLayers):
            if feedback is not None and multiStepFeedback.isCanceled():
                return outputLayerMap
            vl = layerLoader.getLayerByName(l)
            outputLayerMap[vl.name()] = vl
            if feedback is not None:
                multiStepFeedback.setCurrentStep(curr)
        
        for currComplex, l in enumerate(complexLayers):
            if feedback is not None and multiStepFeedback.isCanceled():
                return outputLayerMap
            vl = layerLoader.getComplexLayerByName(l)
            outputLayerMap[vl.name()] = vl
            if feedback is not None:
                multiStepFeedback.setCurrentStep(curr + currComplex)
        # after reading its layers, db connection will not be used again
        del abstractDb
        return outputLayerMap

    def prepareSpatialFilterLayer(self, spatialFilters, context=None):
        """
        Prepares layer used as reference for spatially filtering a dataset.
        :param spatialFilters: (dict) spatial filter's parameters.
        :param context: (QgsProcessingContext) environment parameters in which processing tools are used.
        :return: (QgsVectorLayer) reference layer as requested in the spatial filters.
        """
        # layer always comes from canvas
        spatialFilterlLayer = QgsProject.instance().mapLayersByName(spatialFilters["layer"])
        spatialFilterlLayer = spatialFilterlLayer[0] if spatialFilterlLayer != [] else None
        if spatialFilters["expression"]:
            context = context if context is not None else QgsProcessingContext()
            spatialFilterlLayer = LayerHandler().filterByExpression(layer=spatialFilterlLayer,\
                                                    expression=spatialFilters["expression"],\
                                                    context=context)
        return spatialFilterlLayer

    def prepareInputLayers(self, inputLayers, stepConversionMap, context=None, feedback=None):
        """
        Prepare layers for a translation unit (step) to be executed (e.g. applies filters).
        :param inputLayers: (dict) a map from layer name to each vector layer contained by the
                            input datasource. 
        :param stepConversionMap: (dict) conversion map generated by Datasource Conversion tool
                                  for a conversion step.
        :param context: (QgsProcessingContext) environment parameters in which processing tools are used.
        :param feedback: (QgsProcessingMultiStepFeedback) QGIS tool for progress tracking.
        :return: (dict) map of layers to have its features mapped to output format.
        """
        lh = LayerHandler()
        context = context if context is not None else QgsProcessingContext()
        layerFilters = stepConversionMap["filter"]["layer_filter"]
        spatialFilters = stepConversionMap["filter"]["spatial_filter"]
        # in case a selection of layers was made, only chosen layers should be translated
        inputLayers = inputLayers if layerFilters == {} else {layer : inputLayers[layer] for layer in layerFilters}
        multiStepFeedback = QgsProcessingMultiStepFeedback(len(inputLayers), feedback)
        if spatialFilters:
            # spatial filtering behaviour is set based on the modes defined in convertLayer2LayerAlgorithm
            behaviour = self.getSpatialFilterBehaviour(spatialFilters["predicate"] if "predicate" in spatialFilters else None)
            spatialFilterLayer = self.prepareSpatialFilterLayer(spatialFilters, context)
        else:
            behaviour = None
            spatialFilterLayer = None
        preparedLayers = dict()
        currentStep = 0
        for layer, vl in inputLayers.items():
            if feedback is not None:
                multiStepFeedback.setCurrentStep(currentStep)
                if multiStepFeedback.isCanceled():
                    break
                currentStep += 1
            translatedLayer = lh.prepareConversion(
                                inputLyr=vl,
                                context=context,
                                inputExpression=layerFilters[layer]["expression"] if layer in layerFilters else None,
                                filterLyr=spatialFilterLayer,
                                behavior=behaviour,
                                conversionMap=stepConversionMap,
                                feedback=multiStepFeedback if feedback is not None else None
                                )
            if translatedLayer.featureCount() > 0:
                preparedLayers[layer] = translatedLayer
        return preparedLayers

    def mapFeatures(self, inputPreparedLayers, outputLayers, featureConversionMap=None, feedback=None):
        """
        Maps features from a given set of layers to a different set of layers (including attributes).
        :param inputPreparedLayers: (dict) map of layers to be translated.
        :param outputLayers: (dict) map of layers to be filled.
        :param featureConversionMap: (dict) map of features based on given input.
        :param feedback: (QgsProcessingMultiStepFeedback) QGIS tool for progress tracking.
        :return: (dict) map of (list-of-QgsFeature) features to be added to a (str) layer.
        """
        if featureConversionMap is not None:
            # do the conversion in here using the map - NOT YET SUPPORTED
            pass
        else:
            featuresMap = collections.defaultdict(set)
            lh = LayerHandler()
            fh = FeatureHandler()
            if feedback is not None:
                stepSize = 100 / len(inputPreparedLayers) if len(inputPreparedLayers) else 0
            for current, (layer, vl) in enumerate(inputPreparedLayers.items()):
                if feedback is not None and feedback.isCanceled():
                        break
                if vl.featureCount() == 0 or layer not in outputLayers:
                    continue
                outuputLayer = outputLayers[layer]
                k = "{0}->{1}".format(vl.crs().authid(), outuputLayer.crs().authid())
                if k not in self.coordinateTransformers:
                    self.coordinateTransformers[k] = lh.getCoordinateTransformer(inputLyr=vl, outputLyr=outuputLayer)
                coordinateTransformer = self.coordinateTransformers[k]
                param = lh.getDestinationParameters(vl)
                for feature in vl.getFeatures(QgsFeatureRequest()):
                    featuresMap[layer] |= fh.handleConvertedFeature(
                                                feat=feature,
                                                lyr=outuputLayer,
                                                parameterDict=param,
                                                coordinateTransformer=coordinateTransformer
                                                )
                if feedback is not None:
                    feedback.setProgress(current * stepSize)
            return featuresMap

    # def fanOut(self, inputLayers, preparedLayers, referenceLayer, fanOutFieldName, context=None, feedback=None):
    #     """
        
    #     """
    #     idx = referenceLayer.fields().indexFromName(fanOutFieldName)
    #     reference = referenceLayer.uniqueValues(idx)
    #     fannedOutLayers = {}
    #     lh = LayerHandler()
    #     context = context if not context is None else QgsProcessingContext()
    #     for layer, featuresList in preparedLayers.items():
    #         vl = preparedLayers[layer]
    #         vl.startEditing()
    #         fields = [f.name() for f in inputLayers[layer].fields()]
    #         removeFields = [vl.fields().indexFromName(f.name()) for f in vl.fields() if f.name() not in fields]
    #         for value in reference:
    #             if value not in fannedOutLayers:
    #                 fannedOutLayers[value] = {}
    #             fannedOut = lh.filterByExpression(layer=vl, expression='{0} = {1}'.format(fanOutFieldName, value),
    #                                     context=context, feedback=feedback)
    #             vl.deleteAttributes(removeFields)
    #             vl.updateFields()
    #             vl.commitChanges()
    #             if fannedOut.featureCount() > 0:
    #                 fannedOutLayers[value][layer] = fannedOut
    #     return fannedOutLayers

    def loadToOuput(self, featuresMap, outputLayers, conversionMode, featureConversionMap=None, feedback=None):
        """
        Loads converted features to output dataset.
        :param preparedLayers: (dict) map of (list-of-QgsFeature) features to be added to output layer.
        :param outputLayers: (dict) map of (list-of-QgsVectorLayer) output's layers.
        :param conversionMode: (int) current step conversion mode.
        :param featureConversionMap: (dict) maps features from input structure to the output model structure.
        :param feedback: (QgsProcessingMultiStepFeedback) QGIS tool for progress tracking.
        :return: (tuple-of-dict) successful features addition and failed ones.
        """
        success = dict()
        fail = dict()
        if feedback is not None:
            stepSize = 100 / len(featuresMap) if len(featuresMap) else 0
        flexibleConversion = conversionMode == DsgEnums.FlexibleConversion
        for current, (layer, featureSet) in enumerate(featuresMap.items()):
            if feedback is not None and feedback.isCanceled():
                break
            vl = outputLayers[layer]
            vl.startEditing()
            count = 0
            if vl.addFeatures(featureSet):
                count = len(featureSet)
            elif flexibleConversion:
                # in case conversion mode is set to flexible, only defective features will be ignored
                while featureSet:
                    count += vl.addFeature(featureSet.pop())
            vl.updateExtents()
            if vl.commitChanges():
                self.conversionUpdated.emit(self.tr("{0} successfully loaded.").format(vl.name()))
                success[layer] = count
            else:
                self.conversionUpdated.emit(self.tr("{0} failed to be loaded.").format(vl.name()))
                fail[layer] = outputLayers[layer].commitErrors()[0]
            if feedback is not None:
                feedback.setProgress(current * stepSize)
        return success, fail

    def getLogHeader(self):
        """
        Gets log header. Used to initiate log.
        """
        # any header info insertion should be through template
        # header's data handling should be in this method!
        with open(os.path.join(os.path.dirname(__file__), 'Templates', 'headerConversionSummaryTemplate.html'), 'r') as f:
            return f.read()

    def addConversionStepToLog(self, conversionStep, inputDb, outputDb, inputLayers, creationErrors, successfulLayers, failedLayers, elapsedTime):
        """
        Builds conversion summary log message.
        :param conversionStep: (int) current conversion step.
        :param inputDb: (str) input's dataset name.
        :param outputDb: (str) output's dataset name.
        :param inputLayers: (dict) input layers dict.
        :param creationErrors: (dict) dataset creation errors.
        :param successfulLayers: (dict) map to layers and their successesfully written features.
        :param failedLayers: (dict) map to layers and their failing writting reason.
        :param elapsedTime: (str) current step elapsed time.
        :return: (str) conversion step HTML text.
        """
        with open(os.path.join(os.path.dirname(__file__), 'Templates', 'bodyConversionSummaryTemplate.html'), 'r') as f:
            bodyHtml = f.read()
        bodyHtml = bodyHtml.replace('CONVERSION_STEP', str(conversionStep))
        bodyHtml = bodyHtml.replace('INPUT_DATASET', inputDb)
        bodyHtml = bodyHtml.replace('OUTPUT_DATASET', outputDb)
        inputTable = ""
        for layer, vl in inputLayers.items():
            inputTable += """
            <tr>
                <td>{0}</td>
                <td style="text-align: center;">{1}</td>
            </tr>
            """.format(layer, len([f for f in vl.getFeatures()]))
        bodyHtml = bodyHtml.replace('INPUT_TABLE', inputTable)
        outputTable = ""
        for layer, feat_count in successfulLayers.items():
            outputTable += """
            <tr>
                <td>{0}</td>
                <td style="text-align: center;">{1}</td>
            </tr>
            """.format(layer, feat_count)
        bodyHtml = bodyHtml.replace('OUTPUT_TABLE', outputTable)
        dsErrors = ""
        if "{0} to {1}".format(inputDb, outputDb) in creationErrors:
            dsErrors = """
            <tr>
                <td>{0}</td>
                <td>{1}</td>
            </tr>
            """.format(outputDb, creationErrors["{0} to {1}".format(inputDb, outputDb)])
        bodyHtml = bodyHtml.replace('DATASET_CREATION_ERROR', dsErrors)
        errors = ""
        for layer, reason in failedLayers.items():
            errors += """
            <tr>
                <td>{0}</td>
                <td>{1}</td>
            </tr>
            """.format(layer, reason)
        bodyHtml = bodyHtml.replace('WRITTING_ERRORS', errors)
        return bodyHtml.replace('STEP_ELAPSED_TIME', elapsedTime) + "\n"

    def convertFromMap(self, conversionMap=None, featureConversionMap=None, feedback=None):
        """
        Converts all datasets from a conversion map.
        :param conversionMap: (dict) conversion map generated by Datasource Conversion tool.
        :param featureConversionMap: (dict) map of features based on given input.
        :param feedback: (QgsProcessingMultiStepFeedback) QGIS tool for progress tracking.
        :return: (tuple) successfull and failed translations lists.
        """
        if conversionMap is None:
            conversionMap = self.conversionMap
        if feedback is None:
            feedback = self.feedback
        allInputLayers = dict()
        allOutputLayers = dict()
        errors = dict()
        successfulLayers, failedLayers = None, None
        nSteps = len(self.getAllUniqueInputDb()) + len(self.getAllUniqueOutputDb()) * 4
        multiStepFeedback = QgsProcessingMultiStepFeedback(nSteps, feedback)
        # start log
        conversionSummary = self.getLogHeader()
        conversionStep = 1
        currentStep = 0
        for inputDb, conversionStepMaps in conversionMap.items():
            if multiStepFeedback.isCanceled() or self.isCanceled():
                break
            multiStepFeedback.setCurrentStep(currentStep)
            currentStep += 1
            # input setup
            self.conversionUpdated.emit(self.tr("\nConversion Step {0} started...\n\n").format(conversionStep))
            self.conversionUpdated.emit(self.tr("[INPUT] Reading {0}'s layers...\n").format(inputDb))
            if inputDb not in allInputLayers:
                allInputLayers[inputDb] = self.readInputLayers(datasourcePath=inputDb, feedback=multiStepFeedback)
            inputLayers = allInputLayers[inputDb]
            for currentOutput, conversionStepMap in enumerate(conversionStepMaps):
                startTime = time.time()
                if multiStepFeedback.isCanceled() or self.isCanceled():
                    break
                # output setup
                outputDb = conversionStepMap["outDs"]
                if outputDb not in allOutputLayers:
                    if conversionStepMap["createDs"]:
                        self.conversionUpdated.emit(self.tr("[OUTPUT] Creating dataset {0}...\n").format(outputDb))
                        outputAbstractDb, error = self.checkAndCreateDataset(conversionStepMap)
                        del outputAbstractDb
                        if error != "":
                            k = "{0} to {1}".format(inputDb, outputDb)
                            self.conversionUpdated.emit(self.tr("Dataset creation error ({0}): '{1}'\n").format(outputDb, error))
                            errors[k] = error
                            conversionSummary += self.addConversionStepToLog(conversionStep, inputDb, outputDb, \
                                            inputLayers, errors, {}, {}, "{0:.2f} s".format(time.time() - startTime))
                            conversionStep += 1
                            continue
                    self.conversionUpdated.emit(self.tr("[OUTPUT] Reading {0}'s layers...\n").format(outputDb))
                    multiStepFeedback.setCurrentStep(currentStep)
                    currentStep += 1
                    allOutputLayers[outputDb] = self.readOutputLayers(datasourcePath=outputDb, feedback=multiStepFeedback)
                outputLayers = allOutputLayers[outputDb]
                # now conversion starts
                self.conversionUpdated.emit(self.tr("Preparing {0}'s layers for conversion...").format(inputDb))
                multiStepFeedback.setCurrentStep(currentStep)
                currentStep += 1
                preparedLayers = self.prepareInputLayers(inputLayers, conversionStepMap, feedback=multiStepFeedback)

                self.conversionUpdated.emit(self.tr("Mapping features..."))
                multiStepFeedback.setCurrentStep(currentStep)
                currentStep += 1
                mappedFeatures = self.mapFeatures(preparedLayers, outputLayers, feedback=multiStepFeedback)

                self.conversionUpdated.emit(self.tr("Loading layers to {0}...").format(outputDb))
                multiStepFeedback.setCurrentStep(currentStep)
                currentStep += 1
                successfulLayers, failedLayers = self.loadToOuput(
                                                    mappedFeatures, outputLayers, conversionStepMap["conversionMode"],\
                                                    feedback=multiStepFeedback
                                                 )
                # log update
                conversionSummary += self.addConversionStepToLog(conversionStep, inputDb, outputDb, inputLayers, \
                                            errors, successfulLayers, failedLayers, "{0:.2f} s".format(time.time() - startTime))
                conversionStep += 1
        self.conversionFinished.emit()
        return {
            'creationErrors' : errors,
            'successfulLayers' : successfulLayers,
            'failedLayers' : failedLayers,
            'status' : not feedback.isCanceled(),
            'log' : conversionSummary
        }
    
    def run(self):
        elapsedTime = time.time()
        self.output = self.convertFromMap()
        self.output['elapsedTime'] = "{0:.2f} s".format(time.time() - elapsedTime)
        self.output['log'] = self.output['log'].replace('ELAPSED_TIME', self.output['elapsedTime'])
        return self.output['status']

