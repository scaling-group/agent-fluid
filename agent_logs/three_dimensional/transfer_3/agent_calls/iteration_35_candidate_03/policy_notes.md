# Outer closure-recovery traveling-bend coupling

## Evidence and visual diagnosis before the policy edit

- All four sampled evaluations satisfy the frozen flow contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite moving-window dynamics, and capture. They
  reproduce capture at `19.684490 T`, score `-0.261384287`, mean/final
  distance `2.151092787 L`/`0.748302400 L`, path length `12.951133 L`, and
  `243` moving-window shifts. Three policies are byte-identical `v40`
  controllers; the fourth policy is different but behaviorally dormant.
- I inspected the complete combined sampled sheet, including the top-down
  mid-plane-vorticity row and oblique body/Lambda2 row from release through
  capture, and compared it with the inherited response-permissive terminal
  failure. Both fish visibly self-propel from quiescent water on the same
  compact target-directed arc, shed a coherent alternating posterior wake,
  and retain finite localized three-dimensional structures. Neither shows
  passive advection, collision or boundary-exit precursors, volume-filling
  instability, or wake collapse. The response-permissive handoff changes only
  the late approach, delays capture by five steps to `19.711988 T`, worsens
  score/mean/final distance to `-0.261822240`, `2.151500419 L`, and
  `0.748728991 L`, and adds one moving-window shift. This is an allocation
  regression, not evidence of a different propulsion or wake regime.
- The sampled winner remains monotone through capture and has no joint-angle
  stop dwell. Its unresolved limitation is outer actuator allocation: above
  `4 L`, at least one applied acceleration is effectively at the
  `30.5433 rad/T^2` software cap on most stored states, while the inherited
  direction-conditioned limiter and posterior-response allocation are known
  to outperform whole-vector attenuation. In contrast, completed terminal
  cadence recovery, joint-response handoff selectors, signed yaw/course
  posture, force vetoes, shared-mean unloading, startup curvature, and outer
  phase-lag changes all regress or are dormant. The validated terminal glide,
  fixed posterior lag, mean bend, and outer target-residual steering should
  therefore remain unchanged.

## Policy hypothesis

Preserve `v40` and add one independently active outer allocation mechanism.
When the directly observed center course is already close to the body-frame
target ray, radial closure is deficient, posterior tracking response is
settled, and clipping has distorted the two-joint command direction, transfer
a small additional share from independent clipping toward the existing common
scale. Suppress the transfer while large-angle redirect, poor posterior
response, or target-residual steering owns the state, and make it exactly zero
at and below `4 L`. This tests whether preserving the traveling-bend command
direction can recover forward closure without shortening the fixed posterior
lag, increasing the acceleration limit, adding terminal cadence, or changing
the target-owned curvature equilibrium.

The expected effect is a bounded, state-varying command change on aligned but
closure-poor outer states, followed by equal-state identity throughout the
validated terminal regime. Falsify the mechanism if it is dormant or nearly
constant, overlaps poor-response or target-residual priority, changes any
state at or below `4 L`, slows or loses capture, worsens the distance integral,
changes the compact route, raises stop dwell or loads, destabilizes the flow,
or degrades either wake view. The new CFD rollout occurs only after this
worker exits and is not evidence here.

bookshelf_consulted: true
source_domain: Lighthill-style reactive traveling-wave propulsion and sensor-modulated robotic-fish CPG control
source_mechanism: preserve inter-joint traveling-bend coordination while closed-loop observations decide when actuator allocation can favor propulsion
transferable_invariant: when clipping distorts a propulsive traveling bend, a small continuous common-scale correction should act only in course-aligned closure-poor states and remain subordinate to steering and observed posterior-response recovery
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, full-body waveforms, exact tail or vortex phase, actuator models, target coordinates, capture radius, and task-specific routes
policy_translation: use normalized body-frame center-course miss, radial closure deficit, posterior lag response, clipping-direction distortion, and the existing outer gate to add a bounded common-scale share disjoint from redirect, target-residual priority, and the terminal law
falsification: reject on dormancy, regime overlap, any below-4L action, slower or lost capture, worse distance integral, altered compact topology, joint-stop dwell, material load growth, instability, or degraded top-down or oblique wake coherence

## Non-CFD implementation audit

- Replaying the evaluated `v40` and candidate on reconstructed body-frame
  states from the sampled trajectory changes `198` commands between
  `8.5802 L` and `12.0993 L`, with a maximum equal-state difference of
  `0.0931 rad/T^2`. No state at or below `4 L` changes. This establishes that
  the new gate is independently active, bounded, outer-only, and concentrated
  in the intended early closure-recovery regime; it does not establish a CFD
  improvement.
- The lightweight public-contract check returns exactly two finite
  accelerations. The deterministic schema audit resolves all `92` direct
  `params.FIELD` references against the `93` fields returned by
  `target_policy_params()`; only the version label is intentionally unused.
  No formal CFD was run in this workspace.
- The prescribed `check-runner` was invoked after the required files changed,
  but its pinned `gpt-5.4-mini` model is unsupported on this ChatGPT account
  and failed before executing a command. Running its three configured checks
  directly and separately passes the material-guidance check, exact Julia
  two-output contract, and solver edit boundary. The guidance check initially
  exposed two identical copied-parent markers in the rendered workspace
  `README.md`; removing only one duplicate marker restored unambiguous parent
  resolution without changing the evidence set.
