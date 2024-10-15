# How to run docker of fastqc
# Dockerized FastQC and MultiQC Pipeline

This repository contains a Dockerfile to build a Docker image that runs FastQC and MultiQC, a `run.sh` script that serves as the entrypoint for the Docker image, and GitHub Actions workflow configurations for automated building, pushing, and signing of the Docker image.

## Overview

- **Dockerfile**: Sets up an environment with all the necessary tools installed to run FastQC and MultiQC for sequence data analysis.
- **run.sh**: This script is used as the entrypoint in the Docker container. It configures the environment and executes the analysis tools.
- **GitHub Actions**: Automates the process of building, pushing, and signing the Docker image on GitHub Container Registry (GHCR).

## Prerequisites

- Docker installed on your machine.
- GitHub account with access to GitHub Actions and GitHub Container Registry.
- Git installed on your machine.

## Usage

### Local Build and Run

1. **Clone the Repository**:
   ```bash
   git clone [repository-url]
   cd [repository-name]

2. **Build the Docker Image**:
   docker build -t your-username/fastqc-multiqc .

3. **Run the Docker Container:**:
   docker run -v /path/to/data:/data your-username/fastqc-multiqc
   Replace /path/to/data with the path to the folder containing your sequencing data.

Using GitHub Actions

    1. Fork this repository:
    Fork the repository to your own GitHub account.

    2. Set up GitHub Secrets:
    Navigate to Settings -> Secrets in your GitHub repository and add the following:
        GITHUB_TOKEN: Your GitHub access token with permissions to push images to GHCR.

    3. Trigger Actions:
        Manual trigger: Go to Actions tab, select the workflow, and use the Run workflow dropdown to trigger the workflow manually.
        On push: The workflow will trigger automatically when you push to the main branch or push tags that match v*.*.*.
        On pull request: The workflow will trigger when a pull request is opened to the main branch.
        Scheduled trigger: The workflow is configured to run automatically at 18:37 UTC daily.

Results

    The Docker image will be built with FastQC and MultiQC installed and configured.
    The image will be pushed to GitHub Container Registry, ready to be pulled and used in various environments.
    The image will be signed to ensure its integrity and authenticity.

