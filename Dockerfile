FROM ubuntu:18.04

ENV SSL_TRUSTED="--trusted-host pypi.org --trusted-host files.pythonhosted.org"

###########
# PREREQS #
###########
RUN apt-get update -qq \
&& apt-get install -yq python3 python3-pip

# Copy requirements file
COPY ./python-requirements.txt ./modelcomparisons/python-requirements.txt
# Install Python requirements
RUN cd modelcomparisons/ \
&& python3 -m pip install $SSL_TRUSTED -r python-requirements.txt

#########
# SETUP #
#########
# Copy rest
COPY ./ ./modelcomparisons/
