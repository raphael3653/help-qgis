<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis labelsEnabled="0" simplifyMaxScale="1" simplifyDrawingHints="0" simplifyLocal="1" version="3.7.0-Master" simplifyAlgorithm="0" styleCategories="AllStyleCategories" minScale="1e+8" readOnly="0" hasScaleBasedVisibilityFlag="0" simplifyDrawingTol="1" maxScale="0">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
  </flags>
  <renderer-v2 type="singleSymbol" symbollevels="0" enableorderby="0" forceraster="0">
    <symbols>
      <symbol type="line" clip_to_extent="1" alpha="1" name="0" force_rhr="0">
        <layer pass="0" enabled="1" class="SimpleLine" locked="0">
          <prop k="capstyle" v="square"/>
          <prop k="customdash" v="5;2"/>
          <prop k="customdash_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="customdash_unit" v="MM"/>
          <prop k="draw_inside_polygon" v="0"/>
          <prop k="joinstyle" v="bevel"/>
          <prop k="line_color" v="190,207,80,255"/>
          <prop k="line_style" v="solid"/>
          <prop k="line_width" v="0.26"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="offset" v="0"/>
          <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <prop k="use_custom_dash" v="0"/>
          <prop k="width_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <data_defined_properties>
            <Option type="Map">
              <Option type="QString" value="" name="name"/>
              <Option name="properties"/>
              <Option type="QString" value="collection" name="type"/>
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
      <Option type="QString" value=""/>
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
              <Option type="QString" value="2" name="Não"/>
              <Option type="QString" value="1" name="Sim"/>
            </Option>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="tipolimmassa">
      <editWidget type="ValueMap">
        <config>
          <Option type="Map">
            <Option type="Map" name="map">
              <Option type="QString" value="1" name="Costa visível da carta"/>
              <Option type="QString" value="6" name="Limite com elemento artificial"/>
              <Option type="QString" value="7" name="Limite interno com foz marítima"/>
              <Option type="QString" value="5" name="Limite interno entre massas e/ou trechos"/>
              <Option type="QString" value="2" name="Margem de massa d`água"/>
              <Option type="QString" value="4" name="Margem direita de trechos de massa d`água"/>
              <Option type="QString" value="3" name="Margem esquerda de trechos de massa d`água"/>
            </Option>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="materialpredominante">
      <editWidget type="ValueMap">
        <config>
          <Option type="Map">
            <Option type="Map" name="map">
              <Option type="QString" value="12" name="Areia"/>
              <Option type="QString" value="13" name="Areia Fina"/>
              <Option type="QString" value="15" name="Argila"/>
              <Option type="QString" value="18" name="Cascalho"/>
              <Option type="QString" value="21" name="Concha"/>
              <Option type="QString" value="20" name="Coral"/>
              <Option type="QString" value="0" name="Desconhecido"/>
              <Option type="QString" value="14" name="Lama"/>
              <Option type="QString" value="16" name="Lodo"/>
              <Option type="QString" value="98" name="Misto"/>
              <Option type="QString" value="97" name="Não Aplicável"/>
              <Option type="QString" value="50" name="Pedra"/>
              <Option type="QString" value="4" name="Rocha"/>
              <Option type="QString" value="19" name="Seixo"/>
            </Option>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="alturamediamargem">
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
    <field name="length_otf">
      <editWidget type="">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
  </fieldConfiguration>
  <aliases>
    <alias field="id" name="" index="0"/>
    <alias field="geometriaaproximada" name="" index="1"/>
    <alias field="tipolimmassa" name="" index="2"/>
    <alias field="materialpredominante" name="" index="3"/>
    <alias field="alturamediamargem" name="" index="4"/>
    <alias field="nomeabrev" name="" index="5"/>
    <alias field="length_otf" name="" index="6"/>
  </aliases>
  <excludeAttributesWMS/>
  <excludeAttributesWFS/>
  <defaults>
    <default field="id" expression="" applyOnUpdate="0"/>
    <default field="geometriaaproximada" expression="" applyOnUpdate="0"/>
    <default field="tipolimmassa" expression="" applyOnUpdate="0"/>
    <default field="materialpredominante" expression="" applyOnUpdate="0"/>
    <default field="alturamediamargem" expression="" applyOnUpdate="0"/>
    <default field="nomeabrev" expression="" applyOnUpdate="0"/>
    <default field="length_otf" expression="" applyOnUpdate="0"/>
  </defaults>
  <constraints>
    <constraint field="id" unique_strength="1" exp_strength="0" constraints="3" notnull_strength="1"/>
    <constraint field="geometriaaproximada" unique_strength="0" exp_strength="0" constraints="1" notnull_strength="1"/>
    <constraint field="tipolimmassa" unique_strength="0" exp_strength="0" constraints="1" notnull_strength="1"/>
    <constraint field="materialpredominante" unique_strength="0" exp_strength="0" constraints="1" notnull_strength="1"/>
    <constraint field="alturamediamargem" unique_strength="0" exp_strength="0" constraints="0" notnull_strength="0"/>
    <constraint field="nomeabrev" unique_strength="0" exp_strength="0" constraints="0" notnull_strength="0"/>
    <constraint field="length_otf" unique_strength="0" exp_strength="0" constraints="0" notnull_strength="0"/>
  </constraints>
  <constraintExpressions>
    <constraint field="id" desc="" exp=""/>
    <constraint field="geometriaaproximada" desc="" exp=""/>
    <constraint field="tipolimmassa" desc="" exp=""/>
    <constraint field="materialpredominante" desc="" exp=""/>
    <constraint field="alturamediamargem" desc="" exp=""/>
    <constraint field="nomeabrev" desc="" exp=""/>
    <constraint field="length_otf" desc="" exp=""/>
  </constraintExpressions>
  <expressionfields>
    <field expression="$length" type="6" typeName="" length="0" subType="0" precision="0" comment="" name="length_otf"/>
  </expressionfields>
  <attributeactions/>
  <attributetableconfig sortExpression="" sortOrder="0" actionWidgetStyle="dropDown">
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
