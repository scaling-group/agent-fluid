# Anterior-phase-compensated velocity-course candidate

## Visual diagnosis and completed evidence

- All four sampled rollouts and both completed assigned-parent rollouts report
  direct uniform `U_infinity=(0,0,0)` initialization, no cylinders, and no
  prewarm. Their motion is self-propelled rather than ambient or moving-window
  advection.
- Among the solver samples, the `2.989L` response-released rollout has the
  strongest broad approach. Its top-down row shows a coherent alternating
  vorticity street and its oblique row shows sustained three-dimensional
  Lambda2 structures; peak swimming speed is about `1.03U` while peak local
  flow is only about `0.03U`. The `4.859L` anterior half-cycle-stiffness
  failure retains alternating shedding but lowers peak speed to about `0.95U`
  and raises raw acceleration-envelope exceedance to roughly `53/64%` for the
  two joints. This rejects another anterior stiffness or amplitude edit.
- Velocity-course feedback remains the only inherited semantic improvement:
  it changed the repeated upper hook and `2.96--2.99L` floor into a coherent
  left-exit trajectory with a `0.857L` closest pass. A terminal posterior
  curvature schedule reached `0.832L`, but posterior excursion reached
  `44.3 deg` and raw posterior acceleration exceeded its envelope in about
  `68%` of samples, leaving no evidence for more posterior authority.
- The assigned parent's two completed visual sheets retain the same coherent
  alternating top-down wake and persistent oblique 3D structures, but neither
  terminal overlay changes the miss topology. Opposite-sign anterior assist
  reaches `0.866L`; posterior carrier relief reaches `0.876L` and touches the
  `45 deg` posterior angle stop. Their observed target-x crossings remain
  about `0.88L` above the target. Other inherited terminal controls bound the
  same result: same-sign anterior assist reaches `0.838L`, and posterior
  phase-selective counter-moment relief reaches `0.867L`. Both anterior-center
  signs and both uniform and phase-selective posterior relief therefore fail
  to beat the `0.832L` reference or create a recovery arc.
- Replay of the evaluated `0.857L` trajectory exposes a distinct observation
  problem before the terminal regime. From `6--18T`, body-frame lateral
  velocity and anterior joint rate have correlation `-0.901` and regression
  slope about `-0.113 U/(rad/T)`. Thus the existing velocity-course angle
  interprets carrier-induced lateral sway as route motion. Adding
  `0.11*phi_dot1` to the lateral course component in an offline replay leaves
  the slow translation residual but reduces wrong-sign course-error samples
  from `33.9%` to `2.2%`; the mean bounded turn request changes from `-0.330`
  to `-0.688`. These replay numbers diagnose the recorded states only and are
  not a claim about the unevaluated candidate.

## Policy hypothesis written before the solver edit

Start from the reproduced `0.857L` velocity-course controller, retaining its
zero-centered anterior oscillator, `12 deg` posterior curvature cap, lagged
traveling carrier, and speed gate. Before forming the course angle, subtract
the empirically phase-correlated sway by adding a bounded `0.11*phi_dot1` term
to measured lateral body velocity. This changes the semantic observation, not
a carrier gain: the steering loop sees the slower translation course while
joint rate remains only an observed phase coordinate. Do not retain the
terminal curvature schedule or any recent terminal overlay; the completed
evidence shows limit pressure without a meaningful cross-track shift.

The falsifiable expectation is a coherent far-field wake with a steadier
correct-sign curvature request, an earlier downward course correction, and a
target-x crossing at least `0.13L` lower than the repeated `0.87--0.89L`
offset, enough to enter the `0.75L` capture circle without raising the
posterior cap. Reject the mechanism if it loses the alternating 3D wake,
returns to an upper exit, increases acceleration/angle-limit occupancy,
over-corrects below the target, or does not improve the sub-`1L` trajectory.

```text
bookshelf_consulted: true
source_domain: wake-interacting fish control and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: separate fast rhythmic lateral motion from the slower target-directed course before modulating a traveling-wave carrier
transferable_invariant: an oscillatory locomotor velocity component should not be interpreted as persistent route error; retain the propulsive rhythm while steering from the bounded slow residual
nontransferable_details: published gains, dimensional frequencies, species-specific envelopes, robot linkage geometry, exact vortex phases, and task-specific routes
policy_translation: use normalized body-frame velocity and observed anterior joint rate to cancel only the rollout-calibrated phase-correlated lateral sway before comparing velocity course with target_body_L; preserve the two-joint zero-centered oscillator and posterior lag
falsification: reject if the alternating wake or sub-1L approach is lost, the target-x offset does not fall, limit occupancy rises materially, or the trajectory over-corrects without capture
```
