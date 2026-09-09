# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- All four sampled evaluations report direct uniform still-water
  initialization with `U_infinity=(0,0,0)`, no cylinders, and no prewarm.
  Their displacement and wakes are therefore self-propulsion rather than
  advection or inherited-flow contamination.
- I inspected every combined keyframe sheet from release through termination,
  including the top-down mid-plane vorticity row and oblique body/Lambda2 row.
  The `2.443L` alignment-gated carrier, `2.494L` full-direction gate, `2.429L`
  cross-track/closure hold, and assigned-parent `2.536L` response-gated S-bend
  all retain a coherent alternating planar wake and compact three-dimensional
  vortex chain. None collides, loses propulsion, or becomes unstable. All pass
  below the target and remain powered into the lower virtual boundary near
  `31T`, so wake generation is useful and the repeated failure is terminal
  trajectory topology.
- The newest comparisons reject both candidate mechanisms inherited as open
  hypotheses. The response-gated opposite-sign posterior equilibrium worsens
  minimum distance from the carrier's `2.443L` to `2.536L`. Symmetric
  cross-track/closure attenuation of the posterior wave reaches `2.429L`, only
  `0.014L` closer, while worsening mean distance from `8.443L` to `8.454L` and
  retaining the same powered lower exit. Full-direction propulsion gating is
  worse at `2.494L`. Thus neither more persistent posterior curvature nor
  beat-symmetric terminal drive relief has a surviving semantic improvement.
- At each sampled minimum the target remains strongly lateral in the body
  frame (`1.25--1.45 rad` full direction error), speed remains
  `0.68--0.73U`, and heading rate is `+2.00--2.46 rad/T`, the sign that grows
  the positive target-direction error. This shared wrong-way yaw half-cycle is
  more specific than proximity, center-velocity cross-track magnitude, or
  closing deficit alone. Anterior/posterior acceleration is already clamped
  for roughly `0.72--0.75/0.33--0.36` of samples, so increasing drive or the
  command bound is not supported.

## Policy hypothesis

Start from the strongest simple alignment-gated carrier and change one
actuator mechanism. Preserve its anterior oscillator, bounded target-curvature
steering, posterior lag, mean posterior curvature, alignment envelope, and
command reserve. Within a smooth approach envelope and only for a materially
lateral target, attenuate the oscillatory posterior wave during the measured
heading-rate half-cycle that rotates away from the signed full target
direction. Restore the full wave on the corrective half-cycle. This is a
state-feedback half-cycle brake, not another static S-bend or a scalar gain
tune.

The expected result is unchanged cruise displacement and wake coherence, with
less wrong-way terminal yaw but continued propulsion on corrective half-cycles.
Capture, a useful new termination class, or a minimum materially below
`2.429L` without worse mean distance would support the mechanism. Falsify it
if far-field motion changes, the wake collapses or becomes strongly one-sided,
posterior limit/load residence grows, speed is lost before approach, a tight
curl appears, or the same powered lower exit persists without useful distance
improvement.

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish half-cycle asymmetry and continuous terminal-capture scheduling
source_mechanism: retain a traveling propulsive bend while weakening only the posterior half-cycle whose measured yaw rotates away from the target
transferable_invariant: separate rhythmic propulsion from bounded steering by using signed target error and measured response to suppress only counterproductive oscillatory authority, then restore it continuously on corrective response
nontransferable_details: published gains, dimensional frequencies, species-specific envelopes, robot duty ratios, exact vortex phases, fixed burst durations, approach radii, and task-specific routes
policy_translation: normalized target_body_L supplies full signed direction, normalized distance localizes the response, and bounded heading_rate selects a reflection-equivariant posterior-wave brake around the unchanged two-joint state-feedback carrier
falsification: reject on changed cruise, lost or strongly asymmetric wake coherence, premature speed loss, a short-radius curl, greater posterior command/load residence, no material improvement below 2.429L, or persistence of the powered lower exit
```

## Evaluation boundary

The current candidate has no CFD result; formal evaluation occurs only after
this worker exits. Replay and contract checks can establish signal locality,
symmetry, boundedness, and implementation correctness, but not hydrodynamic
improvement.

## Implemented candidate and pre-CFD checks

The candidate starts from the sampled `2.443L` carrier and adds only the
response-selective posterior-wave brake described above. All approach,
direction, response, floor, and actuator bounds are owned by
`target_policy_params`; no flow, force, coordinate, time, route, or case signal
enters the policy.

Replay of completed trajectories through the new gate is a signal diagnostic,
not CFD evidence for the candidate. Across the four samples, mean brake weight
is `0.0027--0.0031` beyond `4L`, `0.098--0.120` between `3--4L`, and
`0.255--0.273` inside `3L`, where it is active above `0.25` on only
`33.5--35.4%` of samples. At each sampled minimum the wrong-way response makes
brake weight `0.865--0.901`, reducing posterior-wave scale to `0.414--0.438`;
the complementary corrective heading-rate half-cycle restores essentially full
scale. This confirms the intended cruise locality and signed half-cycle
selection without predicting the coupled hydrodynamic response.

The lightweight Julia policy contract passes. Direct probes also pass global
reflection equivariance, corrective-response release, far-field locality,
near-field activation, extreme finite-input handling, configured command
bounds, and parameter ownership. A representative lateral approach produces
brake/scale `(0.909, 0.409)` at `2.4L`, versus `(0.00065, 0.99957)` at `8L`
and `(0.00225, 0.99854)` for corrective yaw at `2.4L`. All `324` repository
non-CFD assertions pass. The configured check runner passes the material
guidance, Julia contract, and solver-boundary checks after removal of a
duplicate assigned-parent marker in the rendered workspace `README.md`. The
bundled semantic checker does not implement the parameter-schema guard promised
by that README, so a separate deterministic scan verified that all `21` direct
`params.FIELD` references are declared by `target_policy_params()`. Formal CFD
was not run.
