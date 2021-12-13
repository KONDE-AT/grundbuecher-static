<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="2.0" exclude-result-prefixes="xsl tei xs">
    <xsl:output encoding="UTF-8" media-type="text/html" method="xhtml" version="1.0" indent="yes" omit-xml-declaration="yes"/>
    <xsl:import href="./partials/base.xsl"/>
    <xsl:import href="./partials/html_navbar.xsl"/>
    <xsl:import href="./partials/html_head.xsl"/>
    <xsl:import href="./partials/html_footer.xsl"/>

    
    <xsl:variable name="signatur">
        <xsl:value-of select=".//tei:institution/text()"/>, <xsl:value-of select=".//tei:repository[1]/text()"/>, <xsl:value-of select=".//tei:msIdentifier/tei:idno[1]/text()"/>
    </xsl:variable>
    <xsl:variable name="IIIFBase">https://iiif.acdh.oeaw.ac.at/grundbuecher/</xsl:variable>
    <xsl:variable name="InfoJson">
        <xsl:value-of select="concat($IIIFBase, substring-before(data(.//tei:graphic[1]/@url), '.'), '/info.json')"/>
    </xsl:variable>
    <xsl:variable name="IIIFViewer">
        <xsl:value-of select="substring-before($InfoJson, 'info.json')"/>
    </xsl:variable>
    <xsl:variable name="prev">
        <xsl:value-of select="replace(tokenize(data(tei:TEI/@prev), '/')[last()], '.xml', '.html')"/>
    </xsl:variable>
    <xsl:variable name="next">
        <xsl:value-of select="replace(tokenize(data(tei:TEI/@next), '/')[last()], '.xml', '.html')"/>
    </xsl:variable>
    <xsl:variable name="path2source"></xsl:variable>
    <xsl:variable name="doc_nr">
        <xsl:value-of select="substring-after(tokenize(data(tei:TEI/@xml:id), '_')[1], 'e')"/>
    </xsl:variable>
    <xsl:variable name="self_link">
        <xsl:value-of select="replace(data(tei:TEI/@xml:id), '.xml', '.html')"/>
    </xsl:variable>
    <xsl:template match="/">
        <xsl:variable name="doc_title">
            <xsl:value-of select=".//tei:title[@type='main'][1]/text()"/>
        </xsl:variable>
        <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
        <html>
            <xsl:call-template name="html_head">
                <xsl:with-param name="html_title" select="$doc_title"></xsl:with-param>
            </xsl:call-template>
            
            <body role="document" class="contained fixed-nav" id="body">
                <div class="hfeed site" id="page">
                    <xsl:call-template name="nav_bar"/>
                    
                    <div class="container">
                        <div class="card">
                            <div class="card card-header">
                                <div class="row">
                                    <div class="col-md-2">
                                        <xsl:if test="$prev">
                                            <h1>
                                                <a>
                                                    <xsl:attribute name="href">
                                                        <xsl:value-of select="$prev"/>
                                                    </xsl:attribute>
                                                    <i class="fas fa-chevron-left" title="prev"/>
                                                </a>
                                            </h1>
                                        </xsl:if>
                                    </div>
                                    <div class="col-md-8">
                                        <h2 align="center">
                                            <xsl:for-each select="//tei:fileDesc/tei:titleStmt/tei:title">
                                                <xsl:apply-templates/>
                                                <br/>
                                            </xsl:for-each>
                                            <a>
                                                <i class="fas fa-info" title="show more info about the document" data-toggle="modal" data-target="#exampleModalLong"/>
                                            </a>
                                            |
                                            <a>
                                                <xsl:attribute name="href"><xsl:value-of select="concat('https://github.com/KONDE-AT/grundbuecher-static/blob/master/data/editions/', ./tei:TEI/@xml:id)"/></xsl:attribute>
                                                <i class="fas fa-download" title="show TEI source"/>
                                            </a>
                                        </h2>
                                    </div>
                                    <div class="col-md-2" style="text-align:right">
                                        <xsl:if test="$next">
                                            <h1>
                                                <a>
                                                    <xsl:attribute name="href">
                                                        <xsl:value-of select="$next"/>
                                                    </xsl:attribute>
                                                    <i class="fas fa-chevron-right" title="next"/>
                                                </a>
                                            </h1>
                                        </xsl:if>
                                    </div>
                                </div>
                            </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-5">
                                    <xsl:apply-templates select="//tei:text"/>
                                </div>
                                <div class="col-md-7" style="text-align: center;">
                                    <div style="width: 100%; height: 100%" id="osd_viewer"/>
                                    <a target="_blank">
                                        <xsl:attribute name="href">
                                            <xsl:value-of select="$IIIFViewer"/>
                                        </xsl:attribute>
                                        open image in new window
                                    </a>
                                </div>
                            </div>
                            <div class="card-footer">
                                <p style="text-align:center;">
                                    <xsl:for-each select="tei:TEI/tei:text/tei:body//tei:note">
                                        <div class="footnotes">
                                            <xsl:element name="a">
                                                <xsl:attribute name="name">
                                                    <xsl:text>fn</xsl:text>
                                                    <xsl:number level="any" format="1" count="tei:note[./tei:p]"/>
                                                </xsl:attribute>
                                                <a>
                                                    <xsl:attribute name="href">
                                                        <xsl:text>#fna_</xsl:text>
                                                        <xsl:number level="any" format="1" count="tei:note"/>
                                                    </xsl:attribute>
                                                    <sup>
                                                        <xsl:number level="any" format="1" count="tei:note[./tei:p]"/>
                                                    </sup>
                                                </a>
                                            </xsl:element>
                                            <xsl:apply-templates/>
                                        </div>
                                    </xsl:for-each>
                                </p>
                                <p>
                                    <hr/>
                                    <h3>Zitierhinweis</h3>
                                    <blockquote class="blockquote">
                                        <cite title="Source Title">
                                            <xsl:value-of select=".//tei:title[@type='main']/text()"/>, Nr. <xsl:value-of select="$doc_nr"/>, In: Ertl, Thomas/Andorfer,
                                            Peter/Fiska,
                                            Patrick/Weinbergmair, Richard/Grünwald, Korbinian: Ein Wiener
                                            Grundbuch
                                            des 15. Jahrhunderts. Digitale Edition des Satzbuch CD (1438-1473).
                                            (Mai 2021), full text: https://grundbuecher.acdh.oeaw.ac.at/<xsl:value-of select="$self_link"/>
                                        </cite>
                                    </blockquote>
                                </p>
                            </div>
                        </div>
                        <div class="modal fade" id="exampleModalLong" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="exampleModalLongTitle">
                                            <xsl:for-each select="//tei:fileDesc/tei:titleStmt/tei:title">
                                                <xsl:apply-templates/>
                                                <br/>
                                            </xsl:for-each>
                                        </h5>
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">x</span>
                                        </button>
                                    </div>
                                    <div class="modal-body">
                                        <table class="table table-striped">
                                            <tbody>
                                                <xsl:if test="//tei:msIdentifier">
                                                    <tr>
                                                        <th>
                                                            <abbr title="//tei:msIdentifie">Signatur</abbr>
                                                        </th>
                                                        <td>
                                                            <xsl:for-each select="//tei:msIdentifier/child::*">
                                                                <abbr>
                                                                    <xsl:attribute name="title">
                                                                        <xsl:value-of select="name()"/>
                                                                    </xsl:attribute>
                                                                    <xsl:value-of select="."/>
                                                                </abbr>
                                                                <br/>
                                                            </xsl:for-each><!--<xsl:apply-templates select="//tei:msIdentifier"/>-->
                                                        </td>
                                                    </tr>
                                                </xsl:if>
                                                <xsl:if test="//tei:msContents">
                                                    <tr>
                                                        <th>
                                                            <abbr title="//tei:msContents">Regest</abbr>
                                                        </th>
                                                        <td>
                                                            <xsl:apply-templates select="//tei:msContents"/>
                                                        </td>
                                                    </tr>
                                                </xsl:if>
                                                <xsl:if test="//tei:supportDesc/tei:extent">
                                                    <tr>
                                                        <th>
                                                            <abbr title="//tei:supportDesc/tei:extent">Extent</abbr>
                                                        </th>
                                                        <td>
                                                            <xsl:apply-templates select="//tei:supportDesc/tei:extent"/>
                                                        </td>
                                                    </tr>
                                                </xsl:if>
                                                <tr>
                                                    <th>Verantwortlich</th>
                                                    <td>
                                                        <xsl:for-each select="//tei:author">
                                                            <xsl:apply-templates/>
                                                        </xsl:for-each>
                                                    </td>
                                                </tr>
                                                <xsl:if test="//tei:titleStmt/tei:respStmt">
                                                    <tr>
                                                        <th>
                                                            <abbr title="//tei:titleStmt/tei:respStmt">responsible</abbr>
                                                        </th>
                                                        <td>
                                                            <xsl:for-each select="//tei:titleStmt/tei:respStmt">
                                                                <p>
                                                                    <xsl:apply-templates/>
                                                                </p>
                                                            </xsl:for-each>
                                                        </td>
                                                    </tr>
                                                </xsl:if>
                                                <tr>
                                                    <th>
                                                        <abbr title="//tei:availability//tei:p[1]">License</abbr>
                                                    </th>
                                                    <xsl:choose>
                                                        <xsl:when test="//tei:licence[@target]">
                                                            <td align="center">
                                                                <a class="navlink" target="_blank">
                                                                    <xsl:attribute name="href">
                                                                        <xsl:value-of select="//tei:licence[1]/data(@target)"/>
                                                                    </xsl:attribute>
                                                                    <xsl:value-of select="//tei:licence[1]/data(@target)"/>
                                                                </a>
                                                            </td>
                                                        </xsl:when>
                                                        <xsl:when test="//tei:licence">
                                                            <td>
                                                                <xsl:apply-templates select="//tei:licence"/>
                                                            </td>
                                                        </xsl:when>
                                                        <xsl:otherwise>
                                                            <td>no license provided</td>
                                                        </xsl:otherwise>
                                                    </xsl:choose>
                                                </tr>
                                            </tbody>
                                        </table>
                                        
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div></div>
                    <script src="https://cdnjs.cloudflare.com/ajax/libs/openseadragon/2.4.1/openseadragon.min.js"/>
                    <script type="text/javascript">
                        var source = "<xsl:value-of select="$InfoJson"/>";
                        var viewer = OpenSeadragon({
                        id: "osd_viewer",
                        tileSources: [
                        source
                        ],
                        prefixUrl:"https://cdnjs.cloudflare.com/ajax/libs/openseadragon/2.4.1/images/",
                        });
                    </script>
                    <xsl:call-template name="html_footer"/>
                </div>
            </body>
        </html>
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
</xsl:stylesheet>