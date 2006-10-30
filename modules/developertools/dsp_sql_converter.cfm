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
<div class="headline">Convert SQL Schema to XML</div>

<div class="headline2">SQL Schema</div>

<form action="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&#request.session.urltoken#" method="post">
<input type="hidden" name="form_submitted" value="true">
	<textarea name="text" style="width: 100%; height: 200px;">#attributes.text#</textarea>
	<input type="submit" value="Convert">
</form>

<div class="headline2">XML Result</div>

<textarea style="width: 100%; height: 200px;" readonly>#sResult#</textarea>
</cfoutput>

<cfsetting enablecfoutputonly="No">