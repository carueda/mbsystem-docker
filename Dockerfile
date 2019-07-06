FROM centos:7

RUN yum -y groupinstall "Development Tools"

RUN yum install -y epel-release

# Per https://www.mbari.org/products/research-software/mb-system/how-to-download-and-install-mb-system/#toggle-id-10
RUN yum -y install openmotif openmotif-devel \
            fftw fftw-devel netcdf netcdf-devel \
            proj proj-devel gdal-devel gmt gmt-devel

# Added freeglut to resolve OpenGL stuff:
RUN yum -y install freeglut freeglut-devel

# -------------------------
# Now the MB-System itself:

RUN  mkdir -p /opt/MB-System /opt/MBSWorkDir

# Build MB-System:
COPY MB-System /opt/MB-System/
RUN  cd /opt/MB-System/         && \
     ./configure                && \
     make                       && \
     make install

# Prepare MB-System program dispatcher:
COPY runmbsp.sh /opt/MB-System/
RUN  chmod +x /opt/MB-System/runmbsp.sh

WORKDIR    /opt/MBSWorkDir
ENTRYPOINT ["/opt/MB-System/runmbsp.sh"]
CMD        []
