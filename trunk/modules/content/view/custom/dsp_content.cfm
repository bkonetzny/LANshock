<cfsetting enablecfoutputonly="Yes">
<!-------------------------------------------------------------------------+
 | Copyright (C) 2002 - 2005 LANshock.com                                  |
 |                                                                         |
 | lastmodified: 04-06-08                                                  |
 |           by: bkonetzny                                                 |
 |                               http://sourceforge.net/projects/lanshock/ |
 | Released Under the GNU General Public License (v2) (see license.txt)    |
 +------------------------------------------------------------------------->

<cfif qContent.recordcount>
	<cfoutput>
		<h3>#qContent.title#</h3>
		#qContent.content#
	</cfoutput>
<cfelse>
	<cfoutput>
		<h3>Content</h3>
		<p>Keine Inhalte gefunden.</p>
	</cfoutput>
</cfif>

<cfsetting enablecfoutputonly="No">