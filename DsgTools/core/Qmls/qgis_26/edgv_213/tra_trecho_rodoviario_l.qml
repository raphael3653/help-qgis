<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis maxScale="0" simplifyDrawingHints="0" readOnly="0" simplifyDrawingTol="1" version="3.7.0-Master" labelsEnabled="0" hasScaleBasedVisibilityFlag="0" styleCategories="AllStyleCategories" simplifyMaxScale="1" minScale="1e+8" simplifyLocal="1" simplifyAlgorithm="0">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
  </flags>
  <renderer-v2 enableorderby="0" forceraster="0" type="singleSymbol" symbollevels="0">
    <symbols>
      <symbol alpha="1" type="line" name="0" clip_to_extent="1" force_rhr="0">
        <layer pass="0" locked="0" enabled="1" class="SimpleLine">
          <prop v="square" k="capstyle"/>
          <prop v="5;2" k="customdash"/>
          <prop v="3x:0,0,0,0,0,0" k="customdash_map_unit_scale"/>
          <prop v="MM" k="customdash_unit"/>
          <prop v="0" k="draw_inside_polygon"/>
          <prop v="bevel" k="joinstyle"/>
          <prop v="213,180,60,255" k="line_color"/>
          <prop v="solid" k="line_style"/>
          <prop v="0.26" k="line_width"/>
          <prop v="MM" k="line_width_unit"/>
          <prop v="0" k="offset"/>
          <prop v="3x:0,0,0,0,0,0" k="offset_map_unit_scale"/>
          <prop v="MM" k="offset_unit"/>
          <prop v="0" k="ring_filter"/>
          <prop v="0" k="use_custom_dash"/>
          <prop v="3x:0,0,0,0,0,0" k="width_map_unit_scale"/>
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
    <field name="codtrechorodov">
      <editWidget type="">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="tipotrechorod">
      <editWidget type="ValueMap">
        <config>
          <Option type="Map">
            <Option type="Map" name="map">
              <Option value="1" type="QString" name="Acesso"/>
              <Option value="4" type="QString" name="Auto-estrada"/>
              <Option value="3" type="QString" name="Caminho carroçável"/>
              <Option value="2" type="QString" name="Rodovia"/>
            </Option>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="jurisdicao">
      <editWidget type="ValueMap">
        <config>
          <Option type="Map">
            <Option type="Map" name="map">
              <Option value="0" type="QString" name="Desconhecida"/>
              <Option value="2" type="QString" name="Estadual"/>
              <Option value="11" type="QString" name="Estadual/Municipal"/>
              <Option value="1" type="QString" name="Federal"/>
              <Option value="9" type="QString" name="Federal/Estadual"/>
              <Option value="12" type="QString" name="Federal/Estadual/Municipal"/>
              <Option value="10" type="QString" name="Federal/Municipal"/>
              <Option value="3" type="QString" name="Municipal"/>
              <Option value="8" type="QString" name="Propriedade particular"/>
            </Option>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="administracao">
      <editWidget type="ValueMap">
        <config>
          <Option type="Map">
            <Option type="Map" name="map">
              <Option value="7" type="QString" name="Concessionada"/>
              <Option value="0" type="QString" name="Desconhecida"/>
              <Option value="2" type="QString" name="Estadual"/>
              <Option value="11" type="QString" name="Estadual/Municipal"/>
              <Option value="1" type="QString" name="Federal"/>
              <Option value="9" type="QString" name="Federal/Estadual"/>
              <Option value="12" type="QString" name="Federal/Estadual/Municipal"/>
              <Option value="10" type="QString" name="Federal/Municipal"/>
              <Option value="3" type="QString" name="Municipal"/>
              <Option value="6" type="QString" name="Particular"/>
            </Option>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="concessionaria">
      <editWidget type="">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="revestimento">
      <editWidget type="ValueMap">
        <config>
          <Option type="Map">
            <Option type="Map" name="map">
              <Option value="4" type="QString" name="Calçado"/>
              <Option value="0" type="QString" name="Desconhecido"/>
              <Option value="1" type="QString" name="Leito natural"/>
              <Option value="3" type="QString" name="Pavimentado"/>
              <Option value="2" type="QString" name="Revestimento primário"/>
            </Option>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="operacional">
      <editWidget type="ValueMap">
        <config>
          <Option type="Map">
            <Option type="Map" name="map">
              <Option value="0" type="QString" name="Desconhecido"/>
              <Option value="2" type="QString" name="Não"/>
              <Option value="1" type="QString" name="Sim"/>
            </Option>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="situacaofisica">
      <editWidget type="ValueMap">
        <config>
          <Option type="Map">
            <Option type="Map" name="map">
              <Option value="1" type="QString" name="Abandonada"/>
              <Option value="5" type="QString" name="Construída"/>
              <Option value="0" type="QString" name="Desconhecida"/>
              <Option value="2" type="QString" name="Destruída"/>
              <Option value="3" type="QString" name="Em Construção"/>
              <Option value="4" type="QString" name="Planejada"/>
            </Option>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="nrpistas">
      <editWidget type="">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="nrfaixas">
      <editWidget type="">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="trafego">
      <editWidget type="ValueMap">
        <config>
          <Option type="Map">
            <Option type="Map" name="map">
              <Option value="0" type="QString" name="Desconhecido"/>
              <Option value="2" type="QString" name="Periódico"/>
              <Option value="1" type="QString" name="Permanente"/>
            </Option>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="canteirodivisorio">
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
    <field name="id_via_rodoviaria">
      <editWidget type="">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="length_otf">
      <editWidget type="">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
  </fieldConfiguration>
  <aliases>
    <alias field="id" index="0" name=""/>
    <alias field="geometriaaproximada" index="1" name=""/>
    <alias field="codtrechorodov" index="2" name=""/>
    <alias field="tipotrechorod" index="3" name=""/>
    <alias field="jurisdicao" index="4" name=""/>
    <alias field="administracao" index="5" name=""/>
    <alias field="concessionaria" index="6" name=""/>
    <alias field="revestimento" index="7" name=""/>
    <alias field="operacional" index="8" name=""/>
    <alias field="situacaofisica" index="9" name=""/>
    <alias field="nrpistas" index="10" name=""/>
    <alias field="nrfaixas" index="11" name=""/>
    <alias field="trafego" index="12" name=""/>
    <alias field="canteirodivisorio" index="13" name=""/>
    <alias field="id_via_rodoviaria" index="14" name=""/>
    <alias field="length_otf" index="15" name=""/>
  </aliases>
  <excludeAttributesWMS/>
  <excludeAttributesWFS/>
  <defaults>
    <default applyOnUpdate="0" field="id" expression=""/>
    <default applyOnUpdate="0" field="geometriaaproximada" expression=""/>
    <default applyOnUpdate="0" field="codtrechorodov" expression=""/>
    <default applyOnUpdate="0" field="tipotrechorod" expression=""/>
    <default applyOnUpdate="0" field="jurisdicao" expression=""/>
    <default applyOnUpdate="0" field="administracao" expression=""/>
    <default applyOnUpdate="0" field="concessionaria" expression=""/>
    <default applyOnUpdate="0" field="revestimento" expression=""/>
    <default applyOnUpdate="0" field="operacional" expression=""/>
    <default applyOnUpdate="0" field="situacaofisica" expression=""/>
    <default applyOnUpdate="0" field="nrpistas" expression=""/>
    <default applyOnUpdate="0" field="nrfaixas" expression=""/>
    <default applyOnUpdate="0" field="trafego" expression=""/>
    <default applyOnUpdate="0" field="canteirodivisorio" expression=""/>
    <default applyOnUpdate="0" field="id_via_rodoviaria" expression=""/>
    <default applyOnUpdate="0" field="length_otf" expression=""/>
  </defaults>
  <constraints>
    <constraint unique_strength="1" field="id" constraints="3" exp_strength="0" notnull_strength="1"/>
    <constraint unique_strength="0" field="geometriaaproximada" constraints="1" exp_strength="0" notnull_strength="1"/>
    <constraint unique_strength="0" field="codtrechorodov" constraints="0" exp_strength="0" notnull_strength="0"/>
    <constraint unique_strength="0" field="tipotrechorod" constraints="1" exp_strength="0" notnull_strength="1"/>
    <constraint unique_strength="0" field="jurisdicao" constraints="1" exp_strength="0" notnull_strength="1"/>
    <constraint unique_strength="0" field="administracao" constraints="1" exp_strength="0" notnull_strength="1"/>
    <constraint unique_strength="0" field="concessionaria" constraints="0" exp_strength="0" notnull_strength="0"/>
    <constraint unique_strength="0" field="revestimento" constraints="1" exp_strength="0" notnull_strength="1"/>
    <constraint unique_strength="0" field="operacional" constraints="1" exp_strength="0" notnull_strength="1"/>
    <constraint unique_strength="0" field="situacaofisica" constraints="1" exp_strength="0" notnull_strength="1"/>
    <constraint unique_strength="0" field="nrpistas" constraints="0" exp_strength="0" notnull_strength="0"/>
    <constraint unique_strength="0" field="nrfaixas" constraints="0" exp_strength="0" notnull_strength="0"/>
    <constraint unique_strength="0" field="trafego" constraints="1" exp_strength="0" notnull_strength="1"/>
    <constraint unique_strength="0" field="canteirodivisorio" constraints="1" exp_strength="0" notnull_strength="1"/>
    <constraint unique_strength="0" field="id_via_rodoviaria" constraints="0" exp_strength="0" notnull_strength="0"/>
    <constraint unique_strength="0" field="length_otf" constraints="0" exp_strength="0" notnull_strength="0"/>
  </constraints>
  <constraintExpressions>
    <constraint exp="" desc="" field="id"/>
    <constraint exp="" desc="" field="geometriaaproximada"/>
    <constraint exp="" desc="" field="codtrechorodov"/>
    <constraint exp="" desc="" field="tipotrechorod"/>
    <constraint exp="" desc="" field="jurisdicao"/>
    <constraint exp="" desc="" field="administracao"/>
    <constraint exp="" desc="" field="concessionaria"/>
    <constraint exp="" desc="" field="revestimento"/>
    <constraint exp="" desc="" field="operacional"/>
    <constraint exp="" desc="" field="situacaofisica"/>
    <constraint exp="" desc="" field="nrpistas"/>
    <constraint exp="" desc="" field="nrfaixas"/>
    <constraint exp="" desc="" field="trafego"/>
    <constraint exp="" desc="" field="canteirodivisorio"/>
    <constraint exp="" desc="" field="id_via_rodoviaria"/>
    <constraint exp="" desc="" field="length_otf"/>
  </constraintExpressions>
  <expressionfields>
    <field precision="0" comment="" length="0" typeName="" expression="$length" type="6" name="length_otf" subType="0"/>
  </expressionfields>
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
  <layerGeometryType>1</layerGeometryType>
</qgis>
