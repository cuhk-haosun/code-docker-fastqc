# docker fastqc & multiQC
# out of cuhkhaosun/base image
FROM cuhkhaosun/base:latest

LABEL maintainer="LYX"

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

# Download the set.thread.num.sh script
RUN curl -o /data/set.thread.num.sh https://raw.githubusercontent.com/cuhk-haosun/code-docker-script-lib/main/set.thread.num.sh && \
    chmod +x /data/set.thread.num.sh

# Copy entrypoint script to container
COPY run.sh /entrypoint.sh

# Permission
RUN chmod +x /entrypoint.sh

# Entry point
ENTRYPOINT ["/entrypoint.sh"]
