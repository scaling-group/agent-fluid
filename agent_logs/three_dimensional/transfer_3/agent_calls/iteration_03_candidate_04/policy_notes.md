# Phase 2 candidate diagnosis and policy hypothesis

## Evidence read before the edit

- All four sampled rollouts report direct-uniform still-water initialization,
  `U_infinity=(0,0,0)`, no cylinders, and no prewarm snapshot. Both the
  top-down vorticity and oblique body/Lambda2 rows were inspected from release
  through termination. Their motion is self-propelled, not background
  advection.
- The prefilled terminal curvature-reallocation policy
  (`solver_a1253ad45bc8`) is the strongest finite example. Its top-down row
  retains the inherited alternating wake and smooth target-directed approach
  outside `4L`; its oblique row confirms coherent three-dimensional vortex
  structures without instability. Inside the terminal band the wake decays as
  both joint rates and commands settle near zero around a bounded bend, and
  the fish coasts through first-pass capture at `25.2615T`. This improves both
  termination and topology over the assigned parent's large-error redirect
  (`solver_cc8652ccb895`), which reaches only `1.1347L` before an upper-left
  exit, and over terminal capture allocation (`solver_638c08139575`), which
  reaches `1.1076L` before the same class of exit.
- The parent's approach-hold policy (`solver_e7a7bd0d3fe2`) is an informative
  successful but weaker comparator. It reduces cadence and damps joint rate
  rather than reallocating the carrier into a curvature equilibrium. The
  combined sheet shows a missed first pass and a large loop before capture at
  `51.6450T`; its score is `-1.1974`, versus `-0.5306` for the prefill. Thus the
  reusable mechanism is the state-space change from rhythmic propulsion to a
  damped bend, not generic near-target slowing.
- The prefill still crosses near the rim rather than the target center. At
  capture its distance is `0.7469L`, speed is about `0.650U`, radial closure is
  about `0.596U`, and tangential speed is about `0.259U`. From `22T` to capture
  the signed velocity-to-target course error decreases only from about
  `0.73 rad` to `0.41 rad`, while the held curvature is derived from body
  pointing geometry alone. This leaves a falsifiable opportunity to aim the
  successful glide more centrally without changing its onset or far-field
  wake.
- The common approach remains command-limited before terminal reallocation:
  the prefill reaches the command cap on `39.5%/31.3%` of logged joint
  commands. That does not justify another additive acceleration residual. A
  bounded change to the terminal curvature target preserves the existing
  convex allocation and its low-load glide.

## Policy hypothesis

Preserve the prefilled controller outside its existing terminal reallocation
gate. During that gate only, compute a signed course error from the dot and
cross products of the normalized body-frame target vector and body-frame
velocity. Add one bounded course-to-curvature residual to the total two-joint
bend tracked by the already-damped terminal controller, sharing the residual
between the anterior and posterior targets. The signal is invariant to world
pose, changes sign under lateral reflection, and requires no clock, route,
target identity, mutable state, or exact wake phase.

The expected result is an unchanged coherent approach outside `4L`, followed
by a smaller tangential/radial velocity ratio and a more central first-pass
capture without restoring the tailbeat or increasing command/load spikes.
Reject this mechanism if it changes far-field commands, loses the existing
first-pass capture, creates an angle stop or persistent terminal command,
increases terminal force/moment peaks, or does not reduce terminal course
error or improve the capture trajectory.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish target steering and terminal capture control
source_mechanism: target-conditioned bounded mean curvature with near-target yaw/slip regulation and continuous return to the posterior-lag rhythm
transferable_invariant: after propulsion is reallocated into a damped bend, remaining curvature should respond to the signed velocity-to-target course error so inertial motion, not body pointing alone, determines terminal aim
nontransferable_details: published gains, dimensional cadence, species-specific turning kinematics, exact vortex phases, full-body waveforms, and prescribed interception routes
policy_translation: body-frame target and velocity dot/cross products form a bounded course angle whose signed residual adjusts both targets of the existing two-joint terminal curvature hold only under its normalized proximity-and-misalignment gate
falsification: reject if far-field propulsion changes, first-pass capture is lost, terminal saturation or loads rise, or terminal course error and capture geometry do not improve

## Non-CFD implementation audit

Separate-module evaluation of the prefill and candidate gives exactly equal
two-joint commands for a finite synthetic state outside `4L`. Replaying only
the prefill's recorded terminal geometry and velocity (without advancing fish
or fluid) shows a positive signed course error of about `0.43`--`0.73 rad`
from `20T` to capture. The new bounded residual therefore requests the same
turn sign as the evidenced recovery, contributes at most about `3.1 deg` to
the blended total-curvature target, and decreases as course error falls. A
mirrored synthetic observation reverses the new course angle and curvature
exactly. These are activation, scale, and symmetry checks only; they are not
CFD evidence or a claim that the unevaluated candidate improves capture.
