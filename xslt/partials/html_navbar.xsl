<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xsl tei xs" version="2.0">
    <xsl:template match="/" name="nav_bar">
        <header>
            <nav class="navbar navbar-expand-md navbar-light fixed-top bg-white box-shadow">
                <a class="navbar-brand" href="index.html">
                    Grundbücher
                </a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"/>
                </button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav mr-auto">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                Menü
                            </a>
                            <div class="dropdown-menu">
                                <a class="dropdown-item" href="toc.html">Alle Dokumente</a>
                                <a class="dropdown-item" href="about.html">Über das Projekt</a>
                            </div>
                        </li>
                    </ul>
                    <form method="get" action="ft_search.html" class="form-inline my-2 my-lg-0">
                        <input name="searchexpr" class="form-control mr-sm-2" type="text" placeholder="Suche im Volltext" aria-label="Search" />
                        <button class="btn btn-main btn-outline-primary btn-mg" type="submit">Suche</button>
                    </form>
                </div>
            </nav>
        </header>
    </xsl:template>
</xsl:stylesheet>