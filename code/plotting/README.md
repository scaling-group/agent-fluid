# Scientific panel and table index

Paths below are relative to the repository root. This index links the manuscript
figures and tables to their scientific inputs and source code. The plotting
scripts generate 24 panels for Figures 1–5 and Supplementary Figures 1–3, along
with three tables. Extended Data Figure 1 illustrates the swimmer geometry and
CFD update equations defined in the simulation code. It contains only conceptual
schematics and no experimental data, so it is not included in the build groups.

| Display | Scientific inputs | Panel generator |
| --- | --- | --- |
| Figure 1 | Figure 2's measured trajectory, field and evolution records; workflow code | `code/plotting/figure_01.py` |
| Figure 2a–e | `derived_data/figure_02/`; 2D evolution, DRL records, executable champion and three illustrated episodes | `code/plotting/figure_02_evolution_target_capture.py` |
| Figure 3a–d | `derived_data/figure_03/`; four original generalization episodes, six VTI fields per case | `code/plotting/figure_03.py` |
| Figure 4a–f | `derived_data/figure_04/`; retained controllers, pressure/vorticity fields, phase and ablation measurements | `code/plotting/figure_04.py` |
| Figure 5a–b | `derived_data/figure_05/data/`; original replay trajectory, 12 T midplane and four 3D vortex meshes | `code/plotting/figure_05.py` |
| Figure 5c | `derived_data/figure_05/data/learning_curves.csv`; all three naive and three transfer runs | `code/plotting/figure_05_learning.py` |
| Extended Data Figure 1a–b (`figure_06`) | Swimmer geometry and CFD update equations | Conceptual schematics; scientific definitions in `code/simulation/2d/` |
| Supplementary Figure 1a–b | `derived_data/supplementary_figure_01/`; foil transition and grid/force convergence | `code/plotting/supplementary_figure_01.py` |
| Supplementary Figure 2 | `derived_data/supplementary_figure_02/`; cylinder force histories and convergence | `code/plotting/supplementary_figure_02.py` |
| Supplementary Figure 3a–b | `derived_data/supplementary_figure_03/`; matched moving-window/full-field trajectories and 10 T fields | `code/plotting/supplementary_figure_03.py` |
| Table 1 | `derived_data/table_01/`; all 130 fixed-policy evaluation records | `code/plotting/tables.py` |
| Supplementary Table 1 | `derived_data/supplementary_table_01/`; five paired moving-window/full-field releases | `code/plotting/tables.py` |
| Supplementary Table 2 | `code/plotting/tables.index.json`; authored interpretations of executable controller milestones | `code/plotting/tables.py` |

## Indices

[index.json](index.json) lists the figure and table groups. The corresponding
`*.index.json` files associate panels with their data and scientific selections.
[tables.index.json](tables.index.json) contains the controller interpretations
used in Supplementary Table 2.

Raw-data extraction and field selections are defined in
[../reproduction/index.json](../reproduction/index.json) and the companion
`*.index.json` files. Commands are in the [main README](../../README.md#reproduce-the-results);
measurement definitions are in the [measurement definitions](../../raw_data/README.md).
