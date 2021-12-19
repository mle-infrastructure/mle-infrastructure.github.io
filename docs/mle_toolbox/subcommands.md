# MLE Subcommands

## `mle run` - Experiment Execution

<a href="../core_api/mle_run.gif"><img src="../core_api/mle_run.gif" width=900 align="center" /></a>

An experiment can be launched from the command line via:

```
mle run <experiment_config>.yaml
```

You can add several command line options, which can come in handy when debugging or if you want to launch multiple experiments sequentially:

- `--no_welcome`: Don't print welcome messages at experiment launch.
- `--no_protocol`: Do not record experiment in the PickleDB protocol database.
- `--resource_to_run <resource>`: Run the experiment on the specified resource.

In the following we walk through the different types of supported experiments and show how to provide the necessary configuration specifications.


## `mle monitor` - Monitor Resources

<a href="../core_api/mle_monitor.gif"><img src="../core_api/mle_monitor.gif" width=900 align="center" /></a>


## `mle retrieve` - Retrieve Results

<a href="../core_api/mle_retrieve.gif"><img src="../core_api/mle_retrieve.gif" width=900 align="center" /></a>


## `mle report` - Report Results

<!-- <a href="../core_api/mle_report.gif"><img src="../core_api/mle_report.gif" width=900 align="center" /></a> -->

## `mle init` - Setup The Toolbox Configuration

<!-- <a href="../core_api/mle_init.gif"><img src="../core_api/mle_init.gif" width=900 align="center" /></a> -->


## `mle sync-gcs` - Download GCS-Backed Experiments

<!-- <a href="../core_api/mle_sync.gif"><img src="../core_api/mle_sync.gif" width=900 align="center" /></a> -->


## `mle project` - Initialize New Template Project

<!-- <a href="../core_api/mle_project.gif"><img src="../core_api/mle_project.gif" width=900 align="center" /></a> -->


## `mle protocol` - List State of Protocol

<!-- <a href="../core_api/mle_protocol.gif"><img src="../core_api/mle_protocol.gif" width=900 align="center" /></a> -->
