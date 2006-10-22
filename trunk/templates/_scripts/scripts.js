// +-------------------------------------------------------------------------+
// | Copyright (C) 2002 - 2005 LANshock.com                                  |
// |                                                                         |
// | lastmodified: 05-02-28                                                  |
// |           by: bkonetzny                                                 |
// |                               http://sourceforge.net/projects/lanshock/ |
// | Released Under the GNU General Public License (v2) (see license.txt)    |
// +-------------------------------------------------------------------------+

function clipboardSet(text){
	window.clipboardData.setData('Text',text);
}

function clipboardGet(){
	return window.clipboardData.getData('Text');
}