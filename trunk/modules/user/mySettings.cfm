<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/user/mySettings.cfm $
$LastChangedDate: 2006-10-22 23:54:35 +0200 (So, 22 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 33 $
--->

<!--- create default config --->
<cfscript>
	stDefaultModuleConfig = StructNew();
	stDefaultModuleConfig.registration_active = true;
	stDefaultModuleConfig.userprofile = StructNew();
	stDefaultModuleConfig.userprofile.edit_personal_data = true;
	stDefaultModuleConfig.userprofile.edit_nickname = true;
</cfscript>

<cfinvoke component="#application.lanshock.environment.componentpath#core.configmanager" method="createConfig" returnvariable="stModuleConfig">
	<cfinvokeargument name="module" value="#myfusebox.thiscircuit#">
	<cfinvokeargument name="data" value="#stDefaultModuleConfig#">
	<cfinvokeargument name="version" value="1">
</cfinvoke>

<cfscript>
/**
 * Generates a password the length you specify.
 * 
 * @param numberOfCharacters 	 Lengh for the generated password. 
 * @return Returns a string. 
 * @author Tony Blackmon (fluid@sc.rr.com) 
 * @version 1, April 25, 2002 
 */
function generatePassword(numberofCharacters) {
  var placeCharacter = "";
  var currentPlace=0;
  var group=0;
  var subGroup=0;

  for(currentPlace=1; currentPlace lte numberofCharacters; currentPlace = currentPlace+1) {
    group = randRange(1,4);
    switch(group) {
      case "1":
        subGroup = rand();
	switch(subGroup) {
          case "0":
            placeCharacter = placeCharacter & chr(randRange(33,46));
            break;
          case "1":
            placeCharacter = placeCharacter & chr(randRange(58,64));
            break;
        }
      case "2":
        placeCharacter = placeCharacter & chr(randRange(97,122));
        break;
      case "3":
        placeCharacter = placeCharacter & chr(randRange(65,90));
        break;
      case "4":
        placeCharacter = placeCharacter & chr(randRange(48,57));
        break;
    }
  }
  return placeCharacter;
}

stCountryList['AD'] = 'Andorra';
stCountryList['AE'] = 'United Arab Emirates';
stCountryList['AF'] = 'Afghanistan';
stCountryList['AG'] = 'Antigua and Barbuda';
stCountryList['AI'] = 'Anguilla';
stCountryList['AL'] = 'Albania';
stCountryList['AM'] = 'Armenia';
stCountryList['AN'] = 'Netherlands Antilles';
stCountryList['AO'] = 'Angola';
stCountryList['AQ'] = 'Antarctica';
stCountryList['AR'] = 'Argentina';
stCountryList['AS'] = 'American Samoa';
stCountryList['AT'] = 'Austria';
stCountryList['AU'] = 'Australia';
stCountryList['AW'] = 'Aruba';
stCountryList['AZ'] = 'Azerbaijan';
stCountryList['BA'] = 'Bosnia and Herzegovina';
stCountryList['BB'] = 'Barbados';
stCountryList['BD'] = 'Bangladesh';
stCountryList['BE'] = 'Belgium';
stCountryList['BF'] = 'Burkina Faso';
stCountryList['BG'] = 'Bulgaria';
stCountryList['BH'] = 'Bahrain';
stCountryList['BI'] = 'Burundi';
stCountryList['BJ'] = 'Benin';
stCountryList['BM'] = 'Bermuda';
stCountryList['BN'] = 'Brunei Darussalam';
stCountryList['BO'] = 'Bolivia';
stCountryList['BR'] = 'Brazil';
stCountryList['BS'] = 'Bahamas';
stCountryList['BT'] = 'Bhutan';
stCountryList['BV'] = 'Bouvet Island';
stCountryList['BW'] = 'Botswana';
stCountryList['BY'] = 'Belarus';
stCountryList['BZ'] = 'Belize';
stCountryList['CA'] = 'Canada';
stCountryList['CC'] = 'Cocos (Keeling) Islands';
stCountryList['CF'] = 'Central African Republic';
stCountryList['CG'] = 'Congo';
stCountryList['CH'] = 'Switzerland';
stCountryList['CI'] = 'Cote D''Ivoire (Ivory Coast)';
stCountryList['CK'] = 'Cook Islands';
stCountryList['CL'] = 'Chile';
stCountryList['CM'] = 'Cameroon';
stCountryList['CN'] = 'China';
stCountryList['CO'] = 'Colombia';
stCountryList['CR'] = 'Costa Rica';
stCountryList['CS'] = 'Czechoslovakia (former)';
stCountryList['CU'] = 'Cuba';
stCountryList['CV'] = 'Cape Verde';
stCountryList['CX'] = 'Christmas Island';
stCountryList['CY'] = 'Cyprus';
stCountryList['CZ'] = 'Czech Republic';
stCountryList['DE'] = 'Germany';
stCountryList['DJ'] = 'Djibouti';
stCountryList['DK'] = 'Denmark';
stCountryList['DM'] = 'Dominica';
stCountryList['DO'] = 'Dominican Republic';
stCountryList['DZ'] = 'Algeria';
stCountryList['EC'] = 'Ecuador';
stCountryList['EE'] = 'Estonia';
stCountryList['EG'] = 'Egypt';
stCountryList['EH'] = 'Western Sahara';
stCountryList['ER'] = 'Eritrea';
stCountryList['ES'] = 'Spain';
stCountryList['ET'] = 'Ethiopia';
stCountryList['FI'] = 'Finland';
stCountryList['FJ'] = 'Fiji';
stCountryList['FK'] = 'Falkland Islands (Malvinas)';
stCountryList['FM'] = 'Micronesia';
stCountryList['FO'] = 'Faroe Islands';
stCountryList['FR'] = 'France';
stCountryList['FX'] = 'France; Metropolitan';
stCountryList['GA'] = 'Gabon';
stCountryList['GB'] = 'Great Britain (UK)';
stCountryList['GD'] = 'Grenada';
stCountryList['GE'] = 'Georgia';
stCountryList['GF'] = 'French Guiana';
stCountryList['GH'] = 'Ghana';
stCountryList['GI'] = 'Gibraltar';
stCountryList['GL'] = 'Greenland';
stCountryList['GM'] = 'Gambia';
stCountryList['GN'] = 'Guinea';
stCountryList['GP'] = 'Guadeloupe';
stCountryList['GQ'] = 'Equatorial Guinea';
stCountryList['GR'] = 'Greece';
stCountryList['GS'] = 'S. Georgia and S. Sandwich Isls.';
stCountryList['GT'] = 'Guatemala';
stCountryList['GU'] = 'Guam';
stCountryList['GW'] = 'Guinea-Bissau';
stCountryList['GY'] = 'Guyana';
stCountryList['HK'] = 'Hong Kong';
stCountryList['HM'] = 'Heard and McDonald Islands';
stCountryList['HN'] = 'Honduras';
stCountryList['HR'] = 'Croatia (Hrvatska)';
stCountryList['HT'] = 'Haiti';
stCountryList['HU'] = 'Hungary';
stCountryList['ID'] = 'Indonesia';
stCountryList['IE'] = 'Ireland';
stCountryList['IL'] = 'Israel';
stCountryList['IN'] = 'India';
stCountryList['IO'] = 'British Indian Ocean Territory';
stCountryList['IQ'] = 'Iraq';
stCountryList['IR'] = 'Iran';
stCountryList['IS'] = 'Iceland';
stCountryList['IT'] = 'Italy';
stCountryList['JM'] = 'Jamaica';
stCountryList['JO'] = 'Jordan';
stCountryList['JP'] = 'Japan';
stCountryList['KE'] = 'Kenya';
stCountryList['KG'] = 'Kyrgyzstan';
stCountryList['KH'] = 'Cambodia';
stCountryList['KI'] = 'Kiribati';
stCountryList['KM'] = 'Comoros';
stCountryList['KN'] = 'Saint Kitts and Nevis';
stCountryList['KP'] = 'Korea (North)';
stCountryList['KR'] = 'Korea (South)';
stCountryList['KW'] = 'Kuwait';
stCountryList['KY'] = 'Cayman Islands';
stCountryList['KZ'] = 'Kazakhstan';
stCountryList['LA'] = 'Laos';
stCountryList['LB'] = 'Lebanon';
stCountryList['LC'] = 'Saint Lucia';
stCountryList['LI'] = 'Liechtenstein';
stCountryList['LK'] = 'Sri Lanka';
stCountryList['LR'] = 'Liberia';
stCountryList['LS'] = 'Lesotho';
stCountryList['LT'] = 'Lithuania';
stCountryList['LU'] = 'Luxembourg';
stCountryList['LV'] = 'Latvia';
stCountryList['LY'] = 'Libya';
stCountryList['MA'] = 'Morocco';
stCountryList['MC'] = 'Monaco';
stCountryList['MD'] = 'Moldova';
stCountryList['MG'] = 'Madagascar';
stCountryList['MH'] = 'Marshall Islands';
stCountryList['MK'] = 'Macedonia';
stCountryList['ML'] = 'Mali';
stCountryList['MM'] = 'Myanmar';
stCountryList['MN'] = 'Mongolia';
stCountryList['MO'] = 'Macau';
stCountryList['MP'] = 'Northern Mariana Islands';
stCountryList['MQ'] = 'Martinique';
stCountryList['MR'] = 'Mauritania';
stCountryList['MS'] = 'Montserrat';
stCountryList['MT'] = 'Malta';
stCountryList['MU'] = 'Mauritius';
stCountryList['MV'] = 'Maldives';
stCountryList['MW'] = 'Malawi';
stCountryList['MX'] = 'Mexico';
stCountryList['MY'] = 'Malaysia';
stCountryList['MZ'] = 'Mozambique';
stCountryList['NA'] = 'Namibia';
stCountryList['NC'] = 'New Caledonia';
stCountryList['NE'] = 'Niger';
stCountryList['NF'] = 'Norfolk Island';
stCountryList['NG'] = 'Nigeria';
stCountryList['NI'] = 'Nicaragua';
stCountryList['NL'] = 'Netherlands';
stCountryList['NO'] = 'Norway';
stCountryList['NP'] = 'Nepal';
stCountryList['NR'] = 'Nauru';
stCountryList['NT'] = 'Neutral Zone';
stCountryList['NU'] = 'Niue';
stCountryList['NZ'] = 'New Zealand (Aotearoa)';
stCountryList['OM'] = 'Oman';
stCountryList['PA'] = 'Panama';
stCountryList['PE'] = 'Peru';
stCountryList['PF'] = 'French Polynesia';
stCountryList['PG'] = 'Papua New Guinea';
stCountryList['PH'] = 'Philippines';
stCountryList['PK'] = 'Pakistan';
stCountryList['PL'] = 'Poland';
stCountryList['PM'] = 'St. Pierre and Miquelon';
stCountryList['PN'] = 'Pitcairn';
stCountryList['PR'] = 'Puerto Rico';
stCountryList['PT'] = 'Portugal';
stCountryList['PW'] = 'Palau';
stCountryList['PY'] = 'Paraguay';
stCountryList['QA'] = 'Qatar';
stCountryList['RE'] = 'Reunion';
stCountryList['RO'] = 'Romania';
stCountryList['RU'] = 'Russian Federation';
stCountryList['RW'] = 'Rwanda';
stCountryList['SA'] = 'Saudi Arabia';
stCountryList['Sb'] = 'Solomon Islands';
stCountryList['SC'] = 'Seychelles';
stCountryList['SD'] = 'Sudan';
stCountryList['SE'] = 'Sweden';
stCountryList['SG'] = 'Singapore';
stCountryList['SH'] = 'St. Helena';
stCountryList['SI'] = 'Slovenia';
stCountryList['SJ'] = 'Svalbard and Jan Mayen Islands';
stCountryList['SK'] = 'Slovak Republic';
stCountryList['SL'] = 'Sierra Leone';
stCountryList['SM'] = 'San Marino';
stCountryList['SN'] = 'Senegal';
stCountryList['SO'] = 'Somalia';
stCountryList['SR'] = 'Suriname';
stCountryList['ST'] = 'Sao Tome and Principe';
stCountryList['SU'] = 'USSR (former)';
stCountryList['SV'] = 'El Salvador';
stCountryList['SY'] = 'Syria';
stCountryList['SZ'] = 'Swaziland';
stCountryList['TC'] = 'Turks and Caicos Islands';
stCountryList['TD'] = 'Chad';
stCountryList['TF'] = 'French Southern Territories';
stCountryList['TG'] = 'Togo';
stCountryList['TH'] = 'Thailand';
stCountryList['TJ'] = 'Tajikistan';
stCountryList['TK'] = 'Tokelau';
stCountryList['TM'] = 'Turkmenistan';
stCountryList['TN'] = 'Tunisia';
stCountryList['TO'] = 'Tonga';
stCountryList['TP'] = 'East Timor';
stCountryList['TR'] = 'Turkey';
stCountryList['TT'] = 'Trinidad and Tobago';
stCountryList['TV'] = 'Tuvalu';
stCountryList['TW'] = 'Taiwan';
stCountryList['TZ'] = 'Tanzania';
stCountryList['UA'] = 'Ukraine';
stCountryList['UG'] = 'Uganda';
stCountryList['UK'] = 'United Kingdom';
stCountryList['UM'] = 'US Minor Outlying Islands';
stCountryList['US'] = 'United States';
stCountryList['UY'] = 'Uruguay';
stCountryList['UZ'] = 'Uzbekistan';
stCountryList['VA'] = 'Vatican City State (Holy See)';
stCountryList['VC'] = 'Saint Vincent and the Grenadines';
stCountryList['VE'] = 'Venezuela';
stCountryList['VG'] = 'Virgin Islands (British)';
stCountryList['VI'] = 'Virgin Islands (U.S.)';
stCountryList['VN'] = 'Viet Nam';
stCountryList['VU'] = 'Vanuatu';
stCountryList['WF'] = 'Wallis and Futuna Islands';
stCountryList['WS'] = 'Samoa';
stCountryList['YE'] = 'Yemen';
stCountryList['YT'] = 'Mayotte';
stCountryList['YU'] = 'Yugoslavia';
stCountryList['ZA'] = 'South Africa';
stCountryList['ZM'] = 'Zambia';
stCountryList['ZR'] = 'Zaire';
stCountryList['ZW'] = 'Zimbabwe';
</cfscript>

<cfsetting enablecfoutputonly="No">