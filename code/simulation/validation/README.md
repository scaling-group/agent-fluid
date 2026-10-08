# CFD validation

The validation sources follow the three parts of the Supplementary Information:

| Directory and entry point | Experiment | Results |
| --- | --- | --- |
| `2d/oscillating_foil2d.jl` | NACA0016 wake transition and thrust/efficiency convergence | Supplementary Figure 1 |
| `3d/oscillating_cylinder3d.jl` | Prescribed-motion 3D cylinder and mean power convergence | Supplementary Figure 2 |
| `moving_window/moving_window_policy3d.jl` | Frozen feedback policy for the five matched 3D moving-window/full-field pairs | Supplementary Figure 3 and Supplementary Table 1 |

The 2D foil and 3D cylinder use the shared `Project.toml` and `Manifest.toml`
in this directory, with Julia 1.12.6 and WaterLily 1.8.0. Install once from
the repository root:

```sh
julia --project=code/simulation/validation -e 'using Pkg; Pkg.instantiate()'
```

## 2D: oscillating foil

The paper uses pure pitching about the leading edge of a NACA0016 foil at
`Re = 1173`. This entry point records thrust, lift, moment, input power,
propulsive efficiency and optional vorticity fields.

The thrust/efficiency convergence study uses `Sr = 0.25`, `A_D = 0.87412`,
30 warm-up cycles and four sampling cycles, at `L = 16, 32, 48, 64, 80, 96,
112, 128`. For example:

```sh
julia --project=code/simulation/validation code/simulation/validation/2d/oscillating_foil2d.jl \
  --L=64 --motion=pitch --pivot-fraction=0 --Re=1173 --A-D=0.87412 --Sr=0.25 \
  --warmup-cycles=30 --sample-cycles=4 --grid-dt=0.024 --backend=cuda \
  --output=../foil-validation-n64
```

The wake-transition study uses the same entry point with `L=64`,
`--save-vorticity=true` and seven Strouhal numbers: `0.16, 0.18, 0.20, 0.225,
0.25, 0.285, 0.32`. Each sampled amplitude is recorded in
`raw_data/cfd_validation/transition/*/summary.json`. Grid records are in
`raw_data/cfd_validation/grid_convergence/` and `grid_ct_eta/`.

## 3D: oscillating cylinder

Use a CUDA GPU. The cylinder follows prescribed streamwise and transverse
oscillations at `Re = 7620`, `Vr = 5.4`, `Ax/D = 0.4`, `Ay/D = 1.6`,
phase `π/6` and perturbation seed `1234`.

```sh
WATERLILY_OSC_N=32 \
WATERLILY_OSC_WARMUP_PERIODS=8 \
WATERLILY_OSC_SAMPLE_PERIODS=8 \
WATERLILY_OSC_SAMPLES_PER_PERIOD=100 \
WATERLILY_OSC_FRAME_COUNT=81 \
WATERLILY_OSC_OUTPUT=../oscillating-cylinder-n32 \
julia --project=code/simulation/validation code/simulation/validation/3d/oscillating_cylinder3d.jl
```

The study uses `n = 16, 32, 48, 64, 72, 80, 96, 112, 128`, a grid of
`(4n, 2n, n)` cells and cylinder diameter `D = n/6` cells. The command uses
the study's eight warm-up and eight sampling periods; the driver's short-run
defaults are two periods each. Outputs include `forces.csv`, `summary.json`,
`midplane/frames.csv` and Float32 vorticity fields. Retained records are in
`raw_data/cfd_validation/oscillating_cylinder/`.

## Moving-window comparison

`moving_window/moving_window_policy3d.jl` supplies the fixed feedback controller
to the [3D simulation sources](../3d/). The simulator loads this policy file.
The [paired-run index](../../../raw_data/moving_window_validation/index.json)
records the five releases and common target. Each pair runs for `10T` at
`L=64`, comparing a `4L × 3L × 1.5L` moving window with the fixed
`24L × 16L × 1.5L` field.

Extraction is in `code/reproduction/`; plotting
is in `code/plotting/supplementary_figure_01.py` through
`supplementary_figure_03.py`.
