<cfset stScaffolding = StructNew()>
<cfset stScaffolding['admin'] = StructNew()>
<cfset stScaffolding['admin'].lTables = 'core_configmanager,core_logs,core_security_roles,core_security_permissions,core_security_roles_permissions_rel,core_security_users_roles_rel,core_modules,core_navigation,user'>
<cfset stScaffolding['blog'] = StructNew()>
<cfset stScaffolding['blog'].lTables = 'news_entry,news_trackback,news_category,news_entry_category,news_ping_url'>