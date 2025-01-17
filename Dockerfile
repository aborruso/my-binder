# Use the same base image as Binder
FROM ubuntu:22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV SHELL=/bin/bash
ENV PATH="/root/.local/bin:$PATH"

# Install system dependencies from apt.txt
RUN apt-get update && apt-get install -y --no-install-recommends \
    autoconf \
    jq \
    zsh \
    xmlstarlet \
    libxml2-dev \
    libxslt1-dev \
    python3-dev \
    python3-lxml \
    nodejs \
    unzip \
    locate \
    moreutils \
    automake \
    autoconf \
    libtool \
    flex \
    build-essential \
    curl \
    wget \
    libproj-dev \
    libgeos-dev \
    libsqlite3-dev \
    zlib1g-dev \
    pkg-config \
    git \
    sqlite3 \
    libfreexl-dev \
    enca \
    libpcre3-dev \
    libpcre3 \
    nano \
    xml2 \
    gdal-bin \
    libgdal-dev \
    && rm -rf /var/lib/apt/lists/*

# Installare curl e wget prima di scaricare Miniconda
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Scaricare Miniconda in modo più sicuro con curl e verificare il file
RUN curl -fsSL -o /tmp/miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    chmod +x /tmp/miniconda.sh && \
    ls -lah /tmp/miniconda.sh && \
    /bin/bash /tmp/miniconda.sh -b -p /opt/conda && \
    rm -rf /tmp/miniconda.sh

# Aggiungere Miniconda al PATH
ENV PATH="/opt/conda/bin:$PATH"

# Create conda environment from environment.yml
COPY binder/environment.yml /tmp/environment.yml
RUN conda env update -n base -f /tmp/environment.yml && \
    conda clean -afy

# Copy and run postBuild script
COPY binder/postBuild /tmp/postBuild
RUN chmod +x /tmp/postBuild && /tmp/postBuild

# Set up working directory
WORKDIR /workspace
VOLUME /workspace

# Default command
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]
