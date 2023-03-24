# -*- coding: utf-8 -*-
"""
/***************************************************************************
 DsgTools
                                 A QGIS plugin
 Brazilian Army Cartographic Production Tools
                              -------------------
        begin                : 2022-09-15
        git sha              : $Format:%H$
        copyright            : (C) 2022 by Mateus Sereno - Cartographic Engineer @ Brazilian Army
        email                : mateus.sereno@ime.eb.br
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
from PyQt5.QtCore import QCoreApplication
from PyQt5.QtGui import QColor
from qgis.PyQt.Qt import QVariant
from qgis.core import (QgsProcessingAlgorithm,
                       QgsProcessingParameterMultipleLayers,
                       QgsField,
                       QgsVectorLayer,
                       QgsConditionalStyle,
                       QgsExpression)

class DetectNullGeometriesAlgorithm(QgsProcessingAlgorithm):
    INPUT_LAYERS = 'INPUT_LAYERS'

    def initAlgorithm(self, config=None):
        self.addParameter(
            QgsProcessingParameterMultipleLayers(
                self.INPUT_LAYERS,
                self.tr("Input layers")
            )
        )

    def processAlgorithm(self, parameters, context, feedback):
        """
        Here is where the processing itself takes place.
        """
        inputLyrList = self.parameterAsLayerList(
            parameters,
            self.INPUT_LAYERS,
            context
        )
        
        if not inputLyrList:
            return {}
        
        listSize = len(inputLyrList)
        stepSize = 100/listSize if listSize else 0

        for current, lyr in enumerate(inputLyrList):
            if feedback.isCanceled():
                break
            self.addRuleToLayer(lyr, feedback=feedback)
            self.createRuleVirtualField(lyr)
            feedback.setProgress(current * stepSize)
        return {}

    def addRuleToLayer(self, lyr:QgsVectorLayer, feedback=None):
        conditionalStyle = self.createConditionalStyle()

        lyr.conditionalStyles().setRowStyles(
            [conditionalStyle]
        )

    def createConditionalStyle(self) -> QgsConditionalStyle:
        """
        Returns a QgsConditionalStyle
        """
        conditionalStyle = QgsConditionalStyle()
        conditionalStyle.setName("Geometria nula")
        conditionalStyle.setRule("is_empty_or_null($geometry)")
        conditionalStyle.setBackgroundColor(
            QColor(255,0,0) 
        )
        conditionalStyle.setTextColor(
            QColor(255,255,255)
        )

        return conditionalStyle
    
    def createRuleVirtualField(self, lyr):
        expressionString = """CASE\n"""
        expressionString += """WHEN {condition} THEN '{result}'\n""".format(
                condition="is_empty_or_null($geometry)",
                result="EMPTY/NULL GEOMETRY"
            )
        expressionString += """ELSE ''\nEND"""

        expression = QgsExpression(expressionString)
        if expression.hasParserError():
            raise Exception(
                f"Invalid expression: \n{expressionString}"
            )
        lyr.addExpressionField(
            expressionString,
            QgsField(
                'geometry_error',
                QVariant.String
            )
        )

    def name(self):
        """
        Returns the algorithm name, used for identifying the algorithm. This
        string should be fixed for the algorithm, and must not be localised.
        The name should be unique within each provider. Names should contain
        lowercase alphanumeric characters only and no spaces or other
        formatting characters.
        """
        return 'detectnullgeometriesalgorithm'

    def displayName(self):
        """
        Returns the translated algorithm name, which should be used for any
        user-visible display of the algorithm name.
        """
        return self.tr('Detect Null Geometries')

    def group(self):
        """
        Returns the name of the group this algorithm belongs to. This string
        should be localised.
        """
        return self.tr('Layer Management Algorithms')

    def groupId(self):
        """
        Returns the unique ID of the group this algorithm belongs to. This
        string should be fixed for the algorithm, and must not be localised.
        The group id should be unique within each provider. Group id should
        contain lowercase alphanumeric characters only and no spaces or other
        formatting characters.
        """
        return 'DSGTools: Layer Management Algorithms'

    def tr(self, string):
        return QCoreApplication.translate('DetectNullGeometriesAlgorithm', string)

    def createInstance(self):
        return DetectNullGeometriesAlgorithm()
