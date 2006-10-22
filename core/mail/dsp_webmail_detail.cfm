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
	<div class="headline">$$$ Webmail Detail</div>
	
	<div class="headline2">$$$ Mail Info</div>
	
	<table class="vlist">
		<tr>
			<th>$$$ From</th>
			<td>#qPop.from#</td>
		</tr>
		<tr>
			<th>$$$ To</th>
			<td>#qPop.to#</td>
		</tr>
		<cfif len(qPop.cc)>
			<tr>
				<th>$$$ CC</th>
				<td>#qPop.cc#</td>
			</tr>
		</cfif>
		<tr>
			<th>$$$ Subject</th>
			<td>#qPop.subject#</td>
		</tr>
		<tr>
			<th>$$$ Date</th>
			<td>#UDF_DateTimeFormat(qPop.date)#</td>
		</tr>
	</table>
	
	<div class="headline2">$$$ Message Body</div>
	
	#ConvertText(qPop.body)#
</cfoutput>

<!--- <cfdump var="#qPop#"> --->

<cfsetting enablecfoutputonly="No">