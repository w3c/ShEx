<?xml version="1.0" encoding="UTF-8"?>

<!-- Version: $Id: zml2html-lines.xsl,v 1.2 2004/11/12 02:17:41 aryman Exp $ -->

<!-- Stylesheet for Z Markup Language (ZML) -->
<!-- Author: Arthur Ryman  <ryman@ca.ibm.com> -->
<!-- Date Created: 2004-10-10 -->

<!-- 
	This stylesheet is copyright (c) 2004 by its authors.  Free
	distribution and modification is permitted, including adding to
	the list of authors and copyright holders, as long as this
	copyright notice is maintained. 
-->

<!-- 
	This stylesheet renders Z Notation as HTML.
	The document must be marked up using ZML
	which is in the namespace http://www.w3.org/2004/zml.
	These tags correspond closely to the LaTeX commands
	defined in the fuzz 2000 document style developed
	by Mike Spivey and which is available at
	http://spivey.oriel.ox.ac.uk/~mike/fuzz/.
-->

<!-- 
	ChangeLog:

	2004-10-10: Arthur Ryman <ryman@ca.ibm.com>
	- simplified ZML to make authoring easier
	
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:z="http://www.w3.org/2004/zml"  exclude-result-prefixes="z" version="1.0">

	<!--
		Outputs the nodes in a Zed box as a sequence of lines.
		
		$box - the Zed box type (zed, schema, axdef, gendef)
	-->

	<xsl:template name="output-lines">
		<xsl:param name="box" />
		<xsl:call-template name="output-rows">
			<xsl:with-param name="box" select="$box" />
			<xsl:with-param name="break" select="1" />
			<xsl:with-param name="start" select="0" />
			<xsl:with-param name="breaks" select="z:nl | z:also | z:where" />
			<xsl:with-param name="nodes" select="node()" />
		</xsl:call-template>
	</xsl:template>

	<!--
		Outputs a node-set as a sequence of rows.
		
		$box - the Zed box type (zed, schema, axdef, gendef)
		$nodes - the node-set
		$breaks - the row breaks in the node-set
		$start - the index of the previous row break in the node-set
		$break - the index of the current break in the breaks node-set
	-->

	<xsl:template name="output-rows">
		<xsl:param name="box" />
		<xsl:param name="nodes" />
		<xsl:param name="breaks" />
		<xsl:param name="start" />
		<xsl:param name="break" />
		<xsl:variable name="newStart">
			<xsl:choose>
				<xsl:when test="$break &gt; count($breaks)">
					<xsl:value-of select="count($nodes) + 1" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="count($breaks[$break]/preceding-sibling::node()) + 1" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:call-template name="output-row">
			<xsl:with-param name="box" select="$box" />
			<xsl:with-param name="before" select="$breaks[$break - 1]" />
			<xsl:with-param name="row" select="$nodes[$start &lt; position() and position() &lt; $newStart]" />
			<xsl:with-param name="after" select="$breaks[$break]" />
		</xsl:call-template>
		<xsl:if test="$break &lt;= count($breaks)">
			<xsl:call-template name="output-rows">
				<xsl:with-param name="box" select="$box" />
				<xsl:with-param name="nodes" select="$nodes" />
				<xsl:with-param name="breaks" select="$breaks" />
				<xsl:with-param name="start" select="$newStart" />
				<xsl:with-param name="break" select="$break + 1" />
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	<xsl:template name="output-row">
		<xsl:param name="box" />
		<xsl:param name="before" />
		<xsl:param name="row" />
		<xsl:param name="after" />
		<xsl:choose>
			<xsl:when test="$box = 'axdef'">
				<xsl:call-template name="axdef-row">
					<xsl:with-param name="before" select="$before" />
					<xsl:with-param name="row" select="$row" />
					<xsl:with-param name="after" select="$after" />
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="$box = 'zed'">
				<xsl:call-template name="zed-row">
					<xsl:with-param name="row" select="$row" />
					<xsl:with-param name="after" select="$after" />
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="schema-row">
					<xsl:with-param name="row" select="$row" />
					<xsl:with-param name="after" select="$after" />
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

</xsl:stylesheet>
