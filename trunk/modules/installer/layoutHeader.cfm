<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/installer/layoutHeader.cfm $
$LastChangedDate: 2006-10-23 00:39:57 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 51 $
--->

<cfoutput>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
	<title>#request.content.__globalmodule__name#</title>
	<style>
	/* =THE BIG GUYS */
	html {margin:0;padding:0}
	body {text-align:left;background: ##5A7EB9 url("full_page_bg.gif") repeat-x 0 0;margin:0;padding:10px;color:##fff;font:76%/1.5 arial,tahoma,verdana,sans-serif}
	
	/* =LINKS */
	a,a:link,a:visited,a:hover,a:active {background:transparent;text-decoration:underline;cursor:pointer;padding:2px 0} 
	a:link, a:visited, a:hover, a:active {color:##E17000}
	a:hover {color:##fff;background:##E17000} 
	
	ul {position:relative;margin: 0 .3em 1em 0;padding: 0;list-style-type:none}
	ol {margin: .5em .5em}
	ol li {margin-left: 2em;padding-left: 0;background: none; list-style-type: decimal}
	li {line-height: 1.3em;padding-left: 20px;background: transparent url("images/sprites.gif") no-repeat 0 -100px}
	ul.nomarker li {background:none;padding-left:0}
	
	##wrap {text-align:left;border: 8px solid ##eee;background:##fff;width:460px;margin: 20px auto;padding: 10px;color:##000}
	
	td {text-align:left}
	
	.languages {text-align:right;}
	
	.logo {text-align:center}
	.logo img {margin:0 auto; padding-bottom: 30px;}
	table {border-collapse:collapse;border:none;border: 1px solid ##fff}
	table td, table th {font-size: 12px; text-align: left; background:##fff; font-weight:bold; border-bottom: 1px solid ##eee; padding: 5px;}
	
	##status, ##navigation {width: 100%; padding: 0; border-top: 1px solid ##E17000; border-bottom: 1px solid ##E17000;}
	##content, ##navigation {text-align: center;}
	
	##status {margin-bottom: 30px;}
	##status ul {width: 100%; margin: 0px; padding: 0;}
	##status li {width: 25%; float: left; margin: 0px; padding: 0; text-align: center;}
	##status li.active {font-weight: bold; background-color: ##eee; color: ##E17000;}

	##navigation {margin-top: 30px;}
	##navigation ul {width: 100%; margin: 0px; padding: 0;}
	##navigation li {width: 50%; float: left; margin: 0px; padding: 0; text-align: center;display:block;}
	##navigation li a {display:block; text-decoration: none;}
	##navigation li.active {font-weight: bold; background-color: ##eee; color: ##E17000;}
	
	.text_important {font-weight: bold; color: ##E17000;}
</style>
</head>

<body>
<div id="wrap">
	<div class="languages"><a href="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&newlang=de_DE&#request.session.urltoken#">[de]</a> <a href="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&newlang=en_US&#request.session.urltoken#">[en]</a></div>
	<div class="logo"><img src="core/lanshock.gif"></div>

	<div id="status">
		<ul>
			<li<cfif myfusebox.thisfuseaction EQ 'setpassword' OR myfusebox.thisfuseaction EQ 'login'> class="active"</cfif>>
				<cfif myfusebox.thisfuseaction EQ 'setpassword'>#request.content.setpassword_headline#
				<cfelse>#request.content.login#</cfif></li>
			<li<cfif myfusebox.thisfuseaction EQ 'config'> class="active"</cfif>>#request.content.configuration#</li>
			<li<cfif myfusebox.thisfuseaction EQ 'rootuser'> class="active"</cfif>>#request.content.root_account#</li>
			<li<cfif myfusebox.thisfuseaction EQ 'viewapp'> class="active"</cfif>>#request.content.launch_system#</li>
		</ul>
	</div>
	
	<div id="content">
</cfoutput>

<cfsetting enablecfoutputonly="No">