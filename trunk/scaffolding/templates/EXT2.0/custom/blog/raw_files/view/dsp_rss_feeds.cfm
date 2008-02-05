<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/modules/news/dsp_rss_feeds.cfm $
$LastChangedDate: 2006-10-30 23:34:27 +0100 (Mo, 30 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 63 $
--->

<cfoutput>
<h3>#request.content.rss_feed_headline#</h3>

<h4><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.rss&mode=short')#" target="_blank">#request.content.rss_feed_short#</a></h4>
<p>#request.content.rss_feed_short_text#</p>

<h4><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.rss&mode=full')#" target="_blank">#request.content.rss_feed_full#</a></h4>
<p>#request.content.rss_feed_full_text#</p>
</cfoutput>

<cfsetting enablecfoutputonly="No">