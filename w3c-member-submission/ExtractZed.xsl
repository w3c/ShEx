<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
	xmlns:html="http://www.w3.org/1999/xhtml" exclude-result-prefixes="xs xd"
	version="1.0">
	
	<xsl:output method="text" />

	<xsl:template match="/">
		<xsl:text>
%%inop \entryFor 4
%%inrel \eqtn
</xsl:text>
		<xsl:apply-templates select="//html:pre[@class='Z-source']" />
	</xsl:template>
	
	<xsl:template match="html:pre">
		<xsl:text>
</xsl:text>
		<xsl:value-of select="." />
	</xsl:template>
	
</xsl:stylesheet>