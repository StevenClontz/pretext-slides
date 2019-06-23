<?xml version='1.0'?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
  xmlns:xml="http://www.w3.org/XML/1998/namespace"
>

<xsl:include href="../pretext/xsl/mathbook-common.xsl"/>

<xsl:output method="xml" indent="yes"/>
<xsl:strip-space elements="*"/>
<!-- https://stackoverflow.com/a/6357859/1607849 -->
<xsl:variable name="slide-defaults">|<xsl:value-of select="pretext/docinfo/@slide-defaults"/>|</xsl:variable>

<xsl:template match="/">
<pretext xmlns:xi="http://www.w3.org/2001/XInclude">
<xsl:copy-of select="pretext/docinfo"/>
<article><slideshow>
  <xsl:for-each select="pretext/book|pretext/article">
  <title><xsl:value-of select="title"/></title>
  <xsl:if test="subtitle">
    <subtitle><xsl:value-of select="subtitle"/></subtitle>
  </xsl:if>
  <frontmatter>
    <xsl:copy-of select="frontmatter/titlepage"/>
    <!-- TODO support additional slides under title e.g. abstract -->	
  </frontmatter>
  <xsl:for-each select="chapter">
    <section>
      <slide>
        <xsl:attribute name="source-label">Chapter</xsl:attribute>
        <xsl:attribute name="source-number"><xsl:apply-templates select="." mode="number"/></xsl:attribute>
        <title><xsl:value-of select="title"/></title>
      </slide>
      <!-- TODO support additional slides under chapter e.g. introduction -->	
    </section>
    <xsl:for-each select="section">
      <section>
        <slide>
          <xsl:attribute name="source-label">Section</xsl:attribute>
          <xsl:attribute name="source-number"><xsl:apply-templates select="." mode="number"/></xsl:attribute>
          <title><xsl:value-of select="title"/></title>
        </slide>
          <xsl:for-each select="*[contains($slide-defaults,concat('|',local-name(),'|')) or @slide='true']">
          <slide>
            <xsl:copy select=".">
              <xsl:if test="self::definition or self::example or self::activity or self::note or self::theorem or self::fact or self::lemma or self::corollary or self::proposition">
                <xsl:attribute name="source-number"><xsl:apply-templates select="." mode="number"/></xsl:attribute>
              </xsl:if>
              <xsl:if test="self::p"><xsl:value-of select="."/></xsl:if>
              <xsl:for-each select="*[self::p or self::sidebyside or self::me or self::ol or self::ul or self::title or self::statement or self::introduction or self::task]">
                <xsl:copy-of select="."/>
              </xsl:for-each>
            </xsl:copy>
          </slide>
        </xsl:for-each>
      </section>
    </xsl:for-each>
  </xsl:for-each>
  </xsl:for-each>
</slideshow></article>
</pretext>
</xsl:template>

</xsl:stylesheet>
