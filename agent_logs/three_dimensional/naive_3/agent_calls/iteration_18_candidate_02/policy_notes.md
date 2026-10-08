# Evidence-selected posterior acceleration-reserve candidate

## Visual diagnosis and completed evidence

- All four sampled rollouts report direct uniform still-water initialization
  with `U_infinity=(0,0,0)`, no cylinders, and no prewarm. Their motion and
  wakes are controller-generated rather than ambient advection or moving-window
  transport.
- The sampled `solver_3f1368fbcb76` rollout is the only completed capture. Its
  top-down row retains a coherent alternating vorticity street from release to
  the target, and its oblique row retains discrete three-dimensional Lambda2
  structures around the posterior body and in the wake. It crosses the
  `0.75L` capture circle at `18.265T` with distance `0.749826L`; peak swimming
  speed is `1.329U` while peak measured local flow is only `0.032U`.
- The prefilled `solver_b7827355cb30` phase-sway-compensated course controller
  is the informative failure. Its two visual rows also show self-propelled,
  alternating shedding, but the fish passes above the target line, turns up,
  and leaves the domain. It reaches only `4.459L`; peak speed is `0.902U`, and
  raw acceleration exceeds the physical envelope in about `54/66%` of
  anterior/posterior samples.
- The assigned-parent notes explain the distinguishing mechanism. The
  successful controller preserves the unmodified target-ray/velocity-course
  observation and explicitly reserves posterior acceleration for mean
  steering inside `6L`; it reaches capture while reducing posterior raw
  acceleration exceedance to about `46%`. In contrast, inherited terminal
  gain, curvature, center-shift, carrier-relief, load-residual, and anterior
  phase variants stayed in a `0.834--0.876L` left-exit plateau. The sampled
  anterior stiffness failure also worsened closest approach to `4.859L`.
- The capture is physically useful but marginal: it enters the capture circle
  by only about `0.00017L`, and the posterior joint touches the `45 deg` angle
  limit. This iteration should establish the successful allocation mechanism
  as the candidate, not stack an unevaluated terminal overlay onto it.

## Policy hypothesis written before the solver edit

Replace the prefilled phase-sway-compensated failure with the completed
posterior acceleration-reserve controller exactly. Preserve its full-quadrant
body-frame target ray, measured body-frame velocity course, speed-gated error,
zero-centered anterior oscillator, posterior lag, damping, and bounded
`12 deg` mean-curvature request. Within the evidenced terminal range, split
the existing posterior acceleration envelope into a soft-bounded carrier and
a target-signed steering reserve; do not change the physical limit.

The expected signature is reproduction of the coherent broad approach and a
capture-class termination, with posterior raw acceleration exceedance below
the prefilled phase-compensated controller. Falsify this candidate if it loses
alternating three-dimensional shedding, fails to reproduce a sub-`1L` path,
returns to a left or upper exit, or increases posterior limit occupancy. A
later robustness edit should first seek a wider capture margin or less
posterior angle-stop contact while retaining this allocation structure.

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG steering and terminal capture control
source_mechanism: retain the rhythmic propulsive scaffold while observation-gated course correction remains active in the terminal regime
transferable_invariant: preserve a productive traveling carrier and give bounded target-signed correction effective authority near capture instead of replacing the gait or increasing physical limits
nontransferable_details: published gains, robot linkage geometry, species-specific gait envelopes, dimensional cadence, clock phase, exact vortex phases, source actuator ratings, and task-specific routes
policy_translation: retain normalized target_body_L versus velocity_body_U course feedback and the two-joint state-feedback carrier; use normalized distance to blend the posterior command into a soft-bounded carrier plus a steering share of the fixed acceleration envelope
falsification: reject if capture or the sub-1L approach is not reproduced, alternating 3D shedding degrades, posterior limit occupancy rises, or the terminal path reverts to a domain exit
```
