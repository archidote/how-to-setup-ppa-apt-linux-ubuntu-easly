#!/bin/bash 

email="archidote.contact@gmail.com"
date=$(date '+%Y-%m-%d %H:%M:%S')

# Packages & Packages.gz
dpkg-scanpackages --multiversion . > Packages
gzip -k -f Packages

# Release, Release.gpg & InRelease
apt-ftparchive release . > Release
gpg --default-key "$email" -abs -o - Release > Release.gpg
gpg --default-key "$email" --clearsign -o - Release > InRelease

# Commit & push
git add -A
git commit -m "update : $date"
git push
