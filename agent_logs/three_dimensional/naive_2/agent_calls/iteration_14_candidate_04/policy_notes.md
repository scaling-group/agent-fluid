# Selective yaw-moment rejection candidate

## Visual and metric diagnosis before the edit

- Every assigned example and inherited parent rollout reports direct uniform
  still-water initialization with `U_infinity=[0,0,0]`, no cylinders, and no
  prewarm. I inspected all four assigned combined sheets and the two strongest
  inherited sheets. Their top-down rows show self-propelled leftward motion
  and persistent alternating vortex streets; the oblique rows retain
  tail-connected three-dimensional Lambda2 structures through the useful
  transit. None is an advection, wake-collapse, or numerical-instability
  failure.
- The assigned examples all repeat the upper-boundary exit at
  `20.52--21.72T`. The best scalar example reaches only `5.126L`; the three
  nearby half-cycle/closure variants reach `4.530--5.000L`. Their coherent
  wakes and similar final distances (`5.885--6.035L`) show that more scalar
  tuning of proximity, agreement, or tail-wave relief is unlikely to change
  the route topology.
- The inherited convention-aware yaw controller is the useful mechanism. It
  established that posterior curvature and physical yaw have opposite useful
  signs, reached `2.299L`, and survived to `28.41T`. Response-deficit
  half-cycle relief then reached the lineage-best `2.169L`, with lower
  acceleration near-limit residence (`52.4%`) and comparable peak loads, but
  still passed the target and exited high. At its closest approach the target
  remained about `[-0.738,-2.039]L` in the body frame, speed was `0.767U`, and
  short-window yaw was `-2.281 rad/T` against a requested physical yaw near
  `+0.8 rad/T`.
- The assigned parent's extra response-gated anterior center shift does not
  survive evaluation as a positive lesson: closest approach regressed from
  `2.169L` to `2.931L`, closure was already negative near the minimum, and it
  left through the same upper boundary at `24.79T`. The alternative inherited
  closure-loss posterior burst likewise reached only `3.254L`. Both preserved
  a coherent wake, so recruiting more curvature after the miss changed the
  trajectory without fixing its direction.
- The strongest inherited trace exposes a faster cue upstream of that miss.
  From `15--19T`, short-window yaw alternates roughly between `-2.5` and
  `+3.5 rad/T` while normalized hydrodynamic yaw moment alternates within
  about `[-0.017,+0.015]`. Around `16.0T`, when course and bearing request a
  positive physical redirect, yaw is still negative and moment is
  `-0.0067`; one quarter-period later the moment has reversed before the yaw
  response has. Thus moment is a plausible bounded anticipatory residual,
  whereas adding curvature only after proximity/closure detects the miss is
  late.

## Single policy hypothesis

Start from the inherited `2.169L` response-deficit controller: preserve its
full anterior state-feedback oscillator, approach-aware course redistribution,
empirically calibrated requested-versus-measured yaw feedback, posterior lag,
and response-gated half-cycle relief. Do not retain the assigned parent's
additional anterior redirect.

Add one new fast feedback mechanism to posterior mean curvature. Normalize
`moment_z_L2` by an evidence-derived soft scale and activate a small residual
only when its sign agrees with the posterior actuator-coordinate route request.
Because useful physical yaw has the opposite sign from posterior curvature,
that agreement identifies a hydrodynamic moment driving away from the
requested yaw. The correction takes the route sign, is speed-qualified,
bounded, and becomes exactly zero for a helpful moment, zero route request,
near-rest motion, or a non-finite observation. It neither cancels all lateral
motion nor alters carrier amplitude, frequency, posterior lag, or the useful
half-cycle.

Expected result: preserve the inherited deep approach and alternating 3D wake
while reducing beat-scale wrong-sign yaw impulses early enough for the
existing route loop to turn downward before the target passes laterally. The
primary success criteria are capture, a re-approach, or a meaningfully
different non-upper exit. Reject the mechanism if closest approach worsens
beyond `2.169L`, the same upper exit persists without a tighter targetward arc,
or acceleration residence, joint limits, force/moment peaks, or either wake
view degrades materially.

bookshelf_consulted: true
source_domain: wake-interacting fish control and sensor-modulated robotic-fish rhythmic direction tracking
source_mechanism: separate slow target-directed steering from a small bounded fast hydrodynamic disturbance residual without suppressing the rhythmic carrier
transferable_invariant: retain helpful wake-induced motion and reject only sensed yaw disturbance that acts against a calibrated requested response
nontransferable_details: cylinder wakes, exact vortex phase, published gains and frequencies, robot geometry, species kinematics, maneuver timing, and task-specific routes
policy_translation: use normalized body-frame target and velocity for the slow request, the established opposite-sign posterior-curvature-to-physical-yaw map, and normalized yaw moment to add posterior mean curvature only when moment and actuator request have the wrong-turn sign agreement
falsification: reject if the inherited 2.169L approach or coherent carrier is lost, upper-boundary topology remains without a tighter or re-approaching arc, or saturation and hydrodynamic loads rise materially

## Evaluation boundary

No CFD result is claimed for this candidate. The later evaluation should
compare termination and minimum distance first, then route and moment signs
before the miss, target body components, re-approach count, acceleration and
joint-limit residence, peak force/moment, and both visual rows against the
inherited `2.169L` controller and the assigned `2.931L` parent.

An algebra-only replay on the completed `2.169L` history makes the new
residual active on `34.3%` of samples, with mean absolute active magnitude
`0.108` and maximum `0.305` in turn-state units. It changes posterior
acceleration by more than `0.1 rad/T^2` on only `6.2%` of samples and by at
most `0.838 rad/T^2`; at the helpful-sign moment samples listed above its
change is zero. This verifies boundedness and sign selectivity on recorded
states, not a counterfactual hydrodynamic outcome.
