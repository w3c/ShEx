<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:html="http://www.w3.org/1999/xhtml" xmlns:z="http://www.w3.org/2004/zml"
	xmlns:local="http://www.w3.org/2004/zml/local" exclude-result-prefixes="html"
	version="1.0">

	<xsl:output method="xml" />

	<!-- The list of all LaTeX commands that map to zml elements -->
	<!-- If two or more commands start with the same substring, put the longest 
		first -->
	<z:commands>
		<z:ELSE />
		<z:IF />
		<z:LET />
		<z:THEN />
		<z:also />
		<z:bag />
		<z:bcount />
		<z:bigcap />
		<z:bigcup />
		<z:bij />
		<z:bind />
		<z:cap />
		<z:cat />
		<z:circ />
		<z:comp />
		<z:cross />
		<z:cup />
		<z:dcat />
		<z:defs />
		<z:disjoint />
		<z:div />
		<z:dom />
		<z:dres />
		<z:emptyset />
		<z:exists_1 />
		<z:exists />
		<z:extract />
		<z:ffun />
		<z:filter />
		<z:finj />
		<z:finset_1 />
		<z:finset />
		<z:forall />
		<z:fun />
		<z:geq />
		<z:hide />
		<z:id />
		<z:iff />
		<z:inbag />
		<z:inj />
		<z:inseq />
		<z:inv />
		<z:in />
		<z:implies />
		<z:iseq />
		<z:lambda />
		<z:land />
		<z:langle />
		<z:lbag />
		<z:lblot />
		<z:ldata />
		<z:leq />
		<z:limg />
		<z:lnot />
		<z:lor />
		<z:mapsto />
		<z:mid />
		<z:mod />
		<z:mu />
		<z:nat_1 />
		<z:nat />
		<z:ndres />
		<z:neq />
		<z:notin />
		<z:nrres />
		<z:num />
		<z:oplus />
		<z:otimes />
		<z:partition />
		<z:pfun />
		<z:pinj />
		<z:pipe />
		<z:plus />
		<z:power_1 />
		<z:power />
		<z:prefix />
		<z:pre />
		<z:project />
		<z:psurj />
		<z:rangle />
		<z:ran />
		<z:rbag />
		<z:rblot />
		<z:rdata />
		<z:rel />
		<z:rimg />
		<z:rres />
		<z:semi />
		<z:seq_1 />
		<z:seq />
		<z:setminus />
		<z:spot />
		<z:star />
		<z:subbageq />
		<z:subseteq />
		<z:suffix />
		<z:surj />
		<z:theta />
		<z:t1 />
		<z:t2 />
		<z:t3 />
		<z:t4 />
		<z:t5 />
		<z:t6 />
		<z:t7 />
		<z:t8 />
		<z:t9 />
		<z:uminus />
		<z:uplus />
		<z:upto />
		<z:where />
	</z:commands>

	<xsl:variable name="commands" select="document('')//z:commands/*" />

	<xsl:variable name="local-commands"
		select="document('local-commands.xml')//commands/command" />

	<xsl:template match="/">
		<xsl:apply-templates />
	</xsl:template>

	<!-- Convert each Z source element to zml -->
	<xsl:template match="html:pre[@class='Z-source'] | html:pre[@class='Z-source Z-syntax']">

		<!-- convert the LaTeX Z source to zml -->
		<xsl:call-template name="convert-latex-to-zml">
			<xsl:with-param name="latex" select="normalize-space()" />
		</xsl:call-template>

		<!-- copy the <pre> element that contains the LaTeX Z source -->
		<xsl:copy-of select="." />

	</xsl:template>

	<!-- Copy all the non-Z source elements -->
	<xsl:template match="*|@*|text()">
		<xsl:copy>
			<xsl:apply-templates select="*|@*|text()" />
		</xsl:copy>
	</xsl:template>

	<!-- Converts a LaTeX Z source paragraph to zml. -->
	<!-- assume that each Z paragraph is syntactically correct -->
	<xsl:template name="convert-latex-to-zml">
		<xsl:param name="latex" />

		<!-- assume each Z source element contains a single paragraph -->
		<!-- there are four possible kinds of paragraph: axdef, gendef, schema, 
			and zed -->
		<xsl:choose>
			<xsl:when test="starts-with($latex,'\begin{axdef}')">
				<xsl:call-template name="convert-axdef-to-zml">
					<xsl:with-param name="latex" select="$latex" />
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="starts-with($latex,'\begin{gendef}')">
				<xsl:call-template name="convert-gendef-to-zml">
					<xsl:with-param name="latex" select="$latex" />
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="starts-with($latex,'\begin{schema}')">
				<xsl:call-template name="convert-schema-to-zml">
					<xsl:with-param name="latex" select="$latex" />
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="starts-with($latex,'\begin{zed}')">
				<xsl:call-template name="convert-zed-to-zml">
					<xsl:with-param name="latex" select="$latex" />
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="starts-with($latex,'\begin{syntax}')">
				<xsl:call-template name="convert-syntax-to-zml">
					<xsl:with-param name="latex" select="$latex" />
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<div class="err">Unrecognized Z Notation paragraph. Must be one of
					axdef, gendef, schema, or zed.</div>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- Converts a LaTeX \begin{axdef} ... \end{axdef} paragraph to zml -->
	<xsl:template name="convert-axdef-to-zml">

		<!-- latex ::= \begin{axdef} paragraph \end{axdef} -->
		<xsl:param name="latex" />

		<!-- strip out the surrounding \begin{axdef} and \end{axdef} commands -->
		<xsl:variable name="paragraph"
			select="normalize-space(substring-before(substring-after($latex,'\begin{axdef}'),'\end{axdef}'))" />

		<!-- write element <z:axdef> paragraph </z:axdef> -->
		<xsl:element name="axdef" namespace="http://www.w3.org/2004/zml">
			<xsl:call-template name="convert-paragraph-to-zml">
				<xsl:with-param name="paragraph" select="$paragraph" />
			</xsl:call-template>
		</xsl:element>

	</xsl:template>

	<!-- Converts a LaTeX \begin{gendef} ... \end{gendef} paragraph to zml -->
	<xsl:template name="convert-gendef-to-zml">

		<!-- latex ::= \begin{gendef}[params] paragraph \end{gendef} -->
		<!-- [params] is optional -->
		<xsl:param name="latex" />

		<!-- strip out the surrounding \begin{gendef} and \end{gendef} commands -->
		<xsl:variable name="params-paragraph"
			select="normalize-space(substring-before(substring-after($latex,'\begin{gendef}'),'\end{gendef}'))" />

		<!-- write element <z:gendef params="params"> paragraph </z:gendef> -->
		<xsl:element name="gendef" namespace="http://www.w3.org/2004/zml">
			<xsl:call-template name="convert-params-paragraph-to-zml">
				<xsl:with-param name="params-paragraph" select="$params-paragraph" />
			</xsl:call-template>
		</xsl:element>

	</xsl:template>

	<!-- Converts a LaTeX \begin{schema} ... \end{schema} paragraph to zml -->
	<xsl:template name="convert-schema-to-zml">

		<!-- latex ::= \begin{schema}{name}[params] paragraph \end{schema} -->
		<!-- [params] is optional -->
		<xsl:param name="latex" />

		<!-- strip out the surrounding \begin{schema} and \end{schema} commands -->
		<xsl:variable name="name-params-paragraph"
			select="normalize-space(substring-before(substring-after($latex,'\begin{schema}'),'\end{schema}'))" />

		<!-- pull out the name -->
		<xsl:variable name="name"
			select="normalize-space(substring-before(substring-after($name-params-paragraph,'{'),'}'))" />

		<!-- drop the leading {name} -->
		<xsl:variable name="params-paragraph"
			select="normalize-space(substring-after($name-params-paragraph,'}'))" />

		<!-- write element <z:schema name="name" params="params"> paragraph </z:schema> -->
		<xsl:element name="schema" namespace="http://www.w3.org/2004/zml">
			<xsl:attribute name="name">
				<xsl:value-of select="$name" />
			</xsl:attribute>
			<xsl:call-template name="convert-params-paragraph-to-zml">
				<xsl:with-param name="params-paragraph" select="$params-paragraph" />
			</xsl:call-template>
		</xsl:element>

	</xsl:template>

	<!-- Converts a LaTeX \begin{zed} ... \end{zed} paragraph to zml -->
	<xsl:template name="convert-zed-to-zml">

		<!-- latex ::= \begin{zed} paragraph \end{zed} -->
		<xsl:param name="latex" />

		<!-- strip out the surrounding \begin{zed} and \end{zed} commands -->
		<xsl:variable name="paragraph"
			select="normalize-space(substring-before(substring-after($latex,'\begin{zed}'),'\end{zed}'))" />

		<!-- write element <z:zed> paragraph </z:zed> -->
		<xsl:element name="zed" namespace="http://www.w3.org/2004/zml">
			<xsl:call-template name="convert-paragraph-to-zml">
				<xsl:with-param name="paragraph" select="$paragraph" />
			</xsl:call-template>
		</xsl:element>

	</xsl:template>

	<!-- Converts a LaTeX \begin{syntax} ... \end{syntax} paragraph to zml -->
	<xsl:template name="convert-syntax-to-zml">

		<!-- latex ::= \begin{syntax} paragraph \end{syntax} -->
		<xsl:param name="latex" />

		<!-- strip out the surrounding \begin{syntax} and \end{syntax} commands -->
		<xsl:variable name="paragraph"
			select="normalize-space(substring-before(substring-after($latex,'\begin{syntax}'),'\end{syntax}'))" />

		<!-- write element <z:syntax> paragraph </z:syntax> -->
		<xsl:element name="syntax" namespace="http://www.w3.org/2004/zml">
			<xsl:call-template name="convert-paragraph-to-zml">
				<xsl:with-param name="paragraph" select="$paragraph" />
			</xsl:call-template>
		</xsl:element>

	</xsl:template>

	<!-- Converts [params]paragraph to zml -->
	<xsl:template name="convert-params-paragraph-to-zml">

		<!-- params-paragraph ::= [params] paragraph -->
		<!-- [params] is options -->
		<xsl:param name="params-paragraph" />

		<!-- check for the optional formal parameters [params] -->
		<xsl:choose>
			<xsl:when test="starts-with($params-paragraph,'[')">

				<!-- there is a leading [params] -->

				<!-- pull out the params -->
				<xsl:variable name="params"
					select="normalize-space(substring-before(substring-after($params-paragraph,'['),']'))" />

				<!-- drop the leading [params] -->
				<xsl:variable name="paragraph"
					select="normalize-space(substring-after($params-paragraph,']'))" />

				<xsl:attribute name="params">
						<xsl:value-of select="$params" />
					</xsl:attribute>
				<xsl:call-template name="convert-paragraph-to-zml">
					<xsl:with-param name="paragraph" select="$paragraph" />
				</xsl:call-template>

			</xsl:when>
			<xsl:otherwise>

				<!-- there is no leading [params] -->
				<xsl:call-template name="convert-paragraph-to-zml">
					<xsl:with-param name="paragraph" select="$params-paragraph" />
				</xsl:call-template>

			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- Converts a LaTeX Z paragraph to zml -->
	<xsl:template name="convert-paragraph-to-zml">
		<xsl:param name="paragraph" />
		<xsl:if test="$paragraph">
			<!-- the paragraph is non-empty so convert it -->
			<xsl:choose>

				<!-- does the paragraph contain a command (\...)? -->
				<xsl:when test="contains($paragraph,'\')">
					<xsl:call-template name="convert-no-command-to-zml">
						<xsl:with-param name="paragraph"
							select="substring-before($paragraph,'\')" />
					</xsl:call-template>
					<xsl:call-template name="convert-command-to-zml">
						<xsl:with-param name="paragraph"
							select="substring-after($paragraph,'\')" />
					</xsl:call-template>
				</xsl:when>

				<xsl:otherwise>
					<xsl:call-template name="convert-no-command-to-zml">
						<xsl:with-param name="paragraph" select="$paragraph" />
					</xsl:call-template>
				</xsl:otherwise>

			</xsl:choose>
		</xsl:if>
	</xsl:template>

	<!-- Converts a LaTeX Z string that does not contain a command (\...) to 
		zml -->
	<xsl:template name="convert-no-command-to-zml">
		<xsl:param name="paragraph" />
		<xsl:choose>

			<!-- does the paragraph contain a superscript? -->
			<xsl:when test="contains($paragraph,'^')">
				<xsl:text>TO DO: Handle the superscript.</xsl:text>
				<xsl:value-of select="$paragraph" />
			</xsl:when>

			<!-- the paragraph contains plain text so write it out -->
			<xsl:otherwise>
				<xsl:value-of select="$paragraph" />
			</xsl:otherwise>

		</xsl:choose>
	</xsl:template>

	<!-- Converts a LaTeX Z string that starts with a command to zml -->
	<xsl:template name="convert-command-to-zml">
		<xsl:param name="paragraph" />
		<xsl:choose>

			<!-- test for a newline \\ -->
			<xsl:when test="starts-with($paragraph,'\')">
				<xsl:element name="nl" namespace="http://www.w3.org/2004/zml" />
				<xsl:call-template name="convert-paragraph-to-zml">
					<xsl:with-param name="paragraph" select="substring($paragraph,2)" />
				</xsl:call-template>
			</xsl:when>

			<!-- test for an underscore \_ -->
			<xsl:when test="starts-with($paragraph,'_')">
				<xsl:element name="u" namespace="http://www.w3.org/2004/zml" />
				<xsl:call-template name="convert-paragraph-to-zml">
					<xsl:with-param name="paragraph" select="substring($paragraph,2)" />
				</xsl:call-template>
			</xsl:when>

			<!-- test for a \# or \{ or \} -->
			<xsl:when
				test="starts-with($paragraph,'#') or starts-with($paragraph,'{') or starts-with($paragraph,'}')">
				<xsl:value-of select="substring($paragraph,1,1)" />
				<xsl:call-template name="convert-paragraph-to-zml">
					<xsl:with-param name="paragraph" select="substring($paragraph,2)" />
				</xsl:call-template>
			</xsl:when>

			<xsl:otherwise>
				<!-- look up the command -->
				<xsl:variable name="command"
					select="$commands[starts-with($paragraph,local-name(.))][1]" />
				<xsl:variable name="local-name" select="local-name($command)" />
				<xsl:choose>
					<!-- test for a known command -->
					<xsl:when test="$command">
						<xsl:choose>
							<xsl:when test="$local-name='mid'">
								<xsl:text>|</xsl:text>
							</xsl:when>
							<xsl:when test="$local-name='spot'">
								<xsl:text>@</xsl:text>
							</xsl:when>
							<xsl:otherwise>
								<xsl:element name="{$local-name}" namespace="http://www.w3.org/2004/zml" />
							</xsl:otherwise>
						</xsl:choose>
						<xsl:call-template name="convert-paragraph-to-zml">
							<xsl:with-param name="paragraph"
								select="substring-after($paragraph,$local-name)" />
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<xsl:variable name="local-command"
							select="$local-commands[starts-with($paragraph,@name)][1]" />
						<xsl:choose>
							<xsl:when test="$local-command">
								<xsl:element name="{$local-command/@name}"
									namespace="http://www.w3.org/2004/zml/local" />
								<xsl:call-template name="convert-paragraph-to-zml">
									<xsl:with-param name="paragraph"
										select="substring-after($paragraph,$local-command/@name)" />
								</xsl:call-template>
							</xsl:when>
							<xsl:otherwise>
								<div class="err">
									<xsl:text>Unknown LaTeX command: \</xsl:text>
									<xsl:value-of select="$paragraph" />
									<xsl:text>. Add entry in local-commands.xml</xsl:text>
								</div>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>

		</xsl:choose>
	</xsl:template>

</xsl:stylesheet>