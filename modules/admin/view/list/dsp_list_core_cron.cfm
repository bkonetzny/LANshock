<cfsilent>
<!--- -->
<fusedoc fuse="$RCSfile: dsp_list_core_cron.cfm,v $" language="ColdFusion 7.01" version="2.0"  >
	<responsibilities>
		This page displays a listing of the core_cron records from a recordset. 
		Each record has a link for viewing, deleting, and editing the selected core_cron record.
	</responsibilities>
	<properties>
		<history author="Kevin Roche" email="kevin@objectiveinternet.com" date="12-Mar-2008" role="Architect" type="Create" />
		<property name="copyright" value="(c)2008 Objective Internet Limited." />
		<property name="licence" value="See licence.txt" />
		<property name="version" value="$Revision: 205 $" />
		<property name="lastupdated" value="$Date: 2008-03-09 12:47:41 +0100 (So, 09 Mrz 2008) 2008/03/12 14:09:10 $" />
		<property name="updatedby" value="$Author: majestixs $" />
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
			<number name="_totalRowCount" precision="integer" scope="variables" comments="Count of rows in the core_cron table." />
			<string name="_listSortByFieldList" default="">
			
			<recordset name="qcore_cron" primaryKeys="id" scope="variables" comments="Recordset containing core_cron records " >
			
				<numeric name="executions" />
				<numeric name="id" />
				<date name="lastrun_dt" />
				<numeric name="active" />
				<string name="action" />
				<string name="module" />
				<string name="result" />
				<string name="run" />
				<numeric name="lastrun_time" />
			
			</recordset>
			
			<list name="fieldlist" scope="variables" optional="Yes" 
				default="executions,id,lastrun_dt,active,action,module,result,run,lastrun_time" 
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
<cfparam name="variables.fieldlist" default="executions,id,lastrun_dt,active,action,module,result,run,lastrun_time">
</cfsilent>
<cfoutput>
<script type="text/javascript">
	Ext.onReady(function(){
		
		Ext.ux.menu.RangeMenu.prototype.icons = {
          gt: '#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/js/ext-2.0-ux/img/greater_then.png', 
          lt: '#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/js/ext-2.0-ux/img/less_then.png',
          eq: '#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/js/ext-2.0-ux/img/equals.png'
		};
		
		Ext.ux.grid.filter.StringFilter.prototype.icon = '#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/js/ext-2.0-ux/img/find.png';
	
		Ext.QuickTips.init();
	    var xg = Ext.grid;
	    var sm = new xg.CheckboxSelectionModel();
	    
	    var cmenu = new Ext.menu.Menu('gridContextMenu');
        cmenu.add({
        	id:'cm_btn_edit',
        	text:'#jsStringFormat(request.content.core_cron_grid_row_edit)#',
        	action:'edit',
        	handler:function(e){window.location.href='#myself##xfa.update#&id=' + grid.getSelectionModel().getSelected().id;},
        	iconCls:'edit'
        });
        cmenu.addSeparator();
        cmenu.add({
        	id:'cm_btn_remove',
        	text:'#jsStringFormat(request.content.core_cron_grid_row_delete)#',
        	action:'remove',
        	handler:doDel,
        	iconCls:'remove'
        });
	    	    
	    var ds = new Ext.data.GroupingStore({
			proxy: new Ext.data.HttpProxy({
				url:'#myself##xfa.grid_json#'
			}),
			
			reader: new Ext.data.JsonReader({
	        	totalProperty: "totalRecords",
	        	root: 'data',
				id: 'id'
	           },[
				{name:'executions',mapping:'executions'},{name:'id',mapping:'id'},{name:'lastrun_dt',mapping:'lastrun_dt'},{name:'active',mapping:'active'},{name:'action',mapping:'action'},{name:'module',mapping:'module'},{name:'result',mapping:'result'},{name:'run',mapping:'run'},{name:'lastrun_time',mapping:'lastrun_time'}
			]),
			
			sortInfo: {field: 'id', direction: 'ASC'},
			remoteSort: true,
			autoLoad: false
		});
		var filters = new Ext.ux.grid.GridFilters({filters:[
			{type: 'string', dataIndex: 'executions'},{type: 'string', dataIndex: 'id'},{type: 'string', dataIndex: 'lastrun_dt'},{type: 'string', dataIndex: 'active'},{type: 'string', dataIndex: 'action'},{type: 'string', dataIndex: 'module'},{type: 'string', dataIndex: 'result'},{type: 'string', dataIndex: 'run'},{type: 'string', dataIndex: 'lastrun_time'}
		]});
	    
	    var grid = new xg.GridPanel({
	        id:'button-grid',
	        ds: ds,
	        cm: new xg.ColumnModel([
	        	sm,
	        	{id:'id',header:'#jsStringFormat(request.content.core_cron_grid_header_Executions)#',width:30,sortable:true,dataIndex:'executions'},{header:'#jsStringFormat(request.content.core_cron_grid_header_Id)#',width:30,sortable:true,dataIndex:'id'},{header:'#jsStringFormat(request.content.core_cron_grid_header_Lastrun dt)#',width:30,sortable:true,dataIndex:'lastrun_dt'},{header:'#jsStringFormat(request.content.core_cron_grid_header_Active)#',width:30,sortable:true,dataIndex:'active'},{header:'#jsStringFormat(request.content.core_cron_grid_header_Action)#',width:30,sortable:true,dataIndex:'action'},{header:'#jsStringFormat(request.content.core_cron_grid_header_Module)#',width:30,sortable:true,dataIndex:'module'},{header:'#jsStringFormat(request.content.core_cron_grid_header_Result)#',width:30,sortable:true,dataIndex:'result'},{header:'#jsStringFormat(request.content.core_cron_grid_header_Run)#',width:30,sortable:true,dataIndex:'run'},{header:'#jsStringFormat(request.content.core_cron_grid_header_Lastrun time)#',width:30,sortable:true,dataIndex:'lastrun_time'}
	        ]),
	        sm: sm,
	
	        // inline toolbars
	        tbar:[{
	            text:'#jsStringFormat(request.content.core_cron_grid_global_add)#',
	            tooltip:'#jsStringFormat(request.content.core_cron_grid_global_add)#',
	            iconCls:'add',
	            handler:function(){window.location.href='#myself##xfa.add#';}
	        },'-',{
	            text:'#jsStringFormat(request.content.core_cron_grid_global_delete)#',
	            tooltip:'#jsStringFormat(request.content.core_cron_grid_global_delete)#',
	            iconCls:'remove',
	            handler: doDel
	        }],
	
	        width:700,
	        height:533,
	        frame:true,
	        title:'#jsStringFormat(request.content['__globalmodule__navigation__core_cron_Listing'])#',
	        iconCls:'icon-grid',
	        renderTo: Ext.get('grid_core_cron'),
	        plugins: filters,
	        
	        view: new Ext.grid.GroupingView({
	        	forceFit:true,
	        	enableGrouping:false,
	        	startCollapsed:false
	        }),
	        
	        bbar: new Ext.PagingToolbar({
	            pageSize: 20,
	            store: ds,
	            plugins: filters
	        })
	    });
		
		ds.load({params:{start: 0, limit: 20}});
	    
	    grid.doRowContextMenu = function (grid, rowIndex, e) {
          e.stopEvent();
          var coords = e.getXY();
          grid.getSelectionModel().selectRow(rowIndex);
          cmenu.showAt([coords[0],coords[1]]);
        }
        
        grid.addListener('rowcontextmenu', grid.doRowContextMenu);
	    
	    function doDel(){
	        var m = grid.getSelections();
	        if(m.length > 0) Ext.MessageBox.confirm('Message','#jsStringFormat(request.content.core_cron_grid_global_delete_warning_confirm)#',doDel2);
	        else Ext.MessageBox.alert('Message','#jsStringFormat(request.content.core_cron_grid_global_delete_warning_select)#');
	    }     
	 
	    function doDel2(btn){
	       if(btn == 'yes') {	
				var m = grid.getSelections();
				var jsonData = "[";
		        for(var i = 0, len = m.length; i < len; i++){        		
					var ss = "{\"id\":\"" + m[i].get("id") + "\"}";
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
<div id="grid_core_cron"></div>
</cfoutput>
<!--- 
$Log$
 --->
