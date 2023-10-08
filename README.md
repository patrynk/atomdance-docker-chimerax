atomdance-docker
================
ver. 0.1-unreleased

Dockerfile and build for containerized execution of gbabbitt/ATOMDANCE-comparative-protein-dynamics Molecular Dynamics software suite.
ATOMDANCE package source is available here:
https://github.com/gbabbitt/ATOMDANCE-comparative-protein-dynamics

How to use this repository
==========================
1) Confirm you have [Docker](https://docs.docker.com/engine/install/) and [docker-compose](https://docs.docker.com/compose/install/linux/) installed.

2) Determine a path on your host machine that you would like to interact with the docker image for passing analyses to and retrieving data from. This is denoted in Step 4 below as /PATH/TO/SHARED/DIRECTORY and will be mapped in the docker container as /data. This directory must exist and be writable by the image. Sample instructions for enabling this as follows:
```bash
mkdir /PATH/TO/SHARED/DIRECTORY && chmod -R 766 /PATH/TO/SHARED/DIRECTORY
```

3) IN DEVELOPMENT - download UCSF ChimeraX and deposit it in your shared directory above. This is how atomdance-docker will install UCSF ChimeraX.

4) Set up and run this image locally:
```bash
# 1) Clone this repository and its cpptraj submodule
git clone --recurse-submodules https://github.com/patrynk/atomdance-docker.git
# 2) Build the image. This will take a WHILE. Future releases will include links to pre-built images.
cd atomdance-docker
sudo su
docker-compose build
# 3) Deploy the image and follow the on-screen GUI.
docker-compose run -u atomuser -v /PATH/TO/SHARED/DIRECTORY:/data atomdance start
```

NOTE: ATOMDANCE analytical pipeline capabilities are still in-development, and will not work in the UI.

Citations:

Babbitt G.A. et al. 2023. ATOMDANCE: machine learning denoising and resonance analysis for functional and evolutionary comparisons of protein dynamics bioRxiv 2023.04.20.537698; doi: https://doi.org/10.1101/2023.04.20.537698

Babbitt G.A. Coppola E.E. Mortensen J.S. Adams L.E. Liao J. K. 2018. DROIDS 1.2 – a GUI-based pipeline for GPU-accelerated comparative protein dynamics. BIOPHYSICAL JOURNAL 114: 1009-1017. CELL Press.

Babbitt G.A. Fokoue E. Evans J.R. Diller K.I. Adams L.E. 2020. DROIDS 3.0 - Detection of genetic and drug class variant impact on conserved protein binding dynamics. BIOPHYSICAL JOURNAL 118: 541-551 CELL Press.

Babbitt G.A. Fokoue E.P. Srivastava H.R. Callahan B. Rajendran M. 2022. Statistical machine learning for comparative protein dynamics with the DROIDS/maxDemon software pipeline. In press. STAR Protocols CELL Pres

Daniel R. Roe and Thomas E. Cheatham, III, "PTRAJ and CPPTRAJ: Software for Processing and Analysis of Molecular Dynamics Trajectory Data". J. Chem. Theory Comput., 2013, 9 (7), pp 3084-3095.