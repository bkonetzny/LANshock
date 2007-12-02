<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/admin/act_import_lansurfer.cfm $
$LastChangedDate: 2006-10-23 00:59:26 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 56 $
--->

<cfparam name="attributes.opt_event_id" default="">
<cfparam name="attributes.opt_event_new" default="false">
<cfparam name="attributes.opt_event_payment" default="false">
<cfparam name="attributes.opt_user_import" default="false">
<cfparam name="attributes.opt_user_delete" default="false">
<cfparam name="attributes.opt_seatplan_import" default="false">
<cfparam name="attributes.opt_seatplan_delete" default="false">

<cfif StructKeyExists(application.module,'m_event')>
	<cfinvoke component="#application.lanshock.environment.componentpath#modules.event.events" method="getEvents" returnvariable="qEvents">
</cfif>

<cfif attributes.form_submitted>

	<cfscript>
		// if() ArrayAppend(aError,'');
		if(NOT len(attributes.file)) ArrayAppend(aError,'Select File');
		if(attributes.opt_event_payment AND NOT attributes.opt_event_new AND NOT isNumeric(attributes.opt_event_id)) ArrayAppend(aError,'Select Event');
	</cfscript>

	<cfif NOT ArrayLen(aError)>

	<cffile action="READ" file="#attributes.file#" variable="importfile">
	<cfscript>
		// parse the xml file
		xml_datei = XmlParse(importfile);
	</cfscript>
	
	<!--- if xml is an valid xml --->
	<cfif IsXmlDoc(xml_datei)>

		<cfif attributes.opt_user_delete>

			<!--- delete users --->
			<cfquery datasource="#application.lanshock.environment.datasource#">
				DELETE
				FROM user
			</cfquery>

			<!--- delete clans --->
			<cfquery datasource="#application.lanshock.environment.datasource#">
				DELETE
				FROM core_team
			</cfquery>
			<cfquery datasource="#application.lanshock.environment.datasource#">
				DELETE
				FROM core_team_user
			</cfquery>

			<!--- delete Admins --->
			<cfquery datasource="#application.lanshock.environment.datasource#">
				DELETE
				FROM admin
			</cfquery>

		</cfif>
		
		<cfif attributes.opt_seatplan_delete>

			<!--- get all rooms --->
			<cfinvoke component="#application.lanshock.environment.componentpath#modules.seatplan.seatplan" method="getRooms" returnvariable="qRooms">
			
			<!--- delete rooms --->
			<cfloop query="qRooms">
			
				<cfinvoke component="#application.lanshock.environment.componentpath#modules.seatplan.seatplan" method="deleteRoom">
					<cfinvokeargument name="roomid" value="#id#">
				</cfinvoke>
				
			</cfloop>

		</cfif>

		<cfif attributes.opt_user_import>

			<!--- insert userdata --->
		 	<cfloop from="1" to="#StructCount(xml_datei.lansurfer.importdata.users)#" index="idx">
	
				<!--- parse the vars --->
				<cfscript>
					username = xml_datei.lansurfer.importdata.users.user[idx].username.xmltext;
					firstname = xml_datei.lansurfer.importdata.users.user[idx].firstname.xmltext;
					lastname = xml_datei.lansurfer.importdata.users.user[idx].name.xmltext;
					email = xml_datei.lansurfer.importdata.users.user[idx].email.xmltext;
					password = xml_datei.lansurfer.importdata.users.user[idx].password.xmltext;
					type = xml_datei.lansurfer.importdata.users.user[idx].type.xmltext;
					// paid = xml_datei.lansurfer.importdata.users.user[idx].paid.xmltext;
					
					wwclid = xml_datei.lansurfer.importdata.users.user[idx].wwclid.xmltext;
					wwclclanid = xml_datei.lansurfer.importdata.users.user[idx].wwclclanid.xmltext;
					clan = xml_datei.lansurfer.importdata.users.user[idx].clan.xmltext;
					additional_data = '';
					if(len(wwclid)) additional_data = additional_data & "WWCL-ID [#wwclid#];";
					if(len(wwclclanid)) additional_data = additional_data & "WWCL-CLAN-ID [#wwclclanid#];";
					if(len(clan)) additional_data = additional_data & "CLAN [#clan#];";
				</cfscript>
	
				<!--- add to users --->
				<!--- <cfquery datasource="#application.lanshock.environment.datasource#">
					INSERT INTO user 
					SET name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#username#" maxlength="255">,
						firstname = <cfqueryparam cfsqltype="cf_sql_varchar" value="#firstname#" maxlength="255">,
						lastname = <cfqueryparam cfsqltype="cf_sql_varchar" value="#lastname#" maxlength="255">,
						email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#email#" maxlength="255">,
						pwd = <cfqueryparam cfsqltype="cf_sql_varchar" value="#password#" maxlength="255">,
						additional_data = <cfqueryparam cfsqltype="cf_sql_varchar" value="#additional_data#" maxlength="255">,
						paid = <cfqueryparam cfsqltype="cf_sql_integer" value="#paid#" maxlength="1">
				</cfquery> --->
				
				<cfquery datasource="#application.lanshock.environment.datasource#">
					INSERT INTO user 
					SET name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#username#" maxlength="255">,
						firstname = <cfqueryparam cfsqltype="cf_sql_varchar" value="#firstname#" maxlength="255">,
						lastname = <cfqueryparam cfsqltype="cf_sql_varchar" value="#lastname#" maxlength="255">,
						email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#email#" maxlength="255">,
						pwd = <cfqueryparam cfsqltype="cf_sql_varchar" value="#password#" maxlength="255">,
						additional_data = <cfqueryparam cfsqltype="cf_sql_varchar" value="#additional_data#" maxlength="255">
				</cfquery>
				
				<cfinvoke component="#application.lanshock.environment.componentpath#core.user.user" method="getUser" returnvariable="qGetUserID">
					<cfinvokeargument name="email" value="#email#">
				</cfinvoke>
	
				<!--- <cfquery datasource="#application.lanshock.environment.datasource#" name="qGetUserID">
					SELECT id
					FROM user
					WHERE email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#email#" maxlength="255">
				</cfquery> --->
	
				<!--- if user is Admin --->
				<cfif type EQ 3 AND qGetUserID.recordcount EQ 1>
	
					<!--- add to Admins --->
					<cfquery datasource="#application.lanshock.environment.datasource#">
						INSERT INTO admin (user, security)
						VALUES (<cfqueryparam cfsqltype="cf_sql_integer" value="#qGetUserID.id#" maxlength="10">,
								'globaladmin')
					</cfquery>
	
				</cfif>
	
			</cfloop>
			
			<cfset iImportedData = idx>

		</cfif>

		<cfif attributes.opt_event_payment>
		
			<cfif attributes.opt_event_new>
				
				<cfinvoke component="#application.lanshock.environment.componentpath#modules.event.events" method="setEvent" returnvariable="iEventID">
					<cfinvokeargument name="id" value="0">
					<cfinvokeargument name="name" value="#xml_datei.lansurfer.LANsurfer_header.event.xmltext#">
					<cfinvokeargument name="max_guest" value="0">
					<cfinvokeargument name="price" value="0">
				</cfinvoke>
				<cfset attributes.opt_event_id = iEventID>
			</cfif>

			<!--- insert userdata --->
		 	<cfloop from="1" to="#StructCount(xml_datei.lansurfer.importdata.users)#" index="idx">
	
				<!--- parse the vars --->
				<cfscript>
					email = xml_datei.lansurfer.importdata.users.user[idx].email.xmltext;
					paid = xml_datei.lansurfer.importdata.users.user[idx].paid.xmltext;
				</cfscript>
				
				<cfinvoke component="#application.lanshock.environment.componentpath#core.user.user" method="getUser" returnvariable="qGetUserID">
					<cfinvokeargument name="email" value="#email#">
				</cfinvoke>

				<cfinvoke component="#application.lanshock.environment.componentpath#modules.event.guest" method="setUserPayment">
					<cfinvokeargument name="user_id" value="#qGetUserID.id#">
					<cfinvokeargument name="event_id" value="#attributes.opt_event_id#">
					<cfinvokeargument name="value" value="#paid#">
					<cfinvokeargument name="dt_created" value="#now()#">
					<cfinvokeargument name="has_paid" value="#paid#">
				</cfinvoke>
	
			</cfloop>

		</cfif>

		<cfif attributes.opt_seatplan_import>

			<!--- insert seatplandata --->
		 	<cfloop from="1" to="#StructCount(xml_datei.lansurfer.importdata.seat_blocks)#" index="idxSeatBlocks">

				<!--- create rooms --->
				<cfinvoke component="#application.lanshock.environment.componentpath#modules.seatplan.seatplan" method="setRoom" returnvariable="iRoomID">
					<cfinvokeargument name="name" value="#xml_datei.lansurfer.importdata.seat_blocks.block[idxSeatBlocks].name.xmltext#">
				</cfinvoke>
			
				<cfscript>
					args = StructNew();
					args.roomid = iRoomID;
					args.number = val(xml_datei.lansurfer.importdata.seat_blocks.block[idxSeatBlocks].cols.xmltext + 1);
				</cfscript>
				
				<cfinvoke component="#application.lanshock.environment.componentpath#modules.seatplan.seatplan" method="addCol" argumentcollection="#args#">
					
				<cfscript>
					args = StructNew();
					args.roomid = iRoomID;
					args.number = val(xml_datei.lansurfer.importdata.seat_blocks.block[idxSeatBlocks].rows.xmltext + 1);
				</cfscript>
				
				<cfinvoke component="#application.lanshock.environment.componentpath#modules.seatplan.seatplan" method="addRow" argumentcollection="#args#">
				
				<!--- insert seats for current block --->
				<cfloop from="1" to="#StructCount(xml_datei.lansurfer.importdata.seat_blocks.block[idxSeatBlocks].seat_seats)#" index="idxSeats">
				
					<cfinvoke component="#application.lanshock.environment.componentpath#modules.seatplan.seatplan" method="changeElement">
						<cfinvokeargument name="roomid" value="#iRoomID#">
						<cfinvokeargument name="row" value="#val(xml_datei.lansurfer.importdata.seat_blocks.block[idxSeatBlocks].seat_seats.seat[idxSeats].row.xmltext + 1)#">
						<cfinvokeargument name="col" value="#val(xml_datei.lansurfer.importdata.seat_blocks.block[idxSeatBlocks].seat_seats.seat[idxSeats].col.xmltext + 1)#">
					</cfinvoke>
					
					<!--- check if seat has an owner --->
					<cfif len(xml_datei.lansurfer.importdata.seat_blocks.block[idxSeatBlocks].seat_seats.seat[idxSeats].owner.xmltext)>
	
						<!--- get userid for seatowner --->
						<cfinvoke component="#application.lanshock.environment.componentpath#core.user.user" method="getUser" returnvariable="qGetSeatOwnerID">
							<cfinvokeargument name="email" value="#xml_datei.lansurfer.importdata.seat_blocks.block[idxSeatBlocks].seat_seats.seat[idxSeats].owner.xmltext#">
						</cfinvoke>
						
						<!--- get seat id --->
						<cfinvoke component="#application.lanshock.environment.componentpath#modules.seatplan.seatplan" method="getElementIdByCoordinates" returnvariable="iElementID">
							<cfinvokeargument name="roomid" value="#iRoomID#">
							<cfinvokeargument name="row" value="#val(xml_datei.lansurfer.importdata.seat_blocks.block[idxSeatBlocks].seat_seats.seat[idxSeats].row.xmltext + 1)#">
							<cfinvokeargument name="col" value="#val(xml_datei.lansurfer.importdata.seat_blocks.block[idxSeatBlocks].seat_seats.seat[idxSeats].col.xmltext + 1)#">
						</cfinvoke>
						
						<cfif iElementID NEQ 0>
						
							<!--- set seat owner --->
							<cfinvoke component="#application.lanshock.environment.componentpath#modules.seatplan.seatplan" method="setSeatOwner">
								<cfinvokeargument name="seatid" value="#iElementID#">
								<cfinvokeargument name="user" value="#qGetSeatOwnerID.id#">
							</cfinvoke>
						
						</cfif>
	
					</cfif>

				</cfloop>

				<!--- insert seatseperators for current block --->
				<cfloop from="1" to="#StructCount(xml_datei.lansurfer.importdata.seat_blocks.block[idxSeatBlocks].seat_sep)#" index="idxSeatSeperators">
								
					<!--- insert seatseperators --->	
					<cfscript>
						args = StructNew();
						args.roomid = iRoomID;
						args.start = xml_datei.lansurfer.importdata.seat_blocks.block[idxSeatBlocks].seat_sep.sep[idxSeatSeperators].value.xmltext + 1;
						args.number = 1;
					</cfscript>
					
					<cfif len(xml_datei.lansurfer.importdata.seat_blocks.block[idxSeatBlocks].seat_sep.sep[idxSeatSeperators].orientation.xmltext) AND xml_datei.lansurfer.importdata.seat_blocks.block[idxSeatBlocks].seat_sep.sep[idxSeatSeperators].orientation.xmltext>

						<cfinvoke component="#application.lanshock.environment.componentpath#modules.seatplan.seatplan" method="addCol" argumentcollection="#args#">

					<cfelse>
										
						<cfinvoke component="#application.lanshock.environment.componentpath#modules.seatplan.seatplan" method="addRow" argumentcollection="#args#">

					</cfif>

				</cfloop>
	
			</cfloop>

		</cfif>

	</cfif>

	</cfif>

</cfif>

<cfsetting enablecfoutputonly="No">
