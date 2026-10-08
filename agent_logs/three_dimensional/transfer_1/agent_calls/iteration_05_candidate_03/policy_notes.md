# Evidence-confirmed acceleration-projected capture candidate

## Evidence and visual diagnosis before editing

- The four assigned solver samples are repeated evaluations of the same
  completion-gated redirect policy.  Each reports direct uniform still-water
  initialization, `U_infinity=(0,0,0)`, no cylinders, no prewarm, finite
  dynamics, and capture at `26.411 T` and `0.7496 L`.  Their identical combined
  sheets therefore show self-propulsion rather than imposed advection.
- In the top-down row, the fish retains a compact alternating red/blue wake,
  follows a continuous target-directed path, and bends into the capture circle
  instead of repeating the inherited upper-left or lower-boundary misses.  In
  the oblique Lambda2 row, discrete three-dimensional structures remain behind
  the posterior body from release through the terminal turn, with no visible
  wake collapse or instability.  The metrics agree: mean distance is
  `2.6134 L`, mean/max speed is `0.501/0.667 L/T`, and peak force and moment
  coefficients are about `0.0332` and `0.0268`.
- The successful parent nevertheless requests at least one acceleration beyond
  the `1800 deg/T^2` envelope in `82.53%` of trajectory rows; component peaks
  are `74.20` and `85.64 rad/T^2`.  The evaluator clips those commands to
  `31.416 rad/T^2` before they affect joint motion.
- The inherited acceleration-projected rollout is the useful contrast.  Its
  combined keyframes are byte-identical to the successful parent, its capture
  time, score, distance, speed, force, moment, and termination are identical,
  and a hash of every trajectory column except the two logged command columns
  is also identical.  Only the raw commands change, with both peaks bounded at
  `31.416 rad/T^2`.  Thus policy-boundary projection is empirically idempotent
  under this evaluator, not a new gait or scalar-only gain edit.
- An earlier inherited sample combined acceleration projection with a
  near-speed-limit outward-acceleration guard.  That additional guard delayed
  capture by `0.4015 T`, worsened mean distance from `2.6134 L` to `2.6382 L`,
  and showed no compensating force/moment benefit.  It remains excluded; the
  available failure evidence does not justify changing the captured joint
  trajectory.

## Policy hypothesis

Retain the evaluated completion-gated redirect, posterior-lag carrier,
target-relative guidance, cadence scheduling, and half-cycle steering.  Add
only a finite componentwise projection of the final two joint-acceleration
commands onto a parameter-owned `1800 deg/T^2` envelope.  This makes the public
policy honor the physical actuator contract while preserving the already
captured applied trajectory.  No joint-speed guard, route, clock, coordinate,
or task identity is added.

Expected result: reproduce the captured parent's trajectory, coherent two-view
wake, `26.411 T` arrival, and score to deterministic tolerance, while never
issuing a raw acceleration outside the public envelope.  Falsify this candidate
if applied joint state, trajectory, wake, loads, capture, or score differs
materially, or if any returned acceleration is nonfinite or exceeds the
parameter-owned bound.

bookshelf_consulted: true
source_domain: actuator-constrained robotic-fish CPG and residual joint control
source_mechanism: preserve a feedback-generated propulsive rhythm while projecting the issued joint command onto the physical actuator interface
transferable_invariant: a feasibility projection belongs at the actuator boundary and should leave all already-feasible lower-amplitude feedback behavior unchanged
nontransferable_details: published robot gains, torque and motor models, clocked CPG phase, species-specific kinematics, exact vortex phases, and task-specific routes
policy_translation: retain normalized body-frame completion-gated guidance and componentwise clamp the two finite final acceleration commands to the parameter-owned envelope, without the unsupported joint-speed guard
falsification: reject if bounded output changes applied joint histories, capture topology, wake coherence, loads, or score, or if a returned command exceeds the declared envelope

