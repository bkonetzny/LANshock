<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/user/dsp_profile_edit_settings.cfm $
$LastChangedDate: 2006-10-22 23:54:35 +0200 (So, 22 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 33 $
--->

<cfoutput>
<h3>#request.content.misc#</h3>

<cfif ArrayLen(aError)>
	<div class="errorBox">
		<h3>#request.content.error#</h3>
		<ul>
			<cfloop from="1" to="#ArrayLen(aError)#" index="idxError">
			<li>#aError[idxError]#</li>
			</cfloop>
		</ul>
	</div>
</cfif>

<form action="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#')#" class="uniForm" method="post">
	<div class="hidden">
		<input type="hidden" name="form_submitted" value="true"/>
	</div>
	
	<fieldset class="inlineLabels">
		<legend>#request.content.misc#</legend>

		<div class="ctrlHolder">
			<label for="profile_homepage">#request.content.homepage#</label>
			<input type="text" class="textInput" name="homepage" id="profile_homepage" value="#attributes.homepage#"/>
		</div>

		<!--- <div class="ctrlHolder">
			<label for="profile_geo_lat">#request.content.geo_lat#</label>
			<input type="text" class="textInput" name="geo_lat" id="profile_geo_lat" value="#attributes.geo_lat#"/>
		</div>

		<div class="ctrlHolder">
			<label for="profile_geo_long">#request.content.geo_long#</label>
			<input type="text" class="textInput" name="geo_long" id="profile_geo_long" value="#attributes.geo_long#"/>
		</div> --->
		
		<cfparam name="attributes.geo_latlong" default="">
		
		<div class="ctrlHolder">
			<label for="profile_geo_long">Position</label>
			<input type="text" class="textInput" name="geo_latlong" id="geo_latlong" value="#attributes.geo_latlong#">
			<cfif len(application.lanshock.settings.google_maps_key)>
				<p class="formHint">
					<div id="google_map" style="width: 100%; height: 300px;"></div>
				</p>
				<script type="text/javascript" src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=#application.lanshock.settings.google_maps_key#"></script>
				<script type="text/javascript">
					<!--
					$(document).ready(function() {
						if (GBrowserIsCompatible()) {
							function OnMapClicked(oGLatLng){
								map.clearOverlays();
								map.addOverlay(new GMarker(oGLatLng));
								$('##geo_latlong').val(oGLatLng.lat()+','+oGLatLng.lng());
							}
							var map = new GMap2(document.getElementById("google_map"));
							map.addControl(new GLargeMapControl());
							map.addControl(new GMapTypeControl());
							<cfif len(attributes.geo_latlong)>
								map.setCenter(new GLatLng(#attributes.geo_latlong#),6,G_HYBRID_MAP);
								map.addOverlay(new GMarker(new GLatLng(#attributes.geo_latlong#)));
							<cfelse>
								map.setCenter(new GLatLng(0,0),1,G_HYBRID_MAP);
							</cfif>
							GEvent.addListener(map,"click",function(overlay,oGLatLng){if(oGLatLng){OnMapClicked(oGLatLng);}}); 
						}
					});
					//-->
				</script>
			</cfif>
		</div>
		
		<div class="ctrlHolder">
			<label for="profile_signature">#request.content.signature#</label>
			<textarea name="signature" id="profile_signature">#attributes.signature#</textarea>
			<script type="text/javascript">
			<!--
				var sBasePath = "#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/js/";
				var oFCKeditorSignature = new FCKeditor('signature');
				oFCKeditorSignature.BasePath = sBasePath + "fckeditor/";
				oFCKeditorSignature.Config['CustomConfigurationsPath'] = sBasePath + "lanshock_fckeditor_config.js";
				oFCKeditorSignature.ToolbarSet = 'Minimum';
				oFCKeditorSignature.ReplaceTextarea();
			//-->
			</script>
		</div>

	</fieldset>
	<div class="buttonHolder">
		<button type="submit" class="submitButton">#request.content.form_save#</button>
		<button type="cancel" class="cancelButton" id="btnCancel" onclick="javascript:location.href='#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.userdetails')#';">#request.content.form_cancel#</button>
	</div>
</form>
</cfoutput>

<cfsetting enablecfoutputonly="No">