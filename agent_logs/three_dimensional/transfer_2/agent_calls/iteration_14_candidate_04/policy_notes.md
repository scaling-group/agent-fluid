# Active posterior stroke-braking candidate

## Evidence diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen evidence contract: direct
  uniform still-water initialization with `U_infinity=[0,0,0]`, no cylinders
  or prewarm, finite dynamics, and moving-window transport. Three samples are
  byte-identical course-preview controllers that capture at `24.5795T`,
  `0.74697L`, and mean distance `2.36044L`; they are replicated evidence for
  one successful route mechanism, not three distinct improvements.
- Both rows of the combined keyframe sheets were inspected for a replicated
  course-preview capture and the assigned predictive-stroke parent. The
  top-down view shows the same self-propelled early diagonal, coherent
  alternating wake, pre-passage redirect, and target crossing near `24.6T`.
  The oblique view shows compact three-dimensional Lambda2 structures through
  redirect and capture. The parent neither relies on passive advection nor
  breaks the established route or wake topology.
- The assigned parent retains capture at `24.5960T`, `0.74858L`, and mean
  distance `2.36174L`. It improves the earlier stroke-aware guard's arrival
  and score (`24.6180T`, `0.74872L`, `2.36225L`) and further reduces peak
  absolute body-frame force/yaw-moment coefficients from
  `0.165/0.118/0.089` to `0.149/0.097/0.067`. Preserve its position-and-rate
  prediction as useful load relief.
- The parent's hard-stop hypothesis is the informative failure. It predicted
  posterior hard-limit and joint-rate exposure below the earlier guard's
  `12.60%/15.10%`, but measures `12.75%/15.14%`; raw acceleration-envelope
  exposure is likewise essentially unchanged (`72.74%` versus `72.65%`).
  Lowering only the steering-priority interpolation anticipates contact but
  does not command the inward acceleration needed to remove posterior kinetic
  stroke. This is a mechanism-level negative result, not a reason to retune
  its onset, floor, or relief magnitude.
- Inherited completed logs also reject nearby alternatives: inward-phase
  allocation handoff captures at only `0.74900L`, course-alignment handoff at
  `0.74984L`, and final output projection exactly reproduces the earlier
  guard's CFD. Another conditional handoff, downstream-equivalent clip, late
  recapture gain, or curvature-gain edit would repeat a closed branch.

## Policy hypothesis

Preserve the evaluated course preview, route requests, posterior
position-and-rate priority guard, and all far behavior. Add one
mirror-equivariant actuator mechanism after posterior steering allocation: a
soft predictive stroke barrier. In the joint's outward coordinate, compute
constant-deceleration stopping stroke from observed posterior angle/rate and
the owned acceleration limit. As projected stroke enters the existing
`36--44 deg` guard band, continuously replace only unsafe outward posterior
acceleration with the inward deceleration required to stop at the soft limit.
Already-safe inward commands pass through unchanged; inward motion and
opposite joint sides are treated symmetrically. This turns the parent's useful
prediction into active braking without changing the propulsive carrier,
geometric route command, or a scalar steering gain.

Expected evidence: retain capture, the common far trajectory, and the
parent's reduced-load class while reducing posterior hard-limit occupancy
below `12.60%` and avoiding worse joint-rate exposure than `15.10%`.
Falsify the mechanism if capture is lost, the pre-passage redirect changes
materially, force/moment returns toward `0.165/0.118/0.089`, or active braking
creates repeated near-boundary chatter. Raw acceleration exposure is a
secondary diagnostic because inherited output projection proved it can be
changed without changing the dynamics.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish rhythmic control and posterior reactive-swimming theory
source_mechanism: proprioceptive feedback modifies a bounded posterior rhythm when finite actuator stroke would otherwise disrupt useful tail kinematics
transferable_invariant: preserve the traveling-wave carrier while using observed joint position and outward rate to actively remove only the kinetic stroke that predicts a constraint conflict
nontransferable_details: published gains, motor models, dimensional cadence, species kinematics, full-body envelopes, exact vortex phase, and task-specific routes
policy_translation: convert posterior angle and rate into a normalized stopping-distance barrier and blend the allocated tail command toward bounded inward braking only inside the existing soft stroke band
falsification: reject if capture or the far route is lost, hard-limit occupancy does not beat 12.60 percent, load returns to the earlier guard class, or boundary chatter appears

## Pre-evaluation validation

- All `82` direct `params.FIELD` references resolve among the `84` fields
  returned by `target_policy_params()`. The prescribed public-contract state
  returns two finite accelerations.
- A `179,520`-probe barrier grid is finite and mirror-equivariant. It passes
  far/disabled and already-safe inward commands unchanged, while a stalled
  tail at either `45 deg` limit receives a mirrored `270 deg/T^2` inward
  command. A separate `18,225`-state target-policy grid is finite.
- Fixed-state comparison with the evaluated parent is exactly equal on `651`
  far-path probes. An offline audit on the parent's sampled trace first changes
  the posterior command at `18.5185T`, after the inherited terminal redirect
  has activated; this checks intended dormancy but is not a CFD outcome claim.
- The reusable-guidance semantic check, exact Julia contract check, and solver
  editable-boundary audit pass. The configured check-runner was invoked, but
  its pinned `gpt-5.4-mini` model is unsupported on this account; its three
  declared no-CFD checks were therefore run directly and separately. No
  formal CFD was run.
