<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/installer/layoutFooter.cfm $
$LastChangedDate: 2006-11-03 21:46:47 +0100 (Fr, 03 Nov 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 73 $
--->

<cfoutput>
		<cfif ListFind('config,rootuser,viewapp',myfusebox.thisfuseaction)>
			<div id="navigation">
				<cfswitch expression="#myfusebox.thisfuseaction#">
					
					<cfcase value="config">
						<ul>
							<li><a href="#myself##myfusebox.thiscircuit#.logout&#request.session.UrlToken#">&laquo #request.content.back#</a></li>
							<li><a href="#myself##myfusebox.thiscircuit#.rootuser&#request.session.UrlToken#">#request.content.next# &raquo;</a></li>
						</ul>
					</cfcase>
					
					<cfcase value="rootuser">
						<ul>
							<li><a href="#myself##myfusebox.thiscircuit#.config&#request.session.UrlToken#">&laquo #request.content.back#</a></li>
							<li><a href="#myself##myfusebox.thiscircuit#.viewapp&#request.session.UrlToken#">#request.content.next# &raquo;</a></li>
						</ul>
					</cfcase>
					
					<cfcase value="viewapp">
						<ul>
							<li><a href="#myself##myfusebox.thiscircuit#.rootuser&#request.session.UrlToken#">&laquo #request.content.back#</a></li>
							<li><a href="#myself#">#request.content.next# &raquo;</a></li>
						</ul>
					</cfcase>
				
				</cfswitch>
			</div>
		</cfif>
	</div>

	<br>&nbsp;<br>

	<table width="100%">
		<tr>
			<td><font size="1">Copyright &copy; 2003 - #year(now())#. <a href="http://www.lanshock.com" target="_blank">LANshock.com</a></font></td>
			<td align="right"><font size="1">#request.lanshock_name#</font></td>
		</tr>
	</table>
</div>

</body>
</html>
</cfoutput>

<cfsetting enablecfoutputonly="No">