<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output omit-xml-declaration="yes" indent="no"/>
  <xsl:template match="/">
    <xsl:for-each select="/TEI.2/text/body/div1[@n='1']/p">
      <xsl:apply-templates/>
    </xsl:for-each>
  </xsl:template>
  <xsl:template match="//note"></xsl:template>
  <!--
  <xsl:template match="//milestone"><xsl:value-of select="concat(' milestone_', @n, ' ')"/></xsl:template>
  -->
  <xsl:template match="//milestone"><xsl:text> </xsl:text></xsl:template>
  <xsl:template match="//quote">"<xsl:apply-templates/>"</xsl:template>
</xsl:stylesheet>


