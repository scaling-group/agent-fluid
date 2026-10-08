# Terminal curved-gait reactivation candidate

## Visual and trace diagnosis before the edit

- The sampled and inherited evaluations are contract-valid direct-uniform
  still-water rollouts (`U_infinity=(0,0,0)`, no cylinders, no prewarm).  The
  top-down vorticity rows and oblique Lambda2 rows for
  `solver_e7a7a878626e` and the assigned-parent `solver_a0100ed18188` show a
  body-attached alternating wake translating with the fish from release
  through the target station.  Their approach is self-propelled rather than
  moving-window advection, and the late miss is not caused by wake collapse.
- `solver_e7a7a878626e` is the strongest sampled finite approach: it reaches
  `0.827823L` at `27.489T` with peak planar force/yaw moment only
  `0.02142/0.00979`.  At the minimum the fish still moves at about
  `0.664L/T`; body-frame course error is about `0.973`, projected miss is
  about `0.806L`, and both joints have nearly settled into the same-sign
  redirect at about `-23.7/-23.1 deg`.  The visible broad pass-by and trace
  therefore diagnose lost dynamic course authority while coasting, not an
  unknown redirect side or insufficient detection of the miss.
- The informative posterior-redistribution failure
  `solver_b6ed3f84ab58` visibly remains in the upper corridor, touches the
  posterior `45 deg` boundary, and exits at `(8.770,15.201)L` after reaching
  only `5.386L`.  Its peak planar force/yaw moment (`0.2124/0.09677`) is
  roughly ten times the near-miss class.  More posterior half-cycle authority
  justified by acceleration headroom is therefore unsafe and unsupported.
- The assigned parent's coordinated C-to-S recoil preserved the same coherent
  visual route but regressed to `0.830575L`; its sibling anterior recovery
  sweep reached `0.828153L`.  Together with the inherited `0.831781L`
  anterior same-side pulse, `0.846679L` posterior recovery, and
  `0.827823L` deeper static bend, the evidence closes scalar depth, one-joint
  recovery, and one-shot recoil as semantic improvements.  A different test
  must make the settled redirect hydrodynamically active without changing the
  far route.

## Policy hypothesis

Recover the low-load, response-released, terminal-miss-vetoed controller and
leave it unchanged outside the capture approach.  While normalized range is
inside `1.75L`, projected miss is unsafe, and observed closing speed is
positive, blend the static same-sign redirect into a small state-feedback
oscillation about that same mean bend.  Joint 1 supplies an autonomous bounded
oscillation around the redirect target; joint 2 follows its deviation with
the established posterior phase lag.  This creates a curved traveling bend
that can continue transferring course-normal momentum instead of holding a
static C-shape, while keeping its predicted joint excursion inside the angle
envelope.  The gate vanishes continuously at range, for a safe intercept, or
when closing stops; it uses no clock, latch, or route coordinate.

The falsifiable expectation is an unchanged far trajectory and coherent 3D
wake, followed by renewed alternating joint motion before closest approach,
a lower projected miss or lower terminal speed, and a first head crossing
inside `0.75L`.  Reject the mechanism if it does not beat `0.827823L`, merely
oscillates the body without rotating the velocity, changes the route outside
`1.75L`, loses wake coherence, touches an angle boundary, or moves load and
limit residence materially toward the posterior-redistribution failure.

bookshelf_consulted: true
source_domain: Taylor/Lighthill reactive traveling-wave propulsion combined with mean-biased robotic-fish turning
source_mechanism: maintain a bounded propulsive traveling wave about a steering curvature so the turn continues to exchange lateral momentum with the fluid instead of settling into a static bend
transferable_invariant: when a productive approach loses course authority after its redirect joints settle, preserve the calibrated mean turn side but restore a small phase-lagged two-joint wave only while measured intercept error is unsafe and closing
nontransferable_details: published gains, dimensional frequencies, full-body envelopes, species-specific joint allocation, exact vortex phases, world-frame routes, and task coordinates
policy_translation: normalized body-frame range, velocity/target projected miss, positive closing speed, joint angle, and joint velocity smoothly select a bounded anterior oscillator about the redirect mean and a lagged posterior follower under the existing acceleration clamp
falsification: reject if the head does not cross inside `0.75L` or beat the `0.827823L` minimum, velocity does not rotate toward the target, the far carrier changes, or angle clearance, coherent wake structure, force, moment, and actuator-limit exposure materially worsen

## Non-CFD implementation audit

Replaying the candidate and sampled closing-gated-depth policy on all `7260`
frozen `solver_e7a7a878626e` states changes `440` actions, all between
`0.8278L` and `1.7481L`; there are zero changes at or beyond the `1.75L`
approach boundary.  The largest component change is `9.9933 rad/T^2`, while
frozen-state acceleration-clamp incidence is unchanged at `2721` joint
samples.  A zero-speed/zero-error state returns `(0,0)`, and reflecting lateral
target and velocity together with heading, joint angle, and joint velocity
negates both commands exactly (maximum algebraic error `0`).  These checks
establish material activation, locality, boundedness, and reflection
equivariance only; they do not predict the pending CFD trajectory or claim a
same-worker improvement.
