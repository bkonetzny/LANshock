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
<div class="headline">#request.content.rss_feed_headline#</div>

<div class="headline2"><a href="#myself##myfusebox.thiscircuit#.rss&mode=short" target="_blank">#request.content.rss_feed_short#</a></div>
#request.content.rss_feed_short_text#

<div class="headline2"><a href="#myself##myfusebox.thiscircuit#.rss&mode=full" target="_blank">#request.content.rss_feed_full#</a></div>
#request.content.rss_feed_full_text#
</cfoutput>

<cfsetting enablecfoutputonly="No">