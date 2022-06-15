<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text" encoding="utf-8"/>

<xsl:strip-space elements="*"/>

<xsl:param name="sep" select="'&#09;'" />
<xsl:param name="eol" select="'&#10;'" />


<xsl:template match="word[not(@artificial)]">
	<!--xsl:value-of select="concat(@form,$sep,@lemma,$sep,@postag,$sep,@relation,$sep,@id,$sep,@head,$sep,../@subdoc,'#',../@document_id,$eol)" /-->	
	<xsl:value-of select="concat(@form,$sep,@lemma,$sep)" />	
        <xsl:call-template name="parsePostag">
            <xsl:with-param name="postag" select="@postag"/>
        </xsl:call-template>
	<!--xsl:value-of select="concat(@relation,$sep,@id,$sep,@head,$sep,../@subdoc,'#',../@document_id,$eol)" /-->	
	<xsl:value-of select="concat(@relation,$sep,@id,$sep,@head,$sep,@cite,$sep,../@subdoc,$sep,../@id,$sep,../@document_id,$eol)" />	
</xsl:template>

<xsl:template name="parsePostag">
    <xsl:param name="postag"/>
        <xsl:value-of select="concat(substring($postag, 1, 1),$sep)"/>
    <xsl:if test="string-length($postag) > 1">
        <xsl:call-template name="parsePostag">
            <xsl:with-param name="postag" select="substring($postag, 2, string-length($postag) - 1)"/>
        </xsl:call-template>
    </xsl:if>
</xsl:template>

<xsl:template match="text()"/>

</xsl:stylesheet>
