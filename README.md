# pandock
A custom dockerized pandoc for use with github actions

## Contents
- Pandoc version 2.18.1 downloaded from Github artifacts
- miktex configured to automatically install missing packages
- graphviz for visualizing dot graphs
- librsvg2-bin for adding svg's into PDF's

## Usage
Should be usable as-is in the same way as the official docker images: 
https://github.com/pandoc/pandoc-action-example

Something like this:
```yaml

name: Simple Usage

on: push

jobs:
  convert_via_pandoc:
    runs-on: ubuntu-18.04
    steps:
      - uses: docker://ghcr.io/saltyjeff/pandock:main
        with:
          args: "--help" # gets appended to pandoc command

```
