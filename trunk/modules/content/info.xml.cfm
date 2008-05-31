<!--
 | Copyright (C) 2002 - 2005 LANshock.com                                  |
 |                                                                         |
 | lastmodified: 06-05-18                                                  |
 |           by: bkonetzny                                                 |
 |                               http://sourceforge.net/projects/lanshock/ |
 | Released Under the GNU General Public License (v2) (see license.txt)    |
-->
<module name="Content Module" version="2.0.0.0" date="2008-05-12" author="LANshock" url="http://www.lanshock.com">
	
	<general requiresLogin="false"/>
	
	<license>
		<license type="gpl"/>
	</license>
	
	<navigation>
		<item action="content_content_Listing" permissions="content_content"/>
	</navigation>
	
	<security>
		<permissions list="content_content"/>
		<role name="Content Admin" permissions="content_content"/>
	</security>
	
	<database>
		<table name="content_content">
			<field name="id" type="integer" len="11" null="false" special="auto_increment"/>
			<field name="codename" type="varchar" len="255" null="false" special=""/>
			<field name="title" type="varchar" len="255" null="false" default=""/>
			<field name="content" type="text" null="false" default=""/>
			<field name="user_id" type="integer" len="11" default="0"/>
			<field name="dtcreated" type="datetime" null="true" default="NULL"/>
			<field name="dtchanged" type="datetime" null="true" default="NULL"/>
			<field name="bactive" type="boolean" null="false" default="0"/>
			<pk fields="id"/>
			<fk field="user_id" mapping="user.id"/>
			<index name="IDX_codename" fields="codename"/>
			<index name="IDX_bactive" fields="bactive"/>
		</table>
	</database>
	
	<scaffolding>
		<table>
			<list>
				<field name="id"/>
				<field name="title"/>
				<field name="user_id"/>
				<field name="dtchanged"/>
				<field name="bactive"/>
				<field name="codename"/>
			</list>
			<form>
				<field name="id" required="true"/>
				<field name="title" required="true"/>
				<field name="content" formType="FckEditor"/>
				<field alias="user_id" required="true" display="name"/>
				<field alias="dtcreated" formType="Display"/>
				<field alias="dtchanged" formType="Display"/>
				<field alias="bactive" required="true"/>
				<field alias="codename" required="true"/>
			</form>
		</table>
	</scaffolding>
</module>
