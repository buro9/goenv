Go ENV
======

Sets up an environment for working with Go, installs Go 1.4.2 from source, and
uses that to install Go 1.5 from source.

Creates a $GOPATH (work directory) of `~/Dev`.

Your working directory (where you check things out and put projects) will be `~/Dev/src` and your built code will be in `~/Dev/bin`.

Aside from installing Go, this script also installs `cover`, `godoc`, `goimports`, `vet`, and `golint`.

Usage
=====

If you have a brand new computer, just copy the `bootstrap.sh` file locally and run
that to install Git and pull this repo locally.

After you have pulled this repo, run `install.sh` to install or update Go.
