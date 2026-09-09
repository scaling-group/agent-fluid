# Candidate diagnosis and policy hypothesis

## Evidence read before the edit

- All four sampled rollouts and the assigned-parent rollout use direct uniform
  still-water initialization with `U_infinity=(0,0,0)`, no cylinders, no
  prewarm, and active moving-window shifts. Their motion and wakes are
  released-swimmer behavior rather than ambient advection.
- The two current exact
  `dogfish3d_intercept_guarded_speed_reserve_v1` samples capture at
  `0.7466--0.7494L` after `18.3205--18.6010T`; the two posterior-pulse samples
  also capture at `0.7480--0.7492L`. All four combined sheets show a coherent
  alternating mid-plane vortex street and compact bilateral Lambda2
  structures through capture. The carrier is active rather than coasting.
- The assigned parent's exact baseline replay is now the informative failure:
  it reaches only `1.7276L` at `18.777T`, continues at `0.8282L/T`, and exits
  below with final distance `10.2037L`. Its top-down row keeps laying down an
  organized alternating wake and its oblique row retains compact 3D
  structures after the miss. This falsifies calling the unchanged baseline
  robust; the failure is terminal path geometry, not propulsion collapse,
  advection, instability, or excessive loads.
- Pre-closest actuator and load ranges overlap the captures. The failed replay
  clamps acceleration on `68.42%/70.91%` of rows, resides at the joint-speed
  limit on `10.05%/11.13%`, and has peak force norm/yaw moment
  `0.03046/0.01571`; the two sampled baseline captures clamp on
  `68.48--68.66%/70.64--70.67%`, reside at the speed limit on
  `10.47--10.69%/11.41--11.71%`, and peak at
  `0.03092--0.03120/0.01597--0.01627`.
- Geometry separates the paths before closest approach. Near `4.27L`, the
  failed replay already has projected miss `1.370L`, versus `0.544--0.665L`
  in the captures at comparable range. At `2.740L` its target/velocity
  alignment is `0.597` and projected miss is `2.198L`; the captures remain at
  alignment `0.822--0.859` and miss `1.348--1.470L` near `2.58--2.64L`.
  The baseline response gate is already commanding nearly full additive
  steering in the failed path, so another route gain, release threshold, or
  scalar cadence change does not address the observed allocation limit.
- Inherited logs already falsify cadence relief, carrier suppression,
  total-command speed governors, phase-weighted steering allocation,
  projected-miss route replacement, terminal yaw braking, and the small
  posterior wave-shape pulse as robust improvements. The reusable open test is
  a materially different steering realization that preserves the carrier.

## One candidate hypothesis

Keep the exact achieved-course/intercept controller, traveling-bend carrier,
response release, and conditional speed reserve. Add one smooth C-start-like
redirect mode: only inside approach range, and only when large normalized
course error coincides with deteriorating target/velocity alignment, blend the
existing asymmetric additive steering into a bounded equal common-mode
acceleration on both joints. Equal common-mode action supplies transient mean
curvature while leaving the differential traveling-wave mode active; recovery
of alignment continuously removes the redirect, and an inner distance fade
hands an already-close crossing back to the evaluated capture controller,
without a clock or hidden stage.

Expected test: remain byte-equivalent in mechanism outside the gated approach
risk, preserve the coherent far-field and terminal wakes, and redirect the
assigned-parent below-target topology early enough to capture without raising
force, moment, clipping, or joint-speed residence outside the sampled baseline
envelope.

Falsification: reject this redirect if it retains a `left_domain` miss, changes
far-field closure, produces a standing or collapsed terminal wake, materially
raises clipping/loads, or worsens the repeat-supported capture paths. Do not
answer a failure by scalar-tuning redirect strength or stacking the previously
falsified yaw, projected-miss, posterior-pulse, or phase-allocation residuals.

bookshelf_consulted: true
source_domain: biological C-start redirection and robotic-fish target-feedback turning
source_mechanism: gate a strong bounded mean-curvature action by large observed direction error and release it as alignment recovers
transferable_invariant: a transient common-mode bend can redirect a self-propelled swimmer while a separate differential traveling wave remains active
nontransferable_details: species-specific C-start kinematics, published gains, dimensional cadence, robot joint geometry, explicit oscillator phase, exact vortex phase, world routes, and task coordinates
policy_translation: use normalized body-frame course error, target/velocity alignment, and outer/inner approach distance gates to blend the evaluated two-joint steering into equal bounded common-mode acceleration only while a missed corridor remains recoverable
falsification: reject if the same below-target miss survives, either wake view loses its traveling structure, far-field closure changes, or actuator and load metrics leave the sampled baseline envelope
