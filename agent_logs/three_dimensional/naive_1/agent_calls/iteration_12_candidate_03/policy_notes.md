# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four sampled evaluations satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm snapshot, and no reported
  numerical instability. The complete `solver_1a1f00e33399` sheet shows the
  fish self-propelling along a continuously closing top-down path, with an
  alternating red/blue mid-plane wake and discrete three-dimensional Lambda2
  structures still present at the `24.3375T` capture. This is active swimming,
  not advection or a terminal coast.
- The same unboosted reactive-rudder policy is evaluated by
  `solver_1a1f00e33399`, `solver_a7973a9fe513`, and
  `solver_d1547c83d2d0`. All three produce the identical `24.337509T` arrival,
  `0.749625L` crossing, `2.224316L` scored mean distance, `-0.325566` score,
  trajectory samples, and approximately `14.0/6.9%` anterior/posterior rate-cap
  occupancy. This supplies the requested deterministic replication of the
  inherited first-capture schedule.
- The assigned prefill `solver_666b72f43d6a` adds up to 20% posterior-rudder
  authority whenever one-step closing speed falls below `0.35L/T`. It is
  identical to the replicated policy through about `22T`, so the useful far
  carrier and route are preserved. Once the response gate acts, however,
  capture is delayed to `24.4145T`, the crossing tightens to `0.749996L`, mean
  distance worsens to `2.224632L`, and score falls to `-0.325802`. Peak planar
  force and yaw moment remain exactly `0.03165/0.01638`, and rate-cap occupancy
  is nearly unchanged, so neither overload nor saturation explains the loss;
  extra tail load during beat-scale closure deficits is simply not a useful
  terminal correction here.
- The three newer evaluations, including the assigned prefill, have blank
  oblique keyframe rows and approximately 2 KB oblique videos. Those are
  visualization failures, so they cannot independently replicate the 3D-wake
  claim. Their valid top-down sheets and complete trajectories support the
  route comparison, while the older complete `solver_1a1f00e33399` sheet is
  the available multimodal evidence for wake coherence.

## One candidate hypothesis

Remove only the unsupported one-step closing-deficit multiplier and promote
the three-times-replicated reactive-rudder controller as the single candidate.
This is a mechanism rollback rather than another scalar-gain trial: joint
state retains the traveling carrier, full normalized head-relative target
geometry and distance retain the successful posterior reactive-load schedule,
and the noisy response pathway that degraded the terminal segment is absent.

The candidate is falsified if it does not reproduce capture near `24.34T` and
`0.749625L`, if its top-down path or load/saturation envelope differs materially
from the replicated traces, or if a complete oblique render no longer shows
the established three-dimensional wake. This fixed-pose replication does not
establish robustness to other target poses or hydrodynamic conditions. Later
terminal work should test a genuinely distinct, smoothly observed approach
mechanism; it should not reintroduce extra rudder from one-step closing speed.

bookshelf_consulted: true
source_domain: Lighthill-style posterior reactive loading and closed-loop robotic-fish mean-offset steering
source_mechanism: preserve a traveling posterior beat while target feedback recruits a bounded mean tail load for yaw
transferable_invariant: retain the rhythmic carrier and select posterior steering load from measured target-side response, removing feedback pathways contradicted by rollout evidence
nontransferable_details: elongated-body coefficients, published gains, robot linkage geometry, species-specific envelopes, dimensional frequencies, prescribed maneuver timing, exact vortex phase, and task-specific routes
policy_translation: normalized full target angle and distance continue to gate the evidenced opposite-sign posterior offset while joint state generates phase; the unevidenced one-step closure multiplier is removed
falsification: reject if the replicated capture, coherent wake, or established saturation and force/moment envelope is not recovered
