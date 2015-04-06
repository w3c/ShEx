<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="1.0">

	<!-- Stylesheet for Z Markup Language (ZML) -->
	<!-- Author: Arthur Ryman <arthur.ryman@gmail.com> -->
	<!-- Date Created: 2015-04-01 -->

	<!-- This stylesheet handles local commands defined in the file local-commands.xml. -->
	
	<xsl:import href="zml2html.xsl" />

	<xsl:output method="xml" />

	<xsl:variable name="local-commands"
		select="document('local-commands.xml')//commands/command" />

	<xsl:template match="/">
		<xsl:apply-templates />
	</xsl:template>

	<!-- apply the imported rules to the ZML elements -->
	<xsl:template match="*[namespace-uri()='http://www.w3.org/2004/zml']">
		<xsl:apply-imports />
	</xsl:template>

	<!-- process the local command elements -->
	<xsl:template match="*[namespace-uri()='http://www.w3.org/2004/zml/local']"
		mode="unicode">
		<xsl:variable name="local-name" select="local-name()" />
		<xsl:variable name="local-command" select="$local-commands[@name=$local-name]" />
		<xsl:copy-of select="$local-command/*" />
	</xsl:template>

	<!-- Copy all the non-ZML nodes -->
	<xsl:template match="*|@*|text()">
		<xsl:copy>
			<xsl:apply-templates select="*|@*|text()" />
		</xsl:copy>
	</xsl:template>

</xsl:stylesheet>