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
	<div class="headline2">#request.content.room_edit_headline#</div>
	<br><br>
	<a href="#myself##myfusebox.thiscircuit#.roomlist&#request.session.UrlToken#"class="link_extended">#request.content.roomlist#</a><br>
	<br>
	<cfif qRooms.recordcount>
	<form action="#myself##myfusebox.thiscircuit#.room_structure_edit&#request.session.UrlToken#" method="post">
		#request.content.current_room# <select name="roomid">
		<cfloop query="qRooms">
			<option value="#id#"<cfif attributes.roomid EQ id> selected</cfif>>#name#</option>
		</cfloop>
	</select>
	<input type="submit" value="#request.content.form_select#">
	</form>
	</cfif>
</cfoutput>

<cfif len(attributes.roomid)>

	<cfscript>
		if(qRoom.cols GT 0 OR qRooms.rows GT 0) bShowElements = true;
		else bShowElements = false;
	</cfscript>

	<cfoutput>
		<form action="#myself##myfusebox.thiscircuit#.room_structure_edit&roomid=#attributes.roomid#&#request.session.UrlToken#" method="post">
		<input type="hidden" name="form_submitted2" value="true">
		<fieldset>
		<legend>#request.content.roomdata#</legend>
		<table width="100%">
			<tr>
				<td>#request.content.name#<br>
					<input type="text" name="name" value="#qRoom.name#"></td>
			</tr>
			<tr>
				<td>#request.content.labels_x#<br>
					<input type="text" name="labels_x" value="#qRoom.labels_x#" style="width: 90%;"></td>
			</tr>
			<tr>
				<td>#request.content.labels_y#<br>
					<input type="text" name="labels_y" value="#qRoom.labels_y#" style="width: 90%;"></td>
			</tr>
			<tr>
				<td><input type="submit" value="#request.content.form_save#"></td>
			</tr>
		</table>
		</fieldset>
		</form>
		
		<cfif bShowElements>
			<script language="JavaScript" type="text/javascript">
			<!--
				currElement = '#stElements.Defaults.Others.Image#';
				currType = 'others';
				
				function setCurrElement(element,type){
					currElement = element;
					currType = type;
					document.getElementById("currentElementDsp").src = "#stImageDir.module#/" + currElement;
				}
				
				function changeElement(elementid){
					document.getElementById("element_"+elementid).value = '' + currElement;
					document.getElementById("element_type_"+elementid).value = '' + currType;
					document.getElementById("img_"+elementid).src = "#stImageDir.module#/" + currElement;
				}
			//-->
			</script>
			<form action="#myself##myfusebox.thiscircuit#.room_structure_edit&roomid=#attributes.roomid#&#request.session.UrlToken#" method="post">
			<input type="hidden" name="form_submit" value="true">
			<table cellpadding="10" align="center">
				<tr>
					<td valign="top">
						<fieldset>
						<legend>#request.content.room_elements#</legend>
							#request.content.room_element_current#<br>
							<table cellpadding="0" cellspacing="1" align="center" border="1" bordercolor="##000000">
								<tr>
									<td><img id="currentElementDsp" src="#stImageDir.module#/#stElements.Defaults.Others.Image#"></td>
								</tr>
							</table><br>
							#request.content.element_seat#<br>
							<cfset aElementsSeats = stElements.Seats>
							<cfloop from="1" to="#ArrayLen(aElementsSeats)#" index="idx">
								<table cellpadding="0" cellspacing="1" align="center" border="1" bordercolor="##000000">
									<cfset idx3 = 0>
									<cfloop from="1" to="#ArrayLen(aElementsSeats[idx])#" index="idx2">
										<cfset idx3 = idx3 + 1>
										<cfif idx3 EQ 5><cfset idx3 = 0><tr></cfif>
											<td onclick="javascript:setCurrElement('#aElementsSeats[idx][idx2]#','seat')"><img src="#stImageDir.module#/#aElementsSeats[idx][idx2]#"></td>
										<cfif idx3 EQ 4></tr></cfif>
									</cfloop>
								</table>
								<br>
							</cfloop>
							#request.content.element_others#<br>
							<cfset aElementsOthers = stElements.Others>
							<cfloop from="1" to="#ArrayLen(aElementsOthers)#" index="idx">
								<table cellpadding="0" cellspacing="1" align="center" border="1" bordercolor="##000000">
									<cfset idx3 = 0>
									<cfloop from="1" to="#ArrayLen(aElementsOthers[idx])#" step="4" index="idx2">
										<cfparam name="aElementsOthers[idx][idx2+1]" default="">
										<cfparam name="aElementsOthers[idx][idx2+2]" default="">
										<cfparam name="aElementsOthers[idx][idx2+3]" default="">
										<tr>
											<td onclick="javascript:setCurrElement('#aElementsOthers[idx][idx2]#','other')"><img src="#stImageDir.module#/#aElementsOthers[idx][idx2]#"></td>
											<cfif len(aElementsOthers[idx][idx2+1])><td onclick="javascript:setCurrElement('#aElementsOthers[idx][idx2+1]#','other')"><img src="#stImageDir.module#/#aElementsOthers[idx][idx2+1]#"></td><cfelse><td style="border: 0px;">&nbsp;</td></cfif>
											<cfif len(aElementsOthers[idx][idx2+2])><td onclick="javascript:setCurrElement('#aElementsOthers[idx][idx2+2]#','other')"><img src="#stImageDir.module#/#aElementsOthers[idx][idx2+2]#"></td><cfelse><td style="border: 0px;">&nbsp;</td></cfif>
											<cfif len(aElementsOthers[idx][idx2+3])><td onclick="javascript:setCurrElement('#aElementsOthers[idx][idx2+3]#','other')"><img src="#stImageDir.module#/#aElementsOthers[idx][idx2+3]#"></td><cfelse><td style="border: 0px;">&nbsp;</td></cfif>
										</tr>
									</cfloop>
								</table>
								<br>
							</cfloop>
							<div align="center"><input type="Submit" value="#request.content.form_save#"></div>
						</fieldset>
					</td>
					<td valign="top">
						<fieldset>
						<legend>#request.content.room#</legend>
							<table cellpadding="0" cellspacing="1" align="center" border="1" bordercolor="##000000">
								<tr>
									<td style="border:0px;"><img src="#stImageDir.module#/nothing.gif"></td>
									<cfloop from="1" to="#qRoom.cols#" index="idxCols">
										<td align="center">X<br>#idxCols#</td>
									</cfloop>
								</tr>
								<cfloop from="1" to="#qRoom.rows#" index="idxRows">
									<tr>
										<td align="center">Y#idxRows#</td>
										<cfloop from="1" to="#qRoom.cols#" index="idxCols">
											<cfparam name="aSeats[idxCols][idxRows]" default="#StructNew()#">
											<cfparam name="aSeats[idxCols][idxRows].status" default="0">
											<cfparam name="aSeats[idxCols][idxRows].id" default="">
											<cfparam name="aSeats[idxCols][idxRows].image" default="#stElements.Defaults.Others.Image#">
											<cfparam name="aSeats[idxCols][idxRows].type" default="others">
											<input type="hidden" name="element_#idxRows#_#idxCols#" id="element_#idxRows#_#idxCols#" value="#aSeats[idxCols][idxRows].image#">
											<input type="hidden" name="element_type_#idxRows#_#idxCols#" id="element_type_#idxRows#_#idxCols#" value="#aSeats[idxCols][idxRows].type#">
											<td onclick="javascript:changeElement('#idxRows#_#idxCols#')"><img id="img_#idxRows#_#idxCols#" src="#stImageDir.module#/#aSeats[idxCols][idxRows].image#" alt="Y#idxRows# X#idxCols##chr(13)#(#request.content.seat_id# #aSeats[idxCols][idxRows].id#)"></td>
										</cfloop>
									</tr>
								</cfloop>
							</table>
						</fieldset>
					</td>
				</tr>
			</table>
			</form>
		</cfif>
		<table align="center">
			<tr>
				<td><fieldset>
					<legend>#request.content.cols_add#</legend>
					<form action="#myself##myfusebox.thiscircuit#.room_changeStructure&#request.session.UrlToken#" method="post">
					<input type="hidden" name="subaction" value="addCol">
					<input type="hidden" name="roomid" value="#attributes.roomid#">
					<table align="center">
						<tr>
							<td align="center">#request.content.count# <input type="text" name="number" value="1" maxlength="2" style="width:20px;"></td>
						</tr>
						<tr>
							<td align="center"><select name="start">
									<cfloop from="1" to="#qRoom.cols#" index="idxCols">
										<option value="#idxCols#">#request.content.pre# X#idxCols#</option>
									</cfloop>
									<option value="#idxCols+1#">#request.content.at_end#</option>
								</select></td>
						</tr>
						<tr>
							<td align="center"><input type="submit" value="#request.content.form_add#"></td>
						</tr>
					</table>
					</form>
					</fieldset></td>
				<td><fieldset>
					<legend>#request.content.rows_add#</legend>
					<form action="#myself##myfusebox.thiscircuit#.room_changeStructure&#request.session.UrlToken#" method="post">
					<input type="hidden" name="subaction" value="addRow">
					<input type="hidden" name="roomid" value="#attributes.roomid#">
					<table align="center">
						<tr>
							<td align="center">#request.content.count# <input type="text" name="number" value="1" maxlength="2" style="width:20px;"></td>
						</tr>
						<tr>
							<td align="center"><select name="start">
									<cfloop from="1" to="#qRoom.rows#" index="idxRows">
									<option value="#idxRows#">#request.content.pre# Y#idxRows#</option>
									</cfloop>
									<option value="#idxRows+1#">#request.content.at_end#</option>
								</select></td>
						</tr>
						<tr>
							<td align="center"><input type="submit" value="#request.content.form_add#"></td>
						</tr>
					</table>
					</form>
					</fieldset></td>
			</tr>
			<cfif bShowElements>
			<tr>
				<td><fieldset>
					<legend>#request.content.cols_del#</legend>
					<form action="#myself##myfusebox.thiscircuit#.room_changeStructure&#request.session.UrlToken#" method="post">
					<input type="hidden" name="subaction" value="deleteCol">
					<input type="hidden" name="roomid" value="#attributes.roomid#">
					<table align="center">
						<tr>
							<td align="center"><select name="colIDX" multiple size="10">
									<cfloop from="1" to="#qRoom.cols#" index="idxCols">
										<option value="#idxCols#">&nbsp;&nbsp;X#idxCols#&nbsp;&nbsp;</option>
									</cfloop>
								</select></td>
						</tr>
						<tr>
							<td align="center"><input type="submit" value="#request.content.form_delete#"></td>
						</tr>
					</table>
					</form>
					</fieldset></td>
				<td><fieldset>
					<legend>#request.content.rows_del#</legend>
					<form action="#myself##myfusebox.thiscircuit#.room_changeStructure&#request.session.UrlToken#" method="post">
					<input type="hidden" name="subaction" value="deleteRow">
					<input type="hidden" name="roomid" value="#attributes.roomid#">
					<table align="center">
						<tr>
							<td align="center"><select name="rowIDX" multiple size="10">
									<cfloop from="1" to="#qRoom.rows#" index="idxRows">
										<option value="#idxRows#">&nbsp;&nbsp;Y#idxRows#&nbsp;&nbsp;</option>
									</cfloop>
								</select></td>
						</tr>
						<tr>
							<td align="center"><input type="submit" value="#request.content.form_delete#"></td>
						</tr>
					</table>
					</form>
					</fieldset></td>
			</tr>
			</cfif>
		</table>
	</cfoutput>

</cfif>

<cfsetting enablecfoutputonly="No">