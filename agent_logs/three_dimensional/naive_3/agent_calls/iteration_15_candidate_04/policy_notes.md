# Terminal carrier-relief velocity-course candidate

## Visual diagnosis and completed evidence

- All four sampled solver rollouts and the assigned-parent rollout report
  direct uniform `U_infinity=(0,0,0)` initialization, no cylinders, and no
  prewarm. Their translation and wakes are controller-generated rather than
  ambient or moving-window advection.
- The sampled `2.989L` response-released rollout is the strongest approach in
  the current four-solver sample. Its top-down row shows a coherent alternating
  vorticity street and its oblique row shows sustained three-dimensional
  Lambda2 structures through the broad approach. The fish reaches about
  `1.03U` while peak local flow is only about `0.03U`, then its joints settle
  near a held posterior bend, wake production weakens, and it hooks into the
  upper boundary. The `4.859L` anterior half-cycle-stiffness rollout is the
  informative visual failure: it retains alternating shedding but lowers peak
  speed to about `0.95U` and raises raw acceleration-envelope exceedance to
  roughly `53/64%`. Another global anterior phase or stiffness edit is not
  supported.
- Inherited evaluated logs show that body-frame target-ray/velocity-course
  error is the mechanism that changed trajectory semantics. It preserved the
  traveling 3D wake, moved the prior `2.96--2.99L` floor to `0.857L`, and
  changed an upper exit to a left exit. A distance-scheduled posterior
  curvature continuation reached about `0.832L`, but at closest approach it
  still traveled near `0.86U` with course error near `-1.38 rad`; posterior
  excursion reached `44.3 deg` and raw posterior acceleration exceeded the
  envelope in about `68%` of samples. More posterior curvature has essentially
  no physical margin.
- The assigned parent's opposite-turn-request anterior terminal assist is now
  a completed negative control. Its combined sheet retains a coherent
  alternating top-down wake and persistent oblique 3D structures, but it
  reaches only `0.866L` and exits left. Thus the added anterior bend worsened
  the inherited `0.832--0.857L` miss instead of crossing the `0.75L` capture
  circle. The sampled same-sign `8 deg` anterior continuation also reached
  only `0.838L` while increasing anterior excursion to `34.3 deg`. Neither
  sign of a terminal anterior center shift has demonstrated capture.

## Policy hypothesis written before the solver edit

Start from the inherited distance-scheduled velocity-course controller. Keep
its full-quadrant body-frame target/course observation, zero-centered anterior
oscillator, `12 deg` far-field posterior curvature, and the already-tested
terminal curvature ceiling. Remove anterior terminal assistance entirely.

Inside only the final `1.75L`, and only while measured velocity course remains
materially misaligned with the target ray, smoothly reduce the oscillatory
posterior carrier toward a `0.55` floor while leaving mean steering curvature
active. This allocates the nearly saturated posterior joint away from
propulsive excursion and toward its bounded steering mean when the rollout is
at risk of a fast tangent miss. Distance or course alignment restores the full
carrier continuously, so the mechanism neither coasts during the broad
approach nor creates a clocked mode.

The falsifiable expectation is an unchanged approach outside `1.75L`, followed
by lower posterior excursion and speed per unit steering during the final
approach, enough to move the inherited `0.832--0.857L` miss across the `0.75L`
capture radius. Reject the mechanism if it changes the broad trajectory,
destroys alternating shedding, loses the sub-`1L` approach, fails to reduce
posterior limit pressure, or still exits without a distinct tighter terminal
arc.

```text
bookshelf_consulted: true
source_domain: terminal capture control and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: continuously reallocate rhythmic propulsion toward steering and lower drive only in a close, misaligned approach
transferable_invariant: preserve the traveling carrier in the far field, then use normalized distance and measured course alignment to reduce excess terminal drive without removing bounded steering authority
nontransferable_details: published gains, species-specific cadence and body envelopes, robot linkage geometry, dimensional speeds, clock phase, exact vortex phase, and task-specific routes
policy_translation: retain full-quadrant target_body_L versus velocity_body_U course feedback; within a smooth distance-and-course-error gate scale only the posterior oscillatory lag component while keeping the zero-centered anterior oscillator and posterior mean-curvature request active
falsification: reject if the pre-terminal path or alternating 3D wake changes, the sub-1L approach is lost, posterior limit pressure does not fall, or terminal distance and termination topology do not improve
```
