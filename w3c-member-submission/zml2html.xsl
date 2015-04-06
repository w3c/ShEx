<?xml version="1.0" encoding="UTF-8"?>

<!-- Version: $Id: zml2html.xsl,v 1.13 2005/05/03 13:46:56 hugo Exp $ -->

<!-- Stylesheet for Z Markup Language (ZML) -->
<!-- Author: Arthur Ryman <ryman@ca.ibm.com> -->
<!-- Date Created: 2004-09-23 -->

<!-- This stylesheet is copyright (c) 2004 by its authors. Free distribution 
	and modification is permitted, including adding to the list of authors and 
	copyright holders, as long as this copyright notice is maintained. -->

<!-- This stylesheet renders Z Notation as HTML. The document must be marked 
	up using ZML which is in the namespace http://www.w3.org/2004/zml. These 
	tags correspond closely to the LaTeX commands defined in the fuzz 2000 document 
	style developed by Mike Spivey and which is available at http://spivey.oriel.ox.ac.uk/~mike/fuzz/. -->

<!-- Change Log: -->

<!-- 2015-04-01: Arthur Ryman <arthur.ryman@gmail.com> - allow formal parameters 
	of gendef to be absent. Treat z:syntax like z:zed. -->

<!-- 2005-03-16: Arthur Ryman <ryman@ca.ibm.com> - change default value of 
	showZed to false -->

<!-- 2004-12-26: Arthur Ryman <ryman@ca.ibm.com> - added interactive version 
	with twisties -->

<!-- 2004-11-16: Arthur Ryman <ryman@ca.ibm.com> - render Z symbols as unicode 
	to be compliant with W3C Character Model -->

<!-- 2004-10-24: Arthur Ryman <ryman@ca.ibm.com> - added support for <z:see/> -->

<!-- 2004-10-13: Arthur Ryman <ryman@ca.ibm.com> - added ability to hide 
	and show Zed notation via links between a full and short version of the specification -->

<!-- 2004-10-10: Arthur Ryman <ryman@ca.ibm.com> - simplified ZML to make 
	authoring easier -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:z="http://www.w3.org/2004/zml" exclude-result-prefixes="z"
	version="1.0">

	<xsl:import href="zml2html-lines.xsl" />
	<xsl:import href="zml2html-tokens.xsl" />
	<xsl:import href="zml2html-symbols.xsl" />
	<xsl:import href="zml2html-symbols-unicode.xsl" />
	<xsl:import href="zml2html-symbols-fonts.xsl" />

	<!-- the renderAs parameter controls how the Z Notation is rendered. The 
		possible values are: unicode - Use Unicode characters. This is the normative 
		value and compliant with the W3C Character Model and is compatible with Mozilla. 
		fonts - Use font switching. This method is compatible with IE. png - Use 
		PNG images for the symbols. Not currently implemented. mathml - Use Presentation 
		MathML. Not currently implemented. -->
	<xsl:param name="renderAs" select="'unicode'" />

	<!-- The interactive parameter enables the interactive hiding and showing 
		of the Z Notation using JavaScript and DHTML. The possible values are: false 
		- Z Notation is always visible. This is the normative value. true - Enable 
		hiding and showing. -->
	<xsl:param name="interactive" select="'false'" />

	<!-- The showZed and linkTo parameters control the generation of cross-linked 
		versions of the spec. One shows the Z Notation and one hides it. They are 
		obsolete. Use the interactive parameter instead. showZed is true or false 
		and controls the visibility of the Z Notation. linkTo is the URL of the version 
		of the spec to be linked to. Each Z section is given a named anchor. The 
		anchor name is the Z name with the prefix zed- prepended. e.g. the Z section 
		named Interface is given the anchor zed-Interface. -->
	<xsl:param name="showZed" select="'false'" />
	<xsl:param name="linkTo" />

	<xsl:template match="z:notation">
		<a name="zed-{@name}" />
		<xsl:choose>
			<xsl:when test="$interactive='true'">
				<div class="twisty-head" id="twisty-head-zed-{@name}">
					<img class="twisty-icon" alt="" src="images/left-twisty-13.png" />
					<a onclick="show('zed-{@name}')">
						<xsl:value-of select="@name" />
					</a>
					<xsl:text>...</xsl:text>
				</div>
				<div class="twisty-body" id="twisty-body-zed-{@name}">
					<img class="twisty-icon" alt="" src="images/down-twisty-13.png" />
					<a onclick="hide('zed-{@name}')">
						<xsl:value-of select="@name" />
					</a>
					<xsl:text>&#160;&#160;[&#160;</xsl:text>
					<a href="#zed-{@name}" onClick="showAll()">show all</a>
					<xsl:text>&#160;]&#160;&#160;[&#160;</xsl:text>
					<a href="#zed-{@name}" onClick="hideAll()">hide all</a>
					<xsl:text>&#160;]</xsl:text>
					<br />
					<xsl:apply-templates />
				</div>
			</xsl:when>
			<xsl:when test="$showZed='true'">
				<xsl:if test="$linkTo">
					<p>
						<span class="zi">
							<a href="{$linkTo}#zed-{@name}">
								<xsl:text>Hide&#160;</xsl:text>
								<xsl:value-of select="@name" />
							</a>
						</span>
					</p>
				</xsl:if>
				<xsl:apply-templates />
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="$linkTo">
					<p>
						<span class="zi">
							<a href="{$linkTo}#zed-{@name}">
								<xsl:text>See also&#160;</xsl:text>
								<xsl:value-of select="@name" />
							</a>
						</span>
					</p>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="z:zed | z:syntax">
		<table class="zzed">
			<col class="zzed1" />
			<tbody>
				<xsl:call-template name="output-lines">
					<xsl:with-param name="box" select="'zed'" />
				</xsl:call-template>
			</tbody>
		</table>
	</xsl:template>

	<xsl:template name="zed-row">
		<xsl:param name="row" />
		<xsl:param name="after" />
		<tr>
			<td>
				<xsl:call-template name="output-row-contents">
					<xsl:with-param name="row" select="$row" />
				</xsl:call-template>
			</td>
		</tr>
		<xsl:if test="local-name($after)='also'">
			<tr>
				<td />
			</tr>
		</xsl:if>
	</xsl:template>

	<xsl:template name="output-row-contents">
		<xsl:param name="row" />
		<xsl:for-each select="$row">
			<xsl:choose>
				<xsl:when test="self::text()">
					<xsl:apply-templates select="." mode="latex" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="render-symbol" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="render-symbol">
		<xsl:choose>
			<xsl:when test="$renderAs='fonts'">
				<xsl:apply-templates select="." mode="fonts" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates select="." mode="unicode" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="z:axdef">
		<table class="zaxdef">
			<col class="zaxdef1" />
			<col class="zaxdef2" />
			<tbody>
				<xsl:call-template name="output-lines">
					<xsl:with-param name="box" select="'axdef'" />
				</xsl:call-template>
			</tbody>
		</table>
	</xsl:template>

	<xsl:template name="axdef-row">
		<xsl:param name="before" />
		<xsl:param name="row" />
		<xsl:param name="after" />
		<xsl:variable name="tdclass">
			<xsl:choose>
				<xsl:when test="local-name($after)='where'">
					<xsl:value-of select="'zaxdefabovewheretext'" />
				</xsl:when>
				<xsl:when test="local-name($before)='where'">
					<xsl:value-of select="'zaxdefbelowwheretext'" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'zaxdeftext'" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<tr>
			<td colspan="2" class="{$tdclass}">
				<xsl:call-template name="output-row-contents">
					<xsl:with-param name="row" select="$row" />
				</xsl:call-template>
			</td>
		</tr>
		<xsl:choose>
			<xsl:when test="local-name($after)='also'">
				<tr>
					<td class="l" />
					<td />
				</tr>
			</xsl:when>
			<xsl:when test="local-name($after)='where'">
				<tr>
					<td class="bl" />
					<td />
				</tr>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="z:schema">
		<table class="zschema">
			<col class="zschema1" />
			<col class="zschema2" />
			<col class="zschema3" />
			<tbody>
				<tr>
					<td class="zschemaname" colspan="2">
						<span class="zschemaname">
							<span class="zi">
								<xsl:value-of select="@name" />
							</span>
							<xsl:if test="@params">
								<xsl:text>[</xsl:text>
								<span class="zi">
									<xsl:value-of select="@params" />
								</span>
								<xsl:text>]</xsl:text>
							</xsl:if>
						</span>
					</td>
					<td />
				</tr>
				<xsl:call-template name="output-lines">
					<xsl:with-param name="box" select="'schema'" />
				</xsl:call-template>
				<tr>
					<td class="bl" />
					<td class="b" />
					<td />
				</tr>
			</tbody>
		</table>
	</xsl:template>

	<xsl:template name="schema-row">
		<xsl:param name="row" />
		<xsl:param name="after" />
		<xsl:variable name="tdclass">
			<xsl:choose>
				<xsl:when test="local-name($after)='nl'">
					<xsl:value-of select="'zschematext'" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'zschemalasttext'" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<tr>
			<td colspan="3" class="{$tdclass}">
				<span class="zschematext">
					<xsl:call-template name="output-row-contents">
						<xsl:with-param name="row" select="$row" />
					</xsl:call-template>
				</span>
			</td>
		</tr>
		<xsl:choose>
			<xsl:when test="local-name($after)='also'">
				<tr>
					<td class="l" />
					<td />
					<td />
				</tr>
			</xsl:when>
			<xsl:when test="local-name($after)='where'">
				<tr>
					<td class="bl" />
					<td />
					<td />
				</tr>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="z:gendef">
		<table class="zschema">
			<col class="zschema1" />
			<col class="zschema2" />
			<col class="zschema3" />
			<tbody>
				<tr>
					<td class="zgendeftop" colspan="2">
						<xsl:if test="@params">
							<span class="zschemaname">
								<xsl:text>[</xsl:text>
								<span class="zi">
									<xsl:value-of select="@params" />
								</span>
								<xsl:text>]</xsl:text>
							</span>
						</xsl:if>
					</td>
					<td />
				</tr>
				<xsl:call-template name="output-lines">
					<xsl:with-param name="box" select="'gendef'" />
				</xsl:call-template>
				<tr>
					<td class="bl" />
					<td class="b" />
					<td />
				</tr>
			</tbody>
		</table>
	</xsl:template>

	<xsl:template match="z:i">
		<span class="zi">
			<xsl:apply-templates />
		</span>
	</xsl:template>

	<xsl:template match="z:math">
		<xsl:call-template name="output-row-contents">
			<xsl:with-param name="row" select="node()" />
		</xsl:call-template>
	</xsl:template>

	<xsl:template match="z:label">
		<a name="{@key}" />
	</xsl:template>

	<xsl:template match="z:ref">
		<a href="#{@key}">
			<xsl:value-of select="@key" />
		</a>
	</xsl:template>

	<xsl:template match="z:see">
		<div class="zsee">
			<span class="zsmall">
				<xsl:text>See</xsl:text>
				<span class="zi">
					<xsl:call-template name="write-names">
						<xsl:with-param name="names" select="normalize-space(@names)" />
					</xsl:call-template>
				</span>
			</span>
		</div>
	</xsl:template>

	<xsl:template name="write-names">
		<xsl:param name="names" />
		<xsl:value-of select="' '" />
		<xsl:choose>
			<xsl:when test="contains($names,' ')">
				<xsl:variable name="name1" select="substring-before($names,' ')" />
				<a href="#zed-{$name1}">
					<xsl:value-of select="$name1" />
				</a>
				<xsl:value-of select="','" />
				<xsl:call-template name="write-names">
					<xsl:with-param name="names" select="substring-after($names,' ')" />
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<a href="#zed-{$names}">
					<xsl:value-of select="$names" />
				</a>
				<xsl:value-of select="'.'" />
			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>

</xsl:stylesheet>