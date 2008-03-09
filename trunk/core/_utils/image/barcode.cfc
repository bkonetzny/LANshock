<!--- 

USAGE:
<cfset o = createObject("component", "#application.lanshock.oRuntime.getEnvironment().sComponentPath#core._utils.image.barcode")>

<cfset o.saveBarcode(code='USER:ID:177256',saveToFile='C:/Server/barbecue.jpg')>

<cfset o.outputBarcode(code='USER:ID:177256')>

--->

<cfcomponent>
	
	<cffunction name="outputBarcode">
		<cfargument name="code" type="string" required="true" />
		<cfargument name="type" type="string" required="false" default="Code128" />
		<cfargument name="format" type="string" required="false" default="jpg" hint="jpg | png | gif" />
		
		<cfset createBarcode(code=arguments.code,type=arguments.type,format=arguments.format,mode='output')>
	</cffunction>
	
	<cffunction name="saveBarcode">
		<cfargument name="code" type="string" required="true" />
		<cfargument name="type" type="string" required="false" default="Code128" />
		<cfargument name="format" type="string" required="false" default="jpg" hint="jpg | png | gif" />
		<cfargument name="saveToFile" type="string" required="false" default="" hint="path to file" />
		
		<cfset createBarcode(code=arguments.code,type=arguments.type,format=arguments.format,mode='save',saveToFile=arguments.saveToFile)>
	</cffunction>
 
	<cffunction name="createBarcode" returntype="any" access="private" output="true">
		<cfargument name="code" type="string" required="true" />
		<cfargument name="type" type="string" required="false" default="Code128" />
		<cfargument name="format" type="string" required="false" default="jpg" hint="jpg | png | gif" />
		<cfargument name="mode" type="string" required="false" default="output" hint="output | save" />
		<cfargument name="saveToFile" type="string" required="false" default="" hint="path to file" />
		
		<cfset var aJarPath = ArrayNew(1)>
		<cfset var oJavaLoader = 0>
		<cfset var oBarcodeFactory = 0>
		<cfset var oBarcodeImageHandler = 0>
		<cfset var outStream = 0>
		<cfset var barcode = 0>
		<cfset var bufferedImage = 0>
		
		<cfsetting showdebugoutput="false">
		
		<cfset aJarPath[1] = expandPath("#application.lanshock.oRuntime.getEnvironment().sBasePath#core/_utils/java/barbecue/barbecue-1.5-beta1.jar")>
		<cfset oJavaLoader = createObject("component", "#application.lanshock.oRuntime.getEnvironment().sComponentPath#core._utils.javaloader.JavaLoader").init(aJarPath)>
		
		<cfset oBarcodeFactory = oJavaLoader.create("net.sourceforge.barbecue.BarcodeFactory")>
		<cfset oBarcodeImageHandler = oJavaLoader.create("net.sourceforge.barbecue.BarcodeImageHandler")>
		
		<cfif arguments.mode EQ 'output'>
			<cfset outStream = createObject("java", "java.io.ByteArrayOutputStream").init()>
		<cfelseif len(arguments.saveToFile)>
			<cfset outStream = createObject("java", "java.io.FileOutputStream").init(arguments.saveToFile)>
		</cfif>
		
		<cfswitch expression="#arguments.type#">
			<cfcase value="Code128">
				<cfset barcode = oBarcodeFactory.createCode128("#arguments.code#")>
			</cfcase>
			<cfcase value="Code128A">
				<cfset barcode = oBarcodeFactory.createCode128A("#arguments.code#")>
			</cfcase>
			<cfcase value="Code128B">
				<cfset barcode = oBarcodeFactory.createCode128B("#arguments.code#")>
			</cfcase>
			<cfcase value="Code128C">
				<cfset barcode = oBarcodeFactory.createCode128C("#arguments.code#")>
			</cfcase>
			<cfcase value="UCC128">
				<cfset barcode = oBarcodeFactory.createUCC128("#arguments.code#")>
			</cfcase>
			<cfcase value="USPS">
				<cfset barcode = oBarcodeFactory.createUSPS("#arguments.code#")>
			</cfcase>
			<cfcase value="ShipmentIdentificationNumber">
				<cfset barcode = oBarcodeFactory.createShipmentIdentificationNumber("#arguments.code#")>
			</cfcase>
			<cfcase value="SSCC18">
				<cfset barcode = oBarcodeFactory.createSSCC18("#arguments.code#")>
			</cfcase>
			<cfcase value="SCC14ShippingCode">
				<cfset barcode = oBarcodeFactory.createSCC14ShippingCode("#arguments.code#")>
			</cfcase>
			<cfcase value="GlobalTradeItemNumber">
				<cfset barcode = oBarcodeFactory.createGlobalTradeItemNumber("#arguments.code#")>
			</cfcase>
			<cfcase value="EAN13">
				<cfset barcode = oBarcodeFactory.createEAN13("#arguments.code#")>
			</cfcase>
			<cfcase value="Bookland">
				<cfset barcode = oBarcodeFactory.createBookland("#arguments.code#")>
			</cfcase>
			<cfcase value="UPCA">
				<cfset barcode = oBarcodeFactory.createUPCA("#arguments.code#")>
			</cfcase>
			<cfcase value="RandomWeightUPCA">
				<cfset barcode = oBarcodeFactory.createRandomWeightUPCA("#arguments.code#")>
			</cfcase>
			<cfcase value="Std2of5">
				<cfset barcode = oBarcodeFactory.createStd2of5("#arguments.code#")>
			</cfcase>
			<cfcase value="Int2of5">
				<cfset barcode = oBarcodeFactory.createInt2of5("#arguments.code#")>
			</cfcase>
			<cfcase value="PDF417">
				<cfset barcode = oBarcodeFactory.createPDF417("#arguments.code#")>
			</cfcase>
			<cfcase value="Code39">
				<cfset barcode = oBarcodeFactory.createCode39("#arguments.code#")>
			</cfcase>
			<cfcase value="3of9">
				<cfset barcode = oBarcodeFactory.create3of9("#arguments.code#")>
			</cfcase>
			<cfcase value="USD3">
				<cfset barcode = oBarcodeFactory.createUSD3("#arguments.code#")>
			</cfcase>
			<cfcase value="Codabar">
				<cfset barcode = oBarcodeFactory.createCodabar("#arguments.code#")>
			</cfcase>
			<cfcase value="USD4">
				<cfset barcode = oBarcodeFactory.createUSD4("#arguments.code#")>
			</cfcase>
			<cfcase value="NW7">
				<cfset barcode = oBarcodeFactory.createNW7("#arguments.code#")>
			</cfcase>
			<cfcase value="Monarch">
				<cfset barcode = oBarcodeFactory.createMonarch("#arguments.code#")>
			</cfcase>
			<cfcase value="2of7">
				<cfset barcode = oBarcodeFactory.create2of7("#arguments.code#")>
			</cfcase>
			<cfcase value="PostNet">
				<cfset barcode = oBarcodeFactory.createPostNet("#arguments.code#")>
			</cfcase>
			<cfdefaultcase>
				<cfthrow message="BarbecueWrapper: '#arguments.type#' is no valid barcode type.">
			</cfdefaultcase>
		</cfswitch>
		
		<cfswitch expression="#arguments.format#">
			<cfcase value="jpg">
				<cfset bufferedImage = oBarcodeImageHandler.writeJPEG(barcode, outStream)>
			</cfcase>
			<cfcase value="png">
				<cfset bufferedImage = oBarcodeImageHandler.writePNG(barcode, outStream)>
			</cfcase>
			<cfcase value="gif">
				<cfset bufferedImage = oBarcodeImageHandler.writeGIF(barcode, outStream)>
			</cfcase>
			<cfdefaultcase>
				<cfthrow message="BarbecueWrapper: '#arguments.format#' is no valid output format.">
			</cfdefaultcase>
		</cfswitch>
		
		
		<cfif arguments.mode EQ 'output'>
			<!--- Return the information as streaming bytes of type image/jpeg --->
			<cfset getPageContext().getOut().clearBuffer()><cfcontent type="image/jpeg" variable="#outStream.toByteArray()#"><cfreturn>
			<cfset outStream.close()>
		<cfelseif len(arguments.saveToFile)>
			<cfset outStream.close()>
		</cfif>
		
	</cffunction>

</cfcomponent>