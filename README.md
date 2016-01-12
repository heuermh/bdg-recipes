Big Data Genomics Recipes
===========

Recipes using BDG projects. Apache 2 licensed.

# Introduction

This repository is a home for "recipes" that use a [Big Data Genomics](http://bdgenomics.org)
project to accomplish some task. By default, these recipes use EC2 to create a Spark cluster,
on which we run [ADAM](https://www.github.com/bigdatagenomics/adam)/etc. These recipes serve three purposes:

* As a quickstart for people new to the BDG project, who would like to figure out how to use
BDG software to replace their current workflows.
* As a benchmarking/regression testing environment for the various BDG tools.
* As a sandbox where we can set up head-to-head tests against other tools (e.g., for experiments
for papers).

# Recipes

Our recipe book contains the following recipes:

* Single node recipes:
  * [bqsr-head-to-head](bqsr-head-to-head/README.md): Runs a head-to-head single node speed test of the
[ADAM](https://www.github.com/bigdatagenomics/adam) and [GATK](https://www.github.com/broadgsa/gatk-protected)
base quality score recalibration (BQSR) engines.
  * [flagstat-head-to-head](flagstat-head-to-head/README.md): Runs a head-to-head performance test of `Flagstat`
using [ADAM](https://www.github.com/bigdatagenomics/adam), [samtools](https://www.github.com/samtools/samtools),
and [sambamba](https://www.github.com/lomereiter/sambamba).
  * [indel-realignment-head-to-head](indel-realignment-head-to-head/README.md): Runs a head-to-head single node speed test of the
[ADAM](https://www.github.com/bigdatagenomics/adam) and [GATK](https://www.github.com/broadgsa/gatk-protected)
INDEL realignment engines.
  * [markdup-head-to-head](markdup-head-to-head/README.md): Runs a head-to-head performance test of duplicate marking
using [ADAM](https://www.github.com/bigdatagenomics/adam), [samtools](https://www.github.com/samtools/samtools),
and [sambamba](https://www.github.com/lomereiter/sambamba), and [picard](https://www.github.com/broadinstitute/picard).
  * [sort-head-to-head](sort-head-to-head/README.md): Runs a head-to-head performance test of sorting
using [ADAM](https://www.github.com/bigdatagenomics/adam), [samtools](https://www.github.com/samtools/samtools),
and [sambamba](https://www.github.com/lomereiter/sambamba), and [picard](https://www.github.com/broadinstitute/picard).
* Multiple node recipes:
  * [adam-transforms](adam-transforms/README.md): Runs scale-out performance testing on [ADAM](https://www.github.com/bigdatagenomics/adam)'s
BQSR, Flagstat, INDEL realignment, duplicate marking, and sort implementations.

## Running a Single Node Recipe

To run a single node recipe, run:

```
fab _configure_master_aptitude
fab bake:<recipe>
```

## Running a Multi Node Recipe

To run a multi node recipe with _n_ nodes, run:

```
fab provision:<n>
fab _configure_master_yum
fab bake:<recipe>
```

# Adding a New Recipe

If you are adding a new recipe, you should add a directory. Under this directory, you should create a Bash
script named `run.sh` that runs the recipe. If the recipe needs setup, you should add the necessary details to
the fabfile configuration target.

# Getting In Touch

## Mailing List

[The ADAM mailing list](https://groups.google.com/forum/#!forum/adam-developers) is a good
way to sync up with other people who use bdg projects including the core developers. You can
subscribe by sending an email to `adam-developers+subscribe@googlegroups.com` or just post using
the [web forum page](https://groups.google.com/forum/#!forum/adam-developers).

## IRC Channel

A lot of the developers are hanging on the [#adamdev](http://webchat.freenode.net/?channels=adamdev)
freenode.net channel. Come join us and ask questions.

# License

bdg-recipes is released under an [Apache 2.0 license](LICENSE).