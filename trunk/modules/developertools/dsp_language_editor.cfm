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
<div class="headline">Edit Strings</div>

<div class="headline2">Informations</div>

<table cellpadding="5">
	<tr>
		<td>This File:</td>
		<td>#attributes.file# (#stLocales[ListGetAt(ListLast(attributes.file,'/'),2,'.')]#)</td>
	</tr>
	<tr>
		<td>This Directory:</td>
		<td><a href="#myself##myfusebox.thiscircuit#.language_main&directory=#UrlEncodedFormat(attributes.directory)#&#request.session.urltoken#">#attributes.directory#</a></td>
	</tr>
	<cfif qReference.recordcount>
		<tr>
			<td>Current Reference:</td>
			<td>#attributes.reference# (#stLocales[ListGetAt(ListLast(attributes.reference,'/'),2,'.')]#)</td>
		</tr>
		<form action="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&#request.session.urltoken#" method="post">
		<input type="hidden" name="file" value="#attributes.file#">
		<input type="hidden" name="directory" value="#attributes.directory#">
			<tr>
				<td>Change Reference:</td>
				<td><select name="reference">
					<cfloop query="qReference">
						<option value="#name#"<cfif name EQ attributes.reference> selected</cfif>>#stLocales[ListGetAt(ListLast(name,'/'),2,'.')]#</option>
					</cfloop>
				</select> <input type="submit" value="Change Reference File"></td>
			</tr>
		</form>
	<cfelse>
		<tr>
			<td>Current Reference:</td>
			<td>No Reference-Files avaible</td>
		</tr>
	</cfif>
</table>

<div class="headline2">Strings</div>

<div align="center"> |
<cfloop list="_,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z" index="idx">
	<a href="###idx#">#idx#</a> | 
</cfloop>
</div>

<table cellpadding="2">
	<form action="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&#request.session.urltoken#" method="post">
	<input type="hidden" name="form_submitted" value="true">
	<input type="hidden" name="file" value="#attributes.file#">
	<input type="hidden" name="directory" value="#attributes.directory#">
	<tr>
		<td colspan="2" align="center">&nbsp;<br><input type="submit" value="Save String Changes"></td>
	</tr>
	<cfset startkey = ''>
	<cfloop list="#ListSort(StructKeyList(stRBreference),'textnocase')#" index="idx">
		<cfif startkey NEQ left(idx,1)>
			<cfset startkey = left(idx,1)>
			<tr>
				<td colspan="2" style="border-bottom: 1px solid black;">&nbsp;<br><a name="#startkey#"></a><strong>#startkey#</strong></td>
			</tr>
		</cfif>
		<tr>
			<td><cfif NOT StructKeyExists(stRB,idx) OR NOT len(stRB[idx])>
					<span style="color: ##CC0000; font-weight: bold;">#LCase(idx)#:</span>
				<cfelse>
					#LCase(idx)#:
				</cfif></td>
			<td align="right"><em><a href="javascript:clipboardSet('##request.content.#LCase(idx)###');">[Copy]</a></em></td>
		</tr>
		<tr>
			<td colspan="2">
				<cfparam name="stRB['#idx#']" default="">
				<input type="text" name="element_#idx#_" value="#HTMLEditFormat(stRB[idx])#" style="width: 600px;"><br>
				<span style="color: gray;">#HTMLEditFormat(stRBreference[idx])#</span></td>
		</tr>
		<tr>
			<td colspan="2">&nbsp;</td>
		</tr>
	</cfloop>
	<tr>
		<td colspan="2" align="center">&nbsp;<br><input type="submit" value="Save String Changes"></td>
	</tr>
	</form>
</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">