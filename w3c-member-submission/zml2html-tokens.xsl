<?xml version="1.0" encoding="UTF-8"?>

<!-- Version: $Id: zml2html-tokens.xsl,v 1.3 2004/12/31 22:03:03 aryman Exp $ -->

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

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

	<!--
		A text node contains a sequence of zero or more words separated by whitespace.
		Leading and trailing whitespace is insignificant.
		A sequence of 1 or more whitespace characters is equivalent to a single space.
		
		A word is a sequence of identifiers, numbers, and operators.
		
		An identifier is a sequence of 1 or more letters and digits, beginning with a letter
		and ending at a punctuation character or the end of the word.
		
		A number is a sequence of 1 or more digits, ending at a punctuation
		character, or the end of the word.
		
		An operator is a sequence of 1 or more punctuation characters, ending at a letter,
		digit, or the end of the word.
	-->

	<xsl:template match="text()" mode="latex">
		<xsl:call-template name="parse-words">
			<xsl:with-param name="words" select="normalize-space()" />
		</xsl:call-template>
	</xsl:template>

	<!-- 
		Outputs the sequence of identifiers, numbers, operators and spaces
		contained in a string in which the whitespace has been normalized.
		
		$words - the input string
	-->

	<xsl:template name="parse-words">
		<xsl:param name="words" />
		<xsl:choose>
			<xsl:when test="contains($words,' ')">
				<xsl:call-template name="parse-word">
					<xsl:with-param name="word" select="substring-before($words,' ')" />
				</xsl:call-template>
				<xsl:value-of select="' '" />
				<xsl:call-template name="parse-words">
					<xsl:with-param name="words" select="substring-after($words,' ')" />
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="parse-word">
					<xsl:with-param name="word" select="$words" />
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- All letters are folded into the letter 'A'. -->
	<xsl:variable name="ABC">ABCDEFGHIJKLMNOPQRSTUVWXYZ</xsl:variable>
	<xsl:variable name="abc">abcdefghijklmnopqrstuvwxyz</xsl:variable>
	<xsl:variable name="AAA">AAAAAAAAAAAAAAAAAAAAAAAAAA</xsl:variable>

	<!-- All digits are folded into the digit '0'. -->
	<xsl:variable name="digits">0123456789</xsl:variable>
	<xsl:variable name="zeroes">0000000000</xsl:variable>

	<!-- All punctuation characters are folded into the character '.'. -->
	<xsl:variable name="punctuation">`-=~!@#$%^*()_+[]\{}|;:,./?&amp;&lt;&gt;&quot;&apos;</xsl:variable>
	<xsl:variable name="dots">................................</xsl:variable>

	<!-- Characters get folded from the source string to the dest string -->
	<xsl:variable name="source" select="concat($ABC,$abc,$digits,$punctuation)" />
	<xsl:variable name="dest" select="concat($AAA,$AAA,$zeroes,$dots)" />

	<!-- 
		Outputs the sequence of identifiers, numbers, and operators
		contained in a word.
		
		$word - the word
	-->
	<xsl:template name="parse-word">
		<xsl:param name="word" />
		<xsl:if test="$word">
			<xsl:variable name="folded" select="translate($word,$source,$dest)" />
			<xsl:call-template name="parse-word2">
				<xsl:with-param name="word" select="$word" />
				<xsl:with-param name="folded" select="$folded" />
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	<!-- 
		Outputs the sequence of identifiers, numbers, and operators
		contained in a word.
		
		$word - the word
		$folded - the folded word
	-->
	<xsl:template name="parse-word2">
		<xsl:param name="word" />
		<xsl:param name="folded" />
		<xsl:choose>
			<xsl:when test="starts-with($folded,'A')">
				<xsl:call-template name="parse-identifier-word2">
					<xsl:with-param name="word" select="$word" />
					<xsl:with-param name="folded" select="$folded" />
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="starts-with($folded,'0')">
				<xsl:call-template name="parse-number-word2">
					<xsl:with-param name="word" select="$word" />
					<xsl:with-param name="folded" select="$folded" />
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="parse-operators-word2">
					<xsl:with-param name="word" select="$word" />
					<xsl:with-param name="folded" select="$folded" />
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!--
		Outputs the sequence of identifiers, numbers, and operators
		contained in a word that begins with an identifier.
		
		$word - the word
		$folded - the folded word
	-->

	<xsl:template name="parse-identifier-word2">
		<xsl:param name="word" />
		<xsl:param name="folded" />
		<xsl:variable name="idlen">
			<xsl:choose>
				<xsl:when test="contains($folded,'.')">
					<xsl:value-of select="string-length(substring-before($folded,'.'))" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="string-length($folded)" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:call-template name="output-identifier">
			<xsl:with-param name="identifier" select="substring($word, 1, $idlen)" />
		</xsl:call-template>
		<xsl:if test="$idlen &lt; string-length($word)">
			<xsl:call-template name="parse-word2">
				<xsl:with-param name="word" select="substring($word,$idlen+1)" />
				<xsl:with-param name="folded" select="substring($folded,$idlen+1)" />
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	<!--
		Outputs the sequence of identifiers, numbers, and operators
		contained in a word that begins with a number.
		
		$word - the word
		$folded - the folded word
	-->

	<xsl:template name="parse-number-word2">
		<xsl:param name="word" />
		<xsl:param name="folded" />
		<xsl:variable name="numlen">
			<xsl:choose>
				<xsl:when test="contains($folded,'.')">
					<xsl:value-of select="string-length(substring-before($folded,'.'))" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="string-length($folded)" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:call-template name="output-number">
			<xsl:with-param name="number" select="substring($word,1, $numlen)" />
		</xsl:call-template>
		<xsl:if test="$numlen &lt; string-length($word)">
			<xsl:call-template name="parse-word2">
				<xsl:with-param name="word" select="substring($word,$numlen+1)" />
				<xsl:with-param name="folded" select="substring($folded,$numlen+1)" />
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	<!--
		Outputs the sequence of identifiers, numbers, and operators
		contained in a word that begins with operators.
		
		$word - the word
		$folded - the folded word
	-->

	<xsl:template name="parse-operators-word2">
		<xsl:param name="word" />
		<xsl:param name="folded" />
		<xsl:variable name="oplen">
			<xsl:choose>
				<xsl:when test="contains($folded,'A')">
					<xsl:variable name="alen" select="string-length(substring-before($folded,'A'))" />
					<xsl:choose>
						<xsl:when test="contains($folded,'0')">
							<xsl:variable name="nlen" select="string-length(substring-before($folded,'0'))" />
							<xsl:choose>
								<xsl:when test="$alen &lt; $nlen">
									<xsl:value-of select="$alen" />
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$nlen" />
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="$alen" />
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="string-length($folded)" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:call-template name="output-operators">
			<xsl:with-param name="operators" select="substring($word,1,$oplen)" />
		</xsl:call-template>
		<xsl:if test="$oplen &lt; string-length($word)">
			<xsl:call-template name="parse-word2">
				<xsl:with-param name="word" select="substring($word,$oplen+1)" />
				<xsl:with-param name="folded" select="substring($folded,$oplen+1)" />
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	<!-- 
		Outputs an identifier string. 
		
		$identifier - the identifier string
	-->

	<xsl:template name="output-identifier">
		<xsl:param name="identifier" />
		<span class="zi">
			<xsl:value-of select="$identifier" />
		</span>
	</xsl:template>

	<!--
		Outputs an operator string.
		
		$operators - the operator string
	-->

	<xsl:template name="output-operators">
		<xsl:param name="operators" />
		<xsl:if test="$operators">
			<xsl:choose>
				<xsl:when test="starts-with($operators,'::=')">
					<xsl:call-template name="free-type" />
					<xsl:call-template name="output-operators">
						<xsl:with-param name="operators" select="substring($operators,4)" />
					</xsl:call-template>
				</xsl:when>
				<xsl:when test="starts-with($operators,'==')">
					<xsl:call-template name="abbreviation" />
					<xsl:call-template name="output-operators">
						<xsl:with-param name="operators" select="substring($operators,3)" />
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="output-operators1">
						<xsl:with-param name="operators" select="$operators" />
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:template>

	<xsl:template name="output-operators1">
		<xsl:param name="operators" />
		<xsl:variable name="op" select="substring($operators,1,1)" />
		<xsl:choose>
			<xsl:when test="$op = '~'">
				<xsl:text>&#160;</xsl:text>
			</xsl:when>
			<xsl:when test="$op = '@'">
				<xsl:call-template name="spot"/>
			</xsl:when>
			<xsl:when test="$op = ':' or $op = '|' or $op = '=' or $op = '+' or $op = '-' or $op = '*' or $op = '&lt;' or $op = '&gt;'">
				<span class="zinfix">
					<xsl:value-of select="$op" />
				</span>
			</xsl:when>
			<xsl:when test="$op = ','">
				<span class="zprefix">
					<xsl:value-of select="$op" />
				</span>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$op" />
			</xsl:otherwise>
		</xsl:choose>
		<xsl:call-template name="output-operators">
			<xsl:with-param name="operators" select="substring($operators,2)" />
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template name="spot">
		<xsl:choose>
			<xsl:when test="$renderAs='fonts'">
				<xsl:call-template name="spot-fonts"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="spot-unicode"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="abbreviation">
		<xsl:choose>
			<xsl:when test="$renderAs='fonts'">
				<xsl:call-template name="abbreviation-fonts"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="abbreviation-unicode"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="free-type">
		<xsl:choose>
			<xsl:when test="$renderAs='fonts'">
				<xsl:call-template name="free-type-fonts"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="free-type-unicode"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!--
		Outputs a number string.
		
		$number - the number string
	-->

	<xsl:template name="output-number">
		<xsl:param name="number" />
		<xsl:value-of select="$number" />
	</xsl:template>

</xsl:stylesheet>
