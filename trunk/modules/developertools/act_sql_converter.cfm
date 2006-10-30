<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfparam name="attributes.form_submitted" default="false">
<cfparam name="attributes.text" default="">
<cfset sResult = ''>

<cfif attributes.form_submitted>
	<cfloop list="#attributes.text#" index="line" delimiters="#chr(13)#">
		<cfscript>
			line = trim(line);
			
			if(right(line,1) EQ ',') line = trim(left(line,len(line)-1));
			
			if(left(line,1) EQ '`'){
				line = trim(right(line,len(line)-1));
				sResult = sResult & '<field name="#ListFirst(line,'`')#"';
				sLineType = '';
				sLineLen = '';
				
				line = trim(right(line,len(line)-len(ListFirst(line,'`'))-1));
				if(ListLen(ListFirst(line,' '),'(') GT 1){
					sLineType = ListFirst(ListFirst(line,' '),'(');
					sLineLen = ListFirst(ListLast(ListFirst(line,' '),'('),')');
				}
				else{
					sLineType = ListFirst(line,' ');
				}
				
				switch(sLineType) {
					case "tinyint":
						sLineType = 'boolean';
						sLineLen = '';
					break;
					case "int":
						sLineType = 'integer';
					break;
				}
				
				sResult = sResult & ' type="#sLineType#"';
				if(len(sLineLen)) sResult = sResult & ' len="#sLineLen#"';
				
				if(len(line)-len(ListFirst(line,' ')))
					line = trim(right(line,len(line)-len(ListFirst(line,' '))));
				else line = '';
				
				if(len(line)){
					if(left(line,8) EQ 'NOT NULL'){
						sResult = sResult & ' null="false"';
						if(len(line)-8 GT 0)
							line = trim(right(line,len(line)-8)); // NOT NULL
						else line = '';
					}
					else sResult = sResult & ' null="true"';
				}
				
				if(len(line) AND left(line,7) EQ 'default'){
				
					line = trim(right(line,len(line)-len('default')));
					if(left(line,1) EQ "'") sDefaultString = ListFirst(line,"'");
					else sDefaultString = ListFirst(line,' ');
					
					sResult = sResult & ' default="#sDefaultString#"';
					
					if(len(line)-len(sDefaultString)-2 GT 0)
						line = trim(right(line,len(line)-len(sDefaultString)-2));
					else line = '';
				}
				
				if(len(line)){
					sResult = sResult & ' special="#line#"';
				}
				
				sResult = sResult & '/>#chr(13)#';
			}
			
			if(left(line,11) EQ 'PRIMARY KEY'){
				line = trim(right(line,len(line)-len('PRIMARY KEY')));
				sPkString = '';
				for (idx=1;idx LTE listlen(line);idx=idx+1){
					sPkString = sPkString & replacelist(listGetAt(line,idx),'(,),`',',,') & ',';
				}
				sResult = sResult & '<index name="#left(sPkString,len(sPkString)-1)#" value=""/>#chr(13)#';
			}
		</cfscript>
	</cfloop>
</cfif>

<cfsetting enablecfoutputonly="No">