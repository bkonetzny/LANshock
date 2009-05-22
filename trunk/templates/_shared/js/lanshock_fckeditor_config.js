/*
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
*/

FCKConfig.EnterMode = 'br';
FCKConfig.LinkBrowser = false;
FCKConfig.LinkUpload = false;
FCKConfig.LinkDlgHideAdvanced = true;
FCKConfig.ImageBrowser = false;
FCKConfig.ImageUpload = false;
FCKConfig.ImageDlgHideAdvanced = true;
FCKConfig.ImageDlgHideLink = true;
FCKConfig.FlashBrowser = false;
FCKConfig.FlashUpload = false;
FCKConfig.FlashDlgHideAdvanced = true;
FCKConfig.ForcePasteAsPlainText	= true;

FCKConfig.Plugins.Add('flvPlayer','en');

FCKConfig.ToolbarSets["Default"] = [
	['Source'],
	['Bold','Italic','Underline','-','OrderedList','UnorderedList','Blockquote','-','Link','Unlink','Image','Flash','flvPlayer','-','About']
];

FCKConfig.ToolbarSets["Minimum"] = [
	['Bold','Italic','Underline','-','OrderedList','UnorderedList','Blockquote','-','Link','Unlink','-','About']
];