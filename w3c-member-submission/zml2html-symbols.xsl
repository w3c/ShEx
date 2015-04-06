<?xml version="1.0" encoding="UTF-8"?>

<!-- Version: $Id: zml2html-symbols.xsl,v 1.3 2004/12/31 22:03:03 aryman 
	Exp $ -->

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

<!-- 2015-04-01: Arthur Ryman <arthur.ryman@gmail.com> - made \ELSE an infix operator -->

<!-- 2004-12-28: Arthur Ryman <ryman@ca.ibm.com> - put mode independent rendering 
	templates here -->

<!-- 2004-10-10: Arthur Ryman <ryman@ca.ibm.com> - simplified ZML to make 
	authoring easier -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:z="http://www.w3.org/2004/zml" exclude-result-prefixes="z"
	version="1.0">

	<xsl:template match="z:sub">
		<span class="zsmall">
			<sub>
				<xsl:call-template name="output-row-contents">
					<xsl:with-param name="row" select="node()" />
				</xsl:call-template>
			</sub>
		</span>
	</xsl:template>

	<xsl:template match="z:u">
		<xsl:text>_</xsl:text>
	</xsl:template>

	<xsl:template match="z:t1">
		<xsl:call-template name="tab" />
	</xsl:template>

	<xsl:template match="z:t2">
		<xsl:call-template name="tab" />
		<xsl:call-template name="tab" />
	</xsl:template>

	<xsl:template match="z:t3">
		<xsl:call-template name="tab" />
		<xsl:call-template name="tab" />
		<xsl:call-template name="tab" />
	</xsl:template>

	<xsl:template match="z:t4">
		<xsl:call-template name="tab" />
		<xsl:call-template name="tab" />
		<xsl:call-template name="tab" />
		<xsl:call-template name="tab" />
	</xsl:template>

	<xsl:template match="z:t5">
		<xsl:call-template name="tab" />
		<xsl:call-template name="tab" />
		<xsl:call-template name="tab" />
		<xsl:call-template name="tab" />

		<xsl:call-template name="tab" />
	</xsl:template>

	<xsl:template match="z:t6">
		<xsl:call-template name="tab" />
		<xsl:call-template name="tab" />
		<xsl:call-template name="tab" />
		<xsl:call-template name="tab" />

		<xsl:call-template name="tab" />
		<xsl:call-template name="tab" />
	</xsl:template>

	<xsl:template match="z:t7">
		<xsl:call-template name="tab" />
		<xsl:call-template name="tab" />
		<xsl:call-template name="tab" />
		<xsl:call-template name="tab" />

		<xsl:call-template name="tab" />
		<xsl:call-template name="tab" />
		<xsl:call-template name="tab" />
	</xsl:template>

	<xsl:template match="z:t8">
		<xsl:call-template name="tab" />
		<xsl:call-template name="tab" />
		<xsl:call-template name="tab" />
		<xsl:call-template name="tab" />

		<xsl:call-template name="tab" />
		<xsl:call-template name="tab" />
		<xsl:call-template name="tab" />
		<xsl:call-template name="tab" />
	</xsl:template>

	<xsl:template match="z:t9">
		<xsl:call-template name="tab" />
		<xsl:call-template name="tab" />
		<xsl:call-template name="tab" />
		<xsl:call-template name="tab" />

		<xsl:call-template name="tab" />
		<xsl:call-template name="tab" />
		<xsl:call-template name="tab" />
		<xsl:call-template name="tab" />

		<xsl:call-template name="tab" />
	</xsl:template>

	<xsl:template name="tab">
		<xsl:text>&#160;&#160;&#160;&#160;&#160;&#160;</xsl:text>
	</xsl:template>

	<xsl:template match="z:lquot | z:rquot">
		<xsl:text>&quot;</xsl:text>
	</xsl:template>

	<xsl:template match="z:lapos | z:rapos">
		<xsl:text>'</xsl:text>
	</xsl:template>

	<!-- Special schema operators -->

	<xsl:template match="z:pre">
		<span class="zprefix">
			<span class="zs">pre</span>
		</span>
	</xsl:template>

	<!-- Basic expressions -->

	<xsl:template match="z:IF">
		<span class="zprefix">
			<span class="zbs">
				<xsl:text>if</xsl:text>
			</span>
		</span>
	</xsl:template>

	<xsl:template match="z:THEN">
		<span class="zinfix">
			<span class="zbs">
				<xsl:text>then</xsl:text>
			</span>
		</span>
	</xsl:template>

	<xsl:template match="z:ELSE">
		<span class="zinfix">
			<span class="zbs">
				<xsl:text>else</xsl:text>
			</span>
		</span>
	</xsl:template>

	<xsl:template match="z:LET">
		<span class="zprefix">
			<span class="zbs">
				<xsl:text>let</xsl:text>
			</span>
		</span>
	</xsl:template>


	<!-- Relations -->

	<xsl:template match="z:dom | z:ran | z:id">
		<span class="zprefix">
			<span class="zs">
				<xsl:value-of select="local-name()" />
			</span>
		</span>
	</xsl:template>

	<xsl:template match="z:inv">
		<sup>~</sup>
	</xsl:template>

	<xsl:template match="z:limg">
		<span style="position: relative; left: .1em">(</span>
		<span>|</span>
	</xsl:template>

	<xsl:template match="z:rimg">
		<span style="position: relative; left: .1em">|</span>
		<span>)</span>
	</xsl:template>

	<xsl:template match="z:plus">
		<sup>+</sup>
	</xsl:template>

	<xsl:template match="z:star">
		<sup>*</sup>
	</xsl:template>

	<xsl:template match="z:sup">
		<sup>
			<xsl:call-template name="output-row-contents">
				<xsl:with-param name="row" select="node()" />
			</xsl:call-template>
		</sup>
	</xsl:template>


	<!-- Numbers and arithmetic -->

	<xsl:template match="z:div | z:mod">
		<span class="zinfix">
			<span class="zss">
				<xsl:value-of select="local-name()" />
			</span>
		</span>
	</xsl:template>

	<!-- Sequences -->

	<xsl:template match="z:seq | z:iseq">
		<span class="zprefix">
			<span class="zs">
				<xsl:value-of select="local-name()" />
			</span>
		</span>
	</xsl:template>

	<xsl:template match="z:seq_1">
		<span class="zprefix">
			<span class="zs">seq</span>
			<span class="zsmall">
				<sub>1</sub>
			</span>
		</span>
	</xsl:template>

	<xsl:template match="z:prefix | z:suffix | z:partition">
		<span class="zinfix">
			<span class="zss">
				<xsl:value-of select="local-name()" />
			</span>
		</span>
	</xsl:template>

	<xsl:template match="z:inseq">
		<span class="zinfix">
			<span class="zss">in</span>
		</span>
	</xsl:template>

	<xsl:template match="z:disjoint">
		<span class="zprefix">
			<span class="zss">
				<xsl:value-of select="local-name()" />
			</span>
		</span>
	</xsl:template>


	<!-- Bags -->

	<xsl:template match="z:bag">
		<span class="zprefix">
			<span class="zs">bag</span>
		</span>
	</xsl:template>

</xsl:stylesheet>