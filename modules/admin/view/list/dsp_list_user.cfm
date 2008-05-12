<cfsilent>
<!--- -->
<fusedoc fuse="$RCSfile: dsp_list_user.cfm,v $" language="ColdFusion 7.01" version="2.0"  >
	<responsibilities>
		This page displays a listing of the user records from a recordset. 
		Each record has a link for viewing, deleting, and editing the selected user record.
	</responsibilities>
	<properties>
		<history author="Kevin Roche" email="kevin@objectiveinternet.com" date="12-May-2008" role="Architect" type="Create" />
		<property name="copyright" value="(c)2008 Objective Internet Limited." />
		<property name="licence" value="See licence.txt" />
		<property name="version" value="$Revision: 205 $" />
		<property name="lastupdated" value="$Date: 2008-03-09 12:47:41 +0100 (So, 09 Mrz 2008) 2008/05/12 14:12:08 $" />
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
			<number name="_totalRowCount" precision="integer" scope="variables" comments="Count of rows in the user table." />
			<string name="_listSortByFieldList" default="">
			
			<recordset name="quser" primaryKeys="id" scope="variables" comments="Recordset containing user records " >
			
				<numeric name="id" />
				<string name="name" />
				<string name="email" />
				<string name="pwd" />
				<string name="firstname" />
				<string name="lastname" />
				<numeric name="gender" />
				<string name="status" />
				<string name="signature" />
				<string name="homepage" />
				<string name="internal_note" />
				<date name="dt_birthdate" />
				<date name="dt_lastlogin" />
				<date name="dt_registered" />
				<string name="language" />
				<string name="country" />
				<string name="city" />
				<string name="street" />
				<string name="zip" />
				<numeric name="logincount" />
				<string name="reset_password_key" />
				<string name="openid_url" />
				<string name="geo_latlong" />
			
			</recordset>
			
			<list name="fieldlist" scope="variables" optional="Yes" 
				default="id,name,email,pwd,firstname,lastname,gender,status,signature,homepage,internal_note,dt_birthdate,dt_lastlogin,dt_registered,language,country,city,street,zip,logincount,reset_password_key,openid_url,geo_latlong" 
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
<cfparam name="variables.fieldlist" default="id,name,email,pwd,firstname,lastname,gender,status,signature,homepage,internal_note,dt_birthdate,dt_lastlogin,dt_registered,language,country,city,street,zip,logincount,reset_password_key,openid_url,geo_latlong">
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
					window.location.href='#myself##xfa.update#&id=' + grid.getSelectionModel().getSelected().id;
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
				id: 'id'
			},[
				{name:'id',mapping:'id'},{name:'name',mapping:'name'},{name:'email',mapping:'email'},{name:'firstname',mapping:'firstname'},{name:'lastname',mapping:'lastname'}
			]),
			
			sortInfo: {field: 'id', direction: 'ASC'},
			remoteSort: true,
			autoLoad: false
		});
	    
	    var grid = new xg.GridPanel({
	        id:'button-grid',
	        ds: ds,
	        cm: new xg.ColumnModel([
	        	sm,
	        	{id:'id',header:'#jsStringFormat(request.content.user_grid_header_id)#',width:30,sortable:true,dataIndex:'id'},{header:'#jsStringFormat(request.content.user_grid_header_name)#',width:30,sortable:true,dataIndex:'name'},{header:'#jsStringFormat(request.content.user_grid_header_email)#',width:30,sortable:true,dataIndex:'email'},{header:'#jsStringFormat(request.content.user_grid_header_firstname)#',width:30,sortable:true,dataIndex:'firstname'},{header:'#jsStringFormat(request.content.user_grid_header_lastname)#',width:30,sortable:true,dataIndex:'lastname'},
	        	action
	        ]),
	        sm: sm,
	
	        // inline toolbars
	        tbar:[{
	            text:'#jsStringFormat(request.content.user_grid_global_add)#',
	            tooltip:'#jsStringFormat(request.content.user_grid_global_add)#',
	            iconCls:'add',
	            handler:function(){window.location.href='#myself##xfa.add#';}
	        },'-',{
	            text:'#jsStringFormat(request.content.user_grid_global_delete)#',
	            tooltip:'#jsStringFormat(request.content.user_grid_global_delete)#',
	            iconCls:'remove',
	            handler: doDel
	        }],
	
	        height:533,
	        frame:false,
	        renderTo: Ext.get('grid_user'),
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
	        if(m.length > 0) Ext.MessageBox.confirm('Message','#jsStringFormat(request.content.user_grid_global_delete_warning_confirm)#',doDel2);
	        else Ext.MessageBox.alert('Message','#jsStringFormat(request.content.user_grid_global_delete_warning_select)#');
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
<div id="grid_user"></div>
</cfoutput>
