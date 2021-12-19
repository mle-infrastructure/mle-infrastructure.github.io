# Toolbox Configuration

By default the toolbox will run locally and without any GCS bucket backup of your experiment results. Furthermore, a lightweight PickleDB protocol database of your experiments will not be synced with the cloud version. In the following, we walkthrough how to

1. Enable the **execution of jobs on remote resources** (cluster/storage) from your local machine or from the resource itself.
2. Enable the **backing up of your experiment results** in a GCS bucket.
3. Enable the **backing up of a PickleDB experiment meta log** in a GCS bucket.
4. Enable resource **monitoring and online dashboard visualization**.
5. Enable **slack bot notifications** for experiment completion and reporting.

**Note**: There are two ways to perform the toolbox configuration:

1. After installation execute `mle init`. This will walk you through all configuration steps in your CLI and save your configuration in `~/mle_config.toml`.
2. Manually edit the [`config_template.toml`](https://github.com/RobertTLange/mle-toolbox/tree/main/config_template.toml) template. Move/rename the template to your home directory via `mv config_template.toml ~/mle_config.toml`.

The configuration procedure consists of 4 optional steps, which depend on your needs:

1. Set whether to store all results & your database locally or remote in a GCS bucket.
2. Add SGE and/or Slurm credentials & cluster-specific details (headnode, partitions, proxy server, etc.).
3. Add the GCP project, GCS bucket name and database filename to store your results.
4. Add credentials for a [slack bot](https://github.com/sprekelerlab/slack-clusterbot/) integration that notifies you about the state of your experiments.


## General Settings 🦿

The configuration starts with a set of basic settings such as the path to your local experiment protocol pickle database, the path to your private key (for passwordless scp/rsync/etc.), environment settings and whether you would like to use slack bot notifications:

```toml
#------------------------------------------------------------------------------#
# 1. General Toolbox Configuration - Verbosity + Whether to use GCS Storage
#------------------------------------------------------------------------------#
[general]
# Local filename to store protocol DB in
local_protocol_fname = '~/local_mle_protocol.db'

# Path to private key for passwordless SSH access
pkey_path = '~/.ssh/id_rsa'

# Whether to use conda or venv for experiment virtual environment
use_conda_venv = true
use_venv_venv = false

# Whether to use slack bot notifications
use_slack_bot = false

# Set remote experiment submission environment name
remote_env_name = 'mle-toolbox'

# Set the random seed for the toolbox/full experiment reproducibility
random_seed = 42
```

You can also set the random seed for reproducibility of your hyperparameter search schedules.

## Remote Resource Execution 🏃

The toolbox supports the usage of multiple different compute resources. This includes your local machine, but more importantly remote clusters such as the prominent Slurm and Grid Engine schedulers and Google Cloud Platform VMs. In order to be able to schedule remote jobs from your local machine or retrieve the results from the cluster, you will have to provide your credentials, headnode and partition names as well as some default arguments for jobs:

```toml
#------------------------------------------------------------------------------#
# 2. Configuration for Slurm Cluster
#------------------------------------------------------------------------------#
[slurm]
    # Slurm credentials - Only if you want to retrieve results from cluster
    [slurm.credentials]
    user_name = '<slurm-user-name>'

    # Slurm cluster information - Job scheduling, monitoring & retrieval
    [slurm.info]
    # Partitions to monitor/run jobs on
    partitions = ['<partition1>']

    # Info for results retrieval & internet tunneling if local launch
    main_server_name = '<main-server-ip>'   # E.g. 'gateway.hpc.tu-berlin.de'
    jump_server_name = '<jump-host-ip>'   # E.g. 'sshgate.tu-berlin.de'
    ssh_port = 22
    # Add proxy server for internet connection if needed!
    http_proxy = "http://<slurm_headnode>:3128/"  # E.g. 'http://frontend01:3128/'
    https_proxy = "http://<slurm_headnode>:3128/"  # E.g. 'http://frontend01:3128/'

    # Default Slurm job arguments (if not supplied in job .yaml config)
    [slurm.default_job_args]
    num_logical_cores = 2
    gpu_tpye = "tesla"
    partition = '<partition1>'
    job_name = 'temp'
    log_file = 'log'
    err_file = 'err'
    env_name = '<mle-default-env>'
```

## Google Cloud Platform ☁️

If you want to use the toolbox for orchestrating GCP VMs, you will need to have set up the [Google Cloud SDK](https://cloud.google.com/sdk/docs/install). This will work as follows:

```
curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-353.0.0-linux-x86_64.tar.gz
./google-cloud-sdk/install.sh
./google-cloud-sdk/bin/gcloud init
```

At initialization you will be required to select a GCP project. Internally the toolbox will call different `gcloud` commands to launch new VMs and/or monitor the status of running jobs.

### GCS Bucket Backups 🗳️

If you choose so, the toolbox will sync a local version of your experiment protocol database with a GCS bucket. Furthermore, the results of your experiments will be zipped and stored via a unique hash. You can afterwards use [`mle retrieve`](../../core_api/mle_retrieve/) in order to retrieve these backed up results from the bucket. These functionalities rely on `google-cloud-storage` and you having set your `GOOGLE_APPLICATION_CREDENTIALS`. You have to follow four steps:

1. Create your `.json` key file [here](https://cloud.google.com/docs/authentication/getting-started). Name it `~/gcp_mle_key.json`
2. Set the path via adding `export GOOGLE_APPLICATION_CREDENTIALS = ~/gcp_mle_key.json` to your `.bashrc` or `.zshrc` file.
3. Create a GCP project and a storage bucket. Have a look [here](https://cloud.google.com/storage/docs/creating-buckets) for how to do this.
4. Provide the path, GCP project and bucket to store your results in your `~/mle_config.toml` configuration:

```toml
#------------------------------------------------------------------------------#
# 4. GCP Config - Credentials, Project + Buffer for Meta-Experiment Protocol
# OPTIONAL: Only required if you want to sync protocol with GCS
#------------------------------------------------------------------------------#
[gcp]
# Set GCloud project and bucket name for storage/compute instances
project_name = "<gcloud_project_name>"
bucket_name = "<gcloud_bucket_name>"

# Filename to retrieve from gcloud bucket & where to store
protocol_fname = "gcloud_mle_protocol.db"

# Syncing of protocol with GCloud
use_protocol_sync = false

# Storing of experiment results in bucket
use_results_storage = false

    # Default GCP job arguments (if not differently supplied)
    [gcp.default_job_arguments]
    num_logical_cores = 2
    num_gpus = 0
    use_tpus = false
    job_name = 'temp'
    log_file = 'log'
    err_file = 'err'
```

## Slack Bot Notification 🔈

If you want to, you can add slack notifications using the [`slack-clusterbot`](https://github.com/sprekelerlab/slack-clusterbot/). If you want to learn more about how to set it up, checkout the [wiki documentation](https://github.com/sprekelerlab/slack-clusterbot/wiki/Installation). To make it short, you need to create a Bot User OAuth Access Token for your slack workspace and afterwards add this to your `mle_config.toml`:

```toml
#------------------------------------------------------------------------------#
# 5. Slack Bot Config - OAuth Access Token & Config Path
# https://github.com/sprekelerlab/slack-clusterbot/wiki/Installation
# OPTIONAL: Only required if you want to slack notifications/updates
#------------------------------------------------------------------------------#
[slack]
# Set authentication token and default username messages are sent to
slack_token = "<xyz-token>"
user_name = "<user_name>"
```
