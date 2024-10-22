# How to run docker of fastqc
# Fastq files quality control overview

This repository contains a Dockerfile to build a Docker image that runs FastQC and MultiQC, a `entrypoint.sh` script  serves as the entrypoint for the Docker image, and GitHub Actions workflow configurations for automated building, pushing, and signing of the Docker image.


# Usage

# Run manually with cmd line
```bash
docker run -it --rm \
  -v ./mnt/in:/data \
  ghcr.io/cuhk-haosun/code-docker-fastqc:latest
```

# Run via github action
 Simply fill in the forms listed in the github action
