<!--
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
-->

<circuit access="public">
	
	<!-- Copy of Gallerylist -->
	<fuseaction name="main">
		<do action="gallerylist"/>
	</fuseaction>
	
	<!-- Show General-Settings -->
	<fuseaction name="general_settings">
		<set name="check" value="#UDF_SecurityCheck(area='configure')#"/>
		<include template="act_general_settings.cfm"/>
		<include template="dsp_general_settings.cfm"/>
	</fuseaction>

	<!-- Show Gallerylist -->
	<fuseaction name="gallerylist">
		<include template="act_gallerylist.cfm"/>
		<include template="dsp_gallerylist.cfm"/>
	</fuseaction>

	<!-- Show Gallery -->
	<fuseaction name="gallery">
		<include template="act_gallery.cfm"/>
		<include template="dsp_gallery.cfm"/>
	</fuseaction>

	<!-- Show Item -->
	<fuseaction name="item">
		<include template="act_item.cfm"/>
		<include template="dsp_item.cfm"/>
	</fuseaction>

	<!-- Edit Gallery -->
	<fuseaction name="gallery_edit">
		<include template="act_gallery_edit.cfm"/>
		<include template="dsp_gallery_edit.cfm"/>
	</fuseaction>

	<!-- ZIP Gallery -->
	<fuseaction name="gallery_zip">
		<include template="act_gallery_zip.cfm"/>
	</fuseaction>
	
	<!-- Delete Gallery -->
	<fuseaction name="gallery_delete">
		<include template="act_gallery_delete.cfm"/>
		<include template="dsp_gallery_delete.cfm"/>
	</fuseaction>
	
	<!-- Edit Item -->
	<fuseaction name="item_edit">
		<include template="act_item_edit.cfm"/>
		<include template="dsp_item_edit.cfm"/>
	</fuseaction>
	
	<!-- Item Zip Upload -->
	<fuseaction name="item_zip_upload">
		<include template="act_item_zip_upload.cfm"/>
		<include template="dsp_item_zip_upload.cfm"/>
	</fuseaction>
	
	<!-- Delete Item -->
	<fuseaction name="item_delete">
		<include template="act_item_delete.cfm"/>
		<include template="dsp_item_delete.cfm"/>
	</fuseaction>
	
</circuit>