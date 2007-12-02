<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/general/dsp_lanshock_code.cfm $
$LastChangedDate: 2006-10-23 00:36:12 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 50 $
--->

<cfif myfusebox.thisfuseaction EQ 'lanshock_code_popup'>
	<cfhtmlhead text="<title>#request.content.lanshock_code_headline#</title>">
</cfif>

<cfoutput>
<h3>#request.content.lanshock_code_headline#</h3>

<p>#request.content.lanshock_code_txt#</p>

<table>
	<tr>
		<th>#request.content.lanshock_code_codeexample#</th>
		<th>#request.content.lanshock_code_coderesult#</th>
		<th>#request.content.lanshock_code_codetxt#</th>
	</tr>
	<tr>
		<td><strong>[b]</strong>Text<strong>[/b]</strong></td>
		<td><strong>Text</strong></td>
		<td>#request.content.lanshock_code_b#</td>
	</tr>
	<tr>
		<td><strong>[i]</strong>Text<strong>[/i]</strong></td>
		<td><em>Text</em></td>
		<td>#request.content.lanshock_code_i#</td>
	</tr>
	<tr>
		<td><strong>[u]</strong>Text<strong>[/u]</strong></td>
		<td><u>Text</u></td>
		<td>#request.content.lanshock_code_u#</td>
	</tr>
	<tr>
		<td><strong>[quote]</strong>Text<strong>[/quote]</strong></td>
		<td><blockquote>Text</blockquote></td>
		<td>#request.content.lanshock_code_quote#</td>
	</tr>
	<tr>
		<td><strong>[code]</strong>set foo = bla<strong>[/code]</strong></td>
		<td><pre>set foo = bla</pre></td>
		<td>#request.content.lanshock_code_quote#</td>
	</tr>
	<tr>
		<td><strong>[url]</strong>http://example.com/<strong>[/url]</strong></td>
		<td><a href="http://example.com/" target="_blank">http://example.com/</a></td>
		<td>#request.content.lanshock_code_url#</td>
	</tr>
	<tr>
		<td><strong>[url=</strong>http://example.com/<strong>]</strong>Example.com Website<strong>[/url]</strong></td>
		<td><a href="http://example.com/" target="_blank">Example.com Website</a></td>
		<td>#request.content.lanshock_code_url2#</td>
	</tr>
	<tr>
		<td><strong>[img]</strong>http://example.com/image.jpg<strong>[/img]</strong></td>
		<td>&nbsp;</td>
		<td>#request.content.lanshock_code_img#</td>
	</tr>
</table>

<table>
	<tr>
		<th>#request.content.lanshock_code_codeexample#</th>
		<th>#request.content.lanshock_code_coderesult#</th>
	</tr>
	<cfset stSmileySet = application.lanshock.settings.layout.smileyset_data>
	<cfloop collection="#stSmileySet.smiley#" item="idx">
		<tr>
			<td align="center">#stSmileySet.smiley[idx][1]#</td>
			<td align="center"><img border="0" hspace="0" vspace="0" src="#stSmileySet.path_web##idx#"></td>
		</tr>
	</cfloop>
</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">