# Experiment Configuration

Each experiment you want to execute via `mle run` has to be specified via a `.yaml` file. This file has to contain a set of basic ingredients such as meta arguments (which script to execute, etc.) - `meta_job_args`, the experiment type-specific arguments and resource/single job-specific arguments - `single_job_args`.

## Basic Configuration

The `meta_job_args` specify the project name, experiment type, directory and base job script/configuration. For a hyperparameter search experiment it should look as follows:

```yaml
# Meta Arguments: What job? What train .py file? Base config? Where to store?
meta_job_args:
    project_name: "<project_name>"  # Project name for protocol db
    experiment_type: "<experiment_type>"  # ['hyperparameter-search', 'multiple-configs', 'single-config', 'population-based-training']
    experiment_dir: "<experiment_dir>"  # Directory to store results in
    base_train_fname: "<train>.py"  # Base .py/.sh job execution script
    base_train_config: "<train_config>.yaml"  # Base .json/.yaml job configuration
```

The `job_spec_args`, on the other hand, specifies environment settings and the resources required per individual job. E.g.:

```yaml
# Parameters specific to an individual job
single_job_args:
    job_name: "<jname>"  # Job name prefix used for qsub/sbatch
    num_logical_cores: 2  # Number of logical cpu cores
    num_gpus: 1  # Number of gpus required per job
    env_name: "<env_name>"  # Name of virtual environment to activat at startup
    use_conda_venv: true  # Whether to use a conda environment
    time_per_job: "<dd:hh:mm>"  # Time limits of a job
```

Given a fixed training configuration file and the Python training script, the only thing that has to be adapted for the different types of experiments are the experiment type-specific arguments. These include:

- `multi_config_args`: For multi-configuration & multi-seed experiments
- `param_search_args`: For hyperparameter search experiments
- `pbt_args`: For Population-Based Training


## Multiple Configurations & Seeds

```yaml
multi_config_args:
    config_fnames:  # List of configuration files to execute
        - "config_1.json"
        - "config_2.json"
    num_seeds: 2  # Number of seeds to schedule
```


## Hyperparameter Search

```yaml
# Parameters specific to the hyperparameter search
param_search_args:
    search_logging:  # Logging-specific settings
        reload_log: False  # Load a previous hyper log
        verbose_log: True  # Print intermediate batch results
        max_objective: False  # Whether to max or min objective
        aggregate_seeds: "p50"  # Aggregation metric across seeds
        problem_type: "final"  # How to score configs ('final', 'best', 'mean')
        eval_metrics: "test_loss"  # Metric to look up for scoring
    search_resources:  # Resource scheduling settings
        # num_search_batches: 4
        # num_evals_per_batch: 4
        num_total_evals: 4  # Number of total evaluations
        max_running_jobs: 4  # Number of max jobs running at one time
        num_seeds_per_eval: 1  # Number of seeds per evaluation
        random_seeds: [2]  # Explicitly fix seeds to run
    search_config:  # Search strategy-specific settings
        search_type: "grid"
        # search_schedule: "sync"
        search_schedule: "async"  # "sync" or "async" job/batch scheduling
        search_params:
            real:
                lrate:
                    begin: 0.1
                    end: 0.5
                    bins: 2
            integer:
                batch_size:
                    begin: 1
                    end: 5
                    bins: 2
```


## Population-Based Training

**Note**: Population-Based Training is still experimental and will most likely change. More updates to follow. Most likely the toolbox will only support a synchronous version.

```yaml
# Parameters specific to the population-based training
pbt_args:
    pbt_logging:
        max_objective: False
        eval_metric: "test_loss"
    pbt_resources:
        num_population_members: 10
        num_total_update_steps: 2000
        num_steps_until_ready: 500
        num_steps_until_eval: 100
    pbt_config:
        pbt_params:
            real:
                l_rate:
                    begin: 1e-5
                    end: 1e-2
        exploration:
            strategy: "perturb"
        selection:
            strategy: "truncation"
```

## Pre-/Post-Processing

You can also add `pre_processing_args` and `post_processing_args` if you would like to either launch a job before or after the main experiment. This can be useful if you need to prepare some data that is afterwards used by all main experiment jobs or if you want to run some analysis using the networks trained in the main experiment.

```yaml
# Parameters for the pre-processing job
pre_processing_args:
    processing_fname: "<run_preprocessing>.py"
    processing_job_args:
        num_logical_cores: 2
        time_per_job: "00:01:00"
    extra_cmd_line_input:
        figures_dir: "experiments/data"

# Parameters for the post-processing job
post_processing_args:
    processing_fname: "<run_postprocessing>.py"
    processing_job_args:
        num_logical_cores: 2
        time_per_job: "00:01:00"
    extra_cmd_line_input:
        figures_dir: "experiments/figures"
```
