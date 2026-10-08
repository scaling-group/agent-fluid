# Multi-wake target-policy candidate diagnosis

## Evidence read before editing

- The assigned parent is the response-plus-stroke-scheduled posterior-rudder
  relief policy currently prefilled in `solver/`. Its inherited optimizer log
  records a third same-score, same-crossing capture at
  `-0.32517157465908086` and `0.749162L`, in addition to the two sampled copies
  below. Only the samples expose byte-identical trajectories; this is evidence
  of a fixed-pose plateau, not held-out robustness.
- `solver_43e27134a723` is the strongest sample with complete visual evidence.
  It uses direct uniform still water, captures at `24.310009T`, crosses at
  `0.749162L`, and has `2.223959L` mean distance. Its top-down row shows a
  self-propelled S-shaped approach rather than passive advection; its oblique
  row shows discrete alternating three-dimensional Lambda2 structures from
  release through capture. The inherited diagnostics put peak normalized
  force/moment at `0.031649/0.016385`, with finite joint-rate saturation.
- `solver_392ed1eddf30` is the informative matched terminal-allocation
  failure with complete visual evidence. Whole-cycle posterior relief retains
  the same route and coherent wake but captures three control steps later at
  `24.326511T`, crosses at `0.749329L`, and has `2.224097L` mean distance.
  The visual match localizes the useful difference to terminal allocation,
  rather than propulsion formation or route topology.
- `solver_a9222453ae0c` replaces the beat-scale closing response with
  translation alignment and is later again at `24.343010T`; its blank oblique
  row is a render artifact, so only its top-down and numerical evidence are
  usable. `solver_c85ef8d2aea3` exactly repeats the strong numerical/top-down
  result but also has a blank oblique row.
- In the complete strong trace, distance falls from `1.3779L` at `22.506T` to
  `0.7492L` at capture while the rhythmic carrier remains active. Near the
  crossing, full target error remains large but improves from about `1.455`
  to `1.324 rad`; the reflection-invariant signed bearing trend settles near
  `-0.13` to `-0.17 rad/T`. Thus the controller is already producing a useful
  target-relative redirect response, yet its anterior redirect remains fully
  scheduled by error and phase speed. This is a distinct remaining allocation
  hypothesis from another posterior-rudder or closing-sensor adjustment.

## Candidate hypothesis

Keep the reproduced carrier, slip-aware anterior center, posterior load sign,
and stroke-qualified closing-deficit rudder relief exactly. Add a bounded
near-field response release only to the additive anterior redirect: inside a
normalized `1.5--1.0L` approach gate, use
`geometric_turn * bearing_window_rate` to distinguish growing target error
from recovery, and smoothly remove at most 20% of the redirect when recovery
reaches the evidenced `0.05--0.15 rad/T` band. The product is reflection
invariant, uses no world route or clock, and leaves the oscillator term intact.

Expected result: the controller should preserve the preterminal trajectory and
three-dimensional carrier wake, reduce competing anterior steering effort once
the target-relative response is established, and capture no later than
`24.310009T` with mean distance no worse than `2.223959L`. Falsify the mechanism
if capture is lost or delayed, the route changes before `1.5L`, target error
grows during the release, or action, saturation, force, moment, or wake quality
worsens.

bookshelf_consulted: true
source_domain: biological burst turning and sensor-modulated robotic-fish CPG control
source_mechanism: release a strong redirect after an observed heading response and return continuously to a propulsive rhythm
transferable_invariant: steering authority should depend on target-relative response as well as error, while the traveling carrier remains active
nontransferable_details: species kinematics, published CPG gains, dimensional rates, exact vortex phase, and prescribed burst timing
policy_translation: use signed normalized body-frame bearing-window rate and distance to bound a near-field release of only the anterior redirect; preserve both joint-state carrier terms and the evidenced posterior rudder
falsification: reject if the fixed-pose capture is later than 24.310009T or mean distance exceeds 2.223959L, or if preterminal route, coherent 3D wake, saturation, effort, force, or moment worsens
