# Multi-wake target-policy candidate notes

## Evidence diagnosis before the edit

- All four sampled rollouts satisfy the direct-uniform still-water contract:
  `U_infinity=[0,0,0]`, no cylinders, no prewarm, and finite dynamics.  Both
  rows of every combined keyframe sheet were inspected.  Their alternating
  top-down vortex trains and compact oblique Lambda2 structures confirm
  self-propulsion; the common failure is route control rather than advection
  or thrust collapse.
- The transferred seed (`solver_e1a03f18d808`) and response-gated child
  (`solver_dc5e319e8345`) are the strongest finite trajectories.  They reduce
  distance from `12.328L` to `4.780L` and `4.660L`, respectively, then continue
  below the target and exit the lower virtual boundary at `27.495T` and
  `28.369T`.  Their nearly identical sheets, termination class, and yaw
  reversal histories show that releasing geometric steering from the
  evaluator's approximately `0.0385T` yaw window did not create route-scale
  response feedback.
- Those two useful carriers are nevertheless clip-shaped: `74.0%` and `75.3%`
  of raw acceleration components exceed `1800 deg/T^2`, at least one component
  exceeds it on about `98%` of samples, and `11.9%` and `12.3%` of joint-speed
  components lie within one percent of the speed limit.  The sampled
  maneuver-cadence child (`solver_914f6830b5c6`) reduces raw component
  exceedance to `63.8%`, but worsens closest approach to `5.347L`, increases
  speed-limit exposure to `15.1%`, and retains the same lower exit.  A later
  cadence-allocation or release-gain repetition is therefore not supported.
- The assigned parent's globally slower, smoothly limited progress redirect
  (`solver_a1d9e06dfe8a`) retains an alternating wake but turns into the upper
  boundary at `14.911T`, never closer than `8.752L`.  Inherited completed logs
  strengthen that negative boundary: tail-only course-aligned mean curvature
  (`solver_ef181490e554`) reaches only `12.083L` before an upper exit, and the
  assigned lineage's cascaded course/yaw mean-curvature controller
  (`solver_eb6cd0354e1b`) reaches only `12.188L` before the same exit.  Thus
  neither persistent mean bend, signed course-error mean bend, nor wholesale
  cruise slowing should be repeated.
- The seed's measured velocity-to-target course error is already large while
  body-axis error remains small (about `-1.44 rad` versus `0.01 rad` at `2T`),
  then stays between roughly `-0.40` and `-1.23 rad` through its useful
  `4--18T` approach.  Course response is therefore an earlier release signal
  than short-window yaw, but the inherited failures show that feeding it into
  a persistent posterior offset has too much accumulated authority.

## Candidate hypothesis

Preserve the sampled seed's joint-state oscillator, posterior lag, amplitude,
and cadence scheduling because they repeatedly produce the deepest approach
and coherent 3D wake.  Remove the multi-branch static-curvature and direct
steering stack.  Replace it with one bounded course-released half-cycle
wave-shape mechanism: blend body-frame target angle at startup into the signed
angle from observed body-frame swimming velocity to the target, then use that
route error only to make the posterior velocity-lag coefficient slightly
different on the two observed joint-velocity half-cycles.  The modulation
vanishes at joint reversal and at course alignment, so it does not impose a
static mean tangent or use a clock.

Expected evidence is retention of the seed's early alternating wake and
targetward translation, a gentler course correction than the evaluated
mean-curvature candidates, and withdrawal or reversal of steering as measured
translation aligns.  Falsify the mechanism if it reproduces either sampled
boundary-exit topology, fails to beat the `4.660L` closest approach without a
better termination class, destroys the coherent wake, or materially increases
the seed's acceleration/velocity limit exposure.  The present worker does not
claim CFD evidence for this candidate; its evaluation occurs after exit.

bookshelf_consulted: true
source_domain: Robotic-fish CPG turning by asymmetric rhythmic actuation, interpreted through classical posterior-lag traveling-wave propulsion.
source_mechanism: Sensor feedback makes the propulsive wave slightly asymmetric across observed beat half-cycles while course alignment continuously releases the steering modulation.
transferable_invariant: Preserve a posterior-lagged propulsive rhythm, but apply route correction through bounded state-phased wave-shape asymmetry that vanishes with measured alignment instead of a persistent body bend.
nontransferable_details: Published gains, motor dynamics, clock-driven CPG phase, species-specific kinematics, dimensional cadence, duty ratios, exact vortex phase, and source-task routes.
policy_translation: Form target and swimming-course error only from normalized body-frame target and velocity observations; multiply the posterior velocity-lag term by a small bounded function of that error and observed anterior joint velocity under the two-joint state-feedback contract.
falsification: Reject the transfer if half-cycle modulation loses the coherent wake, increases envelope exposure, cannot improve the `4.660L` closest approach or termination class, or repeats either the lower under-correction or upper over-redirect trajectory.

## Pre-evaluation checks

- Algebraic replay on every recorded seed state gives finite commands, exact
  reflection equivariance, posterior lag scale `0.9481..1.0521`, and at most
  `0.0522` absolute modulation under the configured `0.06` bound.  The
  candidate's raw acceleration-component overrun on those off-policy states is
  `71.8%`, versus `74.0%` for the evaluated seed action.  This verifies that
  the mechanism is small and does not algebraically increase clipping on the
  inherited trajectory; it is not new CFD evidence.
- A deterministic `8,748`-state grid spanning target quadrants, forward and
  reverse body velocity, both joint-angle limits, both joint-speed limits, and
  closing/receding motion produced finite actions, bounded lag scale, and zero
  reflection error.  An aligned target/course state gives exactly zero turn
  command and lag modulation.  The direct parameter-schema audit also finds no
  `params.FIELD` reference absent from `target_policy_params()`.
- The mandated fixed check-runner was invoked, but its pinned model is not
  available for this account.  Its exact guidance, lightweight Julia contract,
  and solver-boundary commands were run directly and all pass.  No CFD was run.
