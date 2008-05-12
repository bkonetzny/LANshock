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
			<<cfset sCodeColumnModel = sCodeColumnModel & "{id:'id',">>
			<<cfset bFirstColumn = false>>
		<<cfelse>>
			<<cfset sCodeColumnModel = sCodeColumnModel & "," & chr(13) & "{">>
		<</cfif>>
		<<cfset sCodeColumnModel = sCodeColumnModel & "header:'#jsStringFormat(request.content.$$objectName$$_grid_header_$$aFields[idx].alias$$)#',width:30,sortable:true,dataIndex:'$$aFields[idx].alias$$'">>
		<<!--- <<cfswitch expression="$$aFields[idx].type$$">>
			<<cfcase value="date">>
				<<cfset sCodeColumnModel = sCodeColumnModel & ",renderer:Ext.util.Format.dateRenderer('d.m.Y - H:i')">>
			<</cfcase>> 
		<</cfswitch>> --->>
		<<cfset sCodeColumnModel = sCodeColumnModel & "}">>
	<</cfif>>
<</cfloop>>
<</cfsilent>>
<<cfoutput>>
<cfsilent>
<!--- -->
<fusedoc fuse="$RCSfile: dsp_list_$$objectName$$.cfm,v $" language="ColdFusion 7.01" version="2.0"  >
	<responsibilities>
		This page displays a listing of the $$objectName$$ records from a recordset. 
		Each record has a link for viewing, deleting, and editing the selected $$objectName$$ record.
	</responsibilities>
	<properties>
		<history author="Kevin Roche" email="kevin@objectiveinternet.com" date="$$dateFormat(now(),'dd-mmm-yyyy')$$" role="Architect" type="Create" />
		<property name="copyright" value="(c)$$year(now())$$ Objective Internet Limited." />
		<property name="licence" value="See licence.txt" />
		<property name="version" value="$Revision$" />
		<property name="lastupdated" value="$Date$$DateFormat(now(),'yyyy/mm/dd')$$ $$ TimeFormat(now(),'HH:mm:ss')$$ $" />
		<property name="updatedby" value="$Author$" />
	</properties>
	<io>
		<in>
			<string name="self" scope="request" />
			<string name="XFA.Display" scope="variables" comments="link to view a record" />
			<string name="XFA.Edit" scope="variables" comments="link to edit a record" />
			<string name="XFA.Add" scope="variables" comments="link to add a record" />
			<string name="XFA.Delete" scope="variables" comments="link to delete a record" />
			<string name="XFA.Prev" scope="variables" comments="link to next page" />
			<string name="XFA.Next" scope="variables" comments="link to next page" />
			
			<number name="_maxrows" scope="attributes" optional="Yes" comments="Used to limit the display to a number of records." />
			<number name="_startrow" scope="attributes" optional="Yes" comments="Used to specify the first record to display." />
			<number name="_totalRowCount" precision="integer" scope="variables" comments="Count of rows in the $$objectName$$ table." />
			<string name="_listSortByFieldList" default="">
			
			<recordset name="q$$objectname$$" primaryKeys="$$lPKFields$$" scope="variables" comments="Recordset containing $$objectName$$ records " >
			<<cfloop from="1" to="$$ArrayLen(aFields)$$" index="i">>
				<$$aFields[i].type$$ name="$$aFields[i].alias$$" /><</cfloop>>
			<<cfloop from="1" to="$$ArrayLen(aJoinedFields)$$" index="i">><<cfif NOT ListFindNoCase(lFields,aJoinedFields[i].alias)>>
				<$$aJoinedFields[i].type$$ name="$$aJoinedFields[i].alias$$" /><</cfif>><</cfloop>>
			</recordset>
			
			<list name="fieldlist" scope="variables" optional="Yes" 
				default="$$lAllFields$$" 
				comments="List of fields to display." />
		</in>
		<out>
			<string name="fuseaction" scope="formOrUrl" />
			<string name="pkey" scope="formOrUrl" comments="the primary key of the record being viewed, edited or deleted" />
		</out>
	</io>
</fusedoc>
--->
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
<h3>#request.content['__globalmodule__navigation__#request.page.objectName#_Listing']#</h3>
<script type="text/javascript">
	Ext.onReady(function(){
		
		Ext.QuickTips.init();
	    var xg = Ext.grid;
	    var sm = new xg.CheckboxSelectionModel();
        
        var action = new Ext.ux.grid.RowActions({
			header:'Actions',
			actions:[{
				iconCls:'icon-edit-record',
				tooltip:'Edit'
			},{
				iconCls:'icon-delete-record',
				tooltip:'Delete'
			}]
		});
		
		action.on({
			action:function(grid, record, action, row, col) {
				if(action == 'icon-edit-record'){
					window.location.href='#myself##xfa.update#&$$lPKFields$$=' + grid.getSelectionModel().getSelected().id;
				}
				else if(action == 'icon-delete-record'){
					doDel();
				}
			}
		});
	    	    
	    var ds = new Ext.data.GroupingStore({
			proxy: new Ext.data.HttpProxy({
				url:'#myself##xfa.grid_json#'
			}),
			
			reader: new Ext.data.JsonReader({
	        	totalProperty: "totalRecords",
	        	root: 'data',
				id: '$$lPKFields$$'
			},[
				$$sCodeDataReaderModel$$
			]),
			
			sortInfo: {field: '$$lPKFields$$', direction: 'ASC'},
			remoteSort: true,
			autoLoad: false
		});
	    
	    var grid = new xg.GridPanel({
	        id:'button-grid',
	        ds: ds,
	        cm: new xg.ColumnModel([
	        	sm,
	        	$$sCodeColumnModel$$,
	        	action
	        ]),
	        sm: sm,
	
	        // inline toolbars
	        tbar:[{
	            text:'#jsStringFormat(request.content.$$objectName$$_grid_global_add)#',
	            tooltip:'#jsStringFormat(request.content.$$objectName$$_grid_global_add)#',
	            iconCls:'add',
	            handler:function(){window.location.href='#myself##xfa.add#';}
	        },'-',{
	            text:'#jsStringFormat(request.content.$$objectName$$_grid_global_delete)#',
	            tooltip:'#jsStringFormat(request.content.$$objectName$$_grid_global_delete)#',
	            iconCls:'remove',
	            handler: doDel
	        }],
	
	        height:533,
	        frame:false,
	        renderTo: Ext.get('grid_$$objectName$$'),
	        plugins: [action,new Ext.ux.grid.Search({
				mode:'remote',
				iconCls:false,
				dateFormat:'m/d/Y',
				minLength:1
			})],
	        
	        viewConfig: {
		        forceFit: true
		    },
	        
	        bbar: new Ext.PagingToolbar({
	            pageSize: 20,
	            store: ds
	        })
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
					url:"#myself##XFA.delete#",
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