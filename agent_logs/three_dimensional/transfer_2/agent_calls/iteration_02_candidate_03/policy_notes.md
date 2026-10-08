# Multi-wake target-policy diagnosis

## Evidence read before the edit

- All four sampled evaluations satisfy the experiment contract: direct uniform
  still-water initialization with `U_infinity=[0,0,0]`, no cylinders, no
  prewarm, finite dynamics, and `left_domain` termination.  Motion in the
  keyframes is therefore self-propulsion rather than imposed advection.
- Both rows of every combined keyframe sheet were inspected.  The transferred
  seed (`solver_e1a03f18d808`) and response-gated sibling
  (`solver_dc5e319e8345`) form strong alternating top-down vortex trains and
  compact oblique Lambda2 structures while taking nearly the same down-left
  route.  They reach `4.780L` and `4.660L`, respectively, then keep swimming
  below the target and exit the lower boundary at about `27.5--28.4T`.
- The assigned parent (`solver_a1d9e06dfe8a`) preserves an alternating wake
  and reaches `0.692U`, so its slower carrier remains propulsive.  Its
  progress-loss redirect changes the topology but not usefully: the fish
  travels up-left, exits the upper boundary at `14.911T`, and never gets closer
  than `8.752L`.  The direct line-of-sight mean-curvature sibling
  (`solver_dc5bdf69e4ab`) turns upward even sooner, reaches only `12.206L`, and
  exits at `7.887T`.  The oblique views confirm wake production in both cases;
  these are course-control failures rather than thrust collapse.
- The parent removes raw acceleration-envelope exceedance (`0%` versus
  `74.0%` for the seed), but joint-speed exposure rises from `11.9%` to
  `15.6%`.  Thus soft-limiting the carrier is useful but not sufficient, and
  the parent's highest scalar score is caused by its smaller terminal-hold
  distance rather than a better closest approach or termination class.
- The two failure directions expose a discriminating body-frame signal.  On
  the parent's upper route at `6T`, its swimming-velocity angle is about
  `+0.65 rad` while the target-ray angle is about `-0.30 rad`; on the seed's
  lower route at `14T`, those angles are about `+0.37 rad` and `+0.81 rad`.
  Their signed course errors are therefore opposite.  In contrast, a
  geometry-only mean bend overshot into the upper exit, while releasing only
  the inherited acceleration bias after yaw response improved minimum
  distance by just `0.12L` and retained the lower exit under heavy clipping.

## Candidate hypothesis

Preserve the assigned parent's `0.80T`, 22-degree joint-state oscillator,
posterior lag, and smooth acceleration envelope.  Replace the inherited
multi-branch steering and progress-loss redirect with one cascaded
course-response primitive: compare the normalized body-frame target-ray angle
with the observed body-frame swimming-velocity angle, map that course error to
a bounded desired yaw rate, and map yaw-rate error to a bounded cycle-mean
tail tangent.  At low speed, continuously fall back to body-axis target error
so startup velocity noise cannot choose the turn.  Steering then enters the
posterior target upstream of the acceleration envelope and releases or brakes
as the measured turn/course response appears.

Expected evidence is retention of the parent's coherent wake and zero raw
acceleration overrun, an early downward correction of the parent's upper
route without recreating the seed's lower curl, reduced joint-speed limiting,
and either capture or a closest approach below `4.660L` with a better
termination class.  Falsify the mechanism if velocity-angle feedback merely
adds tailbeat-scale switching, if the fish keeps either sampled boundary-exit
topology, if closest approach worsens, or if propulsion/wake coherence is
lost.

bookshelf_consulted: true
source_domain: Sensor-modulated robotic-fish CPG path following and biological burst redirection.
source_mechanism: A slow target/course error requests bounded rhythmic asymmetry, then observed turning response releases or brakes the redirect while the propulsive oscillator continues.
transferable_invariant: Persistent route error should alter cycle-mean curvature upstream of actuator clipping, but correct-sign measured course and yaw response should reduce that curvature before hydrodynamic lag causes overshoot.
nontransferable_details: Published controller gains, dimensional frequencies, robot motor dynamics, species-specific C-start shapes, exact vortex phases, duty ratios, and task-specific routes.
policy_translation: Form target and swimming-course angles only from normalized body-frame target and velocity observations; convert their bounded difference to a desired yaw rate and its response error to a bounded posterior mean tangent in the two-joint state-feedback oscillator.
falsification: Reject the transfer if it loses the coherent alternating wake, increases limit exposure, fails to beat the `4.660L` closest approach or termination class, or reproduces either the upper- or lower-boundary curl.

## Pre-evaluation checks

- Algebraic replay on recorded states gives signed course errors of `+0.904`
  and `+0.340 rad` on the parent's upper route (`6T` and `10T`), versus
  `-0.414` and `-1.171 rad` on the seed's lower route (`14T` and `18T`).  The
  yaw-response loop brakes the already-fast correct-sign rotation at the first
  parent state, requests positive mean tangent when the parent's measured yaw
  has reversed at the second, and requests negative mean tangent on both lower
  route states.  This is an offline policy probe, not new CFD evidence.
- A deterministic grid spanning target quadrants, forward/backward velocity,
  `+/-4 rad/T` yaw, joint-angle limits, and joint-speed limits produced finite
  actions strictly below the `1750 deg/T^2` soft envelope.  A reflection probe
  produced exactly sign-reflected joint commands, and aligned target/course
  state produced zero steering tangent.
- The candidate contract, direct parameter-field ownership, reusable-guidance
  delta, and solver edit-boundary checks pass.  The fixed check-runner agent
  was invoked as required but its mandated `gpt-5.4-mini` model is unavailable
  for this account; its exact three non-CFD commands were therefore run
  directly and all passed.  Formal CFD remains deferred to the evaluator.
