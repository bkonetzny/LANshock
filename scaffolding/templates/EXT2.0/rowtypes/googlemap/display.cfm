<cfoutput>
	<div class="ctrlHolder">
		<label for="formrow_#attributes.stFieldData.uuid#"><cfif attributes.stFieldData.required><em>*</em> </cfif>##request.content.#caller.objectName#_rowtype_label_#attributes.stFieldData.alias###</label>
		<input type="text" class="textInput" name="#attributes.stFieldData.alias#" id="formrow_#attributes.stFieldData.uuid#" value="###caller.Format("o#caller.objectName#.get#attributes.stFieldData.alias#()","#attributes.stFieldData.format#")###"/>
		#chr(60)#cfif len(application.lanshock.settings.google_maps_key)>
			<p class="formHint">
				<div id="formrow_#attributes.stFieldData.uuid#_map" style="width: 100%; height: 300px;"></div>
			</p>
			<script type="text/javascript" src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=#application.lanshock.settings.google_maps_key#"></script>
			<script type="text/javascript">
				<!--
				$(document).ready(function() {
					if (GBrowserIsCompatible()) {
						function OnMapClicked_#attributes.stFieldData.uuid#(oGLatLng){
							map_#attributes.stFieldData.uuid#.clearOverlays();
							map_#attributes.stFieldData.uuid#.addOverlay(new GMarker(oGLatLng));
							$('####formrow_#attributes.stFieldData.uuid#').val(oGLatLng.lat()+','+oGLatLng.lng());
						}
						var map_#attributes.stFieldData.uuid# = new GMap2(document.getElementById("formrow_#attributes.stFieldData.uuid#_map"));
						map_#attributes.stFieldData.uuid#.addControl(new GLargeMapControl());
						map_#attributes.stFieldData.uuid#.addControl(new GMapTypeControl());
						#chr(60)#cfif len(#caller.Format("o#caller.objectName#.get#attributes.stFieldData.alias#()","#attributes.stFieldData.format#")#)>
							map_#attributes.stFieldData.uuid#.setCenter(new GLatLng(###caller.Format("o#caller.objectName#.get#attributes.stFieldData.alias#()","#attributes.stFieldData.format#")###),6,G_HYBRID_MAP);
							map_#attributes.stFieldData.uuid#.addOverlay(new GMarker(new GLatLng(###caller.Format("o#caller.objectName#.get#attributes.stFieldData.alias#()","#attributes.stFieldData.format#")###)));
						#chr(60)#cfelse>
							map_#attributes.stFieldData.uuid#.setCenter(new GLatLng(0,0),1,G_HYBRID_MAP);
						#chr(60)#/cfif>
						GEvent.addListener(map_#attributes.stFieldData.uuid#,"click",function(overlay,oGLatLng){if(oGLatLng){OnMapClicked_#attributes.stFieldData.uuid#(oGLatLng);}});
					}
				});
				//-->
			</script>
		#chr(60)#/cfif>
	</div>
</cfoutput>