<?xml version='1.0'?>

<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
    xmlns:xml="http://www.w3.org/XML/1998/namespace"
    xmlns:exsl="http://exslt.org/common"
    xmlns:date="http://exslt.org/dates-and-times"
    extension-element-prefixes="exsl date"
>

<xsl:import href="../xsl/mathbook-html.xsl" />

<xsl:output method="html" encoding="utf-8"/>

<xsl:template match="pretext">
  <xsl:apply-templates select="article" />
</xsl:template>

<xsl:template match="article|book">
  <xsl:apply-templates select="slideshow" />
</xsl:template>

<xsl:template match="slideshow" mode="is-structural">
    <xsl:value-of select="true()" />
</xsl:template>

<xsl:variable name="chunk-level">
    <xsl:text>0</xsl:text>
</xsl:variable>


<xsl:output method="html" indent="yes" encoding="UTF-8" doctype-system="about:legacy-compat"/>

<xsl:template match="slideshow">
	<html>
	<head>
	<title><xsl:apply-templates select="." mode="title-full" /></title>
	<!-- metadata -->
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=yes"></meta>
  <link href="css/reset.css" rel="stylesheet"></link>
  <link href="css/reveal.css" rel="stylesheet"></link>
  <link href="css/theme/simple.css" rel="stylesheet"></link>
  <link href="plugin/title-footer/title-footer.css" rel="stylesheet"></link>

  <!--  Some style changes from regular pretext-html -->
  <style>
    ul {
      display: block !important;
    }
    .reveal img {
      border: 0.5px !important;
      border-radius: 2px 10px 2px;
      padding: 4px;
    }
  </style>

	</head>

	<body>
    <div class="reveal">
      <div class="slides">
      <xsl:apply-templates select="." mode="title-slide" />
      <xsl:apply-templates select="section"/>
    </div>
  </div>
	</body>

  <script src="js/reveal.js"></script>

  <script>
    Reveal.initialize({
    				controls: false,
    				progress: false,
    				center: false,
    				hash: true,
    				transition: 'fade',
            width: "80%",
            height: "90%",
    				dependencies: [
    					{ src: 'plugin/markdown/marked.js', condition: function() { return !!document.querySelector( '[data-markdown]' ); } },
    					{ src: 'plugin/markdown/markdown.js', condition: function() { return !!document.querySelector( '[data-markdown]' ); } },
    					{ src: 'plugin/highlight/highlight.js', async: true },
    					{ src: 'plugin/search/search.js', async: true },
    					{ src: 'plugin/zoom-js/zoom.js', async: true },
    					{ src: 'plugin/notes/notes.js', async: true },
              { src: 'plugin/title-footer/title-footer.js', async: true, callback: function() {title_footer.initialize('', ''); } },
              { src: 'plugin/math/math.js', async: true },
              ]
            });
  </script>

	</html>

</xsl:template>

<xsl:template match="section">
  <section>
    <xsl:apply-templates select="slide"/>
  </section>
</xsl:template>

<xsl:template match="slideshow" mode="title-slide">
	<section>
		<h1>
      <xsl:apply-templates select="." mode="title-full" />
    </h1>
		<h2>
      <xsl:apply-templates select="." mode="subtitle" />
    </h2>

    <xsl:apply-templates select="." mode="author-list"/>

	</section>
</xsl:template>

<xsl:template match="slideshow" mode="author-list">
  <table>
  <tr>
  <xsl:for-each select="frontmatter/titlepage/author">
    <th align="center" style="border-bottom: 0px;"><xsl:value-of select="personname"/></th>
  </xsl:for-each>
</tr>
  <tr>
  <xsl:for-each select="frontmatter/titlepage/author">
    <td align="center" style="border-bottom: 0px;"><xsl:value-of select="affiliation|institution"/></td>
  </xsl:for-each>
</tr>
<tr>
  <xsl:for-each select="frontmatter/titlepage/author">
    <td align="center"><xsl:apply-templates select="logo" /></td>
  </xsl:for-each>
  </tr>
</table>
</xsl:template>

<xsl:template match="slide">
	<section>
		<h2>
			<xsl:apply-templates select="." mode="title-full" />
		</h2>
		<div align="left">
			<xsl:apply-templates/>
		</div>
	</section>
</xsl:template>

<xsl:template match="ul">
  <ul>
    <xsl:apply-templates/>
  </ul>
</xsl:template>

<xsl:template match="ol">
  <ol>
    <xsl:apply-templates/>
  </ol>
</xsl:template>

<xsl:template match="li">
  <xsl:choose>
  <xsl:when test="../@slide-step">
    <li class="fragment">
      <xsl:apply-templates/>
    </li>
  </xsl:when>
  <xsl:otherwise>
    <li>
      <xsl:apply-templates/>
    </li>
  </xsl:otherwise>
</xsl:choose>
</xsl:template>

<xsl:template match="p">
  <xsl:choose>
  <xsl:when test="@slide-step">
    <p class="fragment">
      <xsl:apply-templates/>
    </p>
  </xsl:when>
  <xsl:otherwise>
    <p>
      <xsl:apply-templates/>
    </p>
  </xsl:otherwise>
</xsl:choose>
</xsl:template>


<xsl:template match="img">
  <img>
    <xsl:attribute name="src">
        <xsl:value-of select="@src" />
    </xsl:attribute>
    <xsl:attribute name="width">
        <xsl:value-of select="@width" />
    </xsl:attribute>
    <xsl:attribute name="height">
        <xsl:value-of select="@height" />
    </xsl:attribute>
    <xsl:apply-templates/>
  </img>
</xsl:template>

<xsl:template match="sidebyside">
<div style="display: table;">
  <xsl:for-each select="*">
    <div>
      <xsl:attribute name="style">
        <xsl:text>display:table-cell; vertical-align:top; width: </xsl:text>
          <xsl:value-of select="../@width" />
          <xsl:text>;</xsl:text>
      </xsl:attribute>
      <xsl:apply-templates/>
    </div>
  </xsl:for-each>
</div>
</xsl:template>

<xsl:template match="subslide">
  <div class="fragment">
    <xsl:apply-templates/>
  </div>
</xsl:template>



<xsl:template match="definition" mode="type-name">
  <xsl:text>Definition</xsl:text>
</xsl:template>
<xsl:template match="definition">
  <div style="border: 0.5px">
	<div style="background: #00608010; width: 90%;">
		<h3>
      <xsl:apply-templates select="." mode="type-name" /> (<xsl:value-of select="@source-number"/>):
      <xsl:apply-templates select="." mode="title-full" />
    </h3>
      <xsl:apply-templates select="statement"/>
	</div>
</div>
</xsl:template>


<xsl:template match="theorem" mode="type-name">
  <xsl:text>Theorem</xsl:text>
</xsl:template>
<xsl:template match="cor" mode="type-name">
  <xsl:text>Corollary</xsl:text>
</xsl:template>
<xsl:template match="theorem|cor">
  <div style="border: 0.5px">
	<div style="background: #ff000010; width: 90%;">
		<h3>
      <xsl:apply-templates select="." mode="type-name" /> (<xsl:value-of select="@source-number"/>):
      <xsl:apply-templates select="." mode="title-full" />
    </h3>
      <xsl:apply-templates select="statement"/>
	</div>
  <xsl:if test="proof">
  <div style="background: #00000010; width: 80%;">
    <xsl:apply-templates select="proof"/>
  </div>
</xsl:if>
</div>
</xsl:template>

<xsl:template match="example" mode="type-name">
  <xsl:text>Example</xsl:text>
</xsl:template>
<xsl:template match="activity" mode="type-name">
  <xsl:text>Activity</xsl:text>
</xsl:template>
<xsl:template match="note" mode="type-name">
  <xsl:text>Note</xsl:text>
</xsl:template>
<xsl:template match="example|activity|note">
  <div style="border: 0.5px">
	<div style="background: #60800010; width: 90%;">
		<h3>
      <xsl:apply-templates select="." mode="type-name" /> (<xsl:value-of select="@source-number"/>):
      <xsl:apply-templates select="." mode="title-full" />
    </h3>
      <xsl:apply-templates />
	</div>
</div>
</xsl:template>

<xsl:template match="fact" mode="type-name">
  <xsl:text>Fact</xsl:text>
</xsl:template>
<xsl:template match="fact">
  <div style="border: 0.5px">
	<div style="background: #00608010; width: 90%;">
		<h3>
      <xsl:apply-templates select="." mode="type-name" /> (<xsl:value-of select="@source-number"/>):
      <xsl:apply-templates select="." mode="title-full" />
    </h3>
      <xsl:apply-templates/>
	</div>
</div>
</xsl:template>

</xsl:stylesheet>
