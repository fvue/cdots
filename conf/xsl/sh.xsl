<!DOCTYPE stylesheet [
<!ENTITY space " ">
<!ENTITY nl "<xsl:text>&#10;</xsl:text>">
]>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text"/>


<xsl:template match="project">
<xsl:text/>#!/bin/bash<xsl:text>
# NOTE: Generated file.  Command: make conf.inc.sh~
</xsl:text>
projCloneOrigin=<xsl:value-of select="cloneOrigin"/>
projName=<xsl:value-of select="name"/>
projPrefix=<xsl:value-of select="prefix"/>
projVersion=<xsl:value-of select="version"/>
<xsl:text>
</xsl:text>
</xsl:template><!-- project -->


</xsl:stylesheet>
