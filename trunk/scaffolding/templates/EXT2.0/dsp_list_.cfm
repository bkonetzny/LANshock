<<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->>

<<cfsilent>>
<<!--- Set the name of the object (table) being updated --->>
<<cfset objectName = oMetaData.getSelectedTableAlias()>>
<<!--- Generate a list of the table fields --->>
<<cfset lFields = oMetaData.getFieldListFromXML(objectName)>>
<<!--- Generate a list of the joined fields --->>
<<cfset lJoinedFields = oMetaData.getJoinedFieldListFromXML(objectName)>>
<<cfif len(lJoinedFields)>>
	<<cfset lAllFields = ListAppend(lFields,lJoinedFields)>>
<<cfelse>>
	<<cfset lAllFields = lFields>>
<</cfif>>
<<!--- Generate a list of the Primary Key fields --->>
<<cfset lPKFields = oMetaData.getPKListFromXML(objectName)>>
<<!--- Get an array of fields --->>
<<cfset aFields = oMetaData.getFieldsFromXML(objectName)>>
<<!--- Get an array of joinedfields --->>
<<cfset aJoinedFields = oMetaData.getJoinedFieldsFromXML(objectName)>>
<<!--- Get table attributes --->>
<<cfset stTableAttributes = oMetaData.getTableAttributesFromXML(objectName)>>
<<cfif StructKeyExists(stTableAttributes,'sSortDefault')>>
	<<cfset sTableSortField = ListFirst(stTableAttributes.sSortDefault,' ')>>
	<<cfset sTableSortDirection = ListLast(stTableAttributes.sSortDefault,' ')>>
<<cfelse>>
	<<cfset sTableSortField = lPKFields>>
	<<cfset sTableSortDirection = 'DESC'>>
<</cfif>>

<<cfset sCodeDataReaderModel = ''>>
<<cfset bFirstColumn = true>>
<<cfloop from="1" to="$$ArrayLen(aFields)$$" index="idx">>
	<<cfif aFields[idx].showOnList>>
		<<cfif NOT bFirstColumn>>
			<<cfset sCodeDataReaderModel = sCodeDataReaderModel & "," & chr(13)>>
		<</cfif>>
		<<cfset sCodeDataReaderModel = sCodeDataReaderModel & "{name:'$$aFields[idx].alias$$',mapping:'$$aFields[idx].alias$$'">>
		<<!--- <<cfswitch expression="$$aFields[idx].type$$">>
			<<cfcase value="date">>
				<<cfset sCodeDataReaderModel = sCodeDataReaderModel & ",type:'date',dateFormat:'Y-m-d g:i'">>
			<</cfcase>>
		<</cfswitch>> --->>
		<<cfset sCodeDataReaderModel = sCodeDataReaderModel & "}">>
		<<cfset bFirstColumn = false>>
	<</cfif>>
<</cfloop>>

<<cfset sCodeColumnModel = ''>>
<<cfset bFirstColumn = true>>
<<cfloop from="1" to="$$ArrayLen(aFields)$$" index="idx">>
	<<cfif aFields[idx].showOnList>>
		<<cfif bFirstColumn>>
			<<cfset sCodeColumnModel = sCodeColumnModel & "{id:'$$lPKFields$$',">>
			<<cfset bFirstColumn = false>>
		<<cfelse>>
			<<cfset sCodeColumnModel = sCodeColumnModel & "," & chr(13) & "{">>
		<</cfif>>
		<<cfset sCodeColumnModel = sCodeColumnModel & "header:'#jsStringFormat(request.content.$$objectName$$_grid_header_$$aFields[idx].alias$$)#',sortable:true,dataIndex:'$$aFields[idx].alias$$'">>
		<<cfswitch expression="$$aFields[idx].type$$">>
			<<cfcase value="boolean">>
				<<cfset sCodeColumnModel = sCodeColumnModel & ",width:24,renderer:LANshock.Formatters.formatBoolean">>
			<</cfcase>>
			<<cfcase value="datetime">>
				<<cfset sCodeColumnModel = sCodeColumnModel & ",width:50,renderer:LANshock.Formatters.cfTimeStamp">>
			<</cfcase>>
			<<cfdefaultcase>>
				<<cfset sCodeColumnModel = sCodeColumnModel & ",width:30">>
			<</cfdefaultcase>>
		<</cfswitch>>
		<<cfset sCodeColumnModel = sCodeColumnModel & "}">>
	<</cfif>>
<</cfloop>>
<</cfsilent>>
<<cfoutput>>
<cfsilent>
<cfparam name="XFA.Display">
<cfparam name="XFA.Update">
<cfparam name="XFA.Delete">
<cfparam name="XFA.Add">
<cfparam name="XFA.grid_json">

<cfparam name="attributes._Startrow" default="1">
<cfparam name="attributes._Maxrows" default="10">
<cfparam name="attributes._listSortByFieldList" default="">

<cfparam name="attributes._totalRowCount" default="0">
<cfparam name="request.searchSafe" default="false">

<cfset sortParams = appendParam("","_listSortByFieldList",attributes._listSortByFieldList)>
<cfset sortParams = appendParam(sortParams,"_Maxrows",attributes._Maxrows)>
<cfset pageParams = appendParam(sortParams,"_StartRow",attributes._Startrow)>

<!--- Complete list of fields that could be displayed --->
<cfparam name="variables.fieldlist" default="$$lAllFields$$">
</cfsilent>

<cfoutput>
<h3>#request.content['__globalmodule__navigation__#request.page.objectName#_listing']#</h3>
<script type="text/javascript">
	Ext.onReady(function(){
		
		Ext.QuickTips.init();
	    var xg = Ext.grid;
	    var sm = new xg.CheckboxSelectionModel();
        
        var action = new Ext.ux.grid.RowActions({
			header:'#jsStringFormat(request.content.$$objectName$$_grid_header__rowactions)#',
			actions:[{
				iconCls:'icon-edit-record',
				tooltip:'#jsStringFormat(request.content.$$objectName$$_grid_row_edit)#'
			},{
				iconCls:'icon-delete-record',
				tooltip:'#jsStringFormat(request.content.$$objectName$$_grid_row_delete)#'
			}]
		});
		
		action.on({
			action:function(grid, record, action, row, col) {
				if(action == 'icon-edit-record'){
					window.location.href='#application.lanshock.oHelper.buildUrl('#xfa.update#')#&$$lPKFields$$=' + grid.getSelectionModel().getSelected().id;
				}
				else if(action == 'icon-delete-record'){
					doDel();
				}
			}
		});
	    	    
	    var ds = new Ext.data.GroupingStore({
			proxy: new Ext.data.HttpProxy({url: '#application.lanshock.oHelper.buildUrl('#xfa.grid_json#')#'}),
			reader: new Ext.data.JsonReader({totalProperty: 'totalRecords', root: 'data', id: '$$lPKFields$$'},[
				$$sCodeDataReaderModel$$
			]),
			sortInfo: {field:'$$sTableSortField$$',direction:'$$sTableSortDirection$$'},
			remoteSort: true,
			autoLoad: false
		});

		var grid = new xg.GridPanel({
			id:'button-grid', ds: ds, sm: sm, height: 533, frame: false,
	        viewConfig: {forceFit: true}, renderTo: Ext.get('grid_$$objectName$$'),
	        bbar: new Ext.PagingToolbar({pageSize: 20, store: ds, displayInfo: true}),
			cm: new xg.ColumnModel([
	        	sm,
	        	$$sCodeColumnModel$$,
	        	action
	        ]),
	
	        // inline toolbars
	        tbar:[{
	            text:'#jsStringFormat(request.content.$$objectName$$_grid_global_add)#',
	            tooltip:'#jsStringFormat(request.content.$$objectName$$_grid_global_add)#',
	            iconCls:'add',
	            handler:function(){window.location.href='#application.lanshock.oHelper.buildUrl('#xfa.add#')#';}
	        },'-',{
	            text:'#jsStringFormat(request.content.$$objectName$$_grid_global_delete)#',
	            tooltip:'#jsStringFormat(request.content.$$objectName$$_grid_global_delete)#',
	            iconCls:'remove',
	            handler: doDel
	        }],
	
	        plugins: [action,new Ext.ux.grid.Search({
				mode: 'remote',
				iconCls: false,
				dateFormat: 'm/d/Y',
				minLength: 1
			})]
	    });
		
		ds.load({params:{start: 0, limit: 20}});
	    
	    function doDel(){
	        var m = grid.getSelections();
	        if(m.length > 0) Ext.MessageBox.confirm('Message','#jsStringFormat(request.content.$$objectName$$_grid_global_delete_warning_confirm)#',doDel2);
	        else Ext.MessageBox.alert('Message','#jsStringFormat(request.content.$$objectName$$_grid_global_delete_warning_select)#');
	    }     
	 
	    function doDel2(btn){
	       if(btn == 'yes') {	
				var m = grid.getSelections();
				var jsonData = "[";
		        for(var i = 0, len = m.length; i < len; i++){        		
					var ss = "{\"$$lPKFields$$\":\"" + m[i].get("$$lPKFields$$") + "\"}";
					if(i==0) jsonData = jsonData + ss ;
				   	else jsonData = jsonData + "," + ss;	
					ds.remove(m[i]);								
		        }	
				jsonData = jsonData + "]";
				var conn = new Ext.data.Connection();
				conn.request({
					url:'#application.lanshock.oHelper.buildUrl('#xfa.delete#')#',
					params:{jsonData:jsonData}
				})
				ds.reload();		
			}
		}
	});
</script>
<div id="grid_$$objectName$$"></div>
</cfoutput>
<</cfoutput>>