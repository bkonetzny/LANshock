<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfcomponent hint="LANshock SmileySet">

	<cffunction name="getSmileySet" output="false" returntype="struct">

		<cfscript>
			var line = '';
			var iLineLen = '';
			var iLineIndex = '';
			var sTypeName = '';
			var linepart = '';
			var sAslName = '';
			var sSmileyFile = '';
			var sSmiley = '';
			var lSmiley = '';
			var aSmiley = '';
			var sSmileyDir = application.lanshock.settings.layout.smileyset;
			var stSmileySet = StructNew();
			var idxSmiley = '';
			var idxSmiley2 = '';

			stSmileySet.path_abs = '#application.lanshock.environment.abspath#core/_utils/smileys/#sSmileyDir#/';
			stSmileySet.path_web = '#application.lanshock.environment.webpath#core/_utils/smileys/#sSmileyDir#/';
			stSmileySet.name = '';
			stSmileySet.author = '';
			stSmileySet.date = '';
			stSmileySet.version = '';
			stSmileySet.selectionsize = '';
			stSmileySet.smiley = StructNew();
			stSmileySet.smiley2 = StructNew();
		</cfscript>
		
		<cfdirectory name="sAslName" directory="#stSmileySet.path_abs#" filter="*.asl">
		<cfset stSmileySet.file = sAslName.name>
		<cffile action="read" file="#stSmileySet.path_abs##stSmileySet.file#" variable="stSmileySet.data">
		
		<cfloop list="#stSmileySet.data#" delimiters="#chr(13)#" index="line">
			
			<cfset iLineLen = ListLen(line,' ')>
			<cfset iLineIndex = 0>
			<cfset sTypeName = ''>
			<cfloop list="#line#" delimiters=" " index="linepart">
				
				<cfset iLineIndex = iLineIndex + 1>
				<cfset linepart = trim(linepart)>
				
				<cfif iLineIndex EQ 1>
				
					<cfswitch expression="#linepart#">
						<cfcase value="name">
							<cfset sTypeName = 'name'>
						</cfcase>
						<cfcase value="author">
							<cfset sTypeName = 'author'>
						</cfcase>
						<cfcase value="date">
							<cfset sTypeName = 'date'>
						</cfcase>
						<cfcase value="version">
							<cfset sTypeName = 'version'>
						</cfcase>
						<cfcase value="selectionsize">
							<cfset sTypeName = 'selectionsize'>
						</cfcase>
						<cfcase value="smiley">
							<cfset sTypeName = 'smiley'>
						</cfcase>
					</cfswitch>
		
				</cfif>
				
				<cfswitch expression="#sTypeName#">
					<cfcase value="name">
						<cfset stSmileySet.name = ListLast(line,'"')>
					</cfcase>
					<cfcase value="author">
						<cfset stSmileySet.author = ListLast(line,'"')>
					</cfcase>
					<cfcase value="date">
						<cfset stSmileySet.date = ListLast(line,'"')>
					</cfcase>
					<cfcase value="version">
						<cfset stSmileySet.version = ListLast(line,'"')>
					</cfcase>
					<cfcase value="selectionsize">
						<cfset stSmileySet.selectionsize = ListLast(line,'=')>
					</cfcase>
					<cfcase value="smiley">
						<cfscript>
							sSmileyFile = ListGetAt(line,2,'"');
							sSmileyFile = Replace(sSmileyFile,'.\','/','all');
							sSmileyFile = Replace(sSmileyFile,'\','/','all');
							sSmileyFile = trim(sSmileyFile);
							
							lSmiley = ListGetAt(line,4,'"');
							aSmiley = ArrayNew(1);
						</cfscript>
						<cfloop list="#lSmiley#" delimiters=" " index="idxSmiley">
							<cfscript>
								sSmiley = idxSmiley;
								sSmiley = Replace(sSmiley,'%%__%%',' ','ALL');
								sSmiley = Replace(sSmiley,"%%''%%",'"','ALL');
								ArrayAppend(aSmiley,trim(sSmiley));
							</cfscript>
						</cfloop>
						<cfset stSmileySet.smiley[sSmileyFile] = aSmiley>
					</cfcase>
				</cfswitch>
		
			</cfloop>
		
		</cfloop>
		
		
		<cfloop collection="#stSmileySet.smiley#" item="idxSmiley">
		
			<cfloop from="1" to="#ArrayLen(stSmileySet.smiley[idxSmiley])#" index="idxSmiley2">
				
				<cfset stSmileySet.smiley2[stSmileySet.smiley[idxSmiley][idxSmiley2]] = idxSmiley>
				
			</cfloop>
		
		</cfloop>
		
		<cfset stSmileySet.lSmileys = request.libs.ListSortByLen(StructKeyList(stSmileySet.smiley2),'desc')>
		
		<cfreturn stSmileySet>
		
	</cffunction>

	<cffunction name="getSmileySetList" output="false" returntype="query">

		<cfscript>
			var stLocal = StructNew();
			stLocal.path_abs = '#application.lanshock.environment.abspath#core/_utils/smileys/';
		</cfscript>
		
		<cfdirectory name="stLocal.qSmileySets" directory="#stLocal.path_abs#">
		
		<cfquery dbtype="query" name="stLocal.qSmileySetsDirs">
			SELECT * FROM stLocal.qSmileySets WHERE type = 'Dir'
		</cfquery>
		
		<cfreturn stLocal.qSmileySetsDirs>
		
	</cffunction>

</cfcomponent>