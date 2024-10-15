<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:local="http://dse-static.foo.bar"
    version="2.0" exclude-result-prefixes="xsl tei xs local">
    <xsl:output encoding="UTF-8" media-type="text/html" method="html" version="5.0" indent="yes" omit-xml-declaration="yes"/>
    
    <xsl:import href="./partials/shared.xsl"/>
    <xsl:import href="./partials/html_navbar.xsl"/>
    <xsl:import href="./partials/html_head.xsl"/>
    <xsl:import href="./partials/html_footer.xsl"/>
    <xsl:import href="./partials/aot-options.xsl"/>
    
    <xsl:variable name="signatur">
        <xsl:value-of select=".//tei:institution/text()"/>, <xsl:value-of select=".//tei:repository[1]/text()"/>, <xsl:value-of select=".//tei:msIdentifier/tei:idno[1]/text()"/>
    </xsl:variable>
    <xsl:variable name="IIIFBase">https://id.acdh.oeaw.ac.at/grundbuecher-facs/</xsl:variable>
    <xsl:variable name="InfoJson">
        <xsl:value-of select="concat($IIIFBase, data(.//tei:graphic[1]/@url), '?format=IIIF')"/>
    </xsl:variable>
    <xsl:variable name="IIIFViewer">
        <xsl:value-of select="$InfoJson"/>
    </xsl:variable>
    <xsl:variable name="prev">
        <xsl:value-of select="replace(tokenize(data(tei:TEI/@prev), '/')[last()], '.xml', '.html')"/>
    </xsl:variable>
    <xsl:variable name="next">
        <xsl:value-of select="replace(tokenize(data(tei:TEI/@next), '/')[last()], '.xml', '.html')"/>
    </xsl:variable>
    <xsl:variable name="teiSource">
        <xsl:value-of select="data(tei:TEI/@xml:id)"/>
    </xsl:variable>
    <xsl:variable name="link">
        <xsl:value-of select="replace($teiSource, '.xml', '.html')"/>
    </xsl:variable>
    <xsl:variable name="doc_title">
        <xsl:value-of select=".//tei:titleStmt/tei:title[1]/text()"/>
    </xsl:variable>
    <xsl:variable name="path2source"></xsl:variable>
    <xsl:variable name="doc_nr">
        <xsl:value-of select="substring-after(tokenize(data(tei:TEI/@xml:id), '_')[1], 'e')"/>
    </xsl:variable>
    <xsl:variable name="self_link">
        <xsl:value-of select="replace(data(tei:TEI/@xml:id), '.xml', '.html')"/>
    </xsl:variable>


    <xsl:template match="/">
        <html class="h-100">
            <head>
                <xsl:call-template name="html_head">
                    <xsl:with-param name="html_title" select="$doc_title"></xsl:with-param>
                </xsl:call-template>
            </head>
            <body class="d-flex flex-column h-100">
                <xsl:call-template name="nav_bar"/>
                <main class="flex-shrink-0 flex-grow-1">
                    <div class="container">
                        <div class="row pt-3">
                            <div class="col-md-2 col-lg-2 col-sm-12 text-start">
                                <xsl:if test="ends-with($prev,'.html')">
                                    <a>
                                        <xsl:attribute name="href">
                                            <xsl:value-of select="$prev"/>
                                        </xsl:attribute>
                                        <i class="fs-2 bi bi-chevron-left" title="Zurück zum vorigen Dokument" visually-hidden="true">
                                            <span class="visually-hidden">Zurück zum vorigen Dokument</span>
                                        </i>
                                    </a>
                                </xsl:if>
                            </div>
                            <div class="col-md-8 col-lg-8 col-sm-12 text-center">
                                <h1>
                                    <span class="pe-2"><xsl:value-of select="$doc_title"/></span>
                                    <button type="button" class="btn btn-outline-secondary">
                                        <i class="bi bi-info-square fs-3" data-bs-toggle="modal" data-bs-target="#exampleModal" title="Informationen zum Dokument" visually-hidden="true">
                                            <span class="visually-hidden">Informationen zum Dokument</span>
                                        </i>
                                    </button>
                                </h1>
                                <div>
                                    <a href="{$teiSource}">
                                        <i class="bi bi-download fs-2 pe-1" title="Zum TEI/XML Dokument" visually-hidden="true">
                                            <span class="visually-hidden">Zum TEI/XML Dokument</span>
                                        </i>
                                    </a>
                                </div>
                            </div>
                            <div class="col-md-2 col-lg-2 col-sm-12 text-end">
                                <xsl:if test="ends-with($next, '.html')">
                                    <a>
                                        <xsl:attribute name="href">
                                            <xsl:value-of select="$next"/>
                                        </xsl:attribute>
                                        <i class="fs-2 bi bi-chevron-right" title="Weiter zum nächsten Dokument" visually-hidden="true">
                                            <span class="visually-hidden">Weiter zum nächsten Dokument</span>
                                        </i>
                                    </a>
                                </xsl:if>
                            </div>
                        </div>
                        
                        <div class="row pt-3">
                            <div class="col-md-5 pt-5">
                                <xsl:apply-templates select="//tei:text"/>
                            </div>
                            <div class="col-md-7 text-center">
                                <div id="osd_viewer"/>
                                <a target="_blank">
                                    <xsl:attribute name="href">
                                        <xsl:value-of select="$IIIFViewer"/>
                                    </xsl:attribute>
                                    Bild in neuem Fenster öffenen
                                </a>
                            </div>
                        </div>
                        <div>
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
                                        (Mai 2021), https://grundbuecher.acdh.oeaw.ac.at/<xsl:value-of select="$self_link"/>
                                    </cite>
                                </blockquote>
                            </p>
                        </div>
                        
                        <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h3 class="modal-title" id="exampleModalLongTitle">
                                            <xsl:for-each select="//tei:fileDesc/tei:titleStmt/tei:title">
                                                <xsl:apply-templates/>
                                                <br/>
                                            </xsl:for-each>
                                        </h3>
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
                                                            </xsl:for-each>
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
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Schließen</button>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                    
                </main>
                <xsl:call-template name="html_footer"/>
                <script src="https://cdnjs.cloudflare.com/ajax/libs/openseadragon/4.1.0/openseadragon.min.js"/>
                <script type="text/javascript">
                    var source = "<xsl:value-of select="$InfoJson"/>";
                    var viewer = OpenSeadragon({
                    id: "osd_viewer",
                    tileSources: {
                    type: 'image',
                    url: source
                    },
                    prefixUrl:"https://cdnjs.cloudflare.com/ajax/libs/openseadragon/4.1.0/images/",
                    });
                </script>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
