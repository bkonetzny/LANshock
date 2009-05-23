<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://lanshock.svn.sourceforge.net/svnroot/lanshock/trunk/fusebox5/lexicon/lanshock/fuseaction.cfm $
$LastChangedDate: 2008-07-03 00:30:41 +0200 (Do, 03 Jul 2008) $
$LastChangedBy: majestixs $
$LastChangedRevision: 366 $
--->

<cfscript>
	if (fb_.verbInfo.executionMode is "start") {
		fb_.app = fb_.verbInfo.action.getCircuit().getApplication();
		
		// template - string - required
		if (not structKeyExists(fb_.verbInfo.attributes,"template")) {
			fb_throw("fusebox.badGrammar.requiredAttributeMissing",
						"Required attribute is missing",
						"The attribute 'template' is required, for a 'lanshock:display' verb in fuseaction #fb_.verbInfo.circuit#.#fb_.verbInfo.fuseaction#.");
		}
		
		// circuit - string - default current circuit alias
		// FB5: official support for this undocumented feature of FB4.x
		if (structKeyExists(fb_.verbInfo.attributes,"circuit")) {
			if (structKeyExists(fb_.app.circuits,fb_.verbInfo.attributes.circuit)) {
				fb_.targetCircuit = fb_.app.circuits[fb_.verbInfo.attributes.circuit];
			} else if (fb_.app.allowImplicitCircuits) {
				// FB55: attempt to create an implicit circuit
				fb_.app.circuits[fb_.verbInfo.attributes.circuit] = __makeImplicitCircuit();
				fb_.targetCircuit = fb_.app.circuits[fb_.verbInfo.attributes.circuit];
			} else {
				fb_throw("fusebox.undefinedCircuit",
							"undefined Circuit",
							"The attribute 'circuit' (which was '#fb_.verbInfo.attributes.circuit#') must specify an existing circuit alias, for a 'lanshock:display' verb in fuseaction #fb_.verbInfo.circuit#.#fb_.verbInfo.fuseaction#.");
			}
		} else {
			fb_.targetCircuit = fb_.verbInfo.action.getCircuit();
		}
		
		// auto-append script extension:
		fb_.standardExtension = fb_.app.scriptFileDelimiter;
		fb_.extension = listLast(fb_.verbInfo.attributes.template,".");
		if (listFindNoCase(fb_.app.maskedFileDelimiters,fb_.extension,',') eq 0 and 
				listFindNoCase(fb_.app.maskedFileDelimiters,'*',',') eq 0) {
			fb_.template = fb_.verbInfo.attributes.template & "." & fb_.standardExtension;
		} else {
			fb_.template = fb_.verbInfo.attributes.template;
		}
		
		sTemplateFile = fb_.verbInfo.action.getCircuit().getApplication().parseRootPath & 'templates/' & application.lanshock.settings.layout.template & '/templates/' & fb_.verbInfo.circuit & '/view/' & fb_.template;
		
		fb_appendLine('<!--- lanshock:display --->');
		fb_appendLine("<cftry>");
		fb_appendLine('<cfinclude template="#sTemplateFile#">');
		fb_appendLine('<cfcatch type="missingInclude">');
		fb_appendLine("<cftry>");
		fb_appendLine('<cfinclude template="#fb_.verbInfo.action.getCircuit().getApplication().parseRootPath##fb_.targetCircuit.getRelativePath()##fb_.template#">');
		fb_appendLine('<cfcatch type="missingInclude"><cfrethrow></cfcatch></cftry>');
		fb_appendLine('</cfcatch></cftry>');
		fb_appendLine('<!--- /lanshock:display --->');
	}
</cfscript>