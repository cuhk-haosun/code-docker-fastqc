# docker fastqc & multiQC
# out of cuhkhaosun/base image
FROM cuhkhaosun/base

# Installation dependency
RUN apt-get update && apt-get install -y \
    wget \
    git \
    build-essential \
    zlib1g-dev


#RUN apt-get update && apt-get install -y \
#    wget fastqc multiqc
RUN apt-get update && apt-get install -o Acquire::Retries=3 -y wget fastqc multiqc

# Set working directory
WORKDIR /data

# Copy entrypoint script to container
COPY run.sh /entrypoint.sh

# Permission
RUN chmod +x /entrypoint.sh

# Entry point
ENTRYPOINT ["/entrypoint.sh"]