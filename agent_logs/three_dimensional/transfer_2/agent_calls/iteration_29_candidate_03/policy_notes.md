# Terminal collision-corridor posterior energy-coast candidate

## Visual diagnosis before the policy edit

- All four sampled solver policies, trajectories, and combined keyframe sheets
  are byte-identical v41 terminal phase-allocation evaluations.  They satisfy
  the frozen contract: direct uniform still water (`U_infinity=[0,0,0]`), no
  cylinders or prewarm, and the L64 inertial moving window.  Every sample
  captures at `24.640015T`, minimum/final distance `0.748356L`, mean distance
  `2.347937L`, score `-0.448328283`, and 284 storage-window shifts.
- The sampled v41 combined sheet was inspected from release through capture in
  both views.  The top-down row starts wake-free, then shows self-propelled
  diagonal progress, a coherent alternating mid-plane vortex street, and a
  smooth transverse hook into the target disk.  The oblique row retains
  compact three-dimensional Lambda2 structures through capture.  This is not
  passive advection, out-of-plane escape, numerical breakup, or a terminal
  collision event; inherited trace analysis places peak absolute planar
  body-force/yaw-moment coefficients in the low
  `0.0230/0.0317/0.0156` class with zero posterior hard-stop occupancy.
- No termination failure is present among the current four samples.  The most
  informative visual performance regressions are therefore the two completed
  v42 allocation variants in inherited optimizer logs, whose combined sheets
  were also inspected.  Both keep v41's coherent wake and route.  Sending the
  extra terminal residual only to the posterior captures later at
  `24.673016T`, `0.748776L`, mean distance `2.348364L`, and score
  `-0.448772903`.  Reclaiming stroke-rejected posterior effort through the
  anterior phase anchor crosses one tick earlier at `24.634514T`, but worsens
  final/mean distance to `0.749001/2.348455L`, score to `-0.448985838`, and
  raw acceleration-envelope exposure from v41's `73.594%` to `74.124%`.
  Their unchanged visual wake class shows that another residual routing or
  magnitude change is not the missing capability.
- Earlier inherited failures define the far-route boundary: posterior
  reference-velocity feedforward and dual-joint rate barriers lowered rate
  statistics but changed the established path and lost capture.  Preserve the
  anterior state-feedback oscillator, posterior lag, coupled route steering,
  and every signal outside the existing `2.10L` terminal neighborhood.

## Policy hypothesis

Keep v41's body-frame geometry, predicted-miss corridor, phase-selected
coupled terminal residual, posterior stopping-stroke reserve, rate coast, and
route-scale gains.  Add one approach-energy mechanism: only while closing
inside the inherited terminal neighborhood and already on a constant-velocity
collision course, taper the portion of posterior carrier acceleration that is
aligned with measured posterior joint velocity.  Do not taper rate-opposing
carrier acceleration, target steering, curvature, or the anterior oscillator.
The gate is continuous, mirror invariant, and exactly zero outside the
existing terminal neighborhood; it uses normalized distance, projected miss,
closing speed, and observed joint state, with no clock or memorized route.

This tests whether v41's narrow crossing is carrying needless follower-wave
energy into an already-safe intercept.  Expected post-exit evidence is retained
capture and exact far-route noninterference, with a coherent wake, zero
posterior hard-stop occupancy, and the same low-load class; useful relief
should improve crossing margin or terminal load without reproducing either
v42 allocation regression.  Reject the mechanism if capture is lost, mean
distance or arrival falls back to the v40/v42 class, the pre-terminal command
changes, projected miss leaves the safe corridor, or posterior coasting erases
the traveling bend before the target is reached.  Formal CFD occurs only after
this worker exits and is not claimed here.

bookshelf_consulted: true
source_domain: closed-loop CPG modulation for robotic-fish direction tracking and terminal approach control
source_mechanism: sensory feedback modulates rhythmic effort without resetting the oscillator phase, while near-target approach control removes excess drive only after a safe intercept is established
transferable_invariant: preserve the observed anterior phase anchor and target-derived steering, and withdraw only follower actuation that is adding joint energy when normalized body-frame range, closing, and projected miss already indicate a safe terminal intercept
nontransferable_details: published gains, dimensional cadence, prescribed amplitudes or duty ratios, species and robot kinematics, full-body waveforms, exact vortex phases, Strouhal targets, the numerical capture radius, and task-specific routes
policy_translation: form an invariant gate from the existing `2.10L` approach schedule, positive normalized closing gate, and predicted-miss corridor; on that gate taper only posterior carrier acceleration with `phi_dot[2] * carrier_accel > 0`, leaving braking carrier, curvature, coupled steering, safety filters, and anterior phase unchanged
falsification: reject if capture, exact far-route locality, coherent wake, zero posterior hard-stop occupancy, or the low-load class is lost, or if crossing margin and mean distance fail to improve over replicated v41 or regress toward either completed v42 allocation

## Pre-evaluation validation

- A pure-function replay over all `4480` reconstructed v41 trace states
  returns finite commands.  The candidate differs from v41 on `145` states,
  first at `22.263998T` and `1.850649L`; the largest command difference is
  posterior-only at `5.13843 rad/T^2`, about `16.4%` of the owned acceleration
  envelope.  Maximum same-state difference at or beyond `2.10L` is numerical
  roundoff (`5.7e-14 rad/T^2`), so no far-route signal was introduced.
- Along that immutable trace, the collision-corridor gate reaches `0.5751`
  and withdraws at most `18.70%` of an energy-increasing posterior carrier
  command.  Braking carrier, curvature, target steering, and every anterior
  command remain unchanged by construction.  An isolated reflected
  joint-rate/carrier pair produces the exact negative coasted acceleration,
  confirming reflection parity of the added map.  This audit checks locality,
  boundedness, and symmetry only; it is not a coupled hydrodynamic rollout.
- Formal CFD is reserved for the post-worker evaluator.  No same-worker
  capture, load, wake, or score result is claimed.
- The configured `check-runner` was invoked, but its pinned `gpt-5.4-mini`
  model is unsupported on this ChatGPT account, matching the inherited
  infrastructure limitation.  Its three declared no-CFD commands were run
  directly and separately: the reusable-guidance semantic check, Julia public
  contract, and solver editable-boundary audit all pass.  The public probe
  returns finite accelerations `(-14.3858335, 0.0005062)`, and the deterministic
  schema audit resolves all `88` direct `params.FIELD` references among the
  `90` fields returned by `target_policy_params()`.
