# MLE-Toolbox Overview

ML researchers need to coordinate different types of experiments on separate remote resources. The *Machine Learning Experiment (MLE)-Toolbox* is designed to facilitate the workflow by providing a simple interface, standardized logging, many common ML experiment types (multi-seed/configurations, grid-searches and hyperparameter optimization pipelines). You can run experiments on your local machine, high-performance compute clusters ([Slurm](https://slurm.schedmd.com/overview.html) and [Sun Grid Engine](http://bioinformatics.mdc-berlin.de/intro2UnixandSGE/sun_grid_engine_for_beginners/README.html)) as well as on cloud VMs ([GCP](https://cloud.google.com/gcp/)). The results are archived (locally/[GCS bucket](https://cloud.google.com/products/storage/)) and can easily be retrieved or automatically summarized/reported.

<a href="https://github.com/mle-infrastructure/mle-toolbox/blob/main/docs/mle_run.gif?raw=true"><img src="https://github.com/mle-infrastructure/mle-toolbox/blob/main/docs/mle_run.gif?raw=true" width="800" align="right" /></a>

## What Does The `mle-toolbox` Provide? 🧑‍🔧

1. API for launching jobs on cluster/cloud computing platforms (Slurm, GridEngine, GCP).
2. Common machine learning research experiment setups:
    - Launching and collecting multiple random seeds in parallel/batches or async.
    - Hyperparameter searches: Random, Grid, SMBO, PBT and Nevergrad.
    - Pre- and post-processing pipelines for data preparation/result visualization.
3. Automated report generation for hyperparameter search experiments.
4. Storage/retrieval of results and database in Google Cloud Storage Bucket.
5. Resource monitoring with dashboard visualization.

![](https://github.com/mle-infrastructure/mle-toolbox/blob/main/docs/mle_toolbox_structure.png?raw=true)

## The 4 Step `mle-toolbox` Cooking Recipe 🍲

1. Follow the [instructions below](https://github.com/mle-infrastructure/mle-toolbox#installation-) to install the `mle-toolbox` and set up your credentials/configuration.
2. Read the [docs](https://mle-infrastructure.github.io) explaining the pillars of the toolbox & the experiment meta-configuration job `.yaml` files .
3. Learn more about the individual infrastructure subpackages with the [dedicated tutorial](https://github.com/mle-infrastructure/mle-tutorial).
4. Check out the [examples 📄](https://github.com/mle-infrastructure/mle-toolbox#examples-) to get started: [Single Objective Optimization](https://github.com/mle-infrastructure/mle-toolbox/tree/main/examples/toy_single_objective), [Multi Objective Optimization](https://github.com/mle-infrastructure/mle-toolbox/tree/main/examples/toy_multi_objective).
5. Run your own experiments using the [template files, project](https://github.com/mle-infrastructure/mle-project) and [`mle run`](https://mle-infrastructure.github.io/mle_toolbox).


## Installation ⏳

If you want to use the toolbox on your local machine follow the instructions locally. Otherwise do so on your respective cluster resource (Slurm/SGE). A PyPI installation is available via:

```
pip install mle-toolbox
```

Alternatively, you can clone this repository and afterwards 'manually' install it:

```
git clone https://github.com/mle-infrastructure/mle-toolbox.git
cd mle-toolbox
pip install -e .
```

## Setting Up Your Toolbox Configuration 🧑‍🎨

By default the toolbox will support local runs without any GCS storage of your experiments. If you want to integrate the `mle-toolbox` with your SGE/Slurm clusters, you have to provide additional data. There 2 ways to do so:

1. After installation type `mle init`. This will walk you through all configuration steps in your CLI and save your configuration in `~/mle_config.toml`.
2. Manually edit the [`config_template.toml`](config_template.toml) template. Move/rename the template to your home directory via `mv config_template.toml ~/mle_config.toml`.

The configuration procedure consists of 4 optional steps, which depend on your needs:

1. Set whether to store all results & your database locally or remote in a GCS bucket.
2. Add SGE and/or Slurm credentials & cluster-specific details (headnode, partitions, proxy server, etc.).
3. Add the GCP project, GCS bucket name and database filename to store your results.
4. Add credentials for a [slack bot](https://github.com/sprekelerlab/slack-clusterbot/) integration that notifies you about the state of your experiments.


## The Core Toolbox Subcommands 🌱

You are now ready to dive deeper into the specifics of [experiment configuration](https://mle-infrastructure.github.io/mle_toolbox/experiments/) and can start running your first experiments from the cluster (or locally on your machine) with the following commands:

|   | Command              |        Description                                                        |
|-----------| -------------------------- | -------------------------------------------------------------- |
|🚀| `mle run`      | Start up an experiment (multi-config/seeds, search).              |
|🖥️| `mle monitor`       | Monitor resource utilisation ([`mle-monitor`](https://github.com/mle-infrastructure/mle-monitor) wrapper).              |
|📥	| `mle retrieve`       | Retrieve experiment result from GCS/cluster.              |
|💌| `mle report`       | Create an experiment report with figures.              |
|⏳| `mle init`       | Setup of credentials & toolbox settings.              |
|🔄| `mle sync`       | Extract all GCS-stored results to your local drive.              |
|🗂| `mle project`    | Initialize a new project by cloning [`mle-project`](https://github.com/mle-infrastructure/mle-project).   
|📝| `mle protocol`    | List a summary of the most recent experiments.

You can find more documentation for each subcommand [here](https://mle-infrastructure.github.io/mle_toolbox/subcommands/).
