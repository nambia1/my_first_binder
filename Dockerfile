FROM rocker/verse:latest

# Install system deps for Jupyter
USER root
RUN apt-get update && apt-get install -y python3-pip && rm -rf /var/lib/apt/lists/*

# Install JupyterLab
RUN pip3 install jupyterlab --break-system-packages

# Install IRkernel and register it
RUN R -e "install.packages('IRkernel', repos='https://cloud.r-project.org')" \
    && R -e "IRkernel::installspec(user = FALSE)"

# Switch back to rstudio user
USER rstudio
WORKDIR /home/rstudio

CMD ["jupyter", "lab", "--ip=0.0.0.0", "--no-browser"]
