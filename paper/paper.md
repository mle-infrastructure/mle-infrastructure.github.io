---
title: '`MLE-Infrastructure`: A Set of Lightweight Tools for Machine Learning Experimentation'
tags:
  - Python
  - Machine Learning
  - Experiment Logging
  - Hyperparameter Optimization
authors:
  - name: Robert Tjarko Lange
    affiliation: "1, 2"
affiliations:
 - name: Technical University Berlin
   index: 1
 - name: Science of Intelligence, Research Cluster of Excellence
   index: 2
date: 08 March 2023
bibliography: paper.bib
---

# Summary

Modern Machine Learning research relies on rapid hypothesis testing, often requiring the evaluation of multiple hyperparameter configurations for different random seeds. Instead of having to manually recycle boilerplate code, the academic community can greatly benefit from lightweight modular experimentation tools. The `MLE-Infrastructure` provides such a diverse set of primitives to log, schedule, optimize and monitor experiment runs and configurations. It contributes the following sub-packages:

1. **[`mle-logging`](https://github.com/mle-infrastructure/mle-logging)**: A Lightweight Logger for ML Experiments
2. **[`mle-scheduler`](https://github.com/mle-infrastructure/mle-scheduler)**: A Lightweight Cluster/Cloud VM Job Management Tool
3. **[`mle-hyperopt`](https://github.com/mle-infrastructure/mle-hyperopt)**: A Lightweight Hyperparameter Optimization Tool
4. **[`mle-monitor`](https://github.com/mle-infrastructure/mle-monitor)**: A Lightweight Experiment & Resource Monitoring Tool
5. **[`mle-toolbox`](https://github.com/mle-infrastructure/mle-toolbox)**: A Lightweight Tool to Manage Distributed ML Experiments

# Design Principles & Internal `MLE-Infrastructure` Workflow

The general design fulfils the following principles:

- *Modularity*: Each individual sub-package can be used independently of the others. A researcher who would only like to use the `ask`-`tell` hyperparameter search API does not have to buy into the full ecosystem.
- *Resource Applicability*: The scheduling of individual jobs is not restricted to a single cluster scheduler, but we provide scheduling utilities for local, server-based jobs, GridEngine, Slurm schedulers and Google Cloud Platform virtual machines.
- *Lightweight Dependencies & Extendability*: The tools do not require extensive configuration, nor do they require the installation of experiment protocol databases. Instead, we rely on progressive revelation of complexity.
- *Rapid Prototype Scaling*: In order to rapidly iterate over hypothesis and training design, we reduce the turn-over time going from a prototype training script to a distributed multi-seed parameter search experiment.

![`MLE-Infrastructure` workflow. Each of the individual sub-packages are synthesized by the `mle-toolbox`, which manages the training jobs.](figure.png){ width=100% }

The infrastructure has already been used to produce results for multiple publications [@lange:2020; @vischer:2021].


# Illustrative Example: Multi-Seed Random Search

```python
from mle_hyperopt import RandomSearch
from mle_scheduler import MLEQueue
from mle_monitor import MLEProtocol

# Load (existing) protocol database and add experiment data
protocol_db = MLEProtocol("mle_protocol.db")
meta_data = {
    "purpose": "random search",  # Purpose of experiment
    "experiment_dir": "logs_search",  # Experiment log storage directory
    "experiment_type": "hyperparameter-search",  # Type of experiment to run
    "base_fname": "train.py",  # Main code script to execute
    "config_fname": "base_config.json",  # Config file path of experiment
    "num_seeds": 2,  # Number of evaluations seeds
    "num_total_jobs": 4,  # Number of total jobs to run
}
new_experiment_id = protocol_db.add(meta_data)

# Instantiate random search class
strategy = RandomSearch(
    real={"lrate": {"begin": 0.1, "end": 0.5, "prior": "log-uniform"}},
    integer={"batch_size": {"begin": 1, "end": 5, "prior": "uniform"}},
    categorical={"arch": ["mlp", "cnn"]},
    verbose=True,
)

# Ask for configurations to evaluate & Store configurations
configs, config_fnames = strategy.ask(2, store=True)

# Run parallel eval of seeds * configs - spawn different jobs
queue = MLEQueue(
    resource_to_run="local",
    job_filename="train.py",
    config_filenames=config_fnames,
    random_seeds=[1, 2],
    experiment_dir="logs_search",
    protocol_db=protocol_db,
)
queue.run()

# Merge logs of random seeds & configs -> load & get final scores
queue.merge_configs(merge_seeds=True)
test_scores = [queue.log[r].stats.test_loss.mean[-1] for r in queue.mle_run_ids]

# Update the hyperparameter search strategy
strategy.tell(configs, test_scores)

# Wrap up experiment (store completion time, etc.)
protocol_db.complete(new_experiment_id)
```

# Comparison to Alternative Frameworks

- Ray Tune [@liaw:2018]
- Sacred [@greff:2017]

# Availability, Test Coverage & Getting Started

`MLE-Infrastructure` and all its sub-packages are publicly available under [MIT license](https://github.com/mle-infrastructure/mle-toolbox/blob/main/LICENSE) at <https://github.com/mle-infrastructure>. We provide documentation, extensive testing and example notebooks for each individual sub-package as well as their integration at <https://mle-infrastructure.github.io/>. Finally, we provide a set of [video tutorials](https://www.youtube.com/channel/UC0-TXSpwRL9EQbW-SIqjqjg) to get started.

# Acknowledgements

This work is funded by the Deutsche Forschungsgemeinschaft (DFG, German Research Foundation) under Germany’s Excellence Strategy - EXC 2002/1 “Science of Intelligence” - project number 390523135.

# References
