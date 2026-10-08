# Phase 2 candidate diagnosis and hypothesis

## Evidence diagnosis before editing

- The assigned prefill and all four sampled solvers satisfy the direct-uniform
  still-water contract (`U_infinity=[0,0,0]`), remain stable, and terminate by
  capture. Two sampled artifacts exactly reproduce the prefill at
  `18.0125T`, score/mean distance `-0.064599/1.950823L`, and therefore make it
  the supported starting point rather than a scalar-only retuning target.
- I inspected both the top-down vorticity and oblique Lambda2 rows for the
  prefill, the lower-scoring consensus-qualified comparator, the unguarded
  posterior-work comparator, and the latest inherited wave-only guard. Each
  fish self-propels from direct-uniform still water, establishes a coherent
  alternating wake by `4T`, and retains compact paired 3D posterior structures
  through capture. No sampled non-capture failure is available; the inherited
  wave-only regression is the most informative negative visual example. Its
  wake also stays coherent, so route and distance histories—not gross vortex
  appearance—separate these controllers.
- The full-tail-target phase guard improves the unguarded reserve's
  score/mean distance from `-0.072146/1.958037L` to
  `-0.064599/1.950823L` and preserves first-`3T` mean distance/speed at
  `12.214593L/0.2519U`. Its cost is a wider, later capture: center path and
  maximum head cross-track rise from `13.0071L/0.6102L` to
  `13.2330L/0.7417L`, near-target course alignment falls from `0.787` to
  `0.664`, and arrival slips from `17.8695T` to `18.0125T`.
- Two inherited completed release tests rule out another posterior-work gate.
  Response-energy release regressed to score/mean distance
  `-0.082282/1.968655L`. Testing work phase only against the oscillatory tail
  target shortened path/cross-track to `12.9783L/0.5621L`, but lost early
  distance/speed (`12.218702L/0.2469U`) and regressed score/mean distance to
  `-0.080637/1.966422L`. Thus neither scalar response magnitude nor strict
  propulsion/steering separation is a supported progress certificate.
- The formal moving-window adapter supplies `velocity_body_U` directly in
  normalized speed units; the sampled trace reaches body-frame lateral speeds
  `-0.520..0.623U` with `0.310U` RMS. The current guidance module divides that
  field by `params.L` a second time. Consequently the active
  `target_lateral_velocity_gain=0.20` contributes only about `0.001` RMS to
  the turn request instead of about `0.062`, leaving its intended body-slip
  feedback effectively absent. This is a field-semantics defect, not evidence
  for changing the gain.

## One policy hypothesis

Preserve the prefill's carrier, lagged posterior wave, full-tail-target
phase-consistency guard, closure qualification, mean-curvature and
beat-synchronous steering, far-route observer, approach handoff, and
reversal-preserving output governor. Make exactly one semantic correction:
use the already normalized lateral component of `velocity_body_U` directly in
the existing target-lateral-velocity feedback instead of dividing it by
`L=64` again. This restores a bounded body-frame course/slip residual without
adding a route, clock, case identity, or new gain.

Expected evidence is retention of coherent self-propulsion and the prefill's
first-`3T` and mean-distance advantage, with less accumulated cross-track,
shorter path, and better approach alignment. Reject the correction if
instantaneous lateral gait motion drives extra switching, worsens mean
distance or arrival, raises actuator/load class, or disrupts either visual
wake row. The new candidate has not received CFD evaluation, so these are
predictions rather than results.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG path following and bounded target-vector turning
source_mechanism: measured body-frame lateral motion modulates the steering residual while the propulsive oscillator remains intact
transferable_invariant: course feedback must consume a dimensionless body-frame lateral-velocity observation at its actual normalized scale
nontransferable_details: published feedback gains, dimensional cadence, robot geometry, species-specific envelopes, exact vortex phases, and prescribed routes
policy_translation: remove the duplicate length normalization from the existing `velocity_body_U[2]` steering residual while preserving its owned bounded gain and all other controller paths
falsification: reject if productive gait sway is mistaken for route slip, causing worse distance, path, arrival, actuator/load class, or top-down and oblique wake coherence
