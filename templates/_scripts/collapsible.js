addEvent(window, "load", initCollapsibleDivs);

if (!sCollapsibleCollapseString) var sCollapsibleCollapseString = 'Collapse';
if (!sCollapsibleExpandString) var sCollapsibleExpandString = 'Expand';

function initCollapsibleDivs(){

	// check if DOM is available, return if not
	if(!document.getElementsByTagName || !document.createTextNode){ return; }
	
	// get an array of all div elements
	var divs=document.getElementsByTagName('div');
	
	// loop over array elements looking for a class name of 'collapsible'
	for (var i=0; i<divs.length; i++)
	{
		if (divs[i] && divs[i].className && 
			(divs[i].className.toLowerCase().indexOf('collapsible')!=-1 
				|| divs[i].className.toLowerCase().indexOf('expandable')!=-1 ))
		{
			// if it's collapsible, then it's initial state is expanded. if it's expandable
			// then its initial state is collapsed
			var childclass = (divs[i].className.indexOf('collapsible')!=-1 ? 'expanded' : 'collapsed');
			
			// get all child divs of this div
			var childdivs = divs[i].getElementsByTagName('div');
			
			for (var j=0; j<childdivs.length; j++)
			{
				// add the child's class
				//childdivs[j].className = childdivs[j].className.replace(/(collapsible)|(expandable)/, childclass);
				childdivs[j].className = (childdivs[j].className==''?childclass:' '+childclass);

				// set the child's id
				childdivs[j].id = 'a'+ i +'_'+ j;
				
				// insert the expand/collapse node before this child div
				//var p=document.createElement('p');
				// p.appendChild(document.createTextNode('Expand/Collapse'));
				if (childclass == 'expanded'){
					var span=document.createElement('span');
					span.id = 'a'+ i +'_'+ j +'span';
					span.appendChild(document.createTextNode(sCollapsibleCollapseString));
					span.className = 'collapsetrigger collapsible_collapse';
				}
				else {
					var span=document.createElement('span');
					span.id = 'a'+ i +'_'+ j +'span';
					span.appendChild(document.createTextNode(sCollapsibleExpandString));
					span.className = 'collapsetrigger collapsible_expand';
				}
				eval("span.onclick = function(){toggleExpanded('a"+ i +"_"+ j +"');}");
				divs[i].insertBefore(span, childdivs[j]);
			}// end for
			
		} // end if
	} // end for
	
} // end initCollapsibleDivs

function toggleExpanded(id)
{
	if (!document.getElementById || !document.getElementsByTagName) return;
	
	// index of parent div
	var pdividx = id.substring(1, id.indexOf('_'))-0;
	
	// index of child div within parent div
	var cdividx = id.substring(id.indexOf('_')+1)-0;
	
	var oelement = document.getElementsByTagName('div')[pdividx].getElementsByTagName('div')[cdividx];
	
	// index of child span within parent div
	var sdividx = id.substring(id.indexOf('_')+1)-0;
	
	var oelementspan = document.getElementsByTagName('div')[pdividx].getElementsByTagName('span')[sdividx];
	
	if (oelement && oelement != null)
	{
		// toggle expanded/collapsed
		if (oelement.className && oelement.className != null){
			oelement.className = (oelement.className.toLowerCase()=='collapsed'?'expanded':'collapsed');
			oelementspan.className = (oelement.className.toLowerCase()=='collapsed'?'collapsetrigger collapsible_expand':'collapsetrigger collapsible_collapse');
			var text = (oelement.className.toLowerCase()=='collapsed'?sCollapsibleExpandString:sCollapsibleCollapseString);
			setTextNode(oelementspan,text);
		}
		else{
			oelement.className = 'collapsed';
			oelementspan.className = 'collapsetrigger collapsible_collapse';
			setTextNode(oelementspan,sCollapsibleCollapseString);
		}
		// end if
	} // end if
}

function setTextNode(oParent, sText)
{
	while (oParent.hasChildNodes())
	oParent.removeChild(oParent.lastChild);
	var textnode = document.createTextNode(sText);
	oParent.appendChild(textnode);
}