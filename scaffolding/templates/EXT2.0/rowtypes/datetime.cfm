<cfoutput>
	<div class="formrow">
		<div class="formrow_label">
			<label for="formrow_##idFormRow##">##request.content.#objectName#_rowtype_label_#aFields[i].label###</label>
		</div>
		<div class="formrow_input">
			<div id="divDatePicker##idFormRow##"></div>
			<input type="hidden" name="#aFields[i].alias#" id="formrow_##idFormRow##" value="##LsDateFormat(#Format("o#objectName#.get#aFields[i].alias#()","#aFields[i].format#")#,'YYYY-MM-DD')##"/>
			<script type="text/javascript">
				var myDatePicker##idFormRow## = new Ext.DatePicker({
					handler : function(dp,date){
						var elmDate = Ext.get('formrow_##idFormRow##');
						elmDate.set({value:date.format("Y-m-d")});
					}
				});
				#chr(60)#cfif isDate(#Format("o#objectName#.get#aFields[i].alias#()","#aFields[i].format#")#)>
					var dt##idFormRow## = new Date();
					dt##idFormRow## = Date.parseDate("##LsDateFormat(#Format("o#objectName#.get#aFields[i].alias#()","#aFields[i].format#")#,'YYYY-MM-DD')##","Y-m-d");
					myDatePicker##idFormRow##.setValue(dt##idFormRow##);
				#chr(60)#/cfif>
				Ext.onReady(function(){
					myDatePicker##idFormRow##.render('divDatePicker##idFormRow##');
				});
			</script>
		</div>
	</div>
</cfoutput>