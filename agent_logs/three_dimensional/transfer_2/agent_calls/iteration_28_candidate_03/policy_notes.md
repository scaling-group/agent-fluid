# Redirect-consistent carrier-release candidate

## Evidence diagnosis before editing

- All four sampled evaluations are valid direct-uniform still-water releases:
  `initialization_mode=uniform_direct`, `direct_quiescent_init=true`, zero
  background velocity, no cylinders or prewarm, stable moving-window
  transport, and `capture` termination. There is no sampled semantic failure,
  so the useful contrast is the strongest finite capture against the assigned
  parent and the two mechanism controls.
- Both rows of every combined keyframe sheet were inspected. The top-down
  mid-plane views show self-propulsion from blank water, organized alternating
  vorticity, and continuous target-directed translation rather than passive
  advection. The oblique views show compact three-dimensional Lambda2
  structures shed aft of the caudal region without wake collapse, collision,
  or instability. The redirect-priority sample reaches the target on a visibly
  broader arc, while the assigned dominant-joint parent has the shortest,
  quieter approach; the images support preserving the carrier/steering and
  capture scaffold but do not support ranking the fastest scalar alone.
- Metrics sharpen that tradeoff. Redirect priority (`solver_3fdd63b3fbda`) is
  the first sample to capture at `16.044T`, with distance integral `1.82409L`
  and `10/8/6/2L` crossings at `5.863/7.838/9.779/14.201T`. Against the
  assigned dominant-joint parent (`solver_5fc33d6eb58b`) at
  `17.990T/1.98918L`, it is materially faster. It also lengthens head path from
  `12.170L` to `13.178L`, raises peak planar force/yaw-moment coefficients from
  `0.02909/0.01498` to `0.03579/0.01770`, raises anterior/posterior residence
  above 99% joint rate from `8.44/0.89%` to `12.24/1.37%`, and increases
  sub-`2L` lateral speed from `0.159` to `0.359U`. The uncancelled-work and
  predictive controls confirm the same finite coherent-wake class but do not
  combine the fast crossings with the parent's route and load quality.
- The inherited step-25 through step-27 logs establish the intended invariant:
  preserve one phase-related carrier scale and restore target-conditioned
  steering unchanged, then release a C-start-like allocation when the measured
  response follows the request. The evaluated redirect-priority code violates
  that last semantic boundary. Its `unfulfilled_redirect` is the velocity-course
  redirect magnitude, but its release factor uses yaw aligned with the broader
  LOS `turn_command`. Reconstructing the normalized body-frame observations
  from `trajectory.csv` shows that `turn_command` and `redirect_command` have
  opposite signs on about 87% of the redirect-priority sample's steps where a
  joint exceeds the governor onset. This is an observation/request mismatch,
  not evidence for changing another scalar gain.

## One-candidate policy hypothesis

Start from the fastest evaluated redirect-priority controller and retain its
gait, capture scaffold, carrier/steering decomposition, positive-work guard,
and parameter values. Change one feedback semantic: declare the redirect
fulfilled only when normalized measured yaw has the sign of the actual bounded
`redirect_command`; keep LOS-turn-aligned response for the separate posterior
wave handoff. Carrier priority will therefore release in response to the
course correction it actually requested instead of an often-opposed route
signal. This remains normalized, body-frame, reflection-equivariant,
state-feedback control with no clock, route memory, or task coordinate.

Expected signature: retain capture and substantially earlier milestones than
the assigned `17.990T` parent while shortening the redirect sample's `13.178L`
path and reducing its `0.03579/0.01770` load peaks, near-rate residence, and
terminal lateral speed toward the parent/control class. Falsify the mechanism
if capture or coherent wakes are lost; timing/integral regress to the
`17.688--17.990T` / `1.964--1.989L` controls without compensating path, load,
and rate improvement; or the long arc, high loads, and near-rate residence
remain. Do not respond to failure by tuning the guard threshold or strength;
restore the supported dominant-joint governor or test a different observation
and mechanism.

bookshelf_consulted: true
source_domain: biological C-start redirects and sensor-modulated robotic-fish CPG path following
source_mechanism: allocate rhythmic propulsion to bounded curvature during large directional error, then release the carrier when the measured turning response follows that same directional request
transferable_invariant: response-gated propulsion and steering allocation must compare measured response with the sign and semantics of the command being fulfilled while preserving the coupled traveling-wave carrier
nontransferable_details: species-specific C-start shapes, published gains and frequencies, motor models, exact tail or vortex phase, full-body kinematics, world coordinates, and task-specific routes
policy_translation: retain normalized body-frame course-error redirect and the two-joint carrier/steering split, but release redirect-priority carrier suppression from signed yaw aligned with `redirect_command`; retain LOS-turn alignment only for its separate wave-handoff role
falsification: reject unless earlier progress and coherent capture coexist with a shorter path, reduced peak load and near-rate residence, preserved joint margin, and lower terminal lateral motion than the evaluated redirect-priority sample
