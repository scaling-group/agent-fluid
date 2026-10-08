# Half-cycle steering candidate notes

## Evidence diagnosis recorded before the edit

- All four sampled rollouts satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no prewarm, and no cylinders. All are finite rather
  than numerically unstable, but all terminate at the upper virtual boundary.
- The target-blind seed is genuinely self-propelled. Its top-down row develops
  a coherent alternating wake from quiescent water and its oblique Lambda2 row
  confirms a three-dimensional caudal wake. It nevertheless sweeps upward,
  improving from `12.328L` only to `12.078L` before exiting at `8.547T` and
  `12.380L`. The carrier and posterior lag are useful; target regulation is
  missing.
- The inherited posterior-only bearing-plus-trend mean-curvature policy is the
  strongest finite comparator. Its coherent wake carries the fish farther
  left, improves minimum/final distance to `11.413/11.421L`, and extends the
  exit to `9.740T`. This validates target-relative steering authority, but the
  top-down and oblique paths still bend upward after alignment and end at
  `y=15.200L`. Its posterior command exceeds the acceleration envelope in
  about 55 percent of logged samples and reaches `101 rad/T^2` before the
  downstream clamp, so continuous mean bias is competing with the propulsive
  half-cycles rather than arresting yaw cleanly.
- The two yaw-rate-damped alternatives do not rescue that topology. A
  posterior-only static bias reaches only `12.091L` and exits at `8.899T`; a
  bias centered on both joints suppresses joint motion and visible wake growth
  for much of the rollout, then makes a broad U-turn and ends at `13.411L`.
  The shared-bias result is concrete evidence against moving the anterior
  oscillator equilibrium. The sampled comparisons and inherited notes support
  keeping target steering posterior-only, while the repeated upper exits
  falsify continuous mean curvature as a sufficient steering translation.

## Policy hypothesis

Retain the sampled best policy's body-frame bearing plus bounded bearing-trend
request and its unchanged anterior Van der Pol carrier. Replace the posterior
joint's continuous mean tangent with one half-cycle amplitude-asymmetry
mechanism: infer the current posterior wave side from the lagged joint-state
target, strengthen the half-cycle having the requested turn sign, and weaken
the opposite half-cycle by the same bounded factor. This preserves zero
crossings and the traveling bend while producing a target-signed cycle-average
curvature. Bound the posterior target inside the joint envelope and return both
accelerations inside the existing actuator envelope, so steering authority is
not expressed as ever-larger clipped commands.

Expected evidence is an alternating posterior wake at least as coherent as the
best comparator, continued progress below `11.413L`, and either a later exit or
a better termination class with less posterior acceleration clipping. Reject
the mechanism if it suppresses forward translation like the shared-bias
candidate, strengthens the wrong half-cycle, retains the same upward exit
without better distance, or replaces raw-command clipping with persistent
joint-angle or joint-rate limiting.

bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping and biological turning superposed on a propulsive rhythm
source_mechanism: state-phased half-cycle amplitude asymmetry for target-directed turning
transferable_invariant: a bounded directional request can steer by strengthening the useful side of an otherwise preserved traveling bend instead of displacing the whole oscillation
nontransferable_details: published duty ratios and gains, clocked CPG phase, species-specific kinematics, exact vortex phase, and task-specific routes
policy_translation: map normalized body-frame bearing plus bounded bearing-window trend to a turn request, infer beat side from the lagged two-joint state target, and oppositely scale the two posterior half-cycles within fixed joint and acceleration bounds
falsification: reject if the wake or forward progress collapses, the upper-boundary arc and `11.413L` closest-approach floor do not improve, or actuator-limit residence remains persistent

The new candidate has no same-worker CFD result; these expectations are for
the downstream evaluation.
