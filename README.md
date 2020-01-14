# Toward a dockerized MB-System

## Status

- Basic setup functional
- Some GUI basic tests OK on MacOS

## TODO

- Determine and implement final launch mechanism on host, in particular
  regarding the following:
    - Location of files manipulated by the MB-System programs.
      A basic initial mechanism would be that `$(pwd)` on the host be mapped to
      some location in the container (e.g., `/opt/MBSWorkDir`) whenever a 
      program is launched so the target file can be operated.
        
- Build GMT from source

- Continuous deployment, so the docker image is automatically built and published
  upon a push to the code (subject to successful testing).
  Ref: https://docs.docker.com/docker-hub/builds/

- Integration of the Docker build under the MB-System repo itself


## Image build

This repo has the MB-System software as a submodule. 

The steps for the image build are still done manually.

First, bring any updates in the MB-System submodule:

    $ (cd MB-System && git checkout master && git pull)

Inspect `MB-System/ChangeLog.md` to determine the version to be
reflected in the docker image.

**TODO**: version captured automatically as part of CI

Build the image, e.g.:
    
    $ MBSYSTEM_IMAGE=mbari/mbsystem:5.7.6beta23
    $ docker build -t "$MBSYSTEM_IMAGE" .

Run some of the programs as basic test that the image is working, e.g:

Command-line program example:

    $ docker run -it --rm $MBSYSTEM_IMAGE mbabsorption -h

    Program MBabsorption
    MB-system Version 5.7.6beta23
    
    MBabsorption calculates the absorption of sound in sea water
    in dB/km as a function of frequency, temperature, salinity,
    sound speed, pH, and depth.
    
    usage: mbabsorption [-Csoundspeed -Ddepth -Ffrequency -Pph -Ssalinity -Ttemperature -V -H]

GUI example (see [`notes/gui`](notes/gui.md)):

    $ docker run -it --rm -e DISPLAY=${ip}:0 $MBSYSTEM_IMAGE mbgrdviz

Publish image as appropriate:

    $ docker push $MBSYSTEM_IMAGE
    
Finally, something like the following to update this repo:

    git add -u
    git commit -m "Update MB-System pointer and build new image $MBSYSTEM_IMAGE"
    git push origin master


**2020-01-13 meeting**

- Ability to access shares like titan
- Use current host directory mapped as "home" directory
- List file with "pointers" to locations
- Windows
- keep using separate repo for now
