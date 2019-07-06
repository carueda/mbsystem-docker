# Toward a dockerized MB-System

## Status and TODO

**Status**: Generated image basically functional. See below.

**TODO**:

- Determine and implement final launch mechanism on host, in particular
  regarding the following:
    - Location of files manipulated by the MB-System programs.
      A basic initial mechanism would be that `$(pwd)` on the host be mapped to
      some location in the container (e.g., `/opt/MBSWorkDir`) whenever a 
      program is launched so the target file can be operated.
    - Any GUIs?
  
- Build GMT from source

- Continuous deployment, so the docker image is automatically built and published
  upon a push to the code (subject to successful testing).
  Ref: https://docs.docker.com/docker-hub/builds/

- Integration of the Docker build in the MB-System repo itself(?)


## Image build

This repo has the MB-System software as a submodule. 

First, check whether updates in the MB-System software itself need to be
reflected in a new image. For example:

    git submodule foreach "(git checkout master; git pull)"

Determine the version to be reflected in the image, say 5.7.5.

Build the image, e.g.:
    
    MBSYSTEM_IMAGE=mbari/mbsystem:5.7.5
    docker build -t "$MBSYSTEM_IMAGE" .

TODO: Publish image as appropriate (e.g., `docker login && docker push $MBSYSTEM_IMAGE`)

Finally, something like the following to update this repo:

    git add -u
    git commit -m "Update MB-System pointer and build new image $MBSYSTEM_IMAGE"
    git push origin master

## Basic test run

    $ docker run -it --rm mbari/mbsystem:5.7.5 mbabsorption -h

    Program MBabsorption
    MB-system Version 5.7.5
    
    MBabsorption calculates the absorption of sound in sea water
    in dB/km as a function of frequency, temperature, salinity,
    sound speed, pH, and depth.
    
    usage: mbabsorption [-Csoundspeed -Ddepth -Ffrequency -Pph -Ssalinity -Ttemperature -V -H]
