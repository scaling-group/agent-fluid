# Outer phase-lag feasibility governor candidate

## Evidence and visual diagnosis before the policy edit

- All four sampled evaluations are valid direct-uniform still-water rollouts:
  `U_infinity=(0,0,0)`, no cylinders or prewarm, finite free planar dynamics,
  and `capture` termination. There is no failed termination class in this
  sample, so the active response-opposed posture regression is the most
  informative failure relative to the strongest finite result.
- I inspected the complete combined keyframe sheets for the reproduced `v40`
  result and the response-opposed posture regression, including the top-down
  vorticity row and oblique body/Lambda2 row from release through capture. Both
  fish visibly self-propel from quiescent water along the same compact target
  arc, form a coherent alternating posterior wake, and retain localized finite
  three-dimensional structures. Neither sheet shows passive advection, a
  collision, a loop, boundary-exit precursors, wake collapse, or numerical
  instability. The nearly unchanged wake therefore does not validate the
  regressive terminal allocator.
- Diagnostics and trajectories agree with that visual reading. Two independent
  `v40` samples capture at `19.684490 T` with score `-0.261384287`, mean/final
  distance `2.151092787 L`/`0.748302400 L`, and identical trajectories. The
  course-worsening response branch is dormant and reproduces the same result.
  Adding response-opposed terminal posture support first changes the trajectory
  at about `3.6221 L`, delays capture to `19.722988 T`, and worsens score,
  mean distance, and final distance to `-0.261856310`, `2.151574012 L`, and
  `0.748641372 L`. Both remain stable with similar finite force/moment envelopes.
- The inherited step-30 notes independently reject the assigned parent's
  terminal command-ratio blend: it delays capture to `19.728489 T` and worsens
  score to `-0.261932556`. Thus two active terminal allocations regress, one
  response allocation is dormant, and two `v40` samples reproduce exactly.
  This is a three-iteration semantic plateau and satisfies the required trigger
  for another bookshelf consultation.
- The remaining evidenced mismatch is outside the protected late approach.
  On the reproduced `v40` trajectory above `4 L`, the anterior/posterior
  command exceeds `30 rad/T^2` on `1139/1671` stored samples and the joints
  contact the `260 deg/T` rate envelope on `215/345` samples; nearly all such
  contacts still request acceleration in the outward velocity direction.
  Yet the two-view wake remains coherent. This supports preserving the
  traveling-bend mechanism while changing how an infeasible posterior lag is
  requested, rather than adding curvature, cadence, force cancellation, or
  another terminal response branch.

## Policy hypothesis

Replace the extra response-conditioned post-clipping common-scale support with
one small outer-only phase-lag feasibility governor. First evaluate the normal
traveling-bend request. Only when three normalized state conditions agree—range
is above `4 L`, independent clipping would materially rotate the two-joint
command, and posterior lag-target error is large—reduce a bounded fraction of
the derivative-defined posterior lag and recompute the carrier. The existing
base direction-conditioned limiter then remains the sole clipping allocator.
This translates overload response into the wave target itself, instead of
stacking another limiter on the same poor-response state. The center-course
residual remains complementary after response settles, and every terminal
equation is unchanged for the same state at or below `4 L`.

This is an actuator/feedback-mechanism change, not scalar-only gain tuning. It
uses joint angle and velocity normalized by declared oscillator amplitude,
body-frame target range, and the dimensionless direction loss caused by the
declared command envelope. It adds no time, step, route, target identity,
world coordinate, vortex phase, force cancellation, or mutable state. The new
CFD result occurs only after this worker exits and is not evidence here.

Expected result: reduce infeasible outer posterior demand while retaining a
directed traveling bend, coherent two-view wake, compact approach, capture,
and the `v40` terminal handoff; improve arrival or distance integral by giving
the anterior/turn components more feasible command direction. Falsify the
mechanism if the phase-lag gate is dormant on sampled `v40` states, remains
active inside `4 L`, slows or loses capture, changes the approach into a loop
or boundary exit, worsens distance integral, increases joint-stop dwell or
loads, destabilizes the rollout, or degrades either wake view.

bookshelf_consulted: true
source_domain: traveling-wave swimming models and closed-loop coupled-oscillator robotic-fish control
source_mechanism: maintain a directed anterior-to-posterior bend and adapt posterior phase lag through observed response rather than forcing an infeasible fixed lag through actuator clipping
transferable_invariant: when a lagged propulsive oscillator cannot track and clipping destroys inter-joint command direction, reshape the requested lag continuously from normalized state feedback before limiting the actuators
nontransferable_details: published gains, dimensional frequencies, species-specific envelopes, full-body waveforms, exact beat or vortex phase, actuator models, target coordinates, and task-specific routes
policy_translation: above 4 L only, combine normalized posterior lag-target error with command-direction distortion, smoothly shorten at most a small declared fraction of the derivative-defined tail lag, and replace the extra response-conditioned common limiter while preserving the base coupled limiter and terminal law
falsification: reject on dormant or terminal activation, slower or lost capture, worse distance integral, changed compact topology, renewed joint-stop dwell, material load growth, instability, or degraded top-down or oblique wake coherence

## Non-CFD implementation audit

- Replaying the candidate and evaluated `v40` controller on all `3579`
  recorded `v40` states confirms the new overload gate is active on `2460` of
  `2807` outer states and zero of `772` states at or below `4 L`. Its maximum
  support is `0.75815`, so the declared `8%` ceiling produces at most a
  `6.0652%` lag reduction on this trace.
- On those fixed recorded states, `2460` outer commands change with maximum
  absolute component difference `0.70718 rad/T^2`; every terminal command is
  exactly identical to evaluated `v40`. This establishes activity, boundedness,
  and same-state terminal noninterference only. The realized CFD trajectory can
  diverge after an outer change and remains the post-worker falsification test.
- The lightweight public-contract check returns two finite accelerations. No
  CFD was run in this workspace.
- The prescribed check-runner was invoked after the required files were
  updated, but its pinned `gpt-5.4-mini` model is unsupported on this ChatGPT
  account and failed before running a command. Running its three commands
  directly gives PASS for the material guidance update, the finite two-output
  Julia contract, and the solver edit boundary. The supplemental deterministic
  schema guard resolves all `88` direct `params.FIELD` references against the
  `89` returned fields; only the version label is intentionally unused.
