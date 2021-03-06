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
<cfparam name="variables.fieldlist" default="id,tournamentid,teamid,pos,stats_win,stats_lose,points_win,points_lose">
</cfsilent>
<cfoutput>
<h3>#request.content['__globalmodule__navigation__#request.page.objectName#_listing']#</h3>
<script type="text/javascript">
	Ext.onReady(function(){
		
		Ext.QuickTips.init();
	    var xg = Ext.grid;
	    var sm = new xg.CheckboxSelectionModel();
        
        var action = new Ext.ux.grid.RowActions({
			header:'#jsStringFormat(request.content.tournament_ranking_grid_header__rowactions)#',
			actions:[{
				iconCls:'icon-edit-record',
				tooltip:'#jsStringFormat(request.content.tournament_ranking_grid_row_edit)#'
			},{
				iconCls:'icon-delete-record',
				tooltip:'#jsStringFormat(request.content.tournament_ranking_grid_row_delete)#'
			}]
		});
		
		action.on({
			action:function(grid, record, action, row, col) {
				if(action == 'icon-edit-record'){
					window.location.href='#application.lanshock.oHelper.buildUrl('#xfa.update#')#&id=' + grid.getSelectionModel().getSelected().id;
				}
				else if(action == 'icon-delete-record'){
					doDel();
				}
			}
		});
	    	    
	    var ds = new Ext.data.GroupingStore({
			proxy: new Ext.data.HttpProxy({url: '#application.lanshock.oHelper.buildUrl('#xfa.grid_json#')#'}),
			reader: new Ext.data.JsonReader({totalProperty: 'totalRecords', root: 'data', id: 'id'},[
				{name:'id',mapping:'id'},{name:'tournamentid',mapping:'tournamentid'},{name:'teamid',mapping:'teamid'},{name:'pos',mapping:'pos'},{name:'stats_win',mapping:'stats_win'},{name:'stats_lose',mapping:'stats_lose'},{name:'points_win',mapping:'points_win'},{name:'points_lose',mapping:'points_lose'}
			]),
			sortInfo: {field:'id',direction:'DESC'},
			remoteSort: true,
			autoLoad: false
		});
		var grid = new xg.GridPanel({
			id:'button-grid', ds: ds, sm: sm, height: 533, frame: false,
	        viewConfig: {forceFit: true}, renderTo: Ext.get('grid_tournament_ranking'),
	        bbar: new Ext.PagingToolbar({pageSize: 20, store: ds, displayInfo: true}),
			cm: new xg.ColumnModel([
	        	sm,
	        	{id:'id',header:'#jsStringFormat(request.content.tournament_ranking_grid_header_id)#',sortable:true,dataIndex:'id',width:30},{header:'#jsStringFormat(request.content.tournament_ranking_grid_header_tournamentid)#',sortable:true,dataIndex:'tournamentid',width:30},{header:'#jsStringFormat(request.content.tournament_ranking_grid_header_teamid)#',sortable:true,dataIndex:'teamid',width:30},{header:'#jsStringFormat(request.content.tournament_ranking_grid_header_pos)#',sortable:true,dataIndex:'pos',width:30},{header:'#jsStringFormat(request.content.tournament_ranking_grid_header_stats_win)#',sortable:true,dataIndex:'stats_win',width:30},{header:'#jsStringFormat(request.content.tournament_ranking_grid_header_stats_lose)#',sortable:true,dataIndex:'stats_lose',width:30},{header:'#jsStringFormat(request.content.tournament_ranking_grid_header_points_win)#',sortable:true,dataIndex:'points_win',width:30},{header:'#jsStringFormat(request.content.tournament_ranking_grid_header_points_lose)#',sortable:true,dataIndex:'points_lose',width:30},
	        	action
	        ]),
	
	        // inline toolbars
	        tbar:[{
	            text:'#jsStringFormat(request.content.tournament_ranking_grid_global_add)#',
	            tooltip:'#jsStringFormat(request.content.tournament_ranking_grid_global_add)#',
	            iconCls:'add',
	            handler:function(){window.location.href='#application.lanshock.oHelper.buildUrl('#xfa.add#')#';}
	        },'-',{
	            text:'#jsStringFormat(request.content.tournament_ranking_grid_global_delete)#',
	            tooltip:'#jsStringFormat(request.content.tournament_ranking_grid_global_delete)#',
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
	        if(m.length > 0) Ext.MessageBox.confirm('Message','#jsStringFormat(request.content.tournament_ranking_grid_global_delete_warning_confirm)#',doDel2);
	        else Ext.MessageBox.alert('Message','#jsStringFormat(request.content.tournament_ranking_grid_global_delete_warning_select)#');
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
					url:'#application.lanshock.oHelper.buildUrl('#xfa.delete#')#',
					params:{jsonData:jsonData}
				})
				ds.reload();		
			}
		}
	});
</script>
<div id="grid_tournament_ranking"></div>
</cfoutput>
