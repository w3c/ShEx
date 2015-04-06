<?xml version="1.0" encoding="UTF-8"?>

<!-- Version: $Id: zml2html-symbols-unicode.xsl,v 1.3 2007/05/27 13:49:16 
	aryman Exp $ -->

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

<!-- 2015-04-01: Arthur Ryman <arthur.ryman@gmail.com> - added support for 
	\bind, \lblot, and \rblot. Used standard characters for \data, \rdata, langle, 
	and rangle -->

<!-- 2007-05-27: Arthur Ryman <ryman@ca.ibm.com> - substituted &lt; and &gt; 
	for &lang; and &rang; because Firefox 2.0 isn't rendering them correctly -->

<!-- 2004-12-28: Arthur Ryman <ryman@ca.ibm.com> - added unicode mode attribute 
	to enable co-existence with alternate renderings -->

<!-- 2004-11-16: Arthur Ryman <ryman@ca.ibm.com> - render Z symbols as Unicode 
	characters to be compliant with W3C Character Model -->

<!-- 2004-10-10: Arthur Ryman <ryman @ ca.ibm.com> - simplified ZML to make 
	authoring easier -->

<!DOCTYPE xsl:stylesheet [
<!ENTITY nbsp   "&#160;"> <!-- no-break space = non-breaking space,
                                  U+00A0 ISOnum -->
<!ENTITY laquo  "&#171;"> <!-- left-pointing double angle quotation mark
                                  = left pointing guillemet, U+00AB ISOnum -->
<!ENTITY not    "&#172;"> <!-- not sign = discretionary hyphen,
                                  U+00AC ISOnum -->
<!ENTITY raquo  "&#187;"> <!-- right-pointing double angle quotation mark
                                  = right pointing guillemet, U+00BB ISOnum -->
<!ENTITY times  "&#215;"> <!-- multiplication sign, U+00D7 ISOnum -->
<!ENTITY divide "&#247;"> <!-- division sign, U+00F7 ISOnum -->
<!ENTITY theta    "&#952;"> <!-- greek small letter theta,
                                    U+03B8 ISOgrk3 -->
<!ENTITY lambda   "&#955;"> <!-- greek small letter lambda,
                                    U+03BB ISOgrk3 -->
<!ENTITY mu       "&#956;"> <!-- greek small letter mu, U+03BC ISOgrk3 -->
<!ENTITY bull     "&#8226;"> <!-- bullet = black small circle,
                                     U+2022 ISOpub  -->
<!-- bullet is NOT the same as bullet operator, U+2219 -->
<!ENTITY rarr     "&#8594;"> <!-- rightwards arrow, U+2192 ISOnum -->
<!ENTITY harr     "&#8596;"> <!-- left right arrow, U+2194 ISOamsa -->
<!ENTITY rArr     "&#8658;"> <!-- rightwards double arrow,
                                     U+21D2 ISOtech -->
<!-- Unicode does not say this is the 'implies' character but does not have 
     another character with this function. rArr can be used for 'implies' as 
     ISOtech suggests -->
<!ENTITY hArr     "&#8660;"> <!-- left right double arrow,
                                     U+21D4 ISOamsa -->
<!ENTITY forall   "&#8704;"> <!-- for all, U+2200 ISOtech -->
<!ENTITY exist    "&#8707;"> <!-- there exists, U+2203 ISOtech -->
<!ENTITY empty    "&#8709;"> <!-- empty set = null set = diameter,
                                     U+2205 ISOamso -->
<!ENTITY isin     "&#8712;"> <!-- element of, U+2208 ISOtech -->
<!ENTITY notin    "&#8713;"> <!-- not an element of, U+2209 ISOtech -->
<!ENTITY minus    "&#8722;"> <!-- minus sign, U+2212 ISOtech -->
<!ENTITY and      "&#8743;"> <!-- logical and = wedge, U+2227 ISOtech -->
<!ENTITY or       "&#8744;"> <!-- logical or = vee, U+2228 ISOtech -->
<!ENTITY cap      "&#8745;"> <!-- intersection = cap, U+2229 ISOtech -->
<!ENTITY cup      "&#8746;"> <!-- union = cup, U+222A ISOtech -->
<!ENTITY ne       "&#8800;"> <!-- not equal to, U+2260 ISOtech -->
<!ENTITY le       "&#8804;"> <!-- less-than or equal to, U+2264 ISOtech -->
<!ENTITY ge       "&#8805;"> <!-- greater-than or equal to,
                                     U+2265 ISOtech -->
<!ENTITY sub      "&#8834;"> <!-- subset of, U+2282 ISOtech -->
<!ENTITY sube     "&#8838;"> <!-- subset of or equal to, U+2286 ISOtech -->
<!ENTITY oplus    "&#8853;"> <!-- circled plus = direct sum,
                                     U+2295 ISOamsb -->
<!ENTITY otimes   "&#8855;"> <!-- circled times = vector product,
                                     U+2297 ISOamsb -->
<!ENTITY lang     "&#9001;"> <!-- left-pointing angle bracket = bra,
                                     U+2329 ISOtech -->
<!-- lang is NOT the same character as U+003C 'less than' 
     or U+2039 'single left-pointing angle quotation mark' -->
<!ENTITY rang     "&#9002;"> <!-- right-pointing angle bracket = ket,
                                     U+232A ISOtech -->
<!-- rang is NOT the same character as U+003E 'greater than' 
     or U+203A 'single right-pointing angle quotation mark' -->
]>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:z="http://www.w3.org/2004/zml" exclude-result-prefixes="z"
	version="1.0">

	<xsl:template match="z:sub" mode="unicode">
		<xsl:apply-templates select="." />
	</xsl:template>

	<xsl:template match="z:u" mode="unicode">
		<xsl:apply-templates select="." />
	</xsl:template>

	<xsl:template
		match="z:t1 | z:t2 | z:t3 | z:t4 | z:t5 | z:t6 | z:t7 | z:t8 | z:t9"
		mode="unicode">
		<xsl:apply-templates select="." />
	</xsl:template>

	<xsl:template match="z:lquot | z:rquot" mode="unicode">
		<xsl:apply-templates select="." />
	</xsl:template>

	<xsl:template match="z:lapos | z:rapos" mode="unicode">
		<xsl:apply-templates select="." />
	</xsl:template>

	<xsl:template name="spot-unicode">
		<span class="zinfix">&bull;
		</span>
	</xsl:template>

	<!-- U+2A75 looks like == -->
	<xsl:template name="abbreviation-unicode">
		<span class="zinfix">
			<span class="zdefa">==</span>
		</span>
	</xsl:template>

	<!-- Schema definition \defs -->

	<xsl:template match="z:defs" mode="unicode">
		<span class="zinfix">&#x2259;</span>
	</xsl:template>

	<!-- U+2A74 looks like ::= -->
	<xsl:template name="free-type-unicode">
		<span class="zinfix">::=</span>
	</xsl:template>

	<!-- Free type definition \ldata, \rdata -->

	<!-- U+300A -->
	<xsl:template match="z:ldata" mode="unicode">
		<xsl:text>&#x300A;</xsl:text>
	</xsl:template>

	<!-- U+300B -->
	<xsl:template match="z:rdata" mode="unicode">
		<xsl:text>&#x300B;</xsl:text>
	</xsl:template>

	<!-- Logic and schema calculus -->

	<xsl:template match="z:lnot" mode="unicode">
		<span class="zprefix">&not;
		</span>
	</xsl:template>

	<xsl:template match="z:land" mode="unicode">
		<span class="zinfix">&and;
		</span>
	</xsl:template>

	<xsl:template match="z:lor" mode="unicode">
		<span class="zinfix">&or;
		</span>
	</xsl:template>

	<xsl:template match="z:implies" mode="unicode">
		<span class="zinfix">&rArr;
		</span>
	</xsl:template>

	<xsl:template match="z:iff" mode="unicode">
		<span class="zinfix">&hArr;
		</span>
	</xsl:template>

	<xsl:template match="z:forall" mode="unicode">
		<span class="zprefix">&forall;
		</span>
	</xsl:template>

	<xsl:template match="z:exists" mode="unicode">
		<span class="zprefix">&exist;
		</span>
	</xsl:template>

	<xsl:template match="z:exists_1" mode="unicode">
		<span class="zprefix">&exist;
			<span class="zsmall">
				<sub>1</sub>
			</span>
		</span>
	</xsl:template>

	<!-- Special schema operators -->

	<xsl:template match="z:hide" mode="unicode">
		<span class="zinfix">\</span>
	</xsl:template>

	<xsl:template match="z:project" mode="unicode">
		<span class="zinfix">&#x21BE;</span>
	</xsl:template>

	<xsl:template match="z:pre" mode="unicode">
		<xsl:apply-templates select="." />
	</xsl:template>

	<xsl:template match="z:semi" mode="unicode">
		<span class="zinfix">;</span>
	</xsl:template>

	<xsl:template match="z:pipe" mode="unicode">
		<span class="zinfix">&gt;&gt;</span>
	</xsl:template>

	<!-- Basic expressions -->

	<xsl:template match="z:neq" mode="unicode">
		<span class="zinfix">&ne;
		</span>
	</xsl:template>

	<xsl:template match="z:IF | z:THEN | z:ELSE | z:LET" mode="unicode">
		<xsl:apply-templates select="." />
	</xsl:template>

	<xsl:template match="z:theta" mode="unicode">
		<span class="zprefix">
			<span class="zi">&theta;
			</span>
		</span>
	</xsl:template>

	<xsl:template match="z:mu" mode="unicode">
		<span class="zprefix">
			<span class="zi">&mu;
			</span>
		</span>
	</xsl:template>


	<!-- Sets -->

	<xsl:template match="z:in" mode="unicode">
		<span class="zinfix">&isin;
		</span>
	</xsl:template>

	<xsl:template match="z:notin" mode="unicode">
		<span class="zinfix">&notin;
		</span>
	</xsl:template>

	<xsl:template match="z:emptyset" mode="unicode">
		<xsl:text>&empty;</xsl:text>
	</xsl:template>

	<xsl:template match="z:subseteq" mode="unicode">
		<span class="zinfix">&sube;
		</span>
	</xsl:template>

	<xsl:template match="z:subset" mode="unicode">
		<span class="zinfix">&sub;
		</span>
	</xsl:template>

	<xsl:template match="z:power" mode="unicode">
		<span class="zprefix">&#x2119;</span>
	</xsl:template>

	<xsl:template match="z:power_1" mode="unicode">
		<span class="zprefix">
			&#x2119;
			<span class="zsmall">
				<sub>1</sub>
			</span>
		</span>
	</xsl:template>

	<xsl:template match="z:cross" mode="unicode">
		<span class="zinfix">&times;
		</span>
	</xsl:template>

	<xsl:template match="z:cup" mode="unicode">
		<span class="zinfix">&cup;
		</span>
	</xsl:template>

	<xsl:template match="z:cap" mode="unicode">
		<span class="zinfix">&cap;
		</span>
	</xsl:template>

	<xsl:template match="z:setminus" mode="unicode">
		<span class="zinfix">\</span>
	</xsl:template>

	<xsl:template match="z:bigcup" mode="unicode">
		<span class="zprefix">&#x22C3;</span>
	</xsl:template>

	<xsl:template match="z:bigcap" mode="unicode">
		<span class="zprefix">&#x22C2;</span>
	</xsl:template>

	<xsl:template match="z:finset" mode="unicode">
		<span class="zprefix">&#x1D53D;</span>
	</xsl:template>

	<xsl:template match="z:finset_1" mode="unicode">
		<span class="zprefix">
			&#x1D53D;
			<span class="zsmall">
				<sub>1</sub>
			</span>
		</span>
	</xsl:template>


	<!-- Relations -->

	<xsl:template match="z:rel" mode="unicode">
		<span class="zinfix">&#x2194;</span>
	</xsl:template>

	<xsl:template match="z:mapsto" mode="unicode">
		<span class="zinfix">&#x21A6;</span>
	</xsl:template>

	<xsl:template match="z:dom | z:ran | z:id" mode="unicode">
		<xsl:apply-templates select="." />
	</xsl:template>

	<!-- U+2A3E looks like ; -->
	<xsl:template match="z:comp" mode="unicode">
		<span class="zinfix">;</span>
	</xsl:template>

	<xsl:template match="z:circ" mode="unicode">
		<span class="zinfix">&#x2218;</span>
	</xsl:template>

	<xsl:template match="z:dres" mode="unicode">
		<span class="zinfix">&#x25C1;</span>
	</xsl:template>

	<xsl:template match="z:rres" mode="unicode">
		<span class="zinfix">&#x25B7;</span>
	</xsl:template>

	<xsl:template match="z:ndres" mode="unicode">
		<span class="zinfix">&#x2A64;</span>
	</xsl:template>

	<xsl:template match="z:nrres" mode="unicode">
		<span class="zinfix">&#x2A65;</span>
	</xsl:template>

	<xsl:template match="z:inv | z:plus | z:star" mode="unicode">
		<xsl:apply-templates select="." />
	</xsl:template>

	<xsl:template match="z:limg" mode="unicode">
		<xsl:text>&#x2987;</xsl:text>
	</xsl:template>

	<xsl:template match="z:rimg" mode="unicode">
		<xsl:text>&#x2988;</xsl:text>
	</xsl:template>

	<xsl:template match="z:oplus" mode="unicode">
		<span class="zinfix">&oplus;
		</span>
	</xsl:template>

	<xsl:template match="z:sup" mode="unicode">
		<xsl:apply-templates select="." />
	</xsl:template>


	<!-- Functions -->

	<xsl:template match="z:lambda" mode="unicode">
		<span class="zprefix">
			<span class="zi">&lambda;
			</span>
		</span>
	</xsl:template>

	<xsl:template match="z:pfun" mode="unicode">
		<span class="zinfix">&#x21F8;</span>
	</xsl:template>

	<xsl:template match="z:fun" mode="unicode">
		<span class="zinfix">&rarr;
		</span>
	</xsl:template>

	<xsl:template match="z:pinj" mode="unicode">
		<span class="zinfix">&#x2914;</span>
	</xsl:template>

	<xsl:template match="z:inj" mode="unicode">
		<span class="zinfix">&#x21A3;</span>
	</xsl:template>

	<xsl:template match="z:psurj" mode="unicode">
		<span class="zinfix">&#x2900;</span>
	</xsl:template>

	<xsl:template match="z:surj" mode="unicode">
		<span class="zinfix">&#x21A0;</span>
	</xsl:template>

	<xsl:template match="z:bij" mode="unicode">
		<span class="zinfix">&#x2916;</span>
	</xsl:template>

	<xsl:template match="z:ffun" mode="unicode">
		<span class="zinfix">&#x21FB;</span>
	</xsl:template>

	<xsl:template match="z:finj" mode="unicode">
		<span class="zinfix">&#x2918;</span>
	</xsl:template>


	<!-- Numbers and arithmetic -->

	<xsl:template match="z:nat" mode="unicode">
		<xsl:text>&#x2115;</xsl:text>
	</xsl:template>

	<xsl:template match="z:num" mode="unicode">
		<xsl:text>&#x2124;</xsl:text>
	</xsl:template>

	<xsl:template match="z:div | z:mod" mode="unicode">
		<xsl:apply-templates select="." />
	</xsl:template>

	<xsl:template match="z:leq" mode="unicode">
		<span class="zinfix">&#x2264;</span>
	</xsl:template>

	<xsl:template match="z:geq" mode="unicode">
		<span class="zinfix">&#x2265;</span>
	</xsl:template>

	<xsl:template match="z:nat_1" mode="unicode">
		<xsl:text>&#x2115;</xsl:text>
		<span class="zsmall">
			<sub>1</sub>
		</span>
	</xsl:template>

	<xsl:template match="z:upto" mode="unicode">
		<span class="zinfix">..</span>
	</xsl:template>


	<!-- Sequences -->

	<xsl:template match="z:seq | z:iseq | z:seq_1" mode="unicode">
		<xsl:apply-templates select="." />
	</xsl:template>

	<!-- U+2329 -->
	<xsl:template match="z:langle" mode="unicode">
		<xsl:text>&#x2329;</xsl:text>
	</xsl:template>

	<!-- U+232A -->
	<xsl:template match="z:rangle" mode="unicode">
		<xsl:text>&#x232A;</xsl:text>
	</xsl:template>

	<xsl:template match="z:cat" mode="unicode">
		<span class="zinfix">&#x2312;</span>
	</xsl:template>

	<xsl:template match="z:extract" mode="unicode">
		<span class="zinfix">&#x21BF;</span>
	</xsl:template>

	<xsl:template match="z:filter" mode="unicode">
		<span class="zinfix">&#x21BE;</span>
	</xsl:template>

	<xsl:template
		match="z:prefix | z:suffix | z:partition | z:inseq | z:disjoint" mode="unicode">
		<xsl:apply-templates select="." />
	</xsl:template>

	<xsl:template match="z:dcat" mode="unicode">
		<span class="zprefix">&#x2312;/</span>
	</xsl:template>


	<!-- Bags -->

	<xsl:template match="z:bag" mode="unicode">
		<xsl:apply-templates select="." />
	</xsl:template>

	<xsl:template match="z:lbag" mode="unicode">
		<xsl:text>&#x27E6;</xsl:text>
	</xsl:template>

	<xsl:template match="z:rbag" mode="unicode">
		<xsl:text>&#x27E7;</xsl:text>
	</xsl:template>

	<!-- no Unicode - looks like # -->
	<xsl:template match="z:bcount" mode="unicode">
		<span class="zinfix">#</span>
	</xsl:template>

	<xsl:template match="z:otimes" mode="unicode">
		<span class="zinfix">&otimes;
		</span>
	</xsl:template>

	<xsl:template match="z:inbag" mode="unicode">
		<span class="zinfix">&#x22FF;</span>
	</xsl:template>

	<xsl:template match="z:subbageq" mode="unicode">
		<span class="zinfix">&#x2291;</span>
	</xsl:template>

	<xsl:template match="z:uplus" mode="unicode">
		<span class="zinfix">&#x228E;</span>
	</xsl:template>

	<!-- no Unicode - looks like &cup; overstruck with - -->
	<xsl:template match="z:uminus" mode="unicode">
		<span class="zpostfix">&cup;
			<span style="position: relative; right: .55em;">-</span>
		</span>
	</xsl:template>

	<!-- symbols about specifications -->

	<xsl:template match="z:bind" mode="unicode">
		<span class="zinfix">&#x21DB;</span>
	</xsl:template>

	<xsl:template match="z:lblot" mode="unicode">
		<xsl:text>&#x2989;</xsl:text>
	</xsl:template>

	<xsl:template match="z:rblot" mode="unicode">
		<xsl:text>&#x298A;</xsl:text>
	</xsl:template>

</xsl:stylesheet>