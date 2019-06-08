########################################################################
# OSMnx + Pandana Dockerfile
# based on the Dockerfile maintained at https://github.com/gboeing/osmnx
# License: MIT, see full license in LICENSE.txt
#
# Run jupyter lab in this container:
# >>> docker run --rm -it -p 8888:8888 -v %cd%:/home wwymak/osmnx-pandana:0.1
#
# Stop/delete all local docker containers/images:
# >>> docker stop $(docker ps -aq)
# >>> docker rm $(docker ps -aq)
# >>> docker rmi $(docker images -q)
########################################################################

FROM continuumio/miniconda3
LABEL maintainer="Wendy Mak <wwymak@gmail.com>"
LABEL url="https://github.com/gboeing/osmnx"
LABEL description="OSMnx is a Python package to retrieve, model, analyze, and visualize OpenStreetMap networks and other spatial data."

# configure conda and install packages in one RUN to keep image tidy
RUN conda config --set show_channel_urls true && \
    conda config --prepend channels conda-forge && \
    conda config --add channels udst && \
    conda update --strict-channel-priority --yes -n base conda && \
    conda install --strict-channel-priority --update-all --force-reinstall --yes jupyterlab osmnx python-igraph bokeh brewer2mpl pyarrow && \
    conda clean --yes --all && \
    conda info --all && \
    conda list
    
RUN pip install tables osmnet GeoAlchemy2

RUN conda install pandana
    
ENV PROJ_LIB=$HOME/miniconda/envs/proj198/lib/python3.6/site-packages/fiona/proj_data
# launch jupyter in the local working directory that we mount
WORKDIR /home

# set default command to launch when container is run
CMD ["jupyter", "lab", "--ip='0.0.0.0'", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=''", "--NotebookApp.password=''"]

# to test, import OSMnx and print its version
# RUN ipython -c "import osmnx; print(osmnx.__version__)"
© 2019 GitHub, Inc.
Terms
Privacy
Security
Status
Help
Contact GitHub
Pricing
API
Training
Blog
About
