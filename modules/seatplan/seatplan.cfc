<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfcomponent>

	<cffunction name="getRooms" access="remote" returntype="query" output="false">
		
		<cfquery datasource="#application.lanshock.environment.datasource#" name="qRooms">
			SELECT rd.id, rd.name, rd.cols, rd.rows, COUNT(re.id) AS seats
			FROM seatplan_location_data rd, seatplan_location_elements re
			WHERE rd.id = re.block
			AND re.type = 'seat'
			GROUP BY rd.id
			ORDER BY rd.name
		</cfquery>
		
		<cfset qRooms2 = QueryNew('id,name,cols,rows,seats,seats_free')>
		
		<cfloop query="qRooms">
		
			<cfquery datasource="#application.lanshock.environment.datasource#" name="qGetFreeSeatCount">
				SELECT COUNT(id) AS seats_free
				FROM seatplan_location_elements
				WHERE block = #qRooms.id[currentrow]#
				AND type = 'seat'
				AND guest = 0
			</cfquery>

			<cfscript>
				QueryAddRow(qRooms2,1);
				QuerySetCell(qRooms2,'id',qRooms.id[currentrow],currentrow);
				QuerySetCell(qRooms2,'name',qRooms.name[currentrow],currentrow);
				QuerySetCell(qRooms2,'cols',qRooms.cols[currentrow],currentrow);
				QuerySetCell(qRooms2,'rows',qRooms.rows[currentrow],currentrow);
				QuerySetCell(qRooms2,'seats',qRooms.seats[currentrow],currentrow);
				QuerySetCell(qRooms2,'seats_free',qGetFreeSeatCount.seats_free,currentrow);
			</cfscript>

		</cfloop>
		
		<cfreturn qRooms2>

	</cffunction>
	
	<cffunction name="getRoom" access="remote" returntype="query" output="false">
		<cfargument name="roomid" type="numeric" required="true">

		<cfquery datasource="#application.lanshock.environment.datasource#" name="qRoom">
			SELECT *
			FROM seatplan_location_data
			WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.roomid#">
		</cfquery>
		
		<cfreturn qRoom>

	</cffunction>

	<cffunction name="getSeatByUserID" access="remote" returntype="query" output="false">
		<cfargument name="userid" required="true" type="numeric">

		<cfquery datasource="#application.lanshock.environment.datasource#" name="qUserSeats">
			SELECT s.id, s.block, s.col, s.row, s.status, s.type, b.name
			FROM seatplan_location_elements s, seatplan_location_data b
			WHERE s.guest = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.userid#">
			AND s.block = b.id
		</cfquery>
		
		<cfreturn qUserSeats>

	</cffunction>

	<cffunction name="getSeatLinkDataByUserID" access="remote" returntype="struct" output="false">
		<cfargument name="userid" required="true" type="numeric">
		
		<cfscript>
			stSeat = StructNew();
		</cfscript>

		<cfquery datasource="#application.lanshock.environment.datasource#" name="qUserSeats">
			SELECT s.id, s.block, s.col, s.row, s.status, s.type, b.name, b.labels_x, b.labels_y
			FROM seatplan_location_elements s, seatplan_location_data b
			WHERE s.guest = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.userid#">
			AND s.block = b.id
		</cfquery>
		
		<cfif qUserSeats.recordcount>
			<cfscript>
				if(ListLen(qUserSeats.labels_x) GTE qUserSeats.col) sCurrentCol = ListGetAt(qUserSeats.labels_x,qUserSeats.col);
				else sCurrentCol = '';
				if(ListLen(qUserSeats.labels_y) GTE qUserSeats.row) sCurrentRow = ListGetAt(qUserSeats.labels_y,qUserSeats.row);
				else sCurrentRow = '';
				
				stSeat.id = qUserSeats.id;
				stSeat.block = qUserSeats.block;
				stSeat.description = "#qUserSeats.name# - #sCurrentRow# #sCurrentCol#";
				stSeat.linkurl = "#application.lanshock.settings.modulePrefix.module#seatplan.seatplan&roomid=#qUserSeats.block#&markseat=#qUserSeats.id#";
			</cfscript>
		</cfif>
		
		<cfreturn stSeat>

	</cffunction>

	<cffunction name="getElementByID" access="public" returntype="query" output="false">
		<cfargument name="id" type="numeric" required="true">

		<cfquery datasource="#application.lanshock.environment.datasource#" name="qElement">
			SELECT id, block, col, row, status, type, guest, image
			FROM seatplan_location_elements
			WHERE id = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.id#">
		</cfquery>
		
		<cfreturn qElement>

	</cffunction>

	<cffunction name="setSeatOwner" access="public" returntype="boolean" output="false">
		<cfargument name="seatid" type="numeric" required="true">
		<cfargument name="user" type="numeric" required="true">

		<cfinvoke component="seatplan" method="getElementImages" returnvariable="stElementImages">
		
		<cfscript>
			aSeats = ArrayNew(1);
			aSeatsReserved = ArrayNew(1);
		</cfscript>
		
		<cfloop from="1" to="#ArrayLen(stElementImages.seats)#" index="idx">
			<cfloop from="1" to="#ArrayLen(stElementImages.seats[idx])#" index="idx2">
				<cfset ArrayAppend(aSeats,stElementImages.seats[idx][idx2])>
			</cfloop>
		</cfloop>
		
		<cfloop from="1" to="#ArrayLen(stElementImages.seatsreserved)#" index="idx">
			<cfloop from="1" to="#ArrayLen(stElementImages.seatsreserved[idx])#" index="idx2">
				<cfset ArrayAppend(aSeatsReserved,stElementImages.seatsreserved[idx][idx2])>
			</cfloop>
		</cfloop>

		<cfinvoke component="seatplan" method="getElementByID" returnvariable="qElement">
			<cfinvokeargument name="id" value="#arguments.seatid#">
		</cfinvoke>
		
		<cfscript>
			lSeats = ArrayToList(aSeats);
			lSeatsReserved = ArrayToList(aSeatsReserved);
			sNewImage = ListGetAt(lSeatsReserved, ListFind(lSeats, qElement.image));
		</cfscript>

		<cfquery datasource="#application.lanshock.environment.datasource#">
			UPDATE seatplan_location_elements
			SET guest = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.user#">,
				status = 2,
				image = <cfqueryparam cfsqltype="cf_sql_varchar" value="#sNewImage#">
			WHERE id = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.seatid#">
		</cfquery>
		
		<cfreturn true>

	</cffunction>

	<cffunction name="removeSeatOwner" access="remote" output="false">
		<cfargument name="seatid" type="numeric" required="true">

		<cfinvoke component="seatplan" method="getElementImages" returnvariable="stElementImages">
		
		<cfscript>
			aSeats = ArrayNew(1);
			aSeatsReserved = ArrayNew(1);
		</cfscript>
		
		<cfloop from="1" to="#ArrayLen(stElementImages.seats)#" index="idx">
			<cfloop from="1" to="#ArrayLen(stElementImages.seats[idx])#" index="idx2">
				<cfset ArrayAppend(aSeats,stElementImages.seats[idx][idx2])>
			</cfloop>
		</cfloop>
		
		<cfloop from="1" to="#ArrayLen(stElementImages.seatsreserved)#" index="idx">
			<cfloop from="1" to="#ArrayLen(stElementImages.seatsreserved[idx])#" index="idx2">
				<cfset ArrayAppend(aSeatsReserved,stElementImages.seatsreserved[idx][idx2])>
			</cfloop>
		</cfloop>

		<cfinvoke component="seatplan" method="getElementByID" returnvariable="qElement">
			<cfinvokeargument name="id" value="#arguments.seatid#">
		</cfinvoke>
		
		<cfscript>
			lSeats = ArrayToList(aSeats);
			lSeatsReserved = ArrayToList(aSeatsReserved);
			sNewImage = ListGetAt(lSeats, ListFind(lSeatsReserved, qElement.image));
		</cfscript>

		<cfquery datasource="#application.lanshock.environment.datasource#">
			UPDATE seatplan_location_elements
			SET guest = "",
				status = 1,
				image = <cfqueryparam cfsqltype="cf_sql_varchar" value="#sNewImage#">
			WHERE id = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.seatid#">
		</cfquery>

	</cffunction>
	
	<cffunction name="setRoom" access="public" output="false" returntype="numeric">
		<cfargument name="id" type="numeric" required="false" default="0">
		<cfargument name="name" type="string" required="true">
		<cfargument name="labels_x" type="string" required="false" default="">
		<cfargument name="labels_y" type="string" required="false" default="">

		<cfif arguments.id NEQ 0>

			<cfquery datasource="#application.lanshock.environment.datasource#">
				UPDATE seatplan_location_data
				SET name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#HTMLEditFormat(arguments.name)#">,
					labels_x = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.labels_x#">,
					labels_y = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.labels_y#">
				WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.id#">
			</cfquery>
			
			<cfreturn arguments.id>

		<cfelse>

			<cfquery datasource="#application.lanshock.environment.datasource#">
				INSERT INTO seatplan_location_data (name, labels_x, labels_y)
				VALUES (<cfqueryparam cfsqltype="cf_sql_varchar" value="#HTMLEditFormat(arguments.name)#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.labels_x#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.labels_y#">)
			</cfquery>

			<cfquery datasource="#application.lanshock.environment.datasource#" name="qGetRoomID">
				SELECT id
				FROM seatplan_location_data
				WHERE name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#HTMLEditFormat(arguments.name)#">
				AND cols = 0
				AND rows = 0
			</cfquery>
			
			<cfreturn qGetRoomID.id>

		</cfif>

	</cffunction>

	<cffunction name="getElements" access="public" returntype="query" output="false">
		<cfargument name="roomid" type="numeric" required="true">

		<cfquery datasource="#application.lanshock.environment.datasource#" name="qElements">
			SELECT id, col, row, status, guest, image, type
			FROM seatplan_location_elements
			WHERE block = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.roomid#">
		</cfquery>
		
		<cfreturn qElements>

	</cffunction>

	<cffunction name="changeElement" access="public" returntype="boolean" output="false">
		<cfargument name="roomid" type="numeric" required="true">
		<cfargument name="row" type="numeric" required="true">
		<cfargument name="col" type="numeric" required="true">
		<cfargument name="type" type="string" required="false" default="">
		<cfargument name="image" type="string" required="false" default="">
		
		<cfinvoke component="seatplan" method="getElementImages" returnvariable="stElementImages">
		
		<cfif NOT len(arguments.type) OR NOT len(arguments.image)>
			<cfset arguments.type = "seat">
			<cfset arguments.image = stElementImages.Defaults.Seats.Image>
		</cfif>
		
		<cfquery datasource="#application.lanshock.environment.datasource#" name="qGetElement">
			SELECT id, status, image
			FROM seatplan_location_elements
			WHERE block = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.roomid#">
			AND row = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.row#">
			AND col = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.col#">
		</cfquery>
		
		<cfif qGetElement.recordcount>

			<cfquery datasource="#application.lanshock.environment.datasource#">
				UPDATE seatplan_location_elements
				SET type = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.type#">,
					image =  <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.image#">
					<cfif arguments.type NEQ "seat">
						,guest = 0,
						status = 0
					<cfelseif qGetElement.status EQ 0>
						,status = 1
					</cfif>
				WHERE block = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.roomid#">
				AND row = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.row#">
				AND col = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.col#">
			</cfquery>

			<cfquery datasource="#application.lanshock.environment.datasource#" name="qGetImage">
				SELECT image, guest
				FROM seatplan_location_elements
				WHERE block = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.roomid#">
				AND row = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.row#">
				AND col = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.col#">
			</cfquery>
			
			<cfif qGetImage.guest NEQ 0>
		
				<cfscript>
					aSeats = ArrayNew(1);
					aSeatsReserved = ArrayNew(1);
				</cfscript>
				
				<cfloop from="1" to="#ArrayLen(stElementImages.seats)#" index="idx">
					<cfloop from="1" to="#ArrayLen(stElementImages.seats[idx])#" index="idx2">
						<cfset ArrayAppend(aSeats,stElementImages.seats[idx][idx2])>
					</cfloop>
				</cfloop>
				
				<cfloop from="1" to="#ArrayLen(stElementImages.seatsreserved)#" index="idx">
					<cfloop from="1" to="#ArrayLen(stElementImages.seatsreserved[idx])#" index="idx2">
						<cfset ArrayAppend(aSeatsReserved,stElementImages.seatsreserved[idx][idx2])>
					</cfloop>
				</cfloop>
				
				<cfscript>
					lSeats = ArrayToList(aSeats);
					lSeatsReserved = ArrayToList(aSeatsReserved);
					if(ListFind(lSeats, qGetImage.image)) sNewImage = ListGetAt(lSeatsReserved, ListFind(lSeats, qGetImage.image));
					else sNewImage = qGetImage.image;
				</cfscript>

				<cfquery datasource="#application.lanshock.environment.datasource#">
					UPDATE seatplan_location_elements
					SET image =  <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#sNewImage#">
					WHERE block = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.roomid#">
					AND row = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.row#">
					AND col = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.col#">
				</cfquery>
				
			</cfif>
		
		<cfelse>

			<cfquery datasource="#application.lanshock.environment.datasource#">
				INSERT INTO seatplan_location_elements (type, image, block, row, col, status)
				VALUES (<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.type#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.image#">,
						<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.roomid#">,
						<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.row#">,
						<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.col#">,
						status = <cfif arguments.type EQ "seat">1<cfelse>0</cfif>)
			</cfquery>
		
		</cfif>
		
		<cfreturn true>

	</cffunction>

	<cffunction name="addCol" access="public" output="false">
		<cfargument name="roomid" type="numeric" required="true">
		<cfargument name="start" type="numeric" required="false" default="0">
		<cfargument name="number" type="numeric" required="true">

		<cfquery datasource="#application.lanshock.environment.datasource#">
			UPDATE seatplan_location_elements
			SET col = col + <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#number#">
			WHERE col >= <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#start#">
			AND block = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.roomid#">
		</cfquery>
		
		<cfquery datasource="#application.lanshock.environment.datasource#">
			UPDATE seatplan_location_data
			SET cols = cols + <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#number#">
			WHERE id = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.roomid#">
		</cfquery>

	</cffunction>

	<cffunction name="addRow" access="public" output="false">
		<cfargument name="roomid" type="numeric" required="true">
		<cfargument name="start" type="numeric" required="false" default="0">
		<cfargument name="number" type="numeric" required="true">

		<cfquery datasource="#application.lanshock.environment.datasource#">
			UPDATE seatplan_location_elements
			SET row = row + <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#number#">
			WHERE row >= <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#start#">
			AND block = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.roomid#">
		</cfquery>
		
		<cfquery datasource="#application.lanshock.environment.datasource#">
			UPDATE seatplan_location_data
			SET rows = rows + <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#number#">
			WHERE id = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.roomid#">
		</cfquery>

	</cffunction>

	<cffunction name="deleteCol" access="remote" output="false">
		<cfargument name="roomid" type="numeric" required="true">
		<cfargument name="cols" type="string" required="true">

		<cfloop list="#ListSort(arguments.cols, 'numeric', 'DESC')#" index="idx">
			
			<cfquery datasource="#application.lanshock.environment.datasource#">
				DELETE FROM seatplan_location_elements
				WHERE block = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.roomid#">
				AND col = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#idx#">
			</cfquery>

			<cfquery datasource="#application.lanshock.environment.datasource#">
				UPDATE seatplan_location_elements
				SET col = col - 1
				WHERE col >= <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#idx#">
				AND block = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.roomid#">
			</cfquery>

		</cfloop>
		
		<cfquery datasource="#application.lanshock.environment.datasource#">
			UPDATE seatplan_location_data
			SET cols = cols - #ListLen(cols)#
			WHERE id = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.roomid#">
		</cfquery>

	</cffunction>

	<cffunction name="deleteRow" access="remote" output="false">
		<cfargument name="roomid" type="numeric" required="true">
		<cfargument name="rows" type="string" required="true">

		<cfloop list="#ListSort(arguments.rows, 'numeric', 'DESC')#" index="idx">
			
			<cfquery datasource="#application.lanshock.environment.datasource#">
				DELETE FROM seatplan_location_elements
				WHERE block = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.roomid#">
				AND row = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#idx#">
			</cfquery>

			<cfquery datasource="#application.lanshock.environment.datasource#">
				UPDATE seatplan_location_elements
				SET row = row - 1
				WHERE row >= <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#idx#">
				AND block = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.roomid#">
			</cfquery>

		</cfloop>
		
		<cfquery datasource="#application.lanshock.environment.datasource#">
			UPDATE seatplan_location_data
			SET rows = rows - #ListLen(rows)#
			WHERE id = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.roomid#">
		</cfquery>

	</cffunction>
	
	<cffunction name="deleteRoom" access="remote" output="false">
		<cfargument name="roomid" type="numeric" required="true">

		<cfquery datasource="#application.lanshock.environment.datasource#">
			DELETE
			FROM seatplan_location_data
			WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.roomid#">
		</cfquery>

		<cfquery datasource="#application.lanshock.environment.datasource#">
			DELETE
			FROM seatplan_location_elements
			WHERE block = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.roomid#">
		</cfquery>

	</cffunction>
	
	<cffunction name="getElementImages" access="public" output="false">

		<cffile action="READ" file="#GetDirectoryFromPath(GetCurrentTemplatePath())#elements.xml" variable="xmlElements">
		
		<cfscript>
			stElements = XMLParse(xmlElements);
			
			aElementsSeats = ArrayNew(1);
			aElementsSeatsReserved = ArrayNew(1);
			aElementsOthers = ArrayNew(1);
		</cfscript>
		
		<cfloop from="1" to="#ArrayLen(stElements.elements.seats.xmlchildren)#" index="IDXpackage">
			<cfset aElementsSeats[IDXpackage] = ArrayNew(1)>
			<cfset aElementsSeatsReserved[IDXpackage] = ArrayNew(1)>
			<cfloop from="1" to="#ArrayLen(stElements.elements.seats.xmlchildren[IDXpackage].xmlchildren)#" index="IDXelement">
				<cfset ArrayAppend(aElementsSeats[IDXpackage], stElements.elements.seats.xmlchildren[IDXpackage].xmlchildren[IDXelement].xmlattributes.image)>
				<cfset ArrayAppend(aElementsSeatsReserved[IDXpackage], stElements.elements.seats.xmlchildren[IDXpackage].xmlchildren[IDXelement].xmlattributes.image_reserved)>
			</cfloop>
		</cfloop>
		
		<cfloop from="1" to="#ArrayLen(stElements.elements.others.xmlchildren)#" index="IDXpackage">
			<cfset aElementsOthers[IDXpackage] = ArrayNew(1)>
			<cfloop from="1" to="#ArrayLen(stElements.elements.others.xmlchildren[IDXpackage].xmlchildren)#" index="IDXelement">
				<cfset ArrayAppend(aElementsOthers[IDXpackage], stElements.elements.others.xmlchildren[IDXpackage].xmlchildren[IDXelement].xmlattributes.image)>
			</cfloop>
		</cfloop>
		
		<cfscript>
			stAllElements = StructNew();
			stAllElements.Seats = aElementsSeats;
			stAllElements.SeatsReserved = aElementsSeatsReserved;
			stAllElements.Others = aElementsOthers;
			stAllElements.Defaults = StructNew();
			stAllElements.Defaults.Others.Image = stElements.elements.defaults.others.xmlattributes.image;
			stAllElements.Defaults.Seats.Image = stElements.elements.defaults.seats.xmlattributes.image;
		</cfscript>
		
		<cfreturn stAllElements>

	</cffunction>

	<cffunction name="getElementIdByCoordinates" access="public" returntype="numeric" output="false">
		<cfargument name="roomid" type="numeric" required="true">
		<cfargument name="row" type="numeric" required="true">
		<cfargument name="col" type="numeric" required="true">

		<cfquery datasource="#application.lanshock.environment.datasource#" name="qElementID">
			SELECT id
			FROM seatplan_location_elements
			WHERE row = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.row#">
			AND col = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.col#">
			AND block = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.roomid#">
		</cfquery>
		
		<cfif qElementID.recordcount>
			<cfreturn qElementID.id>
		<cfelse>
			<cfreturn 0>
		</cfif>

	</cffunction>

</cfcomponent>