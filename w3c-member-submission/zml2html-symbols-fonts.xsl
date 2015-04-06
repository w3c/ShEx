<?xml version="1.0" encoding="UTF-8"?>

<!-- Version: $Id: zml2html-symbols-fonts.xsl,v 1.1 2004/12/31 22:03:03 aryman Exp $ -->

<!-- Stylesheet for Z Markup Language (ZML) -->
<!-- Author: Arthur Ryman  <ryman@ca.ibm.com> -->
<!-- Date Created: 2004-09-23 -->

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
	Change Log:
	
	2004-12-28: Arthur Ryman <ryman@ca.ibm.com>
	- added fonts mode attribute to enable coexistence with alternate renderings

	2004-10-10: Arthur Ryman <ryman@ca.ibm.com>
	- simplified ZML to make authoring easier
	
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:z="http://www.w3.org/2004/zml"  exclude-result-prefixes="z" version="1.0">

	<xsl:template match="z:sub" mode="fonts">
		<xsl:apply-templates select="." />
	</xsl:template>

	<xsl:template match="z:u" mode="fonts">
		<xsl:apply-templates select="." />
	</xsl:template>

	<xsl:template match="z:t1 | z:t2 | z:t3 | z:t4 | z:t5 | z:t6 | z:t7 | z:t8 | z:t9" mode="fonts">
		<xsl:apply-templates select="." />
	</xsl:template>

	<xsl:template match="z:lquot | z:rquot" mode="fonts">
		<xsl:apply-templates select="." />
	</xsl:template>

	<xsl:template match="z:lapos | z:rapos" mode="fonts">
		<xsl:apply-templates select="." />
	</xsl:template>
	
	<xsl:template name="spot-fonts">
		<span class="zinfix">
			<span class="symbol">&#183;</span>
		</span>
	</xsl:template>
	

	<xsl:template name="abbreviation-fonts">
		<span class="zinfix">
			<span class="zdefa">==</span>
		</span>
	</xsl:template>

	<!-- Schema definition \defs -->

	<xsl:template match="z:defs" mode="fonts">
		<span class="zinfix">
			<span
				style="position: relative; left: .325em; bottom: .75ex">
				^
			</span>
			<span style="position: relative; right: .4em">=</span>
		</span>
	</xsl:template>

	<!-- Free type definition ::=, \ldata, \rdata -->

	<xsl:template name="free-type-fonts">
		<span class="zinfix">::=</span>
	</xsl:template>

	<xsl:template match="z:ldata" mode="fonts">
		<span class="symbol">
			<span style="position: relative; left=.2em">&#225;</span>
			<span>&#225;</span>
		</span>
	</xsl:template>

	<xsl:template match="z:rdata" mode="fonts">
		<span class="symbol">
			<span style="position: relative; left=.2em">&#241;</span>
			<span>&#241;</span>
		</span>
	</xsl:template>

	<!-- Logic and schema calculus -->

	<xsl:template match="z:lnot" mode="fonts">
		<span class="zprefix">
			<span class="symbol">
				<xsl:text>&#216;</xsl:text>
			</span>
		</span>
	</xsl:template>

	<xsl:template match="z:land" mode="fonts">
		<span class="zinfix">
			<span class="mathb">
				<xsl:text>&#46;</xsl:text>
			</span>
		</span>
	</xsl:template>

	<xsl:template match="z:lor" mode="fonts">
		<span class="zinfix">
			<span class="mathb">
				<xsl:text>&#45;</xsl:text>
			</span>
		</span>
	</xsl:template>

	<xsl:template match="z:implies" mode="fonts">
		<span class="zinfix">
			<span class="mathc">
				<xsl:text>&#117;</xsl:text>
			</span>
		</span>
	</xsl:template>

	<xsl:template match="z:iff" mode="fonts">
		<span class="zinfix">
			<span class="mathc">&#119;</span>
		</span>
	</xsl:template>

	<xsl:template match="z:forall" mode="fonts">
		<span class="zprefix">
			<span class="symbol">&#34;</span>
		</span>
	</xsl:template>

	<xsl:template match="z:exists" mode="fonts">
		<span class="zprefix">
			<span class="symbol">&#36;</span>
		</span>
	</xsl:template>

	<xsl:template match="z:exists_1" mode="fonts">
		<span class="zprefix">
			<span class="symbol">&#36;</span>
			<span class="zsmall">
				<sub>1</sub>
			</span>
		</span>
	</xsl:template>

	<!-- Special schema operators -->

	<xsl:template match="z:hide" mode="fonts">
		<span class="zinfix">\</span>
	</xsl:template>

	<xsl:template match="z:project" mode="fonts">
		<span class="zinfix">
			<span class="mathc">&#147;</span>
		</span>
	</xsl:template>

	<xsl:template match="z:pre" mode="fonts">
		<xsl:apply-templates select="." />
	</xsl:template>

	<xsl:template match="z:semi" mode="fonts">
		<span class="zinfix">;</span>
	</xsl:template>

	<xsl:template match="z:pipe" mode="fonts">
		<span class="zinfix">
			<span class="mathb">&#112;</span>
		</span>
	</xsl:template>

	<!-- Basic expressions -->

	<xsl:template match="z:neq" mode="fonts">
		<span class="zinfix">
			<span class="mathb">&#103;</span>
		</span>
	</xsl:template>

	<xsl:template match="z:IF | z:THEN | z:ELSE | z:LET" mode="fonts">
		<xsl:apply-templates select="." />
	</xsl:template>

	<xsl:template match="z:theta" mode="fonts">
		<span class="zprefix">
			<span class="zi">
				<span class="symbol">&#113;</span>
			</span>
		</span>
	</xsl:template>

	<xsl:template match="z:mu" mode="fonts">
		<span class="zprefix">
			<span class="zi">
				<span class="symbol">m</span>
			</span>
		</span>
	</xsl:template>


	<!-- Sets -->

	<xsl:template match="z:in" mode="fonts">
		<span class="zinfix">
			<span class="symbol">&#206;</span>
		</span>
	</xsl:template>

	<xsl:template match="z:notin" mode="fonts">
		<span class="zinfix">
			<span class="symbol">&#207;</span>
		</span>
	</xsl:template>

	<xsl:template match="z:emptyset" mode="fonts">
		<span class="symbol">&#198;</span>
	</xsl:template>

	<xsl:template match="z:subseteq" mode="fonts">
		<span class="zinfix">
			<span class="symbol">&#205;</span>
		</span>
	</xsl:template>

	<xsl:template match="z:subset" mode="fonts">
		<span class="zinfix">
			<span class="symbol">&#204;</span>
		</span>
	</xsl:template>

	<xsl:template match="z:power" mode="fonts">
		<span class="zprefix">
			<span class="doublestruck">P</span>
		</span>
	</xsl:template>

	<xsl:template match="z:power_1" mode="fonts">
		<span class="zprefix">
			<span class="doublestruck">P</span>
			<span class="zsmall">
				<sub>1</sub>
			</span>
		</span>
	</xsl:template>

	<xsl:template match="z:cross" mode="fonts">
		<span class="zinfix">
			<span class="symbol">&#180;</span>
		</span>
	</xsl:template>

	<xsl:template match="z:cup" mode="fonts">
		<span class="zinfix">
			<span class="mathb">&#52;</span>
		</span>
	</xsl:template>

	<xsl:template match="z:cap" mode="fonts">
		<span class="zinfix">
			<span class="mathb">&#51;</span>
		</span>
	</xsl:template>

	<xsl:template match="z:setminus" mode="fonts">
		<span class="zinfix">\</span>
	</xsl:template>

	<xsl:template match="z:bigcup" mode="fonts">
		<span class="zprefix">
			<span class="zbig">
				<span class="mathb">&#52;</span>
			</span>
		</span>
	</xsl:template>

	<xsl:template match="z:bigcap" mode="fonts">
		<span class="zprefix">
			<span class="zbig">
				<span class="mathb">&#51;</span>
			</span>
		</span>
	</xsl:template>

	<xsl:template match="z:finset" mode="fonts">
		<span class="zprefix">
			<span class="doublestruck">F</span>
		</span>
	</xsl:template>

	<xsl:template match="z:finset_1" mode="fonts">
		<span class="zprefix">
			<span class="doublestruck">F</span>
			<span class="zsmall">
				<sub>1</sub>
			</span>
		</span>
	</xsl:template>


	<!-- Relations -->

	<xsl:template match="z:rel" mode="fonts">
		<span class="zinfix">
			<span class="mathc">&#118;</span>
		</span>
	</xsl:template>

	<xsl:template match="z:mapsto" mode="fonts">
		<span class="zinfix">
			<span class="mathc">&#120;</span>
		</span>
	</xsl:template>

	<xsl:template match="z:dom | z:ran | z:id" mode="fonts">
		<xsl:apply-templates select="." />
	</xsl:template>

	<xsl:template match="z:comp" mode="fonts">
		<span class="zinfix">;</span>
	</xsl:template>

	<xsl:template match="z:circ" mode="fonts">
		<span class="zinfix">
			<span class="mathb">&#219;</span>
		</span>
	</xsl:template>

	<xsl:template match="z:dres" mode="fonts">
		<span class="zinfix">
			<span class="mathb">&#169;</span>
		</span>
	</xsl:template>

	<xsl:template match="z:rres" mode="fonts">
		<span class="zinfix">
			<span class="mathb">&#168;</span>
		</span>
	</xsl:template>

	<xsl:template match="z:ndres" mode="fonts">
		<span class="mathb" style="position: relative; left: .4em">
			&#169;
		</span>
		<span class="symbol"
			style="position: relative; right: .25em; bottom: .9ex">
			&#95;
		</span>
	</xsl:template>

	<xsl:template match="z:nrres" mode="fonts">
		<span class="symbol"
			style="position: relative; left: .25em; bottom: .9ex">
			&#95;
		</span>
		<span class="mathb" style="position: relative; right: .4em">
			&#168;
		</span>
	</xsl:template>

	<xsl:template match="z:inv | z:plus | z:star" mode="fonts">
		<xsl:apply-templates select="." />
	</xsl:template>

	<xsl:template match="z:limg | z:rimg" mode="fonts">
		<xsl:apply-templates select="." />
	</xsl:template>

	<xsl:template match="z:oplus" mode="fonts">
		<span class="zinfix">
			<span class="mathb">&#47;</span>
		</span>
	</xsl:template>

	<xsl:template match="z:sup" mode="fonts">
		<sup>
			<xsl:apply-templates mode="fonts" />
		</sup>
	</xsl:template>


	<!-- Functions -->

	<xsl:template match="z:lambda" mode="fonts">
		<span class="zprefix">
			<span class="symbol">l</span>
		</span>
	</xsl:template>

	<xsl:template match="z:pfun" mode="fonts">
		<span class="mathc" style="position: relative; left: .2em;">&#116;</span>
		<span class="mathb" style="position: relative; right: .45em;">&#200;</span>
	</xsl:template>

	<xsl:template match="z:fun" mode="fonts">
		<span class="zinfix">
			<span class="mathc">&#116;</span>
		</span>
	</xsl:template>

	<xsl:template match="z:pinj" mode="fonts">
			<span class="mathc" style="position: relative; left: .2em;">&#152;</span>
			<span class="mathb" style="position: relative; right: .4em;">&#200;</span>
	</xsl:template>

	<xsl:template match="z:inj" mode="fonts">
		<span class="zinfix">
			<span class="mathc">&#152;</span>
		</span>
	</xsl:template>

	<xsl:template match="z:psurj" mode="fonts">
			<span class="mathc" style="position: relative; left: .4em">&#137;</span>
			<span class="mathb"
				style="position: relative; right: .4em">
				&#200;
			</span>
	</xsl:template>

	<xsl:template match="z:surj" mode="fonts">
		<span class="zinfix">
			<span class="mathc">&#137;</span>
		</span>
	</xsl:template>

	<!-- use normal symbol since Z symbol is not available -->
	<xsl:template match="z:bij" mode="fonts">
		<span class="zinfix">
			<span class="mathb">&#123;</span>
		</span>
	</xsl:template>

	<xsl:template match="z:ffun" mode="fonts">
			<span class="mathc" style="position: relative; left: .5em;">&#116;</span>
			<span class="mathb"
				style="position: relative; right: .5em;">
				&#201;
			</span>
	</xsl:template>

	<xsl:template match="z:finj" mode="fonts">
			<span class="mathc" style="position: relative; left: .45em;">&#152;</span>
			<span class="mathb"
				style="position: relative; right: .45em;">
				&#201;
			</span>
	</xsl:template>


	<!-- Numbers and arithmetic -->

	<xsl:template match="z:nat" mode="fonts">
		<span class="doublestruck">N</span>
	</xsl:template>

	<xsl:template match="z:num" mode="fonts">
		<span class="doublestruck">Z</span>
	</xsl:template>

	<xsl:template match="z:div | z:mod" mode="fonts">
		<xsl:apply-templates select="." />
	</xsl:template>

	<xsl:template match="z:leq" mode="fonts">
		<span class="zinfix">
			<span class="mathb">
				<xsl:text>&#91;</xsl:text>
			</span>
		</span>
	</xsl:template>

	<xsl:template match="z:geq" mode="fonts">
		<span class="zinfix">
			<span class="mathb">
				<xsl:text>&#109;</xsl:text>
			</span>
		</span>
	</xsl:template>

	<xsl:template match="z:nat_1" mode="fonts">
		<span class="doublestruck">N</span>
		<span class="zsmall">
			<sub>1</sub>
		</span>
	</xsl:template>

	<xsl:template match="z:upto" mode="fonts">
		<span class="zinfix">
			<xsl:text>..</xsl:text>
		</span>
	</xsl:template>


	<!-- Sequences -->

	<xsl:template match="z:seq | z:iseq | z:seq_1" mode="fonts">
		<xsl:apply-templates select="." />
	</xsl:template>

	<xsl:template match="z:langle" mode="fonts">
		<span class="zprefix">
			<span class="symbol">&#225;</span>
		</span>
	</xsl:template>

	<xsl:template match="z:rangle" mode="fonts">
		<span class="zpostfix">
			<span class="symbol">&#241;</span>
		</span>
	</xsl:template>

	<xsl:template match="z:cat" mode="fonts">
		<span class="zinfix">
			<span class="mathb"
				style="position: relative; bottom: 1ex">
				&#102;
			</span>
		</span>
	</xsl:template>

	<xsl:template match="z:extract" mode="fonts">
		<span class="zinfix">
			<span class="mathc">&#150;</span>
		</span>
	</xsl:template>

	<xsl:template match="z:filter" mode="fonts">
		<span class="zinfix">
			<span class="mathc">&#147;</span>
		</span>
	</xsl:template>

	<xsl:template match="z:prefix | z:suffix | z:partition | z:inseq | z:disjoint" mode="fonts">
		<xsl:apply-templates select="." />
	</xsl:template>

	<xsl:template match="z:dcat" mode="fonts">
		<span class="zprefix">
			<span class="mathb"
				style="position: relative; bottom: 1ex">
				&#102;
			</span>
			<span>/</span>
		</span>
	</xsl:template>


	<!-- Bags -->

	<xsl:template match="z:bag" mode="fonts">
		<xsl:apply-templates select="." />
	</xsl:template>

	<xsl:template match="z:lbag" mode="fonts">
		<span class="mathb">&#223;</span>
	</xsl:template>

	<xsl:template match="z:rbag" mode="fonts">
		<span class="mathb">&#224;</span>
	</xsl:template>

	<xsl:template match="z:bcount" mode="fonts">
		<span class="zinfix">
			<span class="mathc">&#204;</span>
		</span>
	</xsl:template>

	<xsl:template match="z:otimes" mode="fonts">
		<span class="zinfix">
			<span class="mathb">&#49;</span>
		</span>
	</xsl:template>

	<xsl:template match="z:inbag" mode="fonts">
		<span class="zinfix">
			<span class="zss">inbag</span>
		</span>
	</xsl:template>

	<xsl:template match="z:subbageq" mode="fonts">
		<span class="zinfix">
			<span class="mathb">&#98;</span>
		</span>
	</xsl:template>

	<xsl:template match="z:uplus" mode="fonts">
		<span class="zinfix">
			<span class="mathb">&#53;</span>
		</span>
	</xsl:template>

	<xsl:template match="z:uminus" mode="fonts">
			<span class="mathb" style="position: relative; left: .3em">&#52;</span>
			<span style="position: relative; right: .4em; top: .1em">
				-
			</span>
	</xsl:template>

</xsl:stylesheet>