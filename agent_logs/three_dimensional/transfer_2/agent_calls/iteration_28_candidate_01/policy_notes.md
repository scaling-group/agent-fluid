# Evidence-selected v41 terminal phase-allocation candidate

## Visual diagnosis before candidate selection

- The four current solver samples are byte-identical v41 rollouts under the
  frozen direct-uniform still-water contract (`U_infinity=[0,0,0]`, no
  cylinders or prewarm).  Each captures at `24.640015T`, minimum/final
  distance `0.748356L`, mean distance `2.347937L`, and score `-0.448328283`.
- The combined v41 sheet was inspected from release through capture in both
  views.  Its top-down row starts wake-free, shows self-propelled diagonal
  progress with a coherent alternating mid-plane vortex street, and ends in a
  bounded transverse hook into the target disk.  Its oblique row retains
  compact three-dimensional Lambda2 structures through the same maneuver.
  The fish is not passively advected, unstable, or escaping out of plane; the
  trace agrees, with peak absolute planar body-force/yaw-moment coefficients
  `0.02303/0.03169/0.01559` and no sampled joint hard-stop occupancy.
- The informative inherited regression is v42's terminal stroke-headroom
  redistribution.  Its combined sheet is visually in the same coherent wake
  and route class, but its completed trace captures at `24.634514T` and only
  `0.749001L`, with mean distance `2.348455L` and score `-0.448985838`.
  Relative to v41, the one-tick earlier crossing therefore consumes most of
  the geometric margin, worsens mean distance by `0.000518L`, and raises raw
  acceleration-envelope exposure from `73.594%` to `74.124%`; exact-rate
  exposure (`13.820%` versus `13.839%`) and peak-load class are essentially
  unchanged.  Transferring an outward, phase-selected posterior share to the
  anterior phase anchor is not load relief or a useful terminal improvement.
- Earlier inherited failures reinforce the locality boundary: broad
  dual-joint rate barriers and posterior reference-velocity feedforward lowered
  rate statistics while changing the established route and losing capture.
  The evidence supports preserving the observed traveling-bend allocation,
  not another scalar tune or another residual redistribution.

## Candidate hypothesis

Select the current v41 terminal phase-allocation policy as this workspace's
exactly one candidate, byte-identical in dynamics and schema to the four
replicated samples.  Preserve its anterior state-feedback phase anchor,
lagged posterior traveling wave, body-frame projected-miss corridor,
posterior stroke braking and rate coast, and the bounded terminal residual
that acts only on the lagged-wave half-cycle aligned with the target-derived
turn.  Do not adopt v42's headroom transfer: the completed result shows that
the posterior safety filter's rejection is part of the useful coupled
allocation rather than unused authority that should be recovered upstream.

Post-exit evaluation should reproduce the v41-family capture, coherent wake,
far-route locality, zero posterior hard-stop occupancy, and low-load class.
Reject the selection if capture or its measured distance/score advantage over
v42 does not repeat.  Reflected or perturbed rollouts are still required to
test generalization; deterministic nominal replication does not establish it.

bookshelf_consulted: true
source_domain: asymmetric fish turning and sensor-modulated coupled-oscillator robotic-fish control
source_mechanism: allocate bounded sensory steering within a stable traveling bend while preserving the phase anchor and posterior lag
transferable_invariant: infer beat phase from joint state and spend an existing target-derived residual only on the compatible half-cycle without reclaiming safety-filtered effort through another joint
nontransferable_details: published gains, dimensional cadence, prescribed duty ratios, species or robot kinematics, full-body waveforms, exact vortex phases, Strouhal targets, capture geometry, and task-specific routes
policy_translation: retain v41's mirror-equivariant lagged-wave phase gate on the normalized body-frame projected-miss residual, with the anterior phase anchor and posterior safety layers unchanged
falsification: reject if nominal replication loses capture, the v42 distance and score advantage, far-route locality, coherent wake, zero posterior hard-stop occupancy, or the low-load class, and separately reject on held-out poses if the phase gate removes necessary corrective steering

## Pre-evaluation validation

- The selected candidate is byte-identical to all four current v41 samples
  (LF SHA-256
  `9e6a29b253671527cc436021e572b18ba5bf6994d71936eadf98ca674753fadd`).
  This is evidence selection of one completed mechanism, not a same-worker CFD
  claim or a scalar-only gain edit.
- The configured check runner was invoked, but its pinned `gpt-5.4-mini` model
  is unsupported on this account.  Its three no-CFD commands were then run
  directly and separately.  Reusable-guidance semantics passes after removing
  the duplicate assigned-parent marker from the rendered workspace README;
  the public policy contract returns two finite accelerations
  (`-14.3858335`, `0.0005062`); and the solver editable-boundary audit passes.
- The deterministic schema audit resolves all `87` direct `params.FIELD`
  references among the `89` fields returned by `target_policy_params()`.
  Formal CFD remains reserved for the post-worker evaluator.
