# Multi-wake target-policy candidate notes

## Evidence diagnosis before the edit

- All inspected evaluations use the required direct-uniform still-water setup
  (`U_infinity=[0,0,0]`, no cylinders, no prewarm).  The top-down and oblique
  rows show self-propelled motion with an alternating mid-plane wake and compact
  three-dimensional Lambda2 structures; the useful carrier is not passive
  advection and should be preserved.
- The transferred seed `solver_e1a03f18d808` and response-release child
  `solver_dc5e319e8345` make the two strongest approaches: distance falls from
  `12.328L` to `4.780L` and `4.660L`, respectively.  Both then sweep below the
  target and leave through the lower boundary at about `27.5--28.4T`.  The
  response gate changes neither that trajectory class nor the clipping burden:
  at least one raw acceleration exceeds `1800 deg/T^2` on about `98%` of both
  traces, while peak body speed remains about `0.83--0.87U` and peak local flow
  is only `0.026--0.027U`.  This supports an actuation-allocation change, not a
  wake-rejection branch or another short-window yaw-release gain.
- The informative upper-exit failures bound steering authority.  A persistent
  corrected-sign `12 deg` tail mean curvature reaches only `12.206L`; the
  inherited course-released `2 deg` tail-curvature policy reaches only
  `12.083L` and exits at `8.618T`; centering both joints on an `8 deg` bend is
  similarly poor.  Thus even small static offsets can over-turn this body.
  Conversely, the prefilled globally slower, soft-limited policy eliminates
  raw acceleration exceedance but weakens the useful approach to `8.752L` and
  exits above.  Persistent mean bend, course-angle mean curvature, global
  cadence reduction, and scalar soft limiting are all contradicted repeats.
- The latest progress-gated cadence candidate `solver_914f6830b5c6` preserves
  a coherent wake but worsens closest approach to `5.347L`, still exits below,
  and retains raw over-envelope acceleration on about `90%` of samples.  Late
  cadence relief therefore does not supply the missing route authority.

## Candidate hypothesis

Preserve the seed's `0.55T`, `28 deg` joint-state oscillator and lagged
posterior target, but remove its static mean-curvature and derivative-heavy
steering stack.  Add one actuator-aware half-cycle-asymmetry mechanism.  A
bounded target-vector angle in the body frame selects the sign and magnitude
of a zero-cycle-mean even deformation of both observed joint cycles.  The
deformation uses joint state as phase, so it adds no clock or route.  Each
carrier component is clipped to the `1800 deg/T^2` policy envelope before its
deformation residual is summed, and the final action is re-clipped.  Thus an
opposite-signed residual can weaken a saturated wrong half-cycle instead of
being erased by the seed's raw overrun, while unsaturated carrier action is
unchanged apart from the intended residual.

The expected evidence is the seed's early distance decrease and coherent wake,
with a shallower downward course and no immediate upper turn.  Falsify the
hypothesis if it repeats either upper-exit topology, fails to improve the
`4.660L` minimum without a better termination class, loses the alternating
wake, or merely reduces effort by sacrificing early progress.  Algebraic
replay can establish boundedness and allocation only; it is not CFD evidence.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning by asymmetric flapping, layered on classical posterior-lagged traveling-wave propulsion
source_mechanism: make the target-useful half-cycle modestly stronger while retaining the oscillatory carrier
transferable_invariant: a zero-cycle-mean phase asymmetry can create signed turning authority without imposing the persistent body curvature that destroyed propulsion and route progress in sampled failures
nontransferable_details: published gains, dimensional frequency and amplitude, motor dynamics, species-specific envelopes, clock-driven CPG phase, exact vortex phase, and task-specific routes
policy_translation: map normalized body-frame target-vector angle to a bounded common half-cycle deformation inferred from observed joint state, apply it after bounding the carrier and re-bound the final action while retaining the demonstrated posterior lag
falsification: reject the transfer if the deformation causes an immediate upper turn, leaves the same lower-boundary sweep, loses the coherent carrier wake or early progress, or reaches the acceleration bound through persistent steering rather than carrier-only clipping

## Pre-evaluation checks

- The mandated guidance semantic-delta check, lightweight Julia policy
  contract, deterministic parameter-schema guard, and solver editable-boundary
  audit pass.  The configured independent check-runner was invoked first but
  its pinned model is unavailable on this account, so its exact three non-CFD
  commands were executed directly and separately.
- An algebraic grid of 2,700 reflection-paired target, joint, joint-rate, and
  closing-speed configurations (5,400 action evaluations) produces finite
  actions no larger than `1800 deg/T^2`.  Mirrored target/joint states produce
  exactly mirrored actions to numerical tolerance, the centerline request is
  neutral, and the body-lateral target sign selects the intended signed
  asymmetry.  These are contract checks, not new hydrodynamic evidence; formal
  CFD remains deferred to EvE.
- Algebraic replay on the recorded seed and best-child states spans signed
  asymmetry of about `-0.037..0.098` against the `0.10` bound, with a peak
  phase-shaping residual of about `6.11 rad/T^2` versus the
  `31.42 rad/T^2` action envelope.  The resulting policy action touches the
  envelope on about `69%` of those inherited states rather than preserving the
  parents' approximately `98%` raw-overrun exposure.  Replay on another
  policy's states is not a predicted trajectory or evidence of improved CFD;
  it only confirms that the new actuator mapping is active, signed, and
  bounded at the failure states it is meant to test.
