<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfparam name="attributes.roomid" default="">
<cfparam name="attributes.markseat" default="">
<cfparam name="attributes.reserve_for_user" default="">

<cfoutput>
	<div class="headline">#request.content.seatplan#</div>
	<cfif isNumeric(attributes.reserve_for_user)>Reservation for: #GetUsernameByID(attributes.reserve_for_user)#</cfif>
</cfoutput>

<cfif qRooms.recordcount>
	<cfoutput>
		<div class="headline2">#request.content.roomlist#</div>
		<table class="list">
			<tr>
				<th>#request.content.room#</th>
				<th>#request.content.seats_stats#</th>
				<th>Besetzt</th>
				<th>Gesamt</th>
				<th colspan="2">#request.content.seats_stats_load#</th>
				<cfif request.session.UserLoggedIn>
					<th>#request.content.your_seat#</th>
					<cfinvoke component="seatplan" method="getSeatLinkDataByUserID" returnvariable="stSeat">
						<cfinvokeargument name="userid" value="#request.session.userid#">
					</cfinvoke>
				</cfif>
			</tr>
			<cfloop query="qRooms">
				<cfscript>
					stSeatplanSummary.seats = stSeatplanSummary.seats + seats;
					stSeatplanSummary.seats_free = stSeatplanSummary.seats_free + seats_free;
				</cfscript>
				<tr>
					<td><a href="#myself##myfusebox.thiscircuit#.seatplan&roomid=#id#<cfif isNumeric(attributes.reserve_for_user)>&reserve_for_user=#attributes.reserve_for_user#</cfif>&#request.session.UrlToken#"><cfif attributes.roomid EQ id><strong>#name#</strong><cfelse>#name#</cfif></a></td>
					<td align="right"><strong>#seats_free#</strong></td>
					<td align="right">#seats-seats_free#</td>
					<td align="right">#seats#</td>
					<td align="right">#int(100-100/seats*seats_free)# %</td>
					<td align="center"><span style="border: 1px dotted grey;"><cfif seats NEQ seats_free><img src="#stImageDir.general#/graph.gif" width="#int(100-100/seats*seats_free)#px" height="10" alt="#seats#" border="0"><cfif int(100/seats*seats_free) NEQ 0><img src="#stImageDir.general#/spacer.gif" width="#int(100/seats*seats_free)#px" height="10" alt="#seats_free#" border="0"></cfif><cfelse><img src="#stImageDir.general#/spacer.gif" width="100px" height="10" alt="#seats_free#" border="0"></cfif></span></td>
					<cfif request.session.UserLoggedIn>
						<td>
							<cfif NOT StructIsEmpty(stSeat) AND stSeat.block EQ id>
				
								<cfif NOT isDefined("attributes.roomid") OR NOT isNumeric(attributes.roomid) AND NOT fileExists(UDF_Module('absPath') & 'images/overview.gif')>
									<cflocation url="#myself##myfusebox.thiscircuit#.seatplan&roomid=#stSeat.block#&markseat=#stSeat.id#&#request.session.URLToken#" addtoken="false">
								</cfif>
							
								<cfoutput>
									<a href="#myself##stSeat.linkurl#&#request.session.UrlToken#"><strong>#stSeat.description#</strong></a>&nbsp;&nbsp;&nbsp;<a href="#myself##myfusebox.thiscircuit#.seat_release&roomid=#stSeat.block#&seatid=#stSeat.id#&#request.session.URLToken#" class="link_extended">#request.content.your_seat_release#</a>
								</cfoutput>
								
							<cfelseif StructIsEmpty(stSeat)>
							
								<cfoutput>
									<a href="#myself##myfusebox.thiscircuit#.seatplan&roomid=#id#&#request.session.UrlToken#" class="link_extended">#request.content.select_seat_in_room#</a>
								</cfoutput>
							
							</cfif>&nbsp;
						</td>
					</cfif>
				</tr>
			</cfloop>
			<tr>
				<td>Summary</td>
				<td align="right"><strong>#stSeatplanSummary.seats_free#</strong></td>
				<td align="right">#stSeatplanSummary.seats-stSeatplanSummary.seats_free#</td>
				<td align="right">#stSeatplanSummary.seats#</td>
				<td align="right">#int(100-100/stSeatplanSummary.seats*stSeatplanSummary.seats_free)# %</td>
				<td align="center"><span style="border: 1px dotted grey;"><cfif stSeatplanSummary.seats NEQ stSeatplanSummary.seats_free><img src="#stImageDir.general#/graph.gif" width="#int(100-100/stSeatplanSummary.seats*stSeatplanSummary.seats_free)#px" height="10" alt="#stSeatplanSummary.seats#" border="0"><cfif int(100/stSeatplanSummary.seats*stSeatplanSummary.seats_free) NEQ 0><img src="#stImageDir.general#/spacer.gif" width="#int(100/stSeatplanSummary.seats*stSeatplanSummary.seats_free)#px" height="10" alt="#stSeatplanSummary.seats_free#" border="0"></cfif><cfelse><img src="#stImageDir.general#/spacer.gif" width="100px" height="10" alt="#stSeatplanSummary.seats_free#" border="0"></cfif></span></td>
				<cfif request.session.UserLoggedIn>
					<td>&nbsp;</td>
				</cfif>
			</tr>
		</table>
	</cfoutput>
<cfelse>
	<cfoutput>
		<div align="center">#request.content.no_rooms_avaible#</div>
	</cfoutput>
</cfif>

<cfif len(attributes.roomid)>

	<cfoutput>
		<div class="headline2">#qRoom.name#</div>
		<table cellpadding="0" cellspacing="1" align="center">
			<tr>
				<td><img src="#stImageDir.module#/nothing.gif"></td>
				<cfloop from="1" to="#qRoom.cols#" index="idxCols">
					<cfscript>
						if(ListLen(qRoom.labels_x) GTE idxCols) sCurrentCol = ListGetAt(qRoom.labels_x,idxCols);
						else sCurrentCol = '';
					</cfscript>
					<td align="center"><span class="text_small">#sCurrentCol#</span></td>
				</cfloop>
			</tr>
			<cfloop from="1" to="#qRoom.rows#" index="idxRows">
				<cfscript>
					if(ListLen(qRoom.labels_y) GTE idxRows) sCurrentRow = ListGetAt(qRoom.labels_y,idxRows);
					else sCurrentRow = '';
				</cfscript>
				<tr>
					<td align="center"><span class="text_small">#sCurrentRow#</span></td>
					<cfloop from="1" to="#qRoom.cols#" index="idxCols">
						<cfparam name="aSeats[idxCols][idxRows]" default="#StructNew()#">
						<cfparam name="aSeats[idxCols][idxRows].status" default="0">
						<cfparam name="aSeats[idxCols][idxRows].id" default="">
						<cfparam name="aSeats[idxCols][idxRows].userid" default="">
						<cfparam name="aSeats[idxCols][idxRows].username" default="">
						<cfparam name="aSeats[idxCols][idxRows].type" default="">
						<cfparam name="aSeats[idxCols][idxRows].image" default="nothing.gif">
						<cfscript>
							if(ListLen(qRoom.labels_x) GTE idxCols) sCurrentCol = ListGetAt(qRoom.labels_x,idxCols);
							else sCurrentCol = '';
							
							if(aSeats[idxCols][idxRows].status EQ 3) aSeats[idxCols][idxRows].type = ListSetAt(aSeats[idxCols][idxRows].type,listLen(aSeats[idxCols][idxRows].type,"_"),"reserved","_");
							else if(aSeats[idxCols][idxRows].status EQ 2) aSeats[idxCols][idxRows].type = ListDeleteAt(aSeats[idxCols][idxRows].type,listLen(aSeats[idxCols][idxRows].type,"_"),"_");
						</cfscript>
						<td align="center" valign="middle"<cfif len(attributes.markseat) AND attributes.markseat EQ aSeats[idxCols][idxRows].id> style="border:1px solid red;"</cfif>>
							<cfswitch expression="#aSeats[idxCols][idxRows].status#">
								<cfcase value="0"><img src="#stImageDir.module#/#aSeats[idxCols][idxRows].image#"></cfcase>
								<cfcase value="1"><a href="#myself##myfusebox.thiscircuit#.seat_reserve&id=#aSeats[idxCols][idxRows].id#&roomid=#attributes.roomid#<cfif isNumeric(attributes.reserve_for_user)>&reserve_for_user=#attributes.reserve_for_user#</cfif>&#request.session.URLToken#"><img src="#stImageDir.module#/#aSeats[idxCols][idxRows].image#" alt="" title="#sCurrentRow# #sCurrentCol##chr(13)##request.content.free_seat##chr(13)#(#request.content.seat_id# #aSeats[idxCols][idxRows].id#)"></a></cfcase>
								<cfcase value="2"><a href="#myself##request.lanshock.settings.modulePrefix.core#user.userdetails&id=#aSeats[idxCols][idxRows].userid#&#request.session.URLToken#"><img src="#stImageDir.module#/#aSeats[idxCols][idxRows].image#" alt="" title="#sCurrentRow# #sCurrentCol##chr(13)##aSeats[idxCols][idxRows].username##chr(13)#(#request.content.seat_id# #aSeats[idxCols][idxRows].id#)"></a></cfcase>
							</cfswitch>
						</td>
					</cfloop>
				</tr>
			</cfloop>
		</table>
	</cfoutput>
	
<cfelse>

	<cfoutput>
		<div align="center">
			<img src="#stImageDir.module#/overview.gif">
		</div>
	</cfoutput>

</cfif>

<cfsetting enablecfoutputonly="No">