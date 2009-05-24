<circuit xmlns:cf="cf/" xmlns:reactor="reactor/" xmlns:cs="coldspring/" xmlns:lanshock="lanshock/">

	
	<prefuseaction>
		<lanshock:fuseaction>
			<set name="request.page" value="#structNew()#"/>
			<lanshock:i18n load="modules/blog/i18n/lang.properties" returnvariable="request.content"/>
			
			<include circuit="blog" template="settings"/>
		</lanshock:fuseaction>
	</prefuseaction>
	
	<postfuseaction>
		<lanshock:fuseaction>
			<if condition="isDefined('request.layout')">
				<true>
					<if condition="request.layout EQ 'json'">
						<true>
							<set name="_fba.debug" value="false"/>
							<include circuit="v_blog" template="dsp_layout_json"/>
						</true>
						<false>
							<if condition="request.layout EQ 'none'">
								<true>
									<set name="_fba.debug" value="false"/>
								</true>
							</if>
						</false>
					</if>
				</true>
			</if>
		</lanshock:fuseaction>
	</postfuseaction>
	
	<fuseaction access="public" name="main">
		
			
			<xfa name="relocate" value="news"/>
<lanshock:relocate xfa="relocate"/>
			
		
	</fuseaction>
	
	<fuseaction access="public" name="news">
		<include circuit="blog" template="custom/act_news"/>
		<lanshock:display circuit="v_blog" template="custom/dsp_news"/>
	</fuseaction>
	
	<fuseaction access="public" name="archive">
		<include circuit="blog" template="custom/act_archive"/>
		<lanshock:display circuit="v_blog" template="custom/dsp_archive"/>
	</fuseaction>
	
	<fuseaction access="public" name="categories">
		<lanshock:display circuit="v_blog" template="custom/dsp_categories"/>
	</fuseaction>
	
	<fuseaction access="public" lanshock:showlayout="none" name="trackback">
		<include circuit="blog" template="custom/act_trackback"/>
		<lanshock:display circuit="v_blog" template="custom/dsp_trackback"/>
	</fuseaction>
	
	<fuseaction access="public" name="news_details">
		<include circuit="blog" template="custom/act_news_details"/>
		<lanshock:display circuit="v_blog" template="custom/dsp_news_details"/>
	</fuseaction>
	
	<fuseaction access="public" name="news_comment_edit">
		<xfa name="next" value="news_comments"/>
		<include circuit="blog" template="custom/act_news_comment_edit"/>
	</fuseaction>
	
	<fuseaction access="public" name="news_comment_del">
		<lanshock:security area="news_entry"/>
		<xfa name="next" value="news_comments"/>
		<include circuit="blog" template="custom/act_news_comment_del"/>
	</fuseaction>
	
	<fuseaction access="public" lanshock:showlayout="none" name="rss">
		<include circuit="blog" template="custom/act_rss"/>
		<include circuit="v_blog" template="custom/dsp_rss"/>
	</fuseaction>
	
	<fuseaction access="public" name="news_category_listing">
		<lanshock:security area="news_category"/>
		
		<!-- force layout: admin -->
		<set name="request.layout" value="admin"/>
		
		<!-- Listing: I display a list of the records in the news_category table. -->
		<set name="request.page.objectName" value="news_category"/>
		<set name="request.page.description" value="I display a list of the news_category records in the table."/>
		<xfa name="update" value="news_category_edit_form"/>
		<xfa name="delete" value="news_category_delete"/>
		<xfa name="display" value="news_category_display"/>
		<xfa name="add" value="news_category_add_form"/>
		<xfa name="grid_json" value="news_category_grid_json"/>
		
		<set name="attributes._maxrows" overwrite="false" value="10"/>
		<set name="attributes._startrow" overwrite="false" value="1"/>
		
		<set name="attributes._listSortByFieldList" overwrite="false" value="news_category|id|ASC"/>
		
		<set name="fieldlist" value="id,name,"/>
		<include circuit="v_blog" template="list/dsp_list_news_category"/>
	</fuseaction>
	
	<fuseaction access="public" lanshock:showlayout="none" name="news_category_grid_json">
		<lanshock:security area="news_category"/>
		
		<!-- force layout: json -->
		<set name="request.layout" value="json"/>
		
		<!-- params by ext.grid -->
		<include circuit="blog" template="list/act_json_filter_news_category"/>
		
		<invoke method="getRecordsForGrid" object="application.lanshock.oFactory.load('news_category','reactorGateway')" returnvariable="request.page.pageContent">
			<argument name="sortByFieldList" value="news_category|#attributes.sort#|#attributes.dir#"/>
			<argument name="startrow" value="#attributes.start#"/>
			<argument name="maxrows" value="#attributes.limit#"/>
			<argument name="filter" value="#stFilters#"/>
		</invoke>
	</fuseaction>
	
	<fuseaction access="public" name="news_category_add_form">
		<set name="mode" value="insert"/>
		<xfa name="save" value="news_category_action_add"/>
		<do action="news_category_form"/>
	</fuseaction>
	
	<fuseaction access="public" name="news_category_edit_form">
		<set name="mode" value="edit"/>
		<xfa name="save" value="news_category_action_update"/>
		<do action="news_category_form"/>
	</fuseaction>
	
	<fuseaction access="private" lanshock:includedCircuit="true" name="news_category_form">
		<lanshock:security area="news_category"/>
		<set name="request.layout" value="admin"/>
		<xfa name="cancel" value="news_category_listing"/>
		
		<include circuit="blog" template="form/act_form_news_category"/>
		
		<include circuit="blog" template="form/act_form_loadrelated_news_category"/>
		
		<!-- snippet 'modules/blog/controller/form/snippets/act_form_loadrelated_custom_news_category.cfm' -->
		
		<!-- /snippet -->
		
		<include circuit="v_blog" template="form/dsp_form_news_category"/>
	</fuseaction>
	
	<fuseaction access="public" name="news_category_action_add">
		<set name="mode" value="insert"/>
		<xfa name="save" value="news_category_action_add"/>
		<do action="news_category_action_save"/>
	</fuseaction>
	
	<fuseaction access="public" name="news_category_action_update">
		<set name="mode" value="edit"/>
		<xfa name="save" value="news_category_action_update"/>
		<do action="news_category_action_save"/>
	</fuseaction>
	
	<fuseaction access="private" lanshock:includedCircuit="true" name="news_category_action_save">
		<lanshock:security area="news_category"/>
		<set name="bHasErrors" value="false"/>
		<xfa name="continue" value="news_category_listing"/>
		<xfa name="cancel" value="news_category_listing"/>
		<include circuit="blog" template="form/act_action_save_news_category"/>
	</fuseaction>
	
	<fuseaction access="public" name="news_category_delete">
		<lanshock:security area="news_category"/>
		
		<!-- Delete: I delete the selected news_category records. -->
		
		<!-- force layout: none -->
		<set name="request.layout" value="none"/>
		
		<invoke method="deleteByIDlist" object="application.lanshock.oFactory.load('news_category','reactorGateway')" returnvariable="request.page.pageContent">
			<argument name="jsonData" value="#attributes.jsonData#"/>
		</invoke>
	</fuseaction>
	
	<fuseaction access="public" name="news_entry_listing">
		<lanshock:security area="news_entry"/>
		
		<!-- force layout: admin -->
		<set name="request.layout" value="admin"/>
		
		<!-- Listing: I display a list of the records in the news_entry table. -->
		<set name="request.page.objectName" value="news_entry"/>
		<set name="request.page.description" value="I display a list of the news_entry records in the table."/>
		<xfa name="update" value="news_entry_edit_form"/>
		<xfa name="delete" value="news_entry_delete"/>
		<xfa name="display" value="news_entry_display"/>
		<xfa name="add" value="news_entry_add_form"/>
		<xfa name="grid_json" value="news_entry_grid_json"/>
		
		<set name="attributes._maxrows" overwrite="false" value="10"/>
		<set name="attributes._startrow" overwrite="false" value="1"/>
		
		<set name="attributes._listSortByFieldList" overwrite="false" value="news_entry|id|ASC"/>
		
		<set name="fieldlist" value="id,author,title,text,date,mp3url,"/>
		<include circuit="v_blog" template="list/dsp_list_news_entry"/>
	</fuseaction>
	
	<fuseaction access="public" lanshock:showlayout="none" name="news_entry_grid_json">
		<lanshock:security area="news_entry"/>
		
		<!-- force layout: json -->
		<set name="request.layout" value="json"/>
		
		<!-- params by ext.grid -->
		<include circuit="blog" template="list/act_json_filter_news_entry"/>
		
		<invoke method="getRecordsForGrid" object="application.lanshock.oFactory.load('news_entry','reactorGateway')" returnvariable="request.page.pageContent">
			<argument name="sortByFieldList" value="news_entry|#attributes.sort#|#attributes.dir#"/>
			<argument name="startrow" value="#attributes.start#"/>
			<argument name="maxrows" value="#attributes.limit#"/>
			<argument name="filter" value="#stFilters#"/>
		</invoke>
	</fuseaction>
	
	<fuseaction access="public" name="news_entry_add_form">
		<set name="mode" value="insert"/>
		<xfa name="save" value="news_entry_action_add"/>
		<do action="news_entry_form"/>
	</fuseaction>
	
	<fuseaction access="public" name="news_entry_edit_form">
		<set name="mode" value="edit"/>
		<xfa name="save" value="news_entry_action_update"/>
		<do action="news_entry_form"/>
	</fuseaction>
	
	<fuseaction access="private" lanshock:includedCircuit="true" name="news_entry_form">
		<lanshock:security area="news_entry"/>
		<set name="request.layout" value="admin"/>
		<xfa name="cancel" value="news_entry_listing"/>
		
		<include circuit="blog" template="form/act_form_news_entry"/>
		
		<include circuit="blog" template="form/act_form_loadrelated_news_entry"/>
		
		<!-- snippet 'modules/blog/controller/form/snippets/act_form_loadrelated_custom_news_entry.cfm' -->
		
		<!-- /snippet -->
		
		<include circuit="v_blog" template="form/dsp_form_news_entry"/>
	</fuseaction>
	
	<fuseaction access="public" name="news_entry_action_add">
		<set name="mode" value="insert"/>
		<xfa name="save" value="news_entry_action_add"/>
		<do action="news_entry_action_save"/>
	</fuseaction>
	
	<fuseaction access="public" name="news_entry_action_update">
		<set name="mode" value="edit"/>
		<xfa name="save" value="news_entry_action_update"/>
		<do action="news_entry_action_save"/>
	</fuseaction>
	
	<fuseaction access="private" lanshock:includedCircuit="true" name="news_entry_action_save">
		<lanshock:security area="news_entry"/>
		<set name="bHasErrors" value="false"/>
		<xfa name="continue" value="news_entry_listing"/>
		<xfa name="cancel" value="news_entry_listing"/>
		<include circuit="blog" template="form/act_action_save_news_entry"/>
	</fuseaction>
	
	<fuseaction access="public" name="news_entry_delete">
		<lanshock:security area="news_entry"/>
		
		<!-- Delete: I delete the selected news_entry records. -->
		
		<!-- force layout: none -->
		<set name="request.layout" value="none"/>
		
		<invoke method="deleteByIDlist" object="application.lanshock.oFactory.load('news_entry','reactorGateway')" returnvariable="request.page.pageContent">
			<argument name="jsonData" value="#attributes.jsonData#"/>
		</invoke>
	</fuseaction>
	
	<fuseaction access="public" name="news_entry_category_listing">
		<lanshock:security area="news_entry_category"/>
		
		<!-- force layout: admin -->
		<set name="request.layout" value="admin"/>
		
		<!-- Listing: I display a list of the records in the news_entry_category table. -->
		<set name="request.page.objectName" value="news_entry_category"/>
		<set name="request.page.description" value="I display a list of the news_entry_category records in the table."/>
		<xfa name="update" value="news_entry_category_edit_form"/>
		<xfa name="delete" value="news_entry_category_delete"/>
		<xfa name="display" value="news_entry_category_display"/>
		<xfa name="add" value="news_entry_category_add_form"/>
		<xfa name="grid_json" value="news_entry_category_grid_json"/>
		
		<set name="attributes._maxrows" overwrite="false" value="10"/>
		<set name="attributes._startrow" overwrite="false" value="1"/>
		
		<set name="attributes._listSortByFieldList" overwrite="false" value="news_entry_category|id|ASC"/>
		
		<set name="fieldlist" value="id,entry_id,category_id,"/>
		<include circuit="v_blog" template="list/dsp_list_news_entry_category"/>
	</fuseaction>
	
	<fuseaction access="public" lanshock:showlayout="none" name="news_entry_category_grid_json">
		<lanshock:security area="news_entry_category"/>
		
		<!-- force layout: json -->
		<set name="request.layout" value="json"/>
		
		<!-- params by ext.grid -->
		<include circuit="blog" template="list/act_json_filter_news_entry_category"/>
		
		<invoke method="getRecordsForGrid" object="application.lanshock.oFactory.load('news_entry_category','reactorGateway')" returnvariable="request.page.pageContent">
			<argument name="sortByFieldList" value="news_entry_category|#attributes.sort#|#attributes.dir#"/>
			<argument name="startrow" value="#attributes.start#"/>
			<argument name="maxrows" value="#attributes.limit#"/>
			<argument name="filter" value="#stFilters#"/>
		</invoke>
	</fuseaction>
	
	<fuseaction access="public" name="news_entry_category_add_form">
		<set name="mode" value="insert"/>
		<xfa name="save" value="news_entry_category_action_add"/>
		<do action="news_entry_category_form"/>
	</fuseaction>
	
	<fuseaction access="public" name="news_entry_category_edit_form">
		<set name="mode" value="edit"/>
		<xfa name="save" value="news_entry_category_action_update"/>
		<do action="news_entry_category_form"/>
	</fuseaction>
	
	<fuseaction access="private" lanshock:includedCircuit="true" name="news_entry_category_form">
		<lanshock:security area="news_entry_category"/>
		<set name="request.layout" value="admin"/>
		<xfa name="cancel" value="news_entry_category_listing"/>
		
		<include circuit="blog" template="form/act_form_news_entry_category"/>
		
		<include circuit="blog" template="form/act_form_loadrelated_news_entry_category"/>
		
		<!-- snippet 'modules/blog/controller/form/snippets/act_form_loadrelated_custom_news_entry_category.cfm' -->
		
		<!-- /snippet -->
		
		<include circuit="v_blog" template="form/dsp_form_news_entry_category"/>
	</fuseaction>
	
	<fuseaction access="public" name="news_entry_category_action_add">
		<set name="mode" value="insert"/>
		<xfa name="save" value="news_entry_category_action_add"/>
		<do action="news_entry_category_action_save"/>
	</fuseaction>
	
	<fuseaction access="public" name="news_entry_category_action_update">
		<set name="mode" value="edit"/>
		<xfa name="save" value="news_entry_category_action_update"/>
		<do action="news_entry_category_action_save"/>
	</fuseaction>
	
	<fuseaction access="private" lanshock:includedCircuit="true" name="news_entry_category_action_save">
		<lanshock:security area="news_entry_category"/>
		<set name="bHasErrors" value="false"/>
		<xfa name="continue" value="news_entry_category_listing"/>
		<xfa name="cancel" value="news_entry_category_listing"/>
		<include circuit="blog" template="form/act_action_save_news_entry_category"/>
	</fuseaction>
	
	<fuseaction access="public" name="news_entry_category_delete">
		<lanshock:security area="news_entry_category"/>
		
		<!-- Delete: I delete the selected news_entry_category records. -->
		
		<!-- force layout: none -->
		<set name="request.layout" value="none"/>
		
		<invoke method="deleteByIDlist" object="application.lanshock.oFactory.load('news_entry_category','reactorGateway')" returnvariable="request.page.pageContent">
			<argument name="jsonData" value="#attributes.jsonData#"/>
		</invoke>
	</fuseaction>
	
	<fuseaction access="public" name="news_ping_url_listing">
		<lanshock:security area="news_ping_url"/>
		
		<!-- force layout: admin -->
		<set name="request.layout" value="admin"/>
		
		<!-- Listing: I display a list of the records in the news_ping_url table. -->
		<set name="request.page.objectName" value="news_ping_url"/>
		<set name="request.page.description" value="I display a list of the news_ping_url records in the table."/>
		<xfa name="update" value="news_ping_url_edit_form"/>
		<xfa name="delete" value="news_ping_url_delete"/>
		<xfa name="display" value="news_ping_url_display"/>
		<xfa name="add" value="news_ping_url_add_form"/>
		<xfa name="grid_json" value="news_ping_url_grid_json"/>
		
		<set name="attributes._maxrows" overwrite="false" value="10"/>
		<set name="attributes._startrow" overwrite="false" value="1"/>
		
		<set name="attributes._listSortByFieldList" overwrite="false" value="news_ping_url|id|ASC"/>
		
		<set name="fieldlist" value="id,name,url,"/>
		<include circuit="v_blog" template="list/dsp_list_news_ping_url"/>
	</fuseaction>
	
	<fuseaction access="public" lanshock:showlayout="none" name="news_ping_url_grid_json">
		<lanshock:security area="news_ping_url"/>
		
		<!-- force layout: json -->
		<set name="request.layout" value="json"/>
		
		<!-- params by ext.grid -->
		<include circuit="blog" template="list/act_json_filter_news_ping_url"/>
		
		<invoke method="getRecordsForGrid" object="application.lanshock.oFactory.load('news_ping_url','reactorGateway')" returnvariable="request.page.pageContent">
			<argument name="sortByFieldList" value="news_ping_url|#attributes.sort#|#attributes.dir#"/>
			<argument name="startrow" value="#attributes.start#"/>
			<argument name="maxrows" value="#attributes.limit#"/>
			<argument name="filter" value="#stFilters#"/>
		</invoke>
	</fuseaction>
	
	<fuseaction access="public" name="news_ping_url_add_form">
		<set name="mode" value="insert"/>
		<xfa name="save" value="news_ping_url_action_add"/>
		<do action="news_ping_url_form"/>
	</fuseaction>
	
	<fuseaction access="public" name="news_ping_url_edit_form">
		<set name="mode" value="edit"/>
		<xfa name="save" value="news_ping_url_action_update"/>
		<do action="news_ping_url_form"/>
	</fuseaction>
	
	<fuseaction access="private" lanshock:includedCircuit="true" name="news_ping_url_form">
		<lanshock:security area="news_ping_url"/>
		<set name="request.layout" value="admin"/>
		<xfa name="cancel" value="news_ping_url_listing"/>
		
		<include circuit="blog" template="form/act_form_news_ping_url"/>
		
		<include circuit="blog" template="form/act_form_loadrelated_news_ping_url"/>
		
		<!-- snippet 'modules/blog/controller/form/snippets/act_form_loadrelated_custom_news_ping_url.cfm' -->
		
		<!-- /snippet -->
		
		<include circuit="v_blog" template="form/dsp_form_news_ping_url"/>
	</fuseaction>
	
	<fuseaction access="public" name="news_ping_url_action_add">
		<set name="mode" value="insert"/>
		<xfa name="save" value="news_ping_url_action_add"/>
		<do action="news_ping_url_action_save"/>
	</fuseaction>
	
	<fuseaction access="public" name="news_ping_url_action_update">
		<set name="mode" value="edit"/>
		<xfa name="save" value="news_ping_url_action_update"/>
		<do action="news_ping_url_action_save"/>
	</fuseaction>
	
	<fuseaction access="private" lanshock:includedCircuit="true" name="news_ping_url_action_save">
		<lanshock:security area="news_ping_url"/>
		<set name="bHasErrors" value="false"/>
		<xfa name="continue" value="news_ping_url_listing"/>
		<xfa name="cancel" value="news_ping_url_listing"/>
		<include circuit="blog" template="form/act_action_save_news_ping_url"/>
	</fuseaction>
	
	<fuseaction access="public" name="news_ping_url_delete">
		<lanshock:security area="news_ping_url"/>
		
		<!-- Delete: I delete the selected news_ping_url records. -->
		
		<!-- force layout: none -->
		<set name="request.layout" value="none"/>
		
		<invoke method="deleteByIDlist" object="application.lanshock.oFactory.load('news_ping_url','reactorGateway')" returnvariable="request.page.pageContent">
			<argument name="jsonData" value="#attributes.jsonData#"/>
		</invoke>
	</fuseaction>
	
	<fuseaction access="public" name="news_trackback_listing">
		<lanshock:security area="news_trackback"/>
		
		<!-- force layout: admin -->
		<set name="request.layout" value="admin"/>
		
		<!-- Listing: I display a list of the records in the news_trackback table. -->
		<set name="request.page.objectName" value="news_trackback"/>
		<set name="request.page.description" value="I display a list of the news_trackback records in the table."/>
		<xfa name="update" value="news_trackback_edit_form"/>
		<xfa name="delete" value="news_trackback_delete"/>
		<xfa name="display" value="news_trackback_display"/>
		<xfa name="add" value="news_trackback_add_form"/>
		<xfa name="grid_json" value="news_trackback_grid_json"/>
		
		<set name="attributes._maxrows" overwrite="false" value="10"/>
		<set name="attributes._startrow" overwrite="false" value="1"/>
		
		<set name="attributes._listSortByFieldList" overwrite="false" value="news_trackback|id|ASC"/>
		
		<set name="fieldlist" value="id,entry_id,blog_name,title,text,date,url,"/>
		<include circuit="v_blog" template="list/dsp_list_news_trackback"/>
	</fuseaction>
	
	<fuseaction access="public" lanshock:showlayout="none" name="news_trackback_grid_json">
		<lanshock:security area="news_trackback"/>
		
		<!-- force layout: json -->
		<set name="request.layout" value="json"/>
		
		<!-- params by ext.grid -->
		<include circuit="blog" template="list/act_json_filter_news_trackback"/>
		
		<invoke method="getRecordsForGrid" object="application.lanshock.oFactory.load('news_trackback','reactorGateway')" returnvariable="request.page.pageContent">
			<argument name="sortByFieldList" value="news_trackback|#attributes.sort#|#attributes.dir#"/>
			<argument name="startrow" value="#attributes.start#"/>
			<argument name="maxrows" value="#attributes.limit#"/>
			<argument name="filter" value="#stFilters#"/>
		</invoke>
	</fuseaction>
	
	<fuseaction access="public" name="news_trackback_add_form">
		<set name="mode" value="insert"/>
		<xfa name="save" value="news_trackback_action_add"/>
		<do action="news_trackback_form"/>
	</fuseaction>
	
	<fuseaction access="public" name="news_trackback_edit_form">
		<set name="mode" value="edit"/>
		<xfa name="save" value="news_trackback_action_update"/>
		<do action="news_trackback_form"/>
	</fuseaction>
	
	<fuseaction access="private" lanshock:includedCircuit="true" name="news_trackback_form">
		<lanshock:security area="news_trackback"/>
		<set name="request.layout" value="admin"/>
		<xfa name="cancel" value="news_trackback_listing"/>
		
		<include circuit="blog" template="form/act_form_news_trackback"/>
		
		<include circuit="blog" template="form/act_form_loadrelated_news_trackback"/>
		
		<!-- snippet 'modules/blog/controller/form/snippets/act_form_loadrelated_custom_news_trackback.cfm' -->
		
		<!-- /snippet -->
		
		<include circuit="v_blog" template="form/dsp_form_news_trackback"/>
	</fuseaction>
	
	<fuseaction access="public" name="news_trackback_action_add">
		<set name="mode" value="insert"/>
		<xfa name="save" value="news_trackback_action_add"/>
		<do action="news_trackback_action_save"/>
	</fuseaction>
	
	<fuseaction access="public" name="news_trackback_action_update">
		<set name="mode" value="edit"/>
		<xfa name="save" value="news_trackback_action_update"/>
		<do action="news_trackback_action_save"/>
	</fuseaction>
	
	<fuseaction access="private" lanshock:includedCircuit="true" name="news_trackback_action_save">
		<lanshock:security area="news_trackback"/>
		<set name="bHasErrors" value="false"/>
		<xfa name="continue" value="news_trackback_listing"/>
		<xfa name="cancel" value="news_trackback_listing"/>
		<include circuit="blog" template="form/act_action_save_news_trackback"/>
	</fuseaction>
	<fuseaction name="news_trackback_delete" access="public">
		<lanshock:security area="news_trackback"/>
		
		<!-- Delete: I delete the selected news_trackback records. -->
		
		<!-- force layout: none -->
		<set name="request.layout" value="none" />
		
		<invoke object="application.lanshock.oFactory.load('news_trackback','reactorGateway')" method="deleteByIDlist" returnvariable="request.page.pageContent">
			<argument name="jsonData" value="#attributes.jsonData#" />
		</invoke>
	</fuseaction>
</circuit>
