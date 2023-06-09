<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis maxScale="0" simplifyDrawingHints="0" readOnly="0" simplifyDrawingTol="1" version="3.7.0-Master" labelsEnabled="0" hasScaleBasedVisibilityFlag="0" styleCategories="AllStyleCategories" simplifyMaxScale="1" minScale="1e+8" simplifyLocal="1" simplifyAlgorithm="0">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
  </flags>
  <renderer-v2 enableorderby="0" forceraster="0" type="singleSymbol" symbollevels="0">
    <symbols>
      <symbol alpha="1" type="marker" name="0" clip_to_extent="1" force_rhr="0">
        <layer pass="0" locked="0" enabled="1" class="SimpleMarker">
          <prop v="0" k="angle"/>
          <prop v="232,113,141,255" k="color"/>
          <prop v="1" k="horizontal_anchor_point"/>
          <prop v="bevel" k="joinstyle"/>
          <prop v="circle" k="name"/>
          <prop v="0,0" k="offset"/>
          <prop v="3x:0,0,0,0,0,0" k="offset_map_unit_scale"/>
          <prop v="MM" k="offset_unit"/>
          <prop v="35,35,35,255" k="outline_color"/>
          <prop v="solid" k="outline_style"/>
          <prop v="0" k="outline_width"/>
          <prop v="3x:0,0,0,0,0,0" k="outline_width_map_unit_scale"/>
          <prop v="MM" k="outline_width_unit"/>
          <prop v="diameter" k="scale_method"/>
          <prop v="2" k="size"/>
          <prop v="3x:0,0,0,0,0,0" k="size_map_unit_scale"/>
          <prop v="MM" k="size_unit"/>
          <prop v="1" k="vertical_anchor_point"/>
          <data_defined_properties>
            <Option type="Map">
              <Option value="" type="QString" name="name"/>
              <Option name="properties"/>
              <Option value="collection" type="QString" name="type"/>
            </Option>
          </data_defined_properties>
        </layer>
      </symbol>
    </symbols>
    <rotation/>
    <sizescale/>
  </renderer-v2>
  <customproperties/>
  <blendMode>0</blendMode>
  <featureBlendMode>0</featureBlendMode>
  <layerOpacity>1</layerOpacity>
  <geometryOptions geometryPrecision="0" removeDuplicateNodes="0">
    <activeChecks type="StringList">
      <Option value="" type="QString"/>
    </activeChecks>
    <checkConfiguration/>
  </geometryOptions>
  <fieldConfiguration>
    <field name="id">
      <editWidget type="">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="nomeabrev">
      <editWidget type="">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="geometriaaproximada">
      <editWidget type="ValueMap">
        <config>
          <Option type="Map">
            <Option type="Map" name="map">
              <Option value="2" type="QString" name="Não"/>
              <Option value="1" type="QString" name="Sim"/>
            </Option>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="tiporef">
      <editWidget type="ValueMap">
        <config>
          <Option type="Map">
            <Option type="Map" name="map">
              <Option value="1" type="QString" name="Altimétrico"/>
              <Option value="4" type="QString" name="Gravimétrico"/>
              <Option value="3" type="QString" name="Planialtimétrico"/>
              <Option value="2" type="QString" name="Planimétrico"/>
            </Option>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="latitude">
      <editWidget type="">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="longitude">
      <editWidget type="">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="altitudeortometrica">
      <editWidget type="">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="sistemageodesico">
      <editWidget type="ValueMap">
        <config>
          <Option type="Map">
            <Option type="Map" name="map">
              <Option value="5" type="QString" name="Astro Chuá"/>
              <Option value="4" type="QString" name="Córrego Alegre"/>
              <Option value="6" type="QString" name="Outra referência"/>
              <Option value="1" type="QString" name="SAD-69"/>
              <Option value="2" type="QString" name="SIRGAS"/>
              <Option value="3" type="QString" name="WGS-84"/>
            </Option>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="referencialaltim">
      <editWidget type="ValueMap">
        <config>
          <Option type="Map">
            <Option type="Map" name="map">
              <Option value="2" type="QString" name="Imbituba"/>
              <Option value="4" type="QString" name="Local"/>
              <Option value="5" type="QString" name="Outra referência"/>
              <Option value="3" type="QString" name="Santana"/>
              <Option value="1" type="QString" name="Torres"/>
            </Option>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="outrarefalt">
      <editWidget type="">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="outrarefplan">
      <editWidget type="">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="orgaoenteresp">
      <editWidget type="">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="codponto">
      <editWidget type="">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="obs">
      <editWidget type="">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="nome">
      <editWidget type="">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="proximidade">
      <editWidget type="ValueMap">
        <config>
          <Option type="Map">
            <Option type="Map" name="map">
              <Option value="15" type="QString" name="Adjacente"/>
              <Option value="16" type="QString" name="Coincidente"/>
              <Option value="0" type="QString" name="Desconhecida"/>
              <Option value="14" type="QString" name="Isolado"/>
            </Option>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="tipoptorefgeodtopo">
      <editWidget type="ValueMap">
        <config>
          <Option type="Map">
            <Option type="Map" name="map">
              <Option value="0" type="QString" name="Desconhecido"/>
              <Option value="3" type="QString" name="Estação Gravimétrica - EG"/>
              <Option value="4" type="QString" name="Estação de Poligonal - EP"/>
              <Option value="99" type="QString" name="Outros"/>
              <Option value="5" type="QString" name="Ponto Astronômico - PA"/>
              <Option value="7" type="QString" name="Ponto Trigonométrico - RV"/>
              <Option value="6" type="QString" name="Ponto barométrico - B"/>
              <Option value="8" type="QString" name="Ponto de Satélite - SAT"/>
              <Option value="2" type="QString" name="Referência de Nível - RN"/>
              <Option value="1" type="QString" name="Vértice de Triangulação - VT"/>
            </Option>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="rede">
      <editWidget type="ValueMap">
        <config>
          <Option type="Map">
            <Option type="Map" name="map">
              <Option value="0" type="QString" name="Desconhecida"/>
              <Option value="2" type="QString" name="Estadual"/>
              <Option value="3" type="QString" name="Municipal"/>
              <Option value="14" type="QString" name="Nacional"/>
              <Option value="15" type="QString" name="Privada"/>
            </Option>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="referencialgrav">
      <editWidget type="ValueMap">
        <config>
          <Option type="Map">
            <Option type="Map" name="map">
              <Option value="3" type="QString" name="Absoluto"/>
              <Option value="0" type="QString" name="Desconhecido"/>
              <Option value="2" type="QString" name="IGSN71"/>
              <Option value="4" type="QString" name="Local"/>
              <Option value="97" type="QString" name="Não Aplicável"/>
              <Option value="1" type="QString" name="Postdam 1930"/>
            </Option>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="situacaomarco">
      <editWidget type="ValueMap">
        <config>
          <Option type="Map">
            <Option type="Map" name="map">
              <Option value="1" type="QString" name="Bom"/>
              <Option value="0" type="QString" name="Desconhecido"/>
              <Option value="2" type="QString" name="Destruído"/>
              <Option value="4" type="QString" name="Destruído com chapa danificada"/>
              <Option value="3" type="QString" name="Destruído sem chapa"/>
              <Option value="7" type="QString" name="Não construído"/>
              <Option value="5" type="QString" name="Não encontrado"/>
              <Option value="6" type="QString" name="Não visitado"/>
            </Option>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="datavisita">
      <editWidget type="">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
  </fieldConfiguration>
  <aliases>
    <alias field="id" index="0" name=""/>
    <alias field="nomeabrev" index="1" name=""/>
    <alias field="geometriaaproximada" index="2" name=""/>
    <alias field="tiporef" index="3" name=""/>
    <alias field="latitude" index="4" name=""/>
    <alias field="longitude" index="5" name=""/>
    <alias field="altitudeortometrica" index="6" name=""/>
    <alias field="sistemageodesico" index="7" name=""/>
    <alias field="referencialaltim" index="8" name=""/>
    <alias field="outrarefalt" index="9" name=""/>
    <alias field="outrarefplan" index="10" name=""/>
    <alias field="orgaoenteresp" index="11" name=""/>
    <alias field="codponto" index="12" name=""/>
    <alias field="obs" index="13" name=""/>
    <alias field="nome" index="14" name=""/>
    <alias field="proximidade" index="15" name=""/>
    <alias field="tipoptorefgeodtopo" index="16" name=""/>
    <alias field="rede" index="17" name=""/>
    <alias field="referencialgrav" index="18" name=""/>
    <alias field="situacaomarco" index="19" name=""/>
    <alias field="datavisita" index="20" name=""/>
  </aliases>
  <excludeAttributesWMS/>
  <excludeAttributesWFS/>
  <defaults>
    <default applyOnUpdate="0" field="id" expression=""/>
    <default applyOnUpdate="0" field="nomeabrev" expression=""/>
    <default applyOnUpdate="0" field="geometriaaproximada" expression=""/>
    <default applyOnUpdate="0" field="tiporef" expression=""/>
    <default applyOnUpdate="0" field="latitude" expression=""/>
    <default applyOnUpdate="0" field="longitude" expression=""/>
    <default applyOnUpdate="0" field="altitudeortometrica" expression=""/>
    <default applyOnUpdate="0" field="sistemageodesico" expression=""/>
    <default applyOnUpdate="0" field="referencialaltim" expression=""/>
    <default applyOnUpdate="0" field="outrarefalt" expression=""/>
    <default applyOnUpdate="0" field="outrarefplan" expression=""/>
    <default applyOnUpdate="0" field="orgaoenteresp" expression=""/>
    <default applyOnUpdate="0" field="codponto" expression=""/>
    <default applyOnUpdate="0" field="obs" expression=""/>
    <default applyOnUpdate="0" field="nome" expression=""/>
    <default applyOnUpdate="0" field="proximidade" expression=""/>
    <default applyOnUpdate="0" field="tipoptorefgeodtopo" expression=""/>
    <default applyOnUpdate="0" field="rede" expression=""/>
    <default applyOnUpdate="0" field="referencialgrav" expression=""/>
    <default applyOnUpdate="0" field="situacaomarco" expression=""/>
    <default applyOnUpdate="0" field="datavisita" expression=""/>
  </defaults>
  <constraints>
    <constraint unique_strength="1" field="id" constraints="3" exp_strength="0" notnull_strength="1"/>
    <constraint unique_strength="0" field="nomeabrev" constraints="0" exp_strength="0" notnull_strength="0"/>
    <constraint unique_strength="0" field="geometriaaproximada" constraints="1" exp_strength="0" notnull_strength="1"/>
    <constraint unique_strength="0" field="tiporef" constraints="1" exp_strength="0" notnull_strength="1"/>
    <constraint unique_strength="0" field="latitude" constraints="0" exp_strength="0" notnull_strength="0"/>
    <constraint unique_strength="0" field="longitude" constraints="0" exp_strength="0" notnull_strength="0"/>
    <constraint unique_strength="0" field="altitudeortometrica" constraints="0" exp_strength="0" notnull_strength="0"/>
    <constraint unique_strength="0" field="sistemageodesico" constraints="1" exp_strength="0" notnull_strength="1"/>
    <constraint unique_strength="0" field="referencialaltim" constraints="1" exp_strength="0" notnull_strength="1"/>
    <constraint unique_strength="0" field="outrarefalt" constraints="0" exp_strength="0" notnull_strength="0"/>
    <constraint unique_strength="0" field="outrarefplan" constraints="0" exp_strength="0" notnull_strength="0"/>
    <constraint unique_strength="0" field="orgaoenteresp" constraints="0" exp_strength="0" notnull_strength="0"/>
    <constraint unique_strength="0" field="codponto" constraints="0" exp_strength="0" notnull_strength="0"/>
    <constraint unique_strength="0" field="obs" constraints="0" exp_strength="0" notnull_strength="0"/>
    <constraint unique_strength="0" field="nome" constraints="0" exp_strength="0" notnull_strength="0"/>
    <constraint unique_strength="0" field="proximidade" constraints="1" exp_strength="0" notnull_strength="1"/>
    <constraint unique_strength="0" field="tipoptorefgeodtopo" constraints="1" exp_strength="0" notnull_strength="1"/>
    <constraint unique_strength="0" field="rede" constraints="1" exp_strength="0" notnull_strength="1"/>
    <constraint unique_strength="0" field="referencialgrav" constraints="1" exp_strength="0" notnull_strength="1"/>
    <constraint unique_strength="0" field="situacaomarco" constraints="1" exp_strength="0" notnull_strength="1"/>
    <constraint unique_strength="0" field="datavisita" constraints="0" exp_strength="0" notnull_strength="0"/>
  </constraints>
  <constraintExpressions>
    <constraint exp="" desc="" field="id"/>
    <constraint exp="" desc="" field="nomeabrev"/>
    <constraint exp="" desc="" field="geometriaaproximada"/>
    <constraint exp="" desc="" field="tiporef"/>
    <constraint exp="" desc="" field="latitude"/>
    <constraint exp="" desc="" field="longitude"/>
    <constraint exp="" desc="" field="altitudeortometrica"/>
    <constraint exp="" desc="" field="sistemageodesico"/>
    <constraint exp="" desc="" field="referencialaltim"/>
    <constraint exp="" desc="" field="outrarefalt"/>
    <constraint exp="" desc="" field="outrarefplan"/>
    <constraint exp="" desc="" field="orgaoenteresp"/>
    <constraint exp="" desc="" field="codponto"/>
    <constraint exp="" desc="" field="obs"/>
    <constraint exp="" desc="" field="nome"/>
    <constraint exp="" desc="" field="proximidade"/>
    <constraint exp="" desc="" field="tipoptorefgeodtopo"/>
    <constraint exp="" desc="" field="rede"/>
    <constraint exp="" desc="" field="referencialgrav"/>
    <constraint exp="" desc="" field="situacaomarco"/>
    <constraint exp="" desc="" field="datavisita"/>
  </constraintExpressions>
  <expressionfields/>
  <attributeactions/>
  <attributetableconfig sortOrder="0" sortExpression="" actionWidgetStyle="dropDown">
    <columns/>
  </attributetableconfig>
  <conditionalstyles>
    <rowstyles/>
    <fieldstyles/>
  </conditionalstyles>
  <editform tolerant="1"></editform>
  <editforminit/>
  <editforminitcodesource>0</editforminitcodesource>
  <editforminitfilepath></editforminitfilepath>
  <editforminitcode><![CDATA[]]></editforminitcode>
  <featformsuppress>0</featformsuppress>
  <editorlayout>generatedlayout</editorlayout>
  <editable/>
  <labelOnTop/>
  <widgets/>
  <previewExpression></previewExpression>
  <mapTip></mapTip>
  <layerGeometryType>0</layerGeometryType>
</qgis>
