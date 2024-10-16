<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="2.0" exclude-result-prefixes="xsl tei xs">
    <xsl:output encoding="UTF-8" media-type="text/html" method="html" version="5.0" indent="yes" omit-xml-declaration="yes"/>
    
    <xsl:import href="./partials/shared.xsl"/>
    <xsl:import href="./partials/html_navbar.xsl"/>
    <xsl:import href="./partials/html_head.xsl"/>
    <xsl:import href="./partials/html_footer.xsl"/>


    <xsl:template match="/">
        <xsl:variable name="doc_title">
            <xsl:value-of select=".//tei:title[@type='main'][1]/text()"/>
        </xsl:variable>
        <html class="h-100">
            <head>
                <xsl:call-template name="html_head">
                    <xsl:with-param name="html_title" select="$doc_title"></xsl:with-param>
                </xsl:call-template>
            </head>
            
            <body class="d-flex flex-column h-100">
            <xsl:call-template name="nav_bar"/>
                <main class="flex-shrink-0 flex-grow-1">
                    <div class="container pt-3">                        
                        <h1 class="text-center p3"><xsl:value-of select="$doc_title"/></h1> 
                        <h2 class="text-center p3"><xsl:value-of select=".//tei:title[@type='sub'][1]/text()"/></h2>
                        <xsl:apply-templates select=".//tei:body"></xsl:apply-templates>
                        <hr />
                        <p style="text-align:center;">
                            <xsl:for-each select="tei:TEI/tei:text/tei:body//tei:note">
                                <div class="footnotes">
                                    <xsl:element name="a">
                                        <xsl:attribute name="name">
                                            <xsl:text>fn</xsl:text>
                                            <xsl:number level="any" format="1"
                                                count="tei:note[./tei:p]"/>
                                        </xsl:attribute>
                                        <a>
                                            <xsl:attribute name="href">
                                                <xsl:text>#fna_</xsl:text>
                                                <xsl:number level="any" format="1"
                                                    count="tei:note"/>
                                            </xsl:attribute>
                                            <sup>
                                                <xsl:number level="any" format="1"
                                                    count="tei:note[./tei:p]"/>
                                            </sup>
                                        </a>
                                    </xsl:element>
                                    <xsl:value-of select="."/>
                                </div>
                            </xsl:for-each>
                        </p>
                        <hr/>
                        <h3>Zitierhinweis</h3>
                        <blockquote class="blockquote">
                            <cite title="Source Title">
                                Das Darlehensbuch Satzbuch CD (1438-1473): Einleitung zur online-Publikation, In: Ertl, Thomas/Andorfer,
                                Peter/Fiska, Patrick/Weinbergmair, Richard/Grünwald, Korbinian: Ein Wiener Grundbuch des 15. Jahrhunderts. Digitale Edition des Satzbuch CD (1438-1473).
                                (Mai 2021), https://grundbuecher.acdh.oeaw.ac.at/about.html
                            </cite>
                        </blockquote>
                    </div>
                </main>
                <xsl:call-template name="html_footer"/>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="tei:body//tei:head">
        <h3><xsl:value-of select="."/></h3>
    </xsl:template>
    <xsl:template match="tei:p">
        <p id="{generate-id()}"><xsl:apply-templates/></p>
    </xsl:template>
    <xsl:template match="tei:div">
        <div id="{generate-id()}"><xsl:apply-templates/></div>
    </xsl:template>
    <xsl:template match="tei:lb">
        <br/>
    </xsl:template>
    <xsl:template match="tei:unclear">
        <abbr title="unclear"><xsl:apply-templates/></abbr>
    </xsl:template>
    <xsl:template match="tei:del">
        <del><xsl:apply-templates/></del>
    </xsl:template>    
</xsl:stylesheet>