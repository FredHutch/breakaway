FROM ubuntu:18.04
MAINTAINER sminot@fredhutch.org

# Install prerequisites and R
RUN apt update && \
    ln -fs /usr/share/zoneinfo/Europe/Dublin /etc/localtime && \
    apt install -y \
    build-essential \
    wget \
    unzip \
    r-base \
    r-base-dev \
    r-recommended \
    libssl-dev \
    libxml2-dev \
    libcurl4-openssl-dev \
    software-properties-common

# Install repository with R
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9 && \
    apt-add-repository "deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/"

# Install devtools
RUN R -e "install.packages('curl', repos = 'http://cran.us.r-project.org'); library(curl)"
RUN R -e "install.packages('httr', repos = 'http://cran.us.r-project.org'); library(httr)"
RUN R -e "install.packages('usethis', repos = 'http://cran.us.r-project.org'); library(usethis)"
RUN R -e "install.packages('devtools', repos = 'http://cran.us.r-project.org'); library(devtools)"
RUN R -e "install.packages('tidyverse', repos = 'http://cran.us.r-project.org'); library(tidyverse)"
RUN R -e "install.packages('vroom', repos = 'http://cran.us.r-project.org'); library(vroom)"

# Install Phyloseq
RUN R -e "source('http://bioconductor.org/biocLite.R'); biocLite('phyloseq'); library(phyloseq)"

# Install breakaway
RUN R -e "library(devtools); devtools::install_github('adw96/breakaway')"
