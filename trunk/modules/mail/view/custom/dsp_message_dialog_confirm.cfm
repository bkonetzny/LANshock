<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfhtmlhead text='<title>#request.content.message_has_been_sent#</title>'>

<cfoutput>
<script type="text/javascript">
	<!--
		setTimeout('self.close()',1500);
	//-->
</script>
<table style="height: 100%; width: 100%;">
	<tr>
		<td align="center" valign="middle">
			#request.content.message_has_been_sent#
			<br>&nbsp;<br>
			<input type="button" onClick="javascript:self.close()" value="#request.content.close_window#">
		</td>
	</tr>
</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">