# Candidate diagnosis and hypothesis

## Evidence read before editing

- The assigned v30 parent and the three sampled v33 copies are direct-uniform
  still-water runs (`U_infinity=[0,0,0]`) with no cylinders; all capture and
  shift the moving window 236 times. No inherited candidate-specific optimizer
  note was present under `logs/optimize/` in this workspace.
- Both combined sheets were inspected from release through capture. Their
  top-down rows show self-propelled target progress with a strong, coherent
  alternating wake rather than advection or wake collapse. Their oblique
  Lambda2 rows show the same persistent three-dimensional paired structures
  and a curved final target crossing; neither sheet exposes a distinct visual
  failure, so the policy distinction must come from the terminal traces.
- The assigned v30 load-gated posterior counter-tangent captures at `23.8315T`
  with score/final distance `-0.535298/0.746599L`. The sampled v33 anterior
  half-cycle correction reproduces exactly in three independent examples and
  improves score/final distance to `-0.535091/0.746165L`; it also lowers
  inside-`3L` peak yaw from `3.2645` to `3.1848 rad/T`, peak moment from
  `0.014385` to `0.013730`, and mean cross-track speed from `0.2449U` to
  `0.2392U`, at an `0.011T` arrival cost.
- The inherited fixed transfer of continuous route curvature to the anterior
  joint retained capture but regressed score/final distance to
  `-0.535920/0.747022L`. This rules out another mean-bend redistribution even
  though the anterior joint is the better phase-selected corrective coordinate.
- Smooth acceleration projection is not the remaining feasibility solution:
  v33 stays below the projected command scale but the anterior joint is still
  at the `260 deg/T` velocity cap for `12.09%` of all samples and `10.96%` of
  samples inside `3L` (v30: `12.12%` and `11.17%`). The sampled center shift
  improves path/load peaks without materially changing this kinematic exposure.

## Policy hypothesis

Start from the reproducible v33 policy, preserving its oscillator, posterior
lag/amplitude, continuous target-course bend, smooth command projection, and
phase-selected anterior counter-curvature. Add one compatible mechanism: a
soft anterior outstroke energy shaper. It contributes damping only when terminal
excess-yaw feedback selects a supporting tail side and normalized anterior
joint velocity is moving farther into that same side. It is zero on the return
stroke, outside the terminal gate, or without excess yaw. This should reduce
velocity-cap dwelling and the remaining yaw/load burst without changing the
cycle-mean route bend or weakening posterior thrust.

Falsify the mechanism if it loses capture, materially regresses v33-scale
score/arrival/final distance, weakens the alternating wake, increases joint-limit
exposure, or fails to improve at least one of anterior velocity-cap exposure,
terminal yaw, moment, or cross-track speed without worsening the others.

bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping and closed-loop CPG modulation
source_mechanism: half-cycle amplitude asymmetry driven by sensed state
transferable_invariant: change energy on only the motion phase that reinforces an unwanted turn while preserving the propulsive return phase
nontransferable_details: published gains, clocked CPG phase, species-specific kinematics, dimensional cadence, and task-specific routes
policy_translation: use terminal carrier-rejected yaw, observed tail tangent, and anterior joint velocity normalized by oscillator amplitude-rate to gate bounded anterior outstroke damping under the two-joint state-feedback contract
falsification: reject if capture or v33-scale distance progress regresses, the coherent wake weakens, loads rise, or velocity-cap exposure is not reduced
