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
	<h3>$$$ Webmail Detail</h3>
	
	<h4>$$$ Mail Info</h4>
	
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
	
	<h4>$$$ Message Body</h4>
	
	#ConvertText(qPop.body)#
</cfoutput>

<!--- <cfdump var="#qPop#"> --->

<cfsetting enablecfoutputonly="No">