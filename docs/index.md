# Welcome to the MLE-Infrastructure 🔬

|<img src="images/logos/lab_logging.png" alt="drawing" width="120"/>|  <img src="images/logos/lab_automation.png" alt="drawing" width="120"/> |  <img src="images/logos/lab_management.png" alt="drawing" width="120"/> | <img src="images/logos/lab_protocol.png" alt="drawing" width="120"/> | <img src="images/logos/lab_workspace.png" alt="drawing" width="120"/> |
|:----:|:----: |:----: |:----:| :----:|
| Experiment Logging | Parameter Searches | Experiment Launch  | Experiment Protocol | Experiment Manager |
|<img src="images/logos/logging.png" alt="drawing" width="120"/>|  <img src="images/logos/hyperopt.png" alt="drawing" width="120"/> | <img src="images/logos/scheduler.png" alt="drawing" width="120"/> | <img src="images/logos/monitor.png" alt="drawing" width="120"/> | <img src="images/logos/toolbox.png" alt="drawing" width="120"/> |
| [`mle-logging`](https://github.com/mle-infrastructure/mle-logging) | [`mle-hyperopt`](https://github.com/mle-infrastructure/mle-hyperopt) | [`mle-scheduler`](https://github.com/mle-infrastructure/mle-scheduler) | [`mle-monitor`](https://github.com/mle-infrastructure/mle-monitor)  | [`mle-toolbox`](https://github.com/mle-infrastructure/mle-toolbox) |
| [![GitHub stars](https://img.shields.io/github/stars/mle-infrastructure/mle-logging.svg?style=social)](https://GitHub.com/mle-infrastructure/mle-logging/stargazers/) | [![GitHub stars](https://img.shields.io/github/stars/mle-infrastructure/mle-hyperopt.svg?style=social)](https://GitHub.com/mle-infrastructure/mle-hyperopt/stargazers/) | [![GitHub stars](https://img.shields.io/github/stars/mle-infrastructure/mle-scheduler.svg?style=social)](https://GitHub.com/mle-infrastructure/mle-scheduler/stargazers/)  | [![GitHub stars](https://img.shields.io/github/stars/mle-infrastructure/mle-monitor.svg?style=social)](https://GitHub.com/mle-infrastructure/mle-monitor/stargazers/) |  [![GitHub stars](https://img.shields.io/github/stars/mle-infrastructure/mle-toolbox.svg?style=social)](https://GitHub.com/mle-infrastructure/mle-toolbox/stargazers/) |
[![Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/mle-infrastructure/mle-logging/blob/main/examples/getting_started.ipynb) | [![Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/mle-infrastructure/mle-hyperopt/blob/main/examples/getting_started.ipynb) | [![Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/mle-infrastructure/mle-scheduler/blob/main/examples/getting_started.ipynb) | [![Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/mle-infrastructure/mle-monitor/blob/main/examples/getting_started.ipynb) |  [![Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/mle-infrastructure/mle-toolbox/blob/main/examples/getting_started.ipynb) |

The MLE-Infrastructure provides a reproducible workflow for distributed Machine Learning experimentation (MLE) with minimal engineering overhead. The core consists of 5 packages:

- [`mle-logging`](https://github.com/mle-infrastructure/mle-logging): Experiment logging with easy multi-seed and configuration aggregation.
- [`mle-hyperopt`](https://github.com/mle-infrastructure/mle-hyperopt): Hyperparameter Optimization with config export, refinement & reloading.
- [`mle-monitor`](https://github.com/mle-infrastructure/mle-monitor): Monitor cluster/cloud VM resource utilization & protocol experiments.
- [`mle-scheduler`](https://github.com/mle-infrastructure/mle-scheduler): Schedule & monitor jobs on Slurm, GridEngine clusters & GCP VMs.
- [`mle-toolbox`](https://github.com/mle-infrastructure/mle-toolbox): Glues everything together to manage & post-process experiments.

<br>
<a href="images/logo_overview.png"><img src="images/logo_overview.png" width="780" align="center" /></a>
<br>

**Note I**: A template repository of an infrastructure-based project can be found in the [`mle-project`](https://github.com/mle-infrastructure/mle-project). You can inspect your experiment stack in an interactive web UI: [`mle-laboratory`](https://github.com/mle-infrastructure/mle-laboratory).

**Note II**: [`mle-logging`](https://github.com/mle-infrastructure/mle-logging), [`mle-hyperopt`](https://github.com/mle-infrastructure/mle-hyperopt), [`mle-monitor`](https://github.com/mle-infrastructure/mle-monitor) and [`mle-scheduler`](https://github.com/mle-infrastructure/mle-scheduler) are standalone packages and can be used independently of the utilities provided by the [`mle-toolbox`](https://github.com/mle-infrastructure/mle-toolbox).
