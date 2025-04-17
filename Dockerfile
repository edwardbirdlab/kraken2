FROM ubuntu:22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV KRAKEN2_DIR=/opt/kraken2

# Install dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential \
        perl \
        make \
        coreutils \
        zlib1g-dev \
        wget \
        rsync \
        && rm -rf /var/lib/apt/lists/*

# Create working directory
WORKDIR /kraken2

# Copy the Kraken 2 source and install script
COPY . .

RUN ls -l && \
    cat install_kraken2.sh && \
    chmod +x install_kraken2.sh && \
    ./install_kraken2.sh "$KRAKEN2_DIR"

# Add Kraken2 to PATH
ENV PATH="$KRAKEN2_DIR:$PATH"

# Default command
CMD ["kraken2", "--help"]
