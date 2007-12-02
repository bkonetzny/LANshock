<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/admin/dsp_import_lansurfer.cfm $
$LastChangedDate: 2006-10-23 00:59:26 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 56 $
--->

<cfoutput>
	<cfif isdefined("iImportedData")>
		<div class="text_important">#iImportedData# #request.content.data_imported#</div>
	</cfif>

	<table>
		<form action="#myself##myfusebox.thiscircuit#.import&#request.session.UrlToken#" enctype="multipart/form-data" method="post">
		<input type="hidden" name="form_submitted" value="true">
		<input type="hidden" name="type" value="#attributes.type#">
		<tr>
			<td><input type="file" name="file"></td>
		</tr>
		<tr>
			<td><div class="headline2">Userdata</div></td>
		</tr>
		<tr>
			<td><input type="Checkbox" name="opt_user_import" id="opt_user_import" value="true"<cfif attributes.opt_user_import> checked</cfif>> <label for="opt_user_import">#request.content.import_lansurfer_user#</label><br>
				<input type="Checkbox" name="opt_user_delete" id="opt_user_delete" value="true"<cfif attributes.opt_user_delete> checked</cfif>> <label for="opt_user_delete">#request.content.import_lansurfer_user_del#</label></td>
		</tr>
		<cfif StructKeyExists(application.module,'m_event')>
		<tr>
			<td><div class="headline2">Events</div></td>
		</tr>
		<tr>
			<td><input type="Checkbox" name="opt_event_payment" id="opt_event_payment" value="true"<cfif attributes.opt_event_payment> checked</cfif>> <label for="opt_event_payment">Import Payment Informationen</label><br>
				<input type="Checkbox" name="opt_event_new" id="opt_event_new" value="true"<cfif attributes.opt_event_new> checked</cfif>> <label for="opt_event_new">Create New Event</label></td>
		</tr>
		<tr>
			<td>For Event: <select name="event_id">
				<cfloop query="qEvents">
					<option value="#id#"<cfif attributes.opt_event_id EQ id> selected</cfif>>#name#</option>
				</cfloop>
			</select></td>
		</tr>
		</cfif>
		<cfif StructKeyExists(application.module,'m_seatplan')>
		<tr>
			<td><div class="headline2">Seatplan</div></td>
		</tr>
		<tr>
			<td><input type="Checkbox" name="opt_seatplan_import" id="opt_seatplan_import" value="true"<cfif attributes.opt_seatplan_import> checked</cfif>> <label for="opt_seatplan_import">#request.content.import_lansurfer_seatplan#</label><br>
				<input type="Checkbox" name="opt_seatplan_delete" id="opt_seatplan_delete" value="true"<cfif attributes.opt_seatplan_delete> checked</cfif>> <label for="opt_seatplan_delete">#request.content.import_lansurfer_seatplan_del#</label></td>
		</tr>
		</cfif>
		<tr>
			<td><input type="Submit" name="submit" value="#request.content.import#"></td>
		</tr>
		</form>
	</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">