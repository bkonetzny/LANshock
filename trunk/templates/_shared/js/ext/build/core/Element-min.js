/*
 * Ext JS Library 2.1
 * Copyright(c) 2006-2008, Ext JS, LLC.
 * licensing@extjs.com
 * 
 * http://extjs.com/license
 */

(function(){var D=Ext.lib.Dom;var E=Ext.lib.Event;var A=Ext.lib.Anim;var propCache={};var camelRe=/(-[a-z])/gi;var camelFn=function(m,a){return a.charAt(1).toUpperCase()};var view=document.defaultView;Ext.Element=function(element,forceNew){var dom=typeof element=="string"?document.getElementById(element):element;if(!dom){return null}var id=dom.id;if(forceNew!==true&&id&&Ext.Element.cache[id]){return Ext.Element.cache[id]}this.dom=dom;this.id=id||Ext.id(dom)};var El=Ext.Element;El.prototype={originalDisplay:"",visibilityMode:1,defaultUnit:"px",setVisibilityMode:function(visMode){this.visibilityMode=visMode;return this},enableDisplayMode:function(display){this.setVisibilityMode(El.DISPLAY);if(typeof display!="undefined"){this.originalDisplay=display}return this},findParent:function(simpleSelector,maxDepth,returnEl){var p=this.dom,b=document.body,depth=0,dq=Ext.DomQuery,stopEl;maxDepth=maxDepth||50;if(typeof maxDepth!="number"){stopEl=Ext.getDom(maxDepth);maxDepth=10}while(p&&p.nodeType==1&&depth<maxDepth&&p!=b&&p!=stopEl){if(dq.is(p,simpleSelector)){return returnEl?Ext.get(p):p}depth++;p=p.parentNode}return null},findParentNode:function(simpleSelector,maxDepth,returnEl){var p=Ext.fly(this.dom.parentNode,"_internal");return p?p.findParent(simpleSelector,maxDepth,returnEl):null},up:function(simpleSelector,maxDepth){return this.findParentNode(simpleSelector,maxDepth,true)},is:function(simpleSelector){return Ext.DomQuery.is(this.dom,simpleSelector)},animate:function(args,duration,onComplete,easing,animType){this.anim(args,{duration:duration,callback:onComplete,easing:easing},animType);return this},anim:function(args,opt,animType,defaultDur,defaultEase,cb){animType=animType||"run";opt=opt||{};var anim=Ext.lib.Anim[animType](this.dom,args,(opt.duration||defaultDur)||0.35,(opt.easing||defaultEase)||"easeOut",function(){Ext.callback(cb,this);Ext.callback(opt.callback,opt.scope||this,[this,opt])},this);opt.anim=anim;return anim},preanim:function(a,i){return !a[i]?false:(typeof a[i]=="object"?a[i]:{duration:a[i+1],callback:a[i+2],easing:a[i+3]})},clean:function(forceReclean){if(this.isCleaned&&forceReclean!==true){return this}var ns=/\S/;var d=this.dom,n=d.firstChild,ni=-1;while(n){var nx=n.nextSibling;if(n.nodeType==3&&!ns.test(n.nodeValue)){d.removeChild(n)}else{n.nodeIndex=++ni}n=nx}this.isCleaned=true;return this},scrollIntoView:function(container,hscroll){var c=Ext.getDom(container)||Ext.getBody().dom;var el=this.dom;var o=this.getOffsetsTo(c),l=o[0]+c.scrollLeft,t=o[1]+c.scrollTop,b=t+el.offsetHeight,r=l+el.offsetWidth;var ch=c.clientHeight;var ct=parseInt(c.scrollTop,10);var cl=parseInt(c.scrollLeft,10);var cb=ct+ch;var cr=cl+c.clientWidth;if(el.offsetHeight>ch||t<ct){c.scrollTop=t}else{if(b>cb){c.scrollTop=b-ch}}c.scrollTop=c.scrollTop;if(hscroll!==false){if(el.offsetWidth>c.clientWidth||l<cl){c.scrollLeft=l}else{if(r>cr){c.scrollLeft=r-c.clientWidth}}c.scrollLeft=c.scrollLeft}return this},scrollChildIntoView:function(child,hscroll){Ext.fly(child,"_scrollChildIntoView").scrollIntoView(this,hscroll)},autoHeight:function(animate,duration,onComplete,easing){var oldHeight=this.getHeight();this.clip();this.setHeight(1);setTimeout(function(){var height=parseInt(this.dom.scrollHeight,10);if(!animate){this.setHeight(height);this.unclip();if(typeof onComplete=="function"){onComplete()}}else{this.setHeight(oldHeight);this.setHeight(height,animate,duration,function(){this.unclip();if(typeof onComplete=="function"){onComplete()}}.createDelegate(this),easing)}}.createDelegate(this),0);return this},contains:function(el){if(!el){return false}return D.isAncestor(this.dom,el.dom?el.dom:el)},isVisible:function(deep){var vis=!(this.getStyle("visibility")=="hidden"||this.getStyle("display")=="none");if(deep!==true||!vis){return vis}var p=this.dom.parentNode;while(p&&p.tagName.toLowerCase()!="body"){if(!Ext.fly(p,"_isVisible").isVisible()){return false}p=p.parentNode}return true},select:function(selector,unique){return El.select(selector,unique,this.dom)},query:function(selector,unique){return Ext.DomQuery.select(selector,this.dom)},child:function(selector,returnDom){var n=Ext.DomQuery.selectNode(selector,this.dom);return returnDom?n:Ext.get(n)},down:function(selector,returnDom){var n=Ext.DomQuery.selectNode(" > "+selector,this.dom);return returnDom?n:Ext.get(n)},initDD:function(group,config,overrides){var dd=new Ext.dd.DD(Ext.id(this.dom),group,config);return Ext.apply(dd,overrides)},initDDProxy:function(group,config,overrides){var dd=new Ext.dd.DDProxy(Ext.id(this.dom),group,config);return Ext.apply(dd,overrides)},initDDTarget:function(group,config,overrides){var dd=new Ext.dd.DDTarget(Ext.id(this.dom),group,config);return Ext.apply(dd,overrides)},setVisible:function(visible,animate){if(!animate||!A){if(this.visibilityMode==El.DISPLAY){this.setDisplayed(visible)}else{this.fixDisplay();this.dom.style.visibility=visible?"visible":"hidden"}}else{var dom=this.dom;var visMode=this.visibilityMode;if(visible){this.setOpacity(0.01);this.setVisible(true)}this.anim({opacity:{to:(visible?1:0)}},this.preanim(arguments,1),null,0.35,"easeIn",function(){if(!visible){if(visMode==El.DISPLAY){dom.style.display="none"}else{dom.style.visibility="hidden"}Ext.get(dom).setOpacity(1)}})}return this},isDisplayed:function(){return this.getStyle("display")!="none"},toggle:function(animate){this.setVisible(!this.isVisible(),this.preanim(arguments,0));return this},setDisplayed:function(value){if(typeof value=="boolean"){value=value?this.originalDisplay:"none"}this.setStyle("display",value);return this},focus:function(){try{this.dom.focus()}catch(e){}return this},blur:function(){try{this.dom.blur()}catch(e){}return this},addClass:function(className){if(Ext.isArray(className)){for(var i=0,len=className.length;i<len;i++){this.addClass(className[i])}}else{if(className&&!this.hasClass(className)){this.dom.className=this.dom.className+" "+className}}return this},radioClass:function(className){var siblings=this.dom.parentNode.childNodes;for(var i=0;i<siblings.length;i++){var s=siblings[i];if(s.nodeType==1){Ext.get(s).removeClass(className)}}this.addClass(className);return this},removeClass:function(className){if(!className||!this.dom.className){return this}if(Ext.isArray(className)){for(var i=0,len=className.length;i<len;i++){this.removeClass(className[i])}}else{if(this.hasClass(className)){var re=this.classReCache[className];if(!re){re=new RegExp("(?:^|\\s+)"+className+"(?:\\s+|$)","g");this.classReCache[className]=re}this.dom.className=this.dom.className.replace(re," ")}}return this},classReCache:{},toggleClass:function(className){if(this.hasClass(className)){this.removeClass(className)}else{this.addClass(className)}return this},hasClass:function(className){return className&&(" "+this.dom.className+" ").indexOf(" "+className+" ")!=-1},replaceClass:function(oldClassName,newClassName){this.removeClass(oldClassName);this.addClass(newClassName);return this},getStyles:function(){var a=arguments,len=a.length,r={};for(var i=0;i<len;i++){r[a[i]]=this.getStyle(a[i])}return r},getStyle:function(){return view&&view.getComputedStyle?function(prop){var el=this.dom,v,cs,camel;if(prop=="float"){prop="cssFloat"}if(v=el.style[prop]){return v}if(cs=view.getComputedStyle(el,"")){if(!(camel=propCache[prop])){camel=propCache[prop]=prop.replace(camelRe,camelFn)}return cs[camel]}return null}:function(prop){var el=this.dom,v,cs,camel;if(prop=="opacity"){if(typeof el.style.filter=="string"){var m=el.style.filter.match(/alpha\(opacity=(.*)\)/i);if(m){var fv=parseFloat(m[1]);if(!isNaN(fv)){return fv?fv/100:0}}}return 1}else{if(prop=="float"){prop="styleFloat"}}if(!(camel=propCache[prop])){camel=propCache[prop]=prop.replace(camelRe,camelFn)}if(v=el.style[camel]){return v}if(cs=el.currentStyle){return cs[camel]}return null}}(),setStyle:function(prop,value){if(typeof prop=="string"){var camel;if(!(camel=propCache[prop])){camel=propCache[prop]=prop.replace(camelRe,camelFn)}if(camel=="opacity"){this.setOpacity(value)}else{this.dom.style[camel]=value}}else{for(var style in prop){if(typeof prop[style]!="function"){this.setStyle(style,prop[style])}}}return this},applyStyles:function(style){Ext.DomHelper.applyStyles(this.dom,style);return this},getX:function(){return D.getX(this.dom)},getY:function(){return D.getY(this.dom)},getXY:function(){return D.getXY(this.dom)},getOffsetsTo:function(el){var o=this.getXY();var e=Ext.fly(el,"_internal").getXY();return[o[0]-e[0],o[1]-e[1]]},setX:function(x,animate){if(!animate||!A){D.setX(this.dom,x)}else{this.setXY([x,this.getY()],this.preanim(arguments,1))}return this},setY:function(y,animate){if(!animate||!A){D.setY(this.dom,y)}else{this.setXY([this.getX(),y],this.preanim(arguments,1))}return this},setLeft:function(left){this.setStyle("left",this.addUnits(left));return this},setTop:function(top){this.setStyle("top",this.addUnits(top));return this},setRight:function(right){this.setStyle("right",this.addUnits(right));return this},setBottom:function(bottom){this.setStyle("bottom",this.addUnits(bottom));return this},setXY:function(pos,animate){if(!animate||!A){D.setXY(this.dom,pos)}else{this.anim({points:{to:pos}},this.preanim(arguments,1),"motion")}return this},setLocation:function(x,y,animate){this.setXY([x,y],this.preanim(arguments,2));return this},moveTo:function(x,y,animate){this.setXY([x,y],this.preanim(arguments,2));return this},getRegion:function(){return D.getRegion(this.dom)},getHeight:function(contentHeight){var h=this.dom.offsetHeight||0;h=contentHeight!==true?h:h-this.getBorderWidth("tb")-this.getPadding("tb");return h<0?0:h},getWidth:function(contentWidth){var w=this.dom.offsetWidth||0;w=contentWidth!==true?w:w-this.getBorderWidth("lr")-this.getPadding("lr");return w<0?0:w},getComputedHeight:function(){var h=Math.max(this.dom.offsetHeight,this.dom.clientHeight);if(!h){h=parseInt(this.getStyle("height"),10)||0;if(!this.isBorderBox()){h+=this.getFrameWidth("tb")}}return h},getComputedWidth:function(){var w=Math.max(this.dom.offsetWidth,this.dom.clientWidth);if(!w){w=parseInt(this.getStyle("width"),10)||0;if(!this.isBorderBox()){w+=this.getFrameWidth("lr")}}return w},getSize:function(contentSize){return{width:this.getWidth(contentSize),height:this.getHeight(contentSize)}},getStyleSize:function(){var w,h,d=this.dom,s=d.style;if(s.width&&s.width!="auto"){w=parseInt(s.width,10);if(Ext.isBorderBox){w-=this.getFrameWidth("lr")}}if(s.height&&s.height!="auto"){h=parseInt(s.height,10);if(Ext.isBorderBox){h-=this.getFrameWidth("tb")}}return{width:w||this.getWidth(true),height:h||this.getHeight(true)}},getViewSize:function(){var d=this.dom,doc=document,aw=0,ah=0;if(d==doc||d==doc.body){return{width:D.getViewWidth(),height:D.getViewHeight()}}else{return{width:d.clientWidth,height:d.clientHeight}}},getValue:function(asNumber){return asNumber?parseInt(this.dom.value,10):this.dom.value},adjustWidth:function(width){if(typeof width=="number"){if(this.autoBoxAdjust&&!this.isBorderBox()){width-=(this.getBorderWidth("lr")+this.getPadding("lr"))}if(width<0){width=0}}return width},adjustHeight:function(height){if(typeof height=="number"){if(this.autoBoxAdjust&&!this.isBorderBox()){height-=(this.getBorderWidth("tb")+this.getPadding("tb"))}if(height<0){height=0}}return height},setWidth:function(width,animate){width=this.adjustWidth(width);if(!animate||!A){this.dom.style.width=this.addUnits(width)}else{this.anim({width:{to:width}},this.preanim(arguments,1))}return this},setHeight:function(height,animate){height=this.adjustHeight(height);if(!animate||!A){this.dom.style.height=this.addUnits(height)}else{this.anim({height:{to:height}},this.preanim(arguments,1))}return this},setSize:function(width,height,animate){if(typeof width=="object"){height=width.height;width=width.width}width=this.adjustWidth(width);height=this.adjustHeight(height);if(!animate||!A){this.dom.style.width=this.addUnits(width);this.dom.style.height=this.addUnits(height)}else{this.anim({width:{to:width},height:{to:height}},this.preanim(arguments,2))}return this},setBounds:function(x,y,width,height,animate){if(!animate||!A){this.setSize(width,height);this.setLocation(x,y)}else{width=this.adjustWidth(width);height=this.adjustHeight(height);this.anim({points:{to:[x,y]},width:{to:width},height:{to:height}},this.preanim(arguments,4),"motion")}return this},setRegion:function(region,animate){this.setBounds(region.left,region.top,region.right-region.left,region.bottom-region.top,this.preanim(arguments,1));return this},addListener:function(eventName,fn,scope,options){Ext.EventManager.on(this.dom,eventName,fn,scope||this,options)},removeListener:function(eventName,fn){Ext.EventManager.removeListener(this.dom,eventName,fn);return this},removeAllListeners:function(){E.purgeElement(this.dom);return this},relayEvent:function(eventName,observable){this.on(eventName,function(e){observable.fireEvent(eventName,e)})},setOpacity:function(opacity,animate){if(!animate||!A){var s=this.dom.style;if(Ext.isIE){s.zoom=1;s.filter=(s.filter||"").replace(/alpha\([^\)]*\)/gi,"")+(opacity==1?"":" alpha(opacity="+opacity*100+")")}else{s.opacity=opacity}}else{this.anim({opacity:{to:opacity}},this.preanim(arguments,1),null,0.35,"easeIn")}return this},getLeft:function(local){if(!local){return this.getX()}else{return parseInt(this.getStyle("left"),10)||0}},getRight:function(local){if(!local){return this.getX()+this.getWidth()}else{return(this.getLeft(true)+this.getWidth())||0}},getTop:function(local){if(!local){return this.getY()}else{return parseInt(this.getStyle("top"),10)||0}},getBottom:function(local){if(!local){return this.getY()+this.getHeight()}else{return(this.getTop(true)+this.getHeight())||0}},position:function(pos,zIndex,x,y){if(!pos){if(this.getStyle("position")=="static"){this.setStyle("position","relative")}}else{this.setStyle("position",pos)}if(zIndex){this.setStyle("z-index",zIndex)}if(x!==undefined&&y!==undefined){this.setXY([x,y])}else{if(x!==undefined){this.setX(x)}else{if(y!==undefined){this.setY(y)}}}},clearPositioning:function(value){value=value||"";this.setStyle({"left":value,"right":value,"top":value,"bottom":value,"z-index":"","position":"static"});return this},getPositioning:function(){var l=this.getStyle("left");var t=this.getStyle("top");return{"position":this.getStyle("position"),"left":l,"right":l?"":this.getStyle("right"),"top":t,"bottom":t?"":this.getStyle("bottom"),"z-index":this.getStyle("z-index")}},getBorderWidth:function(side){return this.addStyles(side,El.borders)},getPadding:function(side){return this.addStyles(side,El.paddings)},setPositioning:function(pc){this.applyStyles(pc);if(pc.right=="auto"){this.dom.style.right=""}if(pc.bottom=="auto"){this.dom.style.bottom=""}return this},fixDisplay:function(){if(this.getStyle("display")=="none"){this.setStyle("visibility","hidden");this.setStyle("display",this.originalDisplay);if(this.getStyle("display")=="none"){this.setStyle("display","block")}}},setOverflow:function(v){if(v=="auto"&&Ext.isMac&&Ext.isGecko){this.dom.style.overflow="hidden";(function(){this.dom.style.overflow="auto"}).defer(1,this)}else{this.dom.style.overflow=v}},setLeftTop:function(left,top){this.dom.style.left=this.addUnits(left);this.dom.style.top=this.addUnits(top);return this},move:function(direction,distance,animate){var xy=this.getXY();direction=direction.toLowerCase();switch(direction){case"l":case"left":this.moveTo(xy[0]-distance,xy[1],this.preanim(arguments,2));break;case"r":case"right":this.moveTo(xy[0]+distance,xy[1],this.preanim(arguments,2));break;case"t":case"top":case"up":this.moveTo(xy[0],xy[1]-distance,this.preanim(arguments,2));break;case"b":case"bottom":case"down":this.moveTo(xy[0],xy[1]+distance,this.preanim(arguments,2));break}return this},clip:function(){if(!this.isClipped){this.isClipped=true;this.originalClip={"o":this.getStyle("overflow"),"x":this.getStyle("overflow-x"),"y":this.getStyle("overflow-y")};this.setStyle("overflow","hidden");this.setStyle("overflow-x","hidden");this.setStyle("overflow-y","hidden")}return this},unclip:function(){if(this.isClipped){this.isClipped=false;var o=this.originalClip;if(o.o){this.setStyle("overflow",o.o)}if(o.x){this.setStyle("overflow-x",o.x)}if(o.y){this.setStyle("overflow-y",o.y)}}return this},getAnchorXY:function(anchor,local,s){var w,h,vp=false;if(!s){var d=this.dom;if(d==document.body||d==document){vp=true;w=D.getViewWidth();h=D.getViewHeight()}else{w=this.getWidth();h=this.getHeight()}}else{w=s.width;h=s.height}var x=0,y=0,r=Math.round;switch((anchor||"tl").toLowerCase()){case"c":x=r(w*0.5);y=r(h*0.5);break;case"t":x=r(w*0.5);y=0;break;case"l":x=0;y=r(h*0.5);break;case"r":x=w;y=r(h*0.5);break;case"b":x=r(w*0.5);y=h;break;case"tl":x=0;y=0;break;case"bl":x=0;y=h;break;case"br":x=w;y=h;break;case"tr":x=w;y=0;break}if(local===true){return[x,y]}if(vp){var sc=this.getScroll();return[x+sc.left,y+sc.top]}var o=this.getXY();return[x+o[0],y+o[1]]},getAlignToXY:function(el,p,o){el=Ext.get(el);if(!el||!el.dom){throw"Element.alignToXY with an element that doesn't exist"}var d=this.dom;var c=false;var p1="",p2="";o=o||[0,0];if(!p){p="tl-bl"}else{if(p=="?"){p="tl-bl?"}else{if(p.indexOf("-")==-1){p="tl-"+p}}}p=p.toLowerCase();var m=p.match(/^([a-z]+)-([a-z]+)(\?)?$/);if(!m){throw"Element.alignTo with an invalid alignment "+p}p1=m[1];p2=m[2];c=!!m[3];var a1=this.getAnchorXY(p1,true);var a2=el.getAnchorXY(p2,false);var x=a2[0]-a1[0]+o[0];var y=a2[1]-a1[1]+o[1];if(c){var w=this.getWidth(),h=this.getHeight(),r=el.getRegion();var dw=D.getViewWidth()-5,dh=D.getViewHeight()-5;var p1y=p1.charAt(0),p1x=p1.charAt(p1.length-1);var p2y=p2.charAt(0),p2x=p2.charAt(p2.length-1);var swapY=((p1y=="t"&&p2y=="b")||(p1y=="b"&&p2y=="t"));var swapX=((p1x=="r"&&p2x=="l")||(p1x=="l"&&p2x=="r"));var doc=document;var scrollX=(doc.documentElement.scrollLeft||doc.body.scrollLeft||0)+5;var scrollY=(doc.documentElement.scrollTop||doc.body.scrollTop||0)+5;if((x+w)>dw+scrollX){x=swapX?r.left-w:dw+scrollX-w}if(x<scrollX){x=swapX?r.right:scrollX}if((y+h)>dh+scrollY){y=swapY?r.top-h:dh+scrollY-h}if(y<scrollY){y=swapY?r.bottom:scrollY}}return[x,y]},getConstrainToXY:function(){var os={top:0,left:0,bottom:0,right:0};return function(el,local,offsets,proposedXY){el=Ext.get(el);offsets=offsets?Ext.applyIf(offsets,os):os;var vw,vh,vx=0,vy=0;if(el.dom==document.body||el.dom==document){vw=Ext.lib.Dom.getViewWidth();vh=Ext.lib.Dom.getViewHeight()}else{vw=el.dom.clientWidth;vh=el.dom.clientHeight;if(!local){var vxy=el.getXY();vx=vxy[0];vy=vxy[1]}}var s=el.getScroll();vx+=offsets.left+s.left;vy+=offsets.top+s.top;vw-=offsets.right;vh-=offsets.bottom;var vr=vx+vw;var vb=vy+vh;var xy=proposedXY||(!local?this.getXY():[this.getLeft(true),this.getTop(true)]);var x=xy[0],y=xy[1];var w=this.dom.offsetWidth,h=this.dom.offsetHeight;var moved=false;if((x+w)>vr){x=vr-w;moved=true}if((y+h)>vb){y=vb-h;moved=true}if(x<vx){x=vx;moved=true}if(y<vy){y=vy;moved=true}return moved?[x,y]:false}}(),adjustForConstraints:function(xy,parent,offsets){return this.getConstrainToXY(parent||document,false,offsets,xy)||xy},alignTo:function(element,position,offsets,animate){var xy=this.getAlignToXY(element,position,offsets);this.setXY(xy,this.preanim(arguments,3));return this},anchorTo:function(el,alignment,offsets,animate,monitorScroll,callback){var action=function(){this.alignTo(el,alignment,offsets,animate);Ext.callback(callback,this)};Ext.EventManager.onWindowResize(action,this);var tm=typeof monitorScroll;if(tm!="undefined"){Ext.EventManager.on(window,"scroll",action,this,{buffer:tm=="number"?monitorScroll:50})}action.call(this);return this},clearOpacity:function(){if(window.ActiveXObject){if(typeof this.dom.style.filter=="string"&&(/alpha/i).test(this.dom.style.filter)){this.dom.style.filter=""}}else{this.dom.style.opacity="";this.dom.style["-moz-opacity"]="";this.dom.style["-khtml-opacity"]=""}return this},hide:function(animate){this.setVisible(false,this.preanim(arguments,0));return this},show:function(animate){this.setVisible(true,this.preanim(arguments,0));return this},addUnits:function(size){return Ext.Element.addUnits(size,this.defaultUnit)},update:function(html,loadScripts,callback){if(typeof html=="undefined"){html=""}if(loadScripts!==true){this.dom.innerHTML=html;if(typeof callback=="function"){callback()}return this}var id=Ext.id();var dom=this.dom;html+="<span id=\""+id+"\"></span>";E.onAvailable(id,function(){var hd=document.getElementsByTagName("head")[0];var re=/(?:<script([^>]*)?>)((\n|\r|.)*?)(?:<\/script>)/ig;var srcRe=/\ssrc=([\'\"])(.*?)\1/i;var typeRe=/\stype=([\'\"])(.*?)\1/i;var match;while(match=re.exec(html)){var attrs=match[1];var srcMatch=attrs?attrs.match(srcRe):false;if(srcMatch&&srcMatch[2]){var s=document.createElement("script");s.src=srcMatch[2];var typeMatch=attrs.match(typeRe);if(typeMatch&&typeMatch[2]){s.type=typeMatch[2]}hd.appendChild(s)}else{if(match[2]&&match[2].length>0){if(window.execScript){window.execScript(match[2])}else{window.eval(match[2])}}}}var el=document.getElementById(id);if(el){Ext.removeNode(el)}if(typeof callback=="function"){callback()}});dom.innerHTML=html.replace(/(?:<script.*?>)((\n|\r|.)*?)(?:<\/script>)/ig,"");return this},load:function(){var um=this.getUpdater();um.update.apply(um,arguments);return this},getUpdater:function(){if(!this.updateManager){this.updateManager=new Ext.Updater(this)}return this.updateManager},unselectable:function(){this.dom.unselectable="on";this.swallowEvent("selectstart",true);this.applyStyles("-moz-user-select:none;-khtml-user-select:none;");this.addClass("x-unselectable");return this},getCenterXY:function(){return this.getAlignToXY(document,"c-c")},center:function(centerIn){this.alignTo(centerIn||document,"c-c");return this},isBorderBox:function(){return noBoxAdjust[this.dom.tagName.toLowerCase()]||Ext.isBorderBox},getBox:function(contentBox,local){var xy;if(!local){xy=this.getXY()}else{var left=parseInt(this.getStyle("left"),10)||0;var top=parseInt(this.getStyle("top"),10)||0;xy=[left,top]}var el=this.dom,w=el.offsetWidth,h=el.offsetHeight,bx;if(!contentBox){bx={x:xy[0],y:xy[1],0:xy[0],1:xy[1],width:w,height:h}}else{var l=this.getBorderWidth("l")+this.getPadding("l");var r=this.getBorderWidth("r")+this.getPadding("r");var t=this.getBorderWidth("t")+this.getPadding("t");var b=this.getBorderWidth("b")+this.getPadding("b");bx={x:xy[0]+l,y:xy[1]+t,0:xy[0]+l,1:xy[1]+t,width:w-(l+r),height:h-(t+b)}}bx.right=bx.x+bx.width;bx.bottom=bx.y+bx.height;return bx},getFrameWidth:function(sides,onlyContentBox){return onlyContentBox&&Ext.isBorderBox?0:(this.getPadding(sides)+this.getBorderWidth(sides))},setBox:function(box,adjust,animate){var w=box.width,h=box.height;if((adjust&&!this.autoBoxAdjust)&&!this.isBorderBox()){w-=(this.getBorderWidth("lr")+this.getPadding("lr"));h-=(this.getBorderWidth("tb")+this.getPadding("tb"))}this.setBounds(box.x,box.y,w,h,this.preanim(arguments,2));return this},repaint:function(){var dom=this.dom;this.addClass("x-repaint");setTimeout(function(){Ext.get(dom).removeClass("x-repaint")},1);return this},getMargins:function(side){if(!side){return{top:parseInt(this.getStyle("margin-top"),10)||0,left:parseInt(this.getStyle("margin-left"),10)||0,bottom:parseInt(this.getStyle("margin-bottom"),10)||0,right:parseInt(this.getStyle("margin-right"),10)||0}}else{return this.addStyles(side,El.margins)}},addStyles:function(sides,styles){var val=0,v,w;for(var i=0,len=sides.length;i<len;i++){v=this.getStyle(styles[sides.charAt(i)]);if(v){w=parseInt(v,10);if(w){val+=(w>=0?w:-1*w)}}}return val},createProxy:function(config,renderTo,matchBox){config=typeof config=="object"?config:{tag:"div",cls:config};var proxy;if(renderTo){proxy=Ext.DomHelper.append(renderTo,config,true)}else{proxy=Ext.DomHelper.insertBefore(this.dom,config,true)}if(matchBox){proxy.setBox(this.getBox())}return proxy},mask:function(msg,msgCls){if(this.getStyle("position")=="static"){this.setStyle("position","relative")}if(this._maskMsg){this._maskMsg.remove()}if(this._mask){this._mask.remove()}this._mask=Ext.DomHelper.append(this.dom,{cls:"ext-el-mask"},true);this.addClass("x-masked");this._mask.setDisplayed(true);if(typeof msg=="string"){this._maskMsg=Ext.DomHelper.append(this.dom,{cls:"ext-el-mask-msg",cn:{tag:"div"}},true);var mm=this._maskMsg;mm.dom.className=msgCls?"ext-el-mask-msg "+msgCls:"ext-el-mask-msg";mm.dom.firstChild.innerHTML=msg;mm.setDisplayed(true);mm.center(this)}if(Ext.isIE&&!(Ext.isIE7&&Ext.isStrict)&&this.getStyle("height")=="auto"){this._mask.setSize(this.dom.clientWidth,this.getHeight())}return this._mask},unmask:function(){if(this._mask){if(this._maskMsg){this._maskMsg.remove();delete this._maskMsg}this._mask.remove();delete this._mask}this.removeClass("x-masked")},isMasked:function(){return this._mask&&this._mask.isVisible()},createShim:function(){var el=document.createElement("iframe");el.frameBorder="no";el.className="ext-shim";if(Ext.isIE&&Ext.isSecure){el.src=Ext.SSL_SECURE_URL}var shim=Ext.get(this.dom.parentNode.insertBefore(el,this.dom));shim.autoBoxAdjust=false;return shim},remove:function(){Ext.removeNode(this.dom);delete El.cache[this.dom.id]},hover:function(overFn,outFn,scope){var preOverFn=function(e){if(!e.within(this,true)){overFn.apply(scope||this,arguments)}};var preOutFn=function(e){if(!e.within(this,true)){outFn.apply(scope||this,arguments)}};this.on("mouseover",preOverFn,this.dom);this.on("mouseout",preOutFn,this.dom);return this},addClassOnOver:function(className){this.hover(function(){Ext.fly(this,"_internal").addClass(className)},function(){Ext.fly(this,"_internal").removeClass(className)});return this},addClassOnFocus:function(className){this.on("focus",function(){Ext.fly(this,"_internal").addClass(className)},this.dom);this.on("blur",function(){Ext.fly(this,"_internal").removeClass(className)},this.dom);return this},addClassOnClick:function(className){var dom=this.dom;this.on("mousedown",function(){Ext.fly(dom,"_internal").addClass(className);var d=Ext.getDoc();var fn=function(){Ext.fly(dom,"_internal").removeClass(className);d.removeListener("mouseup",fn)};d.on("mouseup",fn)});return this},swallowEvent:function(eventName,preventDefault){var fn=function(e){e.stopPropagation();if(preventDefault){e.preventDefault()}};if(Ext.isArray(eventName)){for(var i=0,len=eventName.length;i<len;i++){this.on(eventName[i],fn)}return this}this.on(eventName,fn);return this},parent:function(selector,returnDom){return this.matchNode("parentNode","parentNode",selector,returnDom)},next:function(selector,returnDom){return this.matchNode("nextSibling","nextSibling",selector,returnDom)},prev:function(selector,returnDom){return this.matchNode("previousSibling","previousSibling",selector,returnDom)},first:function(selector,returnDom){return this.matchNode("nextSibling","firstChild",selector,returnDom)},last:function(selector,returnDom){return this.matchNode("previousSibling","lastChild",selector,returnDom)},matchNode:function(dir,start,selector,returnDom){var n=this.dom[start];while(n){if(n.nodeType==1&&(!selector||Ext.DomQuery.is(n,selector))){return !returnDom?Ext.get(n):n}n=n[dir]}return null},appendChild:function(el){el=Ext.get(el);el.appendTo(this);return this},createChild:function(config,insertBefore,returnDom){config=config||{tag:"div"};if(insertBefore){return Ext.DomHelper.insertBefore(insertBefore,config,returnDom!==true)}return Ext.DomHelper[!this.dom.firstChild?"overwrite":"append"](this.dom,config,returnDom!==true)},appendTo:function(el){el=Ext.getDom(el);el.appendChild(this.dom);return this},insertBefore:function(el){el=Ext.getDom(el);el.parentNode.insertBefore(this.dom,el);return this},insertAfter:function(el){el=Ext.getDom(el);el.parentNode.insertBefore(this.dom,el.nextSibling);return this},insertFirst:function(el,returnDom){el=el||{};if(typeof el=="object"&&!el.nodeType&&!el.dom){return this.createChild(el,this.dom.firstChild,returnDom)}else{el=Ext.getDom(el);this.dom.insertBefore(el,this.dom.firstChild);return !returnDom?Ext.get(el):el}},insertSibling:function(el,where,returnDom){var rt;if(Ext.isArray(el)){for(var i=0,len=el.length;i<len;i++){rt=this.insertSibling(el[i],where,returnDom)}return rt}where=where?where.toLowerCase():"before";el=el||{};var refNode=where=="before"?this.dom:this.dom.nextSibling;if(typeof el=="object"&&!el.nodeType&&!el.dom){if(where=="after"&&!this.dom.nextSibling){rt=Ext.DomHelper.append(this.dom.parentNode,el,!returnDom)}else{rt=Ext.DomHelper[where=="after"?"insertAfter":"insertBefore"](this.dom,el,!returnDom)}}else{rt=this.dom.parentNode.insertBefore(Ext.getDom(el),refNode);if(!returnDom){rt=Ext.get(rt)}}return rt},wrap:function(config,returnDom){if(!config){config={tag:"div"}}var newEl=Ext.DomHelper.insertBefore(this.dom,config,!returnDom);newEl.dom?newEl.dom.appendChild(this.dom):newEl.appendChild(this.dom);return newEl},replace:function(el){el=Ext.get(el);this.insertBefore(el);el.remove();return this},replaceWith:function(el){if(typeof el=="object"&&!el.nodeType&&!el.dom){el=this.insertSibling(el,"before")}else{el=Ext.getDom(el);this.dom.parentNode.insertBefore(el,this.dom)}El.uncache(this.id);this.dom.parentNode.removeChild(this.dom);this.dom=el;this.id=Ext.id(el);El.cache[this.id]=this;return this},insertHtml:function(where,html,returnEl){var el=Ext.DomHelper.insertHtml(where,this.dom,html);return returnEl?Ext.get(el):el},set:function(o,useSet){var el=this.dom;useSet=typeof useSet=="undefined"?(el.setAttribute?true:false):useSet;for(var attr in o){if(attr=="style"||typeof o[attr]=="function"){continue}if(attr=="cls"){el.className=o["cls"]}else{if(o.hasOwnProperty(attr)){if(useSet){el.setAttribute(attr,o[attr])}else{el[attr]=o[attr]}}}}if(o.style){Ext.DomHelper.applyStyles(el,o.style)}return this},addKeyListener:function(key,fn,scope){var config;if(typeof key!="object"||Ext.isArray(key)){config={key:key,fn:fn,scope:scope}}else{config={key:key.key,shift:key.shift,ctrl:key.ctrl,alt:key.alt,fn:fn,scope:scope}}return new Ext.KeyMap(this,config)},addKeyMap:function(config){return new Ext.KeyMap(this,config)},isScrollable:function(){var dom=this.dom;return dom.scrollHeight>dom.clientHeight||dom.scrollWidth>dom.clientWidth},scrollTo:function(side,value,animate){var prop=side.toLowerCase()=="left"?"scrollLeft":"scrollTop";if(!animate||!A){this.dom[prop]=value}else{var to=prop=="scrollLeft"?[value,this.dom.scrollTop]:[this.dom.scrollLeft,value];this.anim({scroll:{"to":to}},this.preanim(arguments,2),"scroll")}return this},scroll:function(direction,distance,animate){if(!this.isScrollable()){return }var el=this.dom;var l=el.scrollLeft,t=el.scrollTop;var w=el.scrollWidth,h=el.scrollHeight;var cw=el.clientWidth,ch=el.clientHeight;direction=direction.toLowerCase();var scrolled=false;var a=this.preanim(arguments,2);switch(direction){case"l":case"left":if(w-l>cw){var v=Math.min(l+distance,w-cw);this.scrollTo("left",v,a);scrolled=true}break;case"r":case"right":if(l>0){var v=Math.max(l-distance,0);this.scrollTo("left",v,a);scrolled=true}break;case"t":case"top":case"up":if(t>0){var v=Math.max(t-distance,0);this.scrollTo("top",v,a);scrolled=true}break;case"b":case"bottom":case"down":if(h-t>ch){var v=Math.min(t+distance,h-ch);this.scrollTo("top",v,a);scrolled=true}break}return scrolled},translatePoints:function(x,y){if(typeof x=="object"||Ext.isArray(x)){y=x[1];x=x[0]}var p=this.getStyle("position");var o=this.getXY();var l=parseInt(this.getStyle("left"),10);var t=parseInt(this.getStyle("top"),10);if(isNaN(l)){l=(p=="relative")?0:this.dom.offsetLeft}if(isNaN(t)){t=(p=="relative")?0:this.dom.offsetTop}return{left:(x-o[0]+l),top:(y-o[1]+t)}},getScroll:function(){var d=this.dom,doc=document;if(d==doc||d==doc.body){var l,t;if(Ext.isIE&&Ext.isStrict){l=doc.documentElement.scrollLeft||(doc.body.scrollLeft||0);t=doc.documentElement.scrollTop||(doc.body.scrollTop||0)}else{l=window.pageXOffset||(doc.body.scrollLeft||0);t=window.pageYOffset||(doc.body.scrollTop||0)}return{left:l,top:t}}else{return{left:d.scrollLeft,top:d.scrollTop}}},getColor:function(attr,defaultValue,prefix){var v=this.getStyle(attr);if(!v||v=="transparent"||v=="inherit"){return defaultValue}var color=typeof prefix=="undefined"?"#":prefix;if(v.substr(0,4)=="rgb("){var rvs=v.slice(4,v.length-1).split(",");for(var i=0;i<3;i++){var h=parseInt(rvs[i]);var s=h.toString(16);if(h<16){s="0"+s}color+=s}}else{if(v.substr(0,1)=="#"){if(v.length==4){for(var i=1;i<4;i++){var c=v.charAt(i);color+=c+c}}else{if(v.length==7){color+=v.substr(1)}}}}return(color.length>5?color.toLowerCase():defaultValue)},boxWrap:function(cls){cls=cls||"x-box";var el=Ext.get(this.insertHtml("beforeBegin",String.format("<div class=\"{0}\">"+El.boxMarkup+"</div>",cls)));el.child("."+cls+"-mc").dom.appendChild(this.dom);return el},getAttributeNS:Ext.isIE?function(ns,name){var d=this.dom;var type=typeof d[ns+":"+name];if(type!="undefined"&&type!="unknown"){return d[ns+":"+name]}return d[name]}:function(ns,name){var d=this.dom;return d.getAttributeNS(ns,name)||d.getAttribute(ns+":"+name)||d.getAttribute(name)||d[name]},getTextWidth:function(text,min,max){return(Ext.util.TextMetrics.measure(this.dom,Ext.value(text,this.dom.innerHTML,true)).width).constrain(min||0,max||1000000)}};var ep=El.prototype;ep.on=ep.addListener;ep.mon=ep.addListener;ep.getUpdateManager=ep.getUpdater;ep.un=ep.removeListener;ep.autoBoxAdjust=true;El.unitPattern=/\d+(px|em|%|en|ex|pt|in|cm|mm|pc)$/i;El.addUnits=function(v,defaultUnit){if(v===""||v=="auto"){return v}if(v===undefined){return""}if(typeof v=="number"||!El.unitPattern.test(v)){return v+(defaultUnit||"px")}return v};El.boxMarkup="<div class=\"{0}-tl\"><div class=\"{0}-tr\"><div class=\"{0}-tc\"></div></div></div><div class=\"{0}-ml\"><div class=\"{0}-mr\"><div class=\"{0}-mc\"></div></div></div><div class=\"{0}-bl\"><div class=\"{0}-br\"><div class=\"{0}-bc\"></div></div></div>";El.VISIBILITY=1;El.DISPLAY=2;El.borders={l:"border-left-width",r:"border-right-width",t:"border-top-width",b:"border-bottom-width"};El.paddings={l:"padding-left",r:"padding-right",t:"padding-top",b:"padding-bottom"};El.margins={l:"margin-left",r:"margin-right",t:"margin-top",b:"margin-bottom"};El.cache={};var docEl;El.get=function(el){var ex,elm,id;if(!el){return null}if(typeof el=="string"){if(!(elm=document.getElementById(el))){return null}if(ex=El.cache[el]){ex.dom=elm}else{ex=El.cache[el]=new El(elm)}return ex}else{if(el.tagName){if(!(id=el.id)){id=Ext.id(el)}if(ex=El.cache[id]){ex.dom=el}else{ex=El.cache[id]=new El(el)}return ex}else{if(el instanceof El){if(el!=docEl){el.dom=document.getElementById(el.id)||el.dom;El.cache[el.id]=el}return el}else{if(el.isComposite){return el}else{if(Ext.isArray(el)){return El.select(el)}else{if(el==document){if(!docEl){var f=function(){};f.prototype=El.prototype;docEl=new f();docEl.dom=document}return docEl}}}}}}return null};El.uncache=function(el){for(var i=0,a=arguments,len=a.length;i<len;i++){if(a[i]){delete El.cache[a[i].id||a[i]]}}};El.garbageCollect=function(){if(!Ext.enableGarbageCollector){clearInterval(El.collectorThread);return }for(var eid in El.cache){var el=El.cache[eid],d=el.dom;if(!d||!d.parentNode||(!d.offsetParent&&!document.getElementById(eid))){delete El.cache[eid];if(d&&Ext.enableListenerCollection){E.purgeElement(d)}}}};El.collectorThreadId=setInterval(El.garbageCollect,30000);var flyFn=function(){};flyFn.prototype=El.prototype;var _cls=new flyFn();El.Flyweight=function(dom){this.dom=dom};El.Flyweight.prototype=_cls;El.Flyweight.prototype.isFlyweight=true;El._flyweights={};El.fly=function(el,named){named=named||"_global";el=Ext.getDom(el);if(!el){return null}if(!El._flyweights[named]){El._flyweights[named]=new El.Flyweight()}El._flyweights[named].dom=el;return El._flyweights[named]};Ext.get=El.get;Ext.fly=El.fly;var noBoxAdjust=Ext.isStrict?{select:1}:{input:1,select:1,textarea:1};if(Ext.isIE||Ext.isGecko){noBoxAdjust["button"]=1}Ext.EventManager.on(window,"unload",function(){delete El.cache;delete El._flyweights})})();