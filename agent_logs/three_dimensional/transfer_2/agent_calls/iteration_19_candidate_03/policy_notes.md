# Course-consistent steering-residual coast candidate

## Evidence diagnosis before the policy edit

- All sampled rollouts and the inherited informative failure use direct
  uniform still-water initialization (`U_infinity=[0,0,0]`), no cylinders,
  and no prewarm.  The assigned v35 steering-residual parent captures at
  `24.6730T` and `0.748684L`, with mean distance `2.348256L` and score
  `-0.448647`.  This improves the replicated v34 posterior-coast result
  (`25.0635T`, `0.749973L`, `2.352216L`, `-0.452083`) while preserving zero
  sampled posterior hard-stop occupancy and the same low peak planar
  force/yaw-moment class (`0.0253/0.0309/0.0156` versus
  `0.0244/0.0338/0.0162`).  It is a route/allocation improvement rather than
  a rate cure: posterior/total exact-rate occupancy changes slightly upward
  from `4.586/13.869%` to `4.637/13.932%`, although raw acceleration-envelope
  exposure falls from `73.930%` to `73.473%`.
- Both rows of the v35 combined keyframe sheet were inspected from release to
  capture.  The top-down row starts wake-free, shows self-propelled diagonal
  progress with a coherent alternating mid-plane vortex street, and ends in a
  bounded hook into the capture disk.  The oblique row shows compact
  three-dimensional Lambda2 structures persisting through the redirect.  The
  current result is not passive advection, wake breakup, or instability.
- The inherited phase-reversal follower is the informative failure.  Its
  top-down row follows the broad approach, passes outside the capture disk at
  `0.993183L`, then executes a large upward loop before leaving the left
  boundary at `37.1470T` and `6.9973L`; its oblique row retains compact wake
  structures, so the changed topology is a controller failure.  Metrics agree:
  zero posterior hard-stop occupancy and lower posterior/total exact-rate
  occupancy (`3.598/12.659%`) did not compensate for losing capture and raising
  mean distance to `6.65057L`.  The inherited fixed-trace audit says the new
  reference-velocity feedforward touched `306/4557` states, and the completed
  trajectory has already separated visibly by `8T`.  A joint-only rollout and
  a lower saturation statistic therefore did not establish route safety.
- The successful v35 trace localizes its useful edit far more sharply.  The
  first and only reconstructed state in which the final coast layer retains a
  velocity-opposing steering residual occurs at `12.3695T`, `7.1867L`: the
  posterior rate is at `-260 deg/T`, the retained steering is
  `+4.559 rad/T^2`, and the normalized body-frame velocity-course error is
  `+0.2395`.  Thus the residual both brakes the follower and has the same
  mirrored sign as the route correction.  It releases the plateau without the
  widespread phase intervention that failed.

## Policy hypothesis

Preserve the complete evaluated v35 controller and add only a sign-consistency
veto inside its posterior coast layer.  A velocity-opposing steering residual
may survive at the rate boundary only when its sign agrees with the already
computed normalized body-frame velocity-course error; otherwise the layer
reverts to pure coasting.  This introduces no new acceleration, brake, gain,
clock, coordinate, or route.  Under lateral reflection, posterior steering,
rate, and course error all reverse, so the veto remains equivariant.

The completed v35 trace predicts that its single effective residual survives
unchanged, making the fixed episode a conservative preservation test rather
than another saturation experiment.  Falsify the candidate if capture, the
established trajectory or coherent wake, zero posterior hard-stop occupancy,
or the low-load class changes materially.  On later reflected or perturbed
tests, reject the guard if it suppresses a necessary correction or admits a
course-contradicting residual.  The new CFD result is not available to this
worker and is not claimed here.

bookshelf_consulted: true
source_domain: Lighthill elongated-body reactive swimming and sensor-modulated coupled-oscillator robotic-fish control
source_mechanism: preserve an anterior phase anchor and a lagged posterior traveling bend while allowing bounded sensory feedback to modulate the follower without replacing the rhythm
transferable_invariant: constraint handling should preserve only steering that remains consistent with the current body-frame route objective, while removing conflicted posterior carrier effort
nontransferable_details: published gains, dimensional cadence, species-specific envelopes and kinematics, full-body waveforms, exact vortex phases, Strouhal targets, motor models, and task-specific routes
policy_translation: retain v35 and use the sign of normalized body-frame velocity-course error as a mirror-equivariant veto on its already-requested velocity-opposing posterior steering residual at the owned rate boundary
falsification: reject if capture, established route, coherent wake, zero posterior hard-stop occupancy, or the v35 low-load class is lost, or if a held-out test shows the veto removing route-corrective steering
