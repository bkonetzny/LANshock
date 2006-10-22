<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<!--- <cfsavecontent variable="player_audio">
<object data="#UDF_Module('webPath')#audio-player/player.swf?soundFile=#UrlEncodedFormat(mp3url)#&amp;playerID=1&amp;bg=0xf8f8f8&amp;leftbg=0xeeeeee&amp;lefticon=0x666666&amp;rightbg=0xcccccc&amp;rightbghover=0x999999&amp;righticon=0x666666&amp;righticonhover=0xFFFFFF&amp;text=0x666666&amp;slider=0x666666&amp;track=0xFFFFFF&amp;border=0x666666&amp;loader=0x9FFFB8" type="application/x-shockwave-flash" width="290" height="24" id="audioplayer_#CreateUUID()#">
	<param name="movie" value="#UDF_Module('webPath')#audio-player/player.swf?soundFile=#UrlEncodedFormat(mp3url)#&amp;playerID=1&amp;bg=0xf8f8f8&amp;leftbg=0xeeeeee&amp;lefticon=0x666666&amp;rightbg=0xcccccc&amp;rightbghover=0x999999&amp;righticon=0x666666&amp;righticonhover=0xFFFFFF&amp;text=0x666666&amp;slider=0x666666&amp;track=0xFFFFFF&amp;border=0x666666&amp;loader=0x9FFFB8" />
	<param name="quality" value="high" />
	<param name="menu" value="false" />
	<param name="wmode" value="transparent" />
	<a href="#mp3url#">#mp3url#</a>
</object>
</cfsavecontent>

<cfsavecontent variable="player_video">
<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000"
	codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,0,0"
	width="640" height="400" id="playback" align="middle">
	<param name="allowScriptAccess" value="sameDomain" />
	<param name="movie" value="VideoPlayer.swf?videoFile=http://www.scrollinondubs.com/downloads/video/###FILE###" />
	<param name="quality" value="high" />
	<param name="bgcolor" value="#ffffff" />
	<embed src="VideoPlayer.swf?videoFile=http://www.scrollinondubs.com/downloads/video/###FILE###"
		quality="high" bgcolor="#ffffff" width="640" height="400"
		name="playback" align="middle" allowScriptAccess="sameDomain"
		type="application/x-shockwave-flash"
		pluginspage="http://www.macromedia.com/go/getflashplayer" />
</object>
</cfsavecontent>

<cfscript>
	if(arguments.allow_img){
		sConvertedText = ReReplaceNoCase(sConvertedText, '\[img\]([^[]+)\[/img\]', '<img border="0" src="\1">', 'ALL');
	}

	if(arguments.allow_audio){
		//sConvertedText = ReReplaceNoCase(sConvertedText, '\[audio\]([^[]+)\[/audio\]', '<object data="#replace(UDF_Module('webPath'),'\/','\\/','ALL')#audio-player\/player.swf\?soundFile=#UrlEncodedFormat(/1)#&amp;playerID=1&amp;bg=0xf8f8f8&amp;leftbg=0xeeeeee&amp;lefticon=0x666666&amp;rightbg=0xcccccc&amp;rightbghover=0x999999&amp;righticon=0x666666&amp;righticonhover=0xFFFFFF&amp;text=0x666666&amp;slider=0x666666&amp;track=0xFFFFFF&amp;border=0x666666&amp;loader=0x9FFFB8" type="application\/x-shockwave-flash" width="290" height="24" id="audioplayer_#CreateUUID()#"><param name="movie" value="#replace(UDF_Module('webPath'),'\/','\\/','ALL')#audio-player\/player.swf\?soundFile=#UrlEncodedFormat(/1)#&amp;playerID=1&amp;bg=0xf8f8f8&amp;leftbg=0xeeeeee&amp;lefticon=0x666666&amp;rightbg=0xcccccc&amp;rightbghover=0x999999&amp;righticon=0x666666&amp;righticonhover=0xFFFFFF&amp;text=0x666666&amp;slider=0x666666&amp;track=0xFFFFFF&amp;border=0x666666&amp;loader=0x9FFFB8" \/><param name="quality" value="high" \/><param name="menu" value="false" \/><param name="wmode" value="transparent" \/><a href="/1">/1<\/a><\/object>', 'ALL');
		sConvertedText = ReReplaceNoCase(sConvertedText, '\[audio\]([^[]+)\[/audio\]', '[audio="\1"]', 'ALL');
	}

	if(arguments.allow_video){
		sConvertedText = ReReplaceNoCase(sConvertedText, '\[video\]([^[]+)\[/video\]', '[video="\1"]', 'ALL');
	}

	sConvertedText = ReReplaceNoCase(sConvertedText, '\[quote\]([^[]+)\[/quote\]', '<blockquote>\1</blockquote>', 'ALL');
	sConvertedText = ReReplaceNoCase(sConvertedText, '\[code\]([^[]+)\[/code\]', '<pre>\1</pre>', 'ALL');
	sConvertedText = ReReplaceNoCase(sConvertedText, '\[u\]([^[]+)\[/u\]', '<u>\1</u>', 'ALL');
	sConvertedText = ReReplaceNoCase(sConvertedText, '\[b\]([^[]+)\[/b\]', '<strong>\1</strong>', 'ALL');
	sConvertedText = ReReplaceNoCase(sConvertedText, '\[i\]([^[]+)\[/i\]', '<em>\1</em>', 'ALL');
	sConvertedText = ReReplaceNoCase(sConvertedText, '\[s\]([^[]+)\[/s\]', '<strike>\1</strike>', 'ALL');
	
	sConvertedText = ReplaceNoCase(sConvertedText, '#chr(13)##chr(10)#', '#chr(10)#', 'ALL');
	sConvertedText = ReplaceNoCase(sConvertedText, '#chr(10)##chr(13)#', '#chr(10)#', 'ALL');
	sConvertedText = ReplaceNoCase(sConvertedText, '#chr(13)#', '#chr(10)#', 'ALL');
	sConvertedText = ReplaceNoCase(sConvertedText, '#chr(10)#', '&nbsp;<br>', 'ALL');
	
	if(arguments.allow_url){
		sConvertedText = ReReplaceNoCase(sConvertedText, '\[url=([^]]+)\]([^[]+)\[/url\]', ' <a href="\1" target="_blank">\2</a> ', 'ALL');
		sConvertedText = ReReplaceNoCase(sConvertedText, '\[url\]([^[]+)\[/url\]', '<a href="\1">\1</a> ', 'ALL');
		sConvertedText = ReReplaceNoCase(sConvertedText, '([^=">](ftp|https?)://[^ \t\n<]*)', ' <a href="\1" target="_blank">\1</a> ', 'ALL');
	}
</cfscript> --->

<!---
Author: Jim Davis, the Depressed Press of Boston
Date: October 6, 2002
Contact: webmaster@depressedpress.com
Website: www.depressedpress.com

Full documentation can be found at:
http://www.depressedpress.com/DepressedPress/Content/Development/ColdFusion/Extensions/DP_ParseBBML/Index.cfm

"CF_ColoredCode" and all related code is copyright by Dain Anderson of www.CFCOMET.com.  It is used here with permission.

Copyright (c) 1996-2004, The Depressed Press of Boston (depressedpres.com)

All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

+) Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer. 

+) Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution. 

+) Neither the name of the DEPRESSED PRESS OF BOSTON (DEPRESSEDPRESS.COM) nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission. 

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

--->
<cfscript>
// Set up the complex object arrays
SQLBlocks = ArrayNew(1);
CodeBlocks = ArrayNew(1);

// Convert BBML, if needed
if ( Find("[", sConvertedText) AND Find("]", sConvertedText) ) {

	// Extract SQL Blocks apply formatting
	CurPos=1;
	while (FindNoCase("[sql]", sConvertedText, CurPos) GT 0) {
		sSQLPos = FindNoCase("[sql]", sConvertedText, CurPos) + 5;
		eSQLPos = FindNoCase("[/sql]", sConvertedText, sSQLPos);
		if (eSQLPos EQ 0) {
			break;
		} else {
			CurPos = sSQLPos;
		};
		CurSQLBlock = Mid(sConvertedText, sSQLPos, eSQLPos - sSQLPos);
		sConvertedText = RemoveChars(sConvertedText, sSQLPos, eSQLPos - sSQLPos);
		sConvertedText = Insert("***#Evaluate(ArrayLen(SQLBlocks) + 1)#***", sConvertedText, sSQLPos - 1);
		// Clean up quotes and angle brackets in the code
		CurSQLBlock = Replace(CurSQLBlock, """", "&quot;", "ALL");
		//CurSQLBlock = Replace(CurSQLBlock, "<", "&lt;", "ALL");
		//CurSQLBlock = Replace(CurSQLBlock, ">", "&gt;", "ALL");
		// The following code submitted by Jochem van Dieten.  Used with Permission.
		reservedWords = "ABSOLUTE|ACTION|ADD|ADMIN|AFTER|AGGREGATE|ALIAS|ALL|ALLOCATE|ALTER|AND|ANY|ARE|ARRAY|AS|ASC|ASSERTION|AT|AUTHORIZATION|AVG|BEFORE|BEGIN|BETWEEN|BINARY|BIT|BIT_LENGTH|BLOB|BOOLEAN|BOTH|BREADTH|BY|CALL|CASCADE|CASCADED|CASE|CAST|CATALOG|CHAR|CHAR_LENGTH|CHARACTER|CHARACTER_LENGTH|CHECK|CLASS|CLOB|CLOSE|COALESCE|COLLATE|COLLATION|COLUMN|COMMIT|COMPLETION|CONNECT|CONNECTION|CONSTRAINT|CONSTRAINTS|CONSTRUCTOR|CONTINUE|CONVERT|CORRESPONDING|COUNT|CREATE|CROSS|CUBE|CURRENT|CURRENT_DATE|CURRENT_PATH|CURRENT_ROLE|CURRENT_TIME|CURRENT_TIMESTAMP|CURRENT_USER|CURSOR|CYCLE|DATA|DATE|DAY|DEALLOCATE|DEC|DECIMAL|DECLARE|DEFAULT|DEFERRABLE|DEFERRED|DELETE|DEPTH|DEREF|DESC|DESCRIBE|DESCRIPTOR|DESTROY|DESTRUCTOR|DETERMINISTIC|DIAGNOSTICS|DICTIONARY|DISCONNECT|DISTINCT|DOMAIN|DOUBLE|DROP|DYNAMIC|EACH|ELSE|END|END-EXEC|EQUALS|ESCAPE|EVERY|EXCEPT|EXCEPTION|EXEC|EXECUTE|EXISTS|EXTERNAL|EXTRACT|FALSE|FETCH|FIRST|FLOAT|FOR|FOREIGN|FOUND|FREE|FROM|FULL|FUNCTION|GENERAL|GET|GLOBAL|GO|GOTO|GRANT|GROUP|GROUPING|HAVING|HOST|HOUR|IDENTITY|IGNORE|IMMEDIATE|IN|INDICATOR|INITIALIZE|INITIALLY|INNER|INOUT|sConvertedText|INSENSITIVE|INSERT|INT|INTEGER|INTERSECT|INTERVAL|INTO|IS|ISOLATION|ITERATE|JOIN|KEY|LANGUAGE|LARGE|LAST|LATERAL|LEADING|LEFT|LESS|LEVEL|LIKE|LIMIT|LOCAL|LOCALTIME|LOCALTIMESTAMP|LOCATOR|LOWER|MAP|MATCH|MAX|MIN|MINUTE|MODIFIES|MODIFY|MODULE|MONTH|NAMES|NATIONAL|NATURAL|NCHAR|NCLOB|NEW|NEXT|NO|NONE|NOT|NULL|NULLIF|NUMERIC|OBJECT|OCTET_LENGTH|OF|OFF|OLD|ON|ONLY|OPEN|OPERATION|OPTION|OR|ORDER|ORDINALITY|OUT|OUTER|OUTPUT|OVERLAPS|PAD|PARAMETER|PARAMETERS|PARTIAL|PATH|POSITION|POSTFIX|PRECISION|PREFIX|PREORDER|PREPARE|PRESERVE|PRIMARY|PRIOR|PRIVILEGES|PROCEDURE|PUBLIC|READ|READS|REAL|RECURSIVE|REF|REFERENCES|REFERENCING|RELATIVE|RESTRICT|RESULT|RETURN|RETURNS|REVOKE|RIGHT|ROLE|ROLLBACK|ROLLUP|ROUTINE|ROW|ROWS|SAVEPOINT|SCHEMA|SCOPE|SCROLL|SEARCH|SECOND|SECTION|SELECT|SEQUENCE|SESSION|SESSION_USER|SET|SETS|SIZE|SMALLINT|SOME|SPACE|SPECIFIC|SPECIFICTYPE|SQL|SQLEXCEPTION|SQLSTATE|SQLWARNING|START|STATE|STATEMENT|STATIC|STRUCTURE|SUBSTRING|SUM|SYSTEM_USER|TABLE|TEMPORARY|TERMINATE|THAN|THEN|TIME|TIMESTAMP|TIMEZONE_HOUR|TIMEZONE_MINUTE|TO|TRAILING|TRANSACTION|TRANSLATE|TRANSLATION|TREAT|TRIGGER|TRIM|TRUE|UNDER|UNION|UNIQUE|UNKNOWN|UNNEST|UPDATE|UPPER|USAGE|USER|USING|VALUE|VALUES|VARCHAR|VARIABLE|VARYING|VIEW|WHEN|WHENEVER|WHERE|WITH|WITHOUT|WORK|WRITE|YEAR|ZONE";
		CurSQLBlock = REReplaceNoCase(REReplaceNoCase(" " & CurSQLBlock & " ","([^[:alnum:]])(#reservedWords#)([^[:alnum:]])","\1<strong>\2</strong>\3","All"),"([^[:alnum:]])(#reservedWords#)([^[:alnum:]])","\1<strong>\2</strong>\3","All");
			// End of code submitted by Jochem van Dieten.
		CurSQLBlock = "<pre>#Trim(CurSQLBlock)#</pre>";
		ArrayAppend(SQLBlocks, CurSQLBlock);
	};

		// Extract Code Blocks and apply formatting if CF_ColoredCode if needed
	CurPos=1;
	while (FindNoCase("[code]", sConvertedText, CurPos) GT 0) {
		sCodePos = FindNoCase("[code]", sConvertedText, CurPos) + 6;
		eCodePos = FindNoCase("[/code]", sConvertedText, sCodePos);
		if (eCodePos EQ 0) {
			break;
		} else {
			CurPos = sCodePos;
		};
		CurCodeBlock = Mid(sConvertedText, sCodePos, eCodePos - sCodePos);
		sConvertedText = RemoveChars(sConvertedText, sCodePos, eCodePos - sCodePos);

		// The following code copyrighted by Dain Anderson, www.cfcomet.com.  Used with Permission
		// Pointer to Attributes.Data
		this = CurCodeBlock;
		// Convert many standalone (not within quotes) numbers to blue, ie. myValue = 0
		this = REReplaceNoCase(this, "(gt|lt|eq|is|,|\(|\))([[:space:]]?[0-9]{1,})", "\1<span style='color: blue;'>\2</span>", "ALL");
		// Convert normal tags to navy blue
		this = REReplaceNoCase(this, "&lt;(/?)((!d|b|c(e|i|od|om)|d|e|f(r|o)|h|i|k|l|m|n|o|p|q|r|s|t(e|i|t)|u|v|w|x)[^>]*)&gt;", "<span style='color: navi;'>&lt;\1\2&gt;</span>", "ALL");
		// Convert all table-related tags to teal
		this = REReplaceNoCase(this, "&lt;(/?)(t(a|r|d|b|f|h)([^>]*)|c(ap|ol)([^>]*))&gt;", "<span style='color: teal;'>&lt;\1\2&gt;</span>", "ALL");
		// Convert all form-related tags to orange
		this = REReplaceNoCase(this, "&lt;(/?)((bu|f(i|or)|i(n|s)|l(a|e)|se|op|te)([^>]*))&gt;", "<span style='color: FF8000;'>&lt;\1\2&gt;</span>", "ALL");
		// Convert all tags starting with 'a' to green, since the others aren't used much and we get a speed gain
		this = REReplaceNoCase(this, "&lt;(/?)(a[^>]*)&gt;", "<span style='color: green;'>&lt;\1\2&gt;</span>", "ALL");
		// Convert all image and style tags to purple
		this = REReplaceNoCase(this, "&lt;(/?)((im[^>]*)|(sty[^>]*))&gt;", "<span style='color: purple;'>&lt;\1\2&gt;</span>", "ALL");
		// Convert all ColdFusion, SCRIPT and WDDX tags to maroon
		this = REReplaceNoCase(this, "&lt;(/?)((cf[^>]*)|(sc[^>]*)|(wddx[^>]*))&gt;", "<span style='color: maroon;'>&lt;\1\2&gt;</span>", "ALL");
		// Convert all inline "//" comments to gray (revised)
		this = REReplaceNoCase(this, "([^:/]\/{2,2})([^[:cntrl:]]+)($|[[:cntrl:]])", "<span style='color: gray;'><em>\1\2</em></span>", "ALL");
		// Convert all multi-line script comments to gray
		this = REReplaceNoCase(this, "(\/\*[^\*]*\*\/)", "<span style='color: gray;'><em>\1</em></span>", "ALL");
		// Convert all HTML and ColdFusion comments to gray
		// The next 10 lines of code can be replaced with the commented-out line following them, if you do care whether HTML and CFML comments contain colored markup.
		EOF = 0; BOF = 1;
		while(NOT EOF) {
			sCfmlCommentStart = "<!" & "---";
			Match = REFindNoCase("#sCfmlCommentStart#?([^-]*)-?-->", this, BOF, True);
			if (Match.pos[1]) {
				Orig = Mid(this, Match.pos[1], Match.len[1]);
				Chunk = REReplaceNoCase(Orig, "«(/?[^»]*)»", "", "ALL");
				BOF = ((Match.pos[1] + Len(Chunk)) + 43); // 43 is the length of '<span style='color: gray;'><em></em></span>' in the next line
				this = Replace(this, Orig, "<span style='color: gray;'><em>#Chunk#</em></span>");
			} else EOF = 1;
		}
		// Convert all quoted values to blue
		this = REReplaceNoCase(this, """([^""]*)""", "<span style=""color: blue;"">""\1""</span>", "ALL");
		// ***New Feature*** Convert all FILE and UNC paths to active links (i.e, file:///, \\server\, c:\myfile.cfm)
		this = REReplaceNoCase(this, "(((file:///)|([a-z]:\\)|(\\\\[[:alpha:]]))+(\.?[[:alnum:]\/=^@*|:~`+$%?_##& -])+)", "<a href=""\1"" target=""_blank"">\1</A>", "ALL");
		// Convert all URLs to active links (revised)
		this = REReplaceNoCase(this, "([[:alnum:]]*://[[:alnum:]\@-]*(\.[[:alnum:]][[:alnum:]-]*[[:alnum:]]\.)?[[:alnum:]]{2,}(\.?[[:alnum:]\/=^@*|:~`+$%?_##&-])+)", "<a href=""\1"" target=""_blank"">\1</A>", "ALL");
		// Convert all email addresses to active mailto's (revised)
		this = REReplaceNoCase(this, "(([[:alnum:]][[:alnum:]_.-]*)?[[:alnum:]]@[[:alnum:]][[:alnum:].-]*\.[[:alpha:]]{2,})", "<a href=""mailto:\1"">\1</A>", "ALL");
		this = "<div style=""padding-left : 10px;""><pre>#this#</pre></div>";
		// The above code copyrighted by Dain Anderson, www.cfcomet.com.  Used with Permission
		CurCodeBlock = this;

		ArrayAppend(CodeBlocks, CurCodeBlock);
		sConvertedText = Insert("***#ArrayLen(CodeBlocks)#***", sConvertedText, sCodePos - 1);
	};

	// Validate the [size] tag's limits	
	MaximumFontSize = 25;
	MinimumFontSize = 8;
	CurPos = 1;
	while (ReFindNoCase("\[size=([0-9]*)\]", sConvertedText, CurPos) GT 0) {
		CurPos = ReFindNoCase("\[size=([0-9]*)\]", sConvertedText, CurPos, True);
		CurSize = Mid(sConvertedText, CurPos.pos[2], CurPos.Len[2]);
		if (CurSize GT MaximumFontSize) {
			sConvertedText = ReplaceNoCase(sConvertedText, "[size=#CurSize#]", "[size=#MaximumFontSize#]", "All");
		};
		if (CurSize LT MinimumFontSize) {
			sConvertedText = ReplaceNoCase(sConvertedText, "[size=#CurSize#]", "[size=#MinimumFontSize#]", "All");
		};
		CurPos = CurPos.pos[1] + CurPos.Len[1];
	};
	// Do all simple BBML conversion to HTML
	// The recursive loop, coupled with the regular expressions will validate for proper tag pairs and nesting
	do {
		// Set a temporary variable equal to the sConvertedText - if it changes that means there was some work to be done and another pass is needed.
		TempsConvertedText = sConvertedText;
		// Convert Simple Formatting
		sConvertedText = ReReplaceNoCase(sConvertedText, "\[(b|bold)\]([^[]*)\[/\1\]", "<strong>\2</strong>", "All");
		sConvertedText = ReReplaceNoCase(sConvertedText, "\[(i|italic)\]([^[]*)\[/\1\]", "<em>\2</em>", "All");
		sConvertedText = ReReplaceNoCase(sConvertedText, "\[(u|underline)\]([^[]*)\[/\1\]", "<u>\2</u>", "All");
		sConvertedText = ReReplaceNoCase(sConvertedText, "\[(s|strikethrough)\]([^[]*)\[/\1\]", "<s>\2</s>", "All");
		sConvertedText = ReReplaceNoCase(sConvertedText, "\[(sup|superscript)\]([^[]*)\[/\1\]", "<sup>\2</sup>", "All");
		sConvertedText = ReReplaceNoCase(sConvertedText, "\[(sub|subscript)\]([^[]*)\[/\1\]", "<sub>\2</sub>", "All");
		sConvertedText = ReReplaceNoCase(sConvertedText, "\[center\]([^[]*)\[/center\]", "<div align=""center"">\1</div>", "All");
		// Convert "Color" and "Size"
		sConvertedText = ReReplaceNoCase(sConvertedText, "\[size=([0-9]+)\]([^[]*)\[/size(=\1)?\]", "<span style=""font-size: \1pt;"">\2</span>", "All");
		sConvertedText = ReReplaceNoCase(sConvertedText, "\[color=([##0-9A-Za-z]+)\]([^[]*)\[/color(=\1)?\]", "<span style=""color: \1;"">\2</span>", "All");
		// Convert Special Formatting
		sConvertedText = ReReplaceNoCase(sConvertedText, "\[(q|quote)\]([^[]*)\[/\1\]", "<blockquote>\2</blockquote>", "All");
		sConvertedText = ReReplaceNoCase(sConvertedText, "\[(code)\]([^[]*)\[/\1\]", "<code>\2</code>", "All");
		sConvertedText = ReReplaceNoCase(sConvertedText, "\[(sql)\]([^[]*)\[/\1\]", "<sql>\2</sql>", "All");
		sConvertedText = ReReplaceNoCase(sConvertedText, "\[(pre|preformatted)\]([^[]*)\[/\1\]", "<pre>\2</pre>", "All");

		if(arguments.allow_img){
			// Convert Images
			// sConvertedText = ReReplaceNoCase(sConvertedText, "\[(img|image)\]([^[«]*)\[/(img|image)\]", "<img src=""\2"">", "All");
			sConvertedText = ReReplaceNoCase(sConvertedText, "\[(img|image) width=([0-9]*) height=([0-9]*)\]([^[«]*)\[/(img|image)\]", "<img src=""\4"" width=""\2"" height=""\3"">", "All");
			sConvertedText = ReReplaceNoCase(sConvertedText, "\[(img|image)\]([^[<]*)\[/(img|image)\]", "<img src=""\2"">", "All");
		}
	
		if(arguments.allow_url){
			// Convert Links
			sConvertedText = ReReplaceNoCase(sConvertedText, "\[(url|link)=([^]]*)\]([^[]*)\[/\1\]", "<a href=""\2"">\3</a>", "All");
			sConvertedText = ReReplaceNoCase(sConvertedText, "\[(url|link)\]([^[]*)\[/\1\]", "<a href=""\2"">\2</a>", "All");
			// Convert Email Links
			sConvertedText = ReReplaceNoCase(sConvertedText, "\[email=([^]]*)\]([^[]*)\[/email\]", "<a href=""mailto:\1"">\2</a>", "All");
			sConvertedText = ReReplaceNoCase(sConvertedText, "\[email\]([^[]*)\[/email\]", "<a href=""mailto:\1"">\1</a>", "All");
		}

	// If no changes have been made, break out of the loop - we're done!
	} while (TempsConvertedText NEQ sConvertedText);
};

// Set up Paragraphs and breaks
sConvertedText = Replace(sConvertedText, "#Chr(13)##Chr(10)##Chr(13)##Chr(10)#", "<br>&nbsp;<br>", "ALL");
sConvertedText = Replace(sConvertedText, "#Chr(13)##Chr(10)#", "<br>", "ALL");

// Reinsert code blocks
if (ArrayLen(CodeBlocks) GT 0) {
	for (Cnt = 1; Cnt LTE ArrayLen(CodeBlocks); Cnt = Cnt + 1) {
		sConvertedText = ReplaceNoCase(sConvertedText, "<code>***#Cnt#***</code>", CodeBlocks[Cnt]);
	};
};

// Reinsert SQL blocks
if (ArrayLen(SQLBlocks) GT 0) {
	for (Cnt = 1; Cnt LTE ArrayLen(SQLBlocks); Cnt = Cnt + 1) {
		sConvertedText = ReplaceNoCase(sConvertedText, "<sql>***#Cnt#***</sql>", SQLBlocks[Cnt]);
	};
};
</cfscript>

<cfsetting enablecfoutputonly="No">