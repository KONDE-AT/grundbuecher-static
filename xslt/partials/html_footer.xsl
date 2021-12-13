<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xsl xs"
    version="2.0">
    <xsl:template match="/" name="html_footer">
        <footer class="main-footer">
            <div class="container">
                <div class="footer-wrapper">
                    <div class="footer-sep">
                        <em class="far fa-comment"/> <a href="kontakt.html">Kontakt</a>
                    </div>
                    <div class="row">
                        <div class="col-md-2">
                            <a href="https://www.oeaw.ac.at/acdh/acdh-home/" target="_blank" rel="noopener" aria-label="ACDH">
                                <img src="https://shared.acdh.oeaw.ac.at/acdh-common-assets/images/acdh_logo.svg" alt="ACDH" title="Austrian Centre for Digital Humanities"/>
                            </a>
                        </div>
                        <div class="col-md-2">
                            <a href="https://wirtschaftsgeschichte.univie.ac.at/" target="_blank" rel="noopener" aria-label="Institut für Wirtschafts- und Sozialgeschichte">
                                <img src="https://shared.acdh.oeaw.ac.at/wgb/img/logo_wiso.png" alt="Institut für Wirtschafts- und Sozialgeschichte" title="Institut für Wirtschafts- und Sozialgeschichte"/>
                            </a>
                        </div>
                        <div class="col-md-2">
                            <a href="https://www.univie.ac.at/" target="_blank" rel="noopener" aria-label="Universität Wien">
                                <img src="https://shared.acdh.oeaw.ac.at/wgb/img/logo_uni_wien.png" alt="Universität Wien" title="Universität Wien"/>
                            </a>
                        </div>
                        <div class="col-md-2">
                            <a href="https://www.wien.gv.at/kultur/archiv/" target="_blank" rel="noopener" aria-label="Wiener Stadt- und Landesarchiv (MA 8)">
                                <img src="https://shared.acdh.oeaw.ac.at/wgb/img/logo_wstla.jpg" alt="Wiener Stadt- und Landesarchiv (MA 8)" title="Wiener Stadt- und Landesarchiv (MA 8)"/>
                            </a>
                        </div>
                        <div class="col-md-2">
                            <a href="https://www.wien.gv.at/kultur/abteilung/" target="_blank" rel="noopener" aria-label="Kulturabteilung (MA 7)">
                                <img src="https://shared.acdh.oeaw.ac.at/wgb/img/logo_MA_7.jpg" alt="Kulturabteilung (MA 7)" title="Kulturabteilung (MA 7)"/>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="footer-imprint-bar">
                <a href="imprint.html">Impressum/Imprint</a>
                <div class="row" style="padding-top: 20px;">
                    <div class="col-sm">
                        <a href="https://github.com/KONDE-AT/grundbuecher">
                            <em class="fab fa-github-square fa-2x"/>
                        </a>
                    </div>
                </div>
            </div>
        </footer>
        <script type="text/javascript" src="dist/fundament/vendor/jquery/jquery.min.js"></script>
        <script type="text/javascript" src="dist/fundament/js/fundament.min.js"></script>
        <script type="text/javascript" src="https://cdn.datatables.net/v/bs4/jszip-2.5.0/dt-1.11.0/b-2.0.0/b-html5-2.0.0/cr-1.5.4/r-2.2.9/sp-1.4.0/datatables.min.js"></script>
        <script type="text/javascript" src="js/dt.js"></script>
    </xsl:template>
</xsl:stylesheet>