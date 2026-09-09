# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- All four sampled evaluations satisfy the frozen Phase 2 contract: direct
  uniform initialization with `U_infinity=(0,0,0)`, no cylinders or prewarm,
  finite dynamics, and `horizon` termination. I inspected both the top-down
  mid-plane-vorticity and oblique body/Lambda2 rows of every combined
  keyframe sheet. All four fish self-propel from rest and retain coherent
  alternating planar wakes with compact three-dimensional structures through
  repeated return arcs; passive advection, wake collapse, collision, domain
  exit, and instability do not explain their misses.
- The assigned parent's response-conditioned carrier contraction is a
  completed negative result. It reaches only `2.484L`, with mean/final
  distance `4.544/4.673L`; after `18T` it does not produce the intended
  turn-in-place response, and its full-trace mean speed remains `0.655U` while
  anterior/posterior acceleration-clamp residence is about `0.712/0.103`.
  The top-down and oblique paths retain the same broad powered loops. Do not
  add another scalar drive contraction to that scaffold.
- Response-held curvature (`solver_2c7a9d1d6ee7`) and a response-selected
  posterior counterbend (`solver_bac4e1917fd6`) remain coherent but miss at
  `2.377L` and `2.249L`, respectively. Their anterior clamp residence remains
  about `0.73`, and neither changes the broad noncapturing orbit class. The
  counterbend's later-yaw trigger therefore does not justify moving more turn
  work into the posterior joint.
- The course-response curvature-reserve sibling (`solver_951085a20092`) is the
  strongest finite sample: it improves minimum/mean/final distance to
  `1.314/4.056/3.077L`, retains the coherent horizon wake, and reduces
  anterior/posterior clamp residence to about `0.249/0.103`. At its closest
  pass (`69.283T`) it still moves at `0.652U`; the normalized course is
  slightly receding (`course_dot=-0.101`), target-ray/course error is
  `1.672 rad`, the body-frame target is behind/lateral at
  `(1.037,0.807)L`, and signed yaw response is only `-0.137 rad/T`. From
  `62--69T`, the target closes from `3.750L` to `1.322L` while the same large
  course error persists and useful yaw repeatedly falls below about
  `0.2 rad/T`. The remaining miss is therefore a delayed turn response with
  ample anterior command reserve, not loss of thrust or excessive established
  yaw.

## Policy hypothesis

Use the strongest course-response sibling as the scaffold. Preserve its
far-field oscillator, bearing curvature, posterior brake and lag modulation,
target-behind C-turn, nonclosing course-response reserve, and wave envelope.
Add one compact mechanism before the closest-pass failure: while the target is
behind, distance and speed make the recovery observable, target-ray/course
error is large, and measured yaw has not yet developed in the requested turn
direction, add a bounded anterior-only curvature burst. Release only that
burst continuously as useful signed yaw appears. The posterior equilibrium and
traveling wave are unchanged, so burst release returns authority to the
evidenced posteriorly lagged carrier instead of adding another posterior
counterbend or reducing scalar drive.

Support requires preservation of the coherent inbound pass and horizon class
plus capture, a pass below `1.31L`, or a materially smaller orbit with improved
mean/final distance at comparable clamp/load residence. Reject the mechanism
if it changes cruise or the first pass, creates a tight curl, transfers clamp
residence or load to the posterior joint, loses wake coherence, or retains the
same near-tangential `1.3L` miss without useful distance improvement. Coupled
CFD runs only after this worker exits; trace replay can establish selector
locality, reflection symmetry, bounds, and schema ownership, not performance.

```text
bookshelf_consulted: true
source_domain: biological C-start redirects and sensor-modulated robotic-fish CPG turning
source_mechanism: large direction error requests a strong bounded anterior bend, then measured useful turn response releases it into the posteriorly emphasized propulsive rhythm
transferable_invariant: separate a transient turn-response deficit from sustained course response; add bounded curvature only until observed yaw develops in the requested direction
nontransferable_details: species-specific C-start stages, published gains, dimensional beat frequency, full-body kinematics, clocked CPG phase, exact vortex phase, capture radius, target coordinates, and prescribed routes
policy_translation: normalized body-frame target and velocity directions, distance, speed, and signed measured heading rate gate a reflection-equivariant anterior equilibrium-curvature burst inside the existing two-joint state-feedback carrier
falsification: reject if cruise changes, useful yaw does not appear, the wake curls or stalls, clamp/load residence rises, or closest, mean, and final distance retain the same noncapturing orbit class
```

## Evaluation boundary

The candidate has no same-worker CFD evidence. Non-CFD replay and controller
checks performed after the edit will be recorded below without presenting them
as hydrodynamic validation.

## Implemented candidate and non-CFD probes

The candidate starts from the completed course-response curvature-reserve
sibling and adds five owned burst parameters. Target-behind geometry and the
existing normalized distance/speed response envelope first localize the
mechanism; large absolute target-ray/course error and a deficit in signed
useful heading rate then select at most `5 deg` of anterior-only equilibrium
curvature. The sampled posterior redirect, wave envelope, brake, and phase lag
are unchanged. There is no clock, step count, hidden state, world coordinate,
target identity, route, or file access.

Counterfactual selector replay on the completed best trace gives zero burst
through its `2.3771L` first pass and a mean below displayed precision through
`12T`. At the late `1.3137L` closest pass, the burst weight is `0.5198`, or
`2.599 deg`; its mean contribution across states inside `2L` is about
`2.085 deg`, and its maximum frozen-trace weight is `0.5492`. These values
establish first-pass locality and material late-pass authority only; they do
not predict the coupled body/fluid trajectory.

All `45` direct parameter references are returned by
`target_policy_params()`. Mirrored target, velocity, bearing, heading-rate,
joint-angle, and joint-rate probes negate both actions with zero floating-point
residual. Zero and large finite probes remain finite and respect the declared
`+/-28 rad/T^2` reserve. The guidance-materiality check, lightweight Julia
policy contract, deterministic parameter-schema audit, and solver editable-
boundary check pass. The duplicated assigned-parent marker in the rendered
workspace `README.md` was removed so the mandated guidance checker could
unambiguously resolve its parent. No formal CFD was run.
