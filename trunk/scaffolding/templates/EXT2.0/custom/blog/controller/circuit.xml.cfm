<cfoutput>
	<fuseaction access="public" name="news">
		<include circuit="#sModule#" template="act_news"/>
		<include circuit="v_#sModule#" template="dsp_news"/>
	</fuseaction>
	
	<fuseaction access="public" name="archive">
		<include circuit="#sModule#" template="act_archive"/>
		<include circuit="v_#sModule#" template="dsp_archive"/>
	</fuseaction>
	
	<fuseaction access="public" name="categories">
		<include circuit="v_#sModule#" template="dsp_categories"/>
	</fuseaction>
	
	<fuseaction access="public" name="trackback" lanshock:showlayout="none">
		<include circuit="#sModule#" template="act_trackback"/>
		<include circuit="v_#sModule#" template="dsp_trackback"/>
	</fuseaction>
	
	<fuseaction access="public" name="panel_news" lanshock:showlayout="basic">
		<include circuit="#sModule#" template="act_panel_news"/>
		<include circuit="v_#sModule#" template="dsp_panel_news"/>
	</fuseaction>
	
	<fuseaction access="public" name="news_details">
		<include circuit="#sModule#" template="act_news_details"/>
		<include circuit="v_#sModule#" template="dsp_news_details"/>
	</fuseaction>
	
	<fuseaction access="public" name="news_comment_edit">
		<xfa name="next" value="news_comments"/>
		<include circuit="#sModule#" template="act_news_comment_edit"/>
	</fuseaction>
	
	<fuseaction access="public" name="news_comment_del">
		<lanshock:security area="news_entry"/>
		<xfa name="next" value="news_comments"/>
		<include circuit="#sModule#" template="act_news_comment_del"/>
	</fuseaction>
	
	<fuseaction access="public" name="rss" lanshock:showlayout="none">
		<include circuit="#sModule#" template="act_rss"/>
		<include circuit="v_#sModule#" template="dsp_rss"/>
	</fuseaction>
</cfoutput>