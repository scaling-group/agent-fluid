# Actuator-consistent stroke-aware course-preview candidate

## Visual diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen evidence contract: direct
  uniform still-water initialization with `U_infinity=[0,0,0]`, no cylinders
  or prewarm snapshot, finite dynamics, and moving-window transport. Three
  byte-identical v27 course-preview policies capture at `24.5795T`,
  `0.746968L`, and mean distance `2.36044L`; the assigned v28 parent captures
  at `24.6180T`, `0.748724L`, and mean distance `2.36225L`.
- Both rows of the combined sheets were inspected for v27, the assigned v28
  parent, the inherited bounded-output v30 completion, and the informative
  pre-preview `1.09231L` left-domain failure. The top-down views show
  self-propulsion with a coherent alternating wake on the common early
  diagonal. The failure retains that wake but passes outside the capture
  circle, makes a broad post-passage hairpin, and exits at `37.493T`; the
  course-preview family redirects before passage and captures near `24.6T`.
  The oblique body/Lambda2 views retain compact three-dimensional shedding
  through both the failed turn and the successful approach. Wake breakup,
  imposed advection, and lost propulsion are therefore not the intervention
  targets.
- The diagnostics distinguish semantic success from actuator quality. The
  v28 proprioceptive allocation guard preserves the v27 capture topology while
  reducing posterior hard-stop occupancy from `23.38%` to `12.60%`, peak
  planar force magnitude from `0.323` to `0.203`, and peak yaw moment from
  `0.143` to `0.089`. It does not resolve raw acceleration-envelope exposure
  (`72.84%` versus `72.65%`) or joint-rate exposure (`15.15%` versus
  `15.10%`). Completed course-alignment and phase-release refinements either
  restore the higher load class or are physically neutral, so another guard
  threshold or phase blend is not supported.
- An inherited completed v30 branch tests a different mechanism: projecting
  each fully allocated output onto the owned `1800 deg/T^2` envelope. Its
  rollout is dynamically identical to v28 after downstream actuator clipping:
  capture at `24.6180T`, minimum/final distance `0.748724L`, mean distance
  `2.36225L`, and the same reduced-load trajectory. Its raw policy outputs are
  feasible by construction. This is interface/command consistency, not
  evidence of lower joint-rate exposure, lower effort, or further load relief.

## Policy hypothesis

Preserve the assigned v28 controller's normalized body-frame velocity-course
preview, coherent traveling-wave carrier, bounded steering-priority allocator,
and joint-side/outward-pressure stroke guard. Add one final symmetric action
projection shared by both joints, using the existing owned acceleration limit.
The projection changes no feedback, route, switching surface, or available
actuator authority; it makes the public policy return only commands the
downstream actuator can realize.

The falsifiable expectation is the inherited v30 result: capture and all
trajectory/load diagnostics remain in the evaluated v28 class, while no
returned acceleration exceeds the owned envelope. Reject the translation if
capture or far-path invariance is lost, any raw output remains out of bounds,
posterior occupancy or peak force/moment rises, or feasibility is incorrectly
claimed to solve the still-observed joint-rate exposure. Formal CFD for this
workspace remains deferred to EvE.

## Bookshelf transfer

The fish-control bookshelf was consulted after the current visual and numeric
evidence. Its finite-authority, sensor-modulated rhythmic-control invariant
supports a final feasible action projection around the preserved carrier and
steering mechanisms; the numerical limit comes from this lane's owned actuator
contract, not from a publication.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and elongated-body posterior reactive propulsion
source_mechanism: combine a lagged posterior propulsive rhythm with bounded feedback modulation under finite actuator authority
transferable_invariant: preserve the state-feedback traveling wave and target steering, but expose only a realizable final joint command so unavailable authority cannot masquerade as control effort
nontransferable_details: published gains, dimensional cadence, motor curves, full-body or species-specific kinematics, exact vortex phase, and task-specific routes
policy_translation: symmetrically project both fully allocated two-joint accelerations onto the existing owned envelope after normalized body-frame course feedback and proprioceptive stroke allocation
falsification: reject if capture or the reduced-load path changes, any returned acceleration exceeds the owned limit, or raw feasibility is conflated with reduced rate exposure or hydrodynamic load

## Pre-evaluation checks

- The candidate SHA-256 is
  `091ca36b3bdf5eaa03810a24a1ce27c2d0cbdcd5fd4a1ecdd6ac72de03d6dd8b`;
  it is byte-identical to the completed inherited bounded-output controller
  and remains non-empty.
- The configured check runner was invoked, but its pinned `gpt-5.4-mini`
  model is unavailable on this ChatGPT account. Its three prescribed no-CFD
  commands were therefore run directly and separately. The reusable-guidance
  semantic check, finite two-joint Julia contract/schema check, and solver
  editable-boundary audit all pass.
- No formal CFD was run. The inherited v30 rollout is prior evidence for this
  selection; this workspace's post-worker evaluation remains evidence for a
  later generation.
