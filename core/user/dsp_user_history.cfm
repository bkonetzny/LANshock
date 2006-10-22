<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfoutput>
<div class="headline">#request.content.status_history#</div>
	
<table class="list">
	<tr>
		<th>#request.content.history_date#</th>
		<th>#request.content.history_status#</th>
		<th>#request.content.history_admin#</th>
	</tr>
	<cfloop query="qUserHistory">
		<cfif ListLen(status) EQ 2 AND ListFirst(status,',') EQ 'status_payment'>
			<cftry>
				<cfset sStatusText = '#request.content.payment_paid_entry# "#stModuleConfig.entry[ListFirst(ListLast(status,','),'/')].name#" -> "#stModuleConfig.entry[ListLast(ListLast(status,','),'/')].name#"'>
				<cfcatch>
					<cfset sStatusText = "#request.content.status_unknown_status_error# (#status#)">
				</cfcatch>
			</cftry>
		<cfelse>
			<cftry>
				<cfset sStatusText = request.content[status]>
				<cfcatch>
					<cfset sStatusText = "#request.content.status_unknown_status_error# (#status#)">
				</cfcatch>
			</cftry>
		</cfif>
		<tr>
			<td>#UDF_DateTimeFormat(datetime)#</td>
			<td>#sStatusText#</td>
			<td>#GetUsernameByID(admin_id)#</td>
		</tr>
	</cfloop>
</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">