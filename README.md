<div align="center">

# Self-Evolving Scientific Agent Designs Physically Reasoned White-Box Fluid Control

Boai Sun · Wenjin Guo · Zongmin Yu · Liu Yang

[Scientific Computing and Intelligence Group (Scaling Group) · National University of Singapore](https://scaling-group.github.io)

**[Read the paper on arXiv](https://arxiv.org/abs/2606.08405)** ·
[Paper PDF](https://arxiv.org/pdf/2606.08405) ·
[Explore the results](code/plotting/README.md) ·
[Reproduce](#reproduce-the-results) ·
[Cite](#citation)

</div>

## Overview

Our code implements a scientific agent workflow for building interpretable fluid
controllers through simulation, physical reasoning and iterative code refinement.
The testbed is an underactuated, two-joint dogfish swimmer navigating an unsteady flow.

This is the public data and code release for the work. It contains experimental
records, controller source code, agent evolution logs, and the scripts needed to
extract plotting data and generate 24 standalone panels and three related tables.
The plotting scripts cover Figures 1–5 and Supplementary Figures 1–3.

## Explore the results

Start with the **[figure and table index](code/plotting/README.md)** to find the data
and code behind a result. The [measurement definitions](raw_data/README.md)
defines measurement fields, units and scoring conventions.

| What you want to inspect | Where to start |
| --- | --- |
| Manuscript and Supplementary figures and tables | [Panel and table mappings](code/plotting/README.md) · [Plotting scripts](code/plotting/) · [Derived data](derived_data/) |
| Agent evolution and controller development | [2D run archives](agent_logs/two_dimensional/) · [3D run archives](agent_logs/three_dimensional/) |
| Policy evaluation scores | [2D score records](raw_data/policy_scores/two_dimensional/) · [3D score records](raw_data/policy_scores/three_dimensional/) |
| Generalization and fixed-policy comparisons | [Configurations and policies](code/generalization/) · [Evaluation records](raw_data/generalization/) |
| Deep reinforcement learning baselines | [Training records](raw_data/drl_training/) · [Training code](code/drl/) |
| Flow fields, trajectories and physical mechanisms | [2D examples](raw_data/illustrated_2d/) · [Generalization examples](raw_data/illustrated_generalization/) · [Mechanisms](raw_data/physical_mechanisms/) · [3D experiments](raw_data/three_dimensional/) |
| Numerical validation | [Simulation code and run guide](code/simulation/validation/README.md) · [CFD records](raw_data/cfd_validation/) · [Moving-window records](raw_data/moving_window_validation/) |

For simulator sources, runtime environments and rendering commands, see the
**[code guide](code/INDEX.md)**.

The 2D and 3D run archives share candidate-numbered policy, guidance and agent-call
folders. Policy evaluation scores are grouped by dimension in `raw_data/policy_scores/`.
The extraction scripts read the saved [2D policy scores](raw_data/policy_scores/two_dimensional/)
and [3D evaluation records](raw_data/policy_scores/three_dimensional/) directly to generate plotting data.

## Reproduce the results

The reproducible path is:

```text
raw_data/ + agent_logs/ + scientific code
    -> code/reproduction/extract_derived_data.py
    -> derived_data/
    -> code/plotting/build_all.py
    -> manuscript panels and tables
```

The experimental records are in `raw_data/` and `agent_logs/`; `derived_data/`
contains the processed inputs used by the plots and tables. For example, CFD
convergence and transition summaries are computed from force histories and
vorticity fields.

| Task | Scripts | Entry point |
| --- | --- | --- |
| Extract raw records into derived data | [code/reproduction/](code/reproduction/) | [extract_derived_data.py](code/reproduction/extract_derived_data.py) |
| Generate the manuscript subpanels | [code/plotting/](code/plotting/) | [build_all.py](code/plotting/build_all.py); individual figure scripts are in the same directory |
| Generate the three tables | [code/plotting/](code/plotting/) | [tables.py](code/plotting/tables.py) |

Input mappings and scientific selections are defined by the index files alongside
the [extraction scripts](code/reproduction/index.json) and
[plotting scripts](code/plotting/index.json).

Extraction and plotting use the stored experimental records. They need neither
new CFD simulations nor a GPU. The 3D field extractor uses VTK; rendering uses an
available OpenGL context (tested with off-screen VTK on Windows x64).

### 1. Set up

Use Python 3.12. From the repository root, in a Python environment of your choice:

```sh
python -m pip install -r code/reproduction/requirements.txt
```

The reproduction requirements include the plotting dependencies. CFD simulation
and DRL training have separate environments described in the [code guide](code/INDEX.md).

### 2. Extract derived data

Reconstruct all 84 figure/table inputs from the raw records and compare them with
the included derived data:

```sh
python code/reproduction/extract_derived_data.py --output-dir ../agent-fluid-derived --compare-dir derived_data
```

The comparison checks CSV values, JSON content, controller bytes and every NumPy
array. The extraction report records source hashes and each transformation.
Omit `--output-dir` to regenerate the repository's `derived_data/` itself.

### 3. Generate the panels and tables

```sh
python code/plotting/build_all.py --output-dir ../agent-fluid-figures
```

This command generates 24 standalone panels as PDF, SVG and PNG, plus Table 1
and Supplementary Tables 1–2 as TeX, in `../agent-fluid-figures/`.

The build reads the included `derived_data/` by default. To plot the separately
regenerated directory from step 2, set the environment variable
`AGENT_FLUID_DERIVED_DATA` to that directory's absolute path before running it.

List panel coverage or build one figure group with:

```sh
python code/plotting/build_all.py --list
python code/plotting/build_all.py --figure 5 --output-dir ../agent-fluid-figures
```

Available build groups are `1`, `2`, `3`, `4`, `5`, `S1`, `S2` and `S3`.
Extended Data Figure 1 contains only conceptual schematics and no experimental
data, so it is not included in these build groups.

[Panel mappings](code/plotting/index.json) identify each panel's inputs and statistical
definitions. Field selections and processing parameters are recorded in the
extraction provenance and the [field selections](code/reproduction/).

### Optional: Check data consistency

This optional check compares the recorded and reconstructed results. It is not
required to extract data or generate the panels and tables.

```sh
python code/reproduction/verify.py --output ../agent-fluid-verification.json
```

It checks the original experimental records, recomputes all 130 generalization
outcomes and the five paired moving-window comparisons, checks 2D/3D agent logs
and 3D scores, and compares all 84 derived outputs with a fresh extraction.
Numerical comparisons allow floating-point roundoff; missing records, inconsistent
run identities and differences beyond the reported tolerances are flagged.

## Repository layout

| Directory | Contents |
| --- | --- |
| [agent_logs/](agent_logs/) | Agent sessions, policy notes and evolution records |
| [code/](code/) | Simulators, controllers, fixed policies and reproduction scripts |
| [raw_data/](raw_data/) | Experimental records, trajectories, fields and metrics |
| [derived_data/](derived_data/) | Automatically extracted measurements, selected field arrays, vortex meshes and provenance |

Scientific indices and definitions include:

- [Per-panel mappings](code/plotting/index.json) linking each panel to its input data and statistical definitions.
- [Extraction selections](code/reproduction/index.json) and [keyframes](code/reproduction/keyframes.index.json) identifying the original experiments, controllers and flow frames to use.
- [Field and unit definitions](raw_data/README.md).
- [Supplementary Table 2 text](code/plotting/tables.index.json), which contains authored controller interpretations rather than measured results.

## Citation

If you use these data or tools, please cite the
[paper](https://arxiv.org/abs/2606.08405) and record the repository commit used
in your analysis.

```bibtex
@misc{sun2026whitebox,
  title         = {Self-Evolving Scientific Agent Designs Physically Reasoned White-Box Fluid Control},
  author        = {Sun, Boai and Guo, Wenjin and Yu, Zongmin and Yang, Liu},
  year          = {2026},
  eprint        = {2606.08405},
  archivePrefix = {arXiv},
  primaryClass  = {cs.AI},
  doi           = {10.48550/arXiv.2606.08405},
  url           = {https://arxiv.org/abs/2606.08405}
}
```

## License

Our original code, data, documentation and agent logs are licensed under
[Apache License 2.0](LICENSE). Third-party code and adapted portions retain
their upstream licenses.

The CFD runtime uses [WaterLily.jl](https://github.com/WaterLily-jl/WaterLily.jl)
(MIT); foil validation also uses ParametricBodies.jl (MIT). Their copyright
notices, license texts and source attributions are preserved in
[Third-party notices](THIRD_PARTY_NOTICES.md). Other dependencies and cited
benchmark data retain their own terms.
