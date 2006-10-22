<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfcomponent hint="Session Manager">
	
	<cffunction name="refreshSessionCache" output="false">
		<cfargument name="cache" type="struct" default="#StructNew()#">
		<cfargument name="timeout" type="numeric" default="300">
		
		<cfscript>
			var stCache = '';
			var stSessions = '';
		</cfscript>
		
		<cfparam name="arguments.cache.stSessions" default="#StructNew()#">
		
		<cfscript>
			stCache = StructNew();
			stCache.iOnlineUser = 0;
			stCache.iOnlineGuest = 0;
			stCache.lUserIDs = '';
			stSessions = arguments.cache.stSessions;
			sKey = '';

			if(NOT listFind('CFSCHEDULE,ColdFusion,LANshock Cron Service',cgi.http_user_agent)){
				if(ListLen(cgi.query_string,'=') GTE 2 AND ListLen(ListDeleteAt(cgi.query_string,1,'='),'.') GTE 2){
					sKey = request.session.urltoken;
					stSessions[sKey] = StructNew();
					stSessions[sKey].query_string = cgi.query_string;
					stSessions[sKey].http_user_agent = cgi.http_user_agent;
					stSessions[sKey].session = request.session;
					stSessions[sKey].fusebox = StructNew();
					stSessions[sKey].fusebox.urlvalue = ListFirst(ListDeleteAt(cgi.query_string,1,'='),'&');
					stSessions[sKey].fusebox.circuit = ListFirst(stSessions[sKey].fusebox.urlvalue,'.');
					stSessions[sKey].fusebox.action = ListLast(stSessions[sKey].fusebox.urlvalue,'.');
				}
			}
			
			// remove users with timeout
			for(idx in stSessions){
				if(NOT StructKeyExists(stSessions[idx].session,'timestamp') OR DateDiff('s', stSessions[idx].session.timestamp, now()) GT arguments.timeout) StructDelete(stSessions, idx);
				else{
					if(len(sKey)){
						stCache.lUserIDs = ListAppend(stCache.lUserIDs,stSessions[sKey].session.userid);
					
						if(StructKeyExists(stSessions[idx].session, 'userloggedin') AND stSessions[idx].session.userloggedin) stCache.iOnlineUser = stCache.iOnlineUser + 1;
						else stCache.iOnlineGuest = stCache.iOnlineGuest + 1;
					}
				}
			}
			
			stCache.iActiveSessions = StructCount(stSessions);
			stCache.stSessions = stSessions;
		</cfscript>
		
		<cfreturn stCache>
	</cffunction>

</cfcomponent>