<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="#all"
    version="2.0">
    <xsl:template match="/" name="html_footer">
        <footer class="footer mt-auto py-3 bg-body-tertiary">
            <div class="container p-4">
                <div class="row my-4">
                    <div class="col-lg-2 col-md-6 mb-4 mb-md-0" align="right">
                        <div>
                            <a href="https://geschichtsforschung.univie.ac.at/">
                                <img src="images/uni_wien_logo.png" class="footerimage" />
                            </a>
                        </div>
                    </div>
                    <div class="col-lg-2 col-md-6 mb-4 mb-md-0">
                        <p>
                            Institut für Wirtschafts- und Sozialgeschichte
                            <br></br>
                            Universtiät Wien
                            <br></br>
                            Universitätsring 1
                            <br></br>
                            1010 Wien
                        </p>
                        <p>
                            T: +43-1-4277-272 01
                            <br></br>
                            <a href="https://wirtschaftsgeschichte.univie.ac.at/">Website</a>
                        </p>
                    </div>
                    <div class="col-lg-1 col-md-6 mb-4 mb-md-0" align="right">
                        <div>
                            <a href="https://www.oeaw.ac.at/acdh/acdh-ch-home">
                                <img src="images/acdhch_logo.png" class="footerimage"></img>
                            </a>
                        </div>
                    </div>
                    <div class="col-lg-2 col-md-6 mb-4 mb-md-0">
                        <p>
                            ACDH-CH
                            <br></br>
                            Austrian Centre for Digital Humanities and Cultural Heritage
                            <br></br>
                            Österreichische Akademie der Wissenschaften
                        </p>
                        <p>
                            Bäckerstraße 13
                            <br></br>
                            1010 Wien
                        </p>
                        <p>
                            T: +43 1 51581-2200
                            <br></br>
                            E: <a href="mailto:acdh-ch-helpdesk@oeaw.ac.at">acdh-ch-helpdesk@oeaw.ac.at</a>
                        </p>
                    </div>
                    <div class="col-lg-3 col-md-6 mb-4 mb-md-0" align="right">
                        <div class="text-center">
                            <p>
                            Gefördert durch Stadt Wien Kulturabteilung (MA 7)
                            
                            <a href="https://www.wien.gv.at/kultur/abteilung/">
                                <img src="images/logo_MA_7.jpg" class="footerimage"></img>
                            </a>
                            </p>
                        </div>
                        <div class="text-center">
                            <p>
                                Faksimiles zur Verfügung gestellt vom Wiener Stadt- und Landesarchiv (MA 8)
                            <a href="https://www.wien.gv.at/kultur/archiv/">
                                <img src="images/logo_wstla.jpg" class="footerimage"></img>
                            </a>
                            </p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="text-center">
                <a href="https://github.com/KONDE-AT/grundbuecher-static"><i class="bi bi-github fs-2"></i></a>
            </div>
        </footer>
        <script src="https://code.jquery.com/jquery-3.6.3.min.js" integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
        
    </xsl:template>
</xsl:stylesheet>