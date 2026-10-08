# Receding-gated burst-redirect candidate

## Visual diagnosis and inherited evidence

- All four sampled diagnostics and the assigned parent's completed rollout use
  direct uniform still-water initialization (`U_infinity=0`), with no cylinders
  or prewarm. Their motion is therefore controller-driven rather than ambient
  advection.
- The sampled `2.989L` prefill and `2.999L` sibling show the same useful broad
  approach in both visual rows: a coherent alternating mid-plane vorticity
  street and persistent oblique three-dimensional Lambda2 structures accompany
  self-propulsion to about `1.03U`. Local flow remains only about `0.02U`
  streamwise and `0.01U` laterally. Near minimum distance, however, their
  redirects settle toward nearly fixed bends and the paths hook upward while
  the target sweeps into the rear quadrant.
- The sampled anterior half-cycle stiffness edit is an informative mechanism
  failure. It retains visible alternating shedding, but closest approach
  worsens to `4.859L`, peak speed falls to `0.947U`, and raw acceleration-limit
  occupancy rises from about `34/45%` in the prefill to `53/64%` for joints
  1/2. Preserving oscillation is not sufficient when phase shaping degrades the
  established approach and increases actuator demand.
- The assigned parent's later posterior counterstroke-relief rollout supplies
  the newest negative result. Its top-down and oblique rows retain rhythmic
  alternating shedding through the pass, and closest approach changes only
  from `2.989L` to `2.978L`. Yet full bearing continues from about `-1.39 rad`
  at minimum distance to `-2.66 rad` by `24T`; final distance worsens from
  `6.387L` to `6.714L`, raw acceleration-limit occupancy is about `56/52%`,
  and termination remains an upper-boundary exit. Mild posterior half-cycle
  attenuation therefore preserves propulsion but does not supply enough
  recovery yaw.
- In the prefill trajectory, target-relative radial closing stays positive
  through the broad approach, is nearly zero around the `2.989L` pass, and is
  clearly negative after the target enters the rear quadrant (`-0.56U` near
  `20T`). This body-frame geometric response separates the failed pass from
  ordinary approach without using elapsed time or a world-frame route.

## Policy hypothesis

Preserve the zero-centered anterior oscillator, posterior lag, and bounded
bearing-minus-slip mean curvature exactly during target-closing motion. Add one
nonsteady recovery mechanism: when a large signed full-quadrant bearing
coincides with negative radial closing, smoothly recruit a stronger same-sign
bend at both joints and temporarily reduce the posterior traveling component.
This creates a bounded C-start-like coil only while the fish is moving away
from the target. As soon as the velocity becomes radially target-closing, the
gate releases continuously and restores the full traveling carrier, allowing
repeated state-triggered attempts without a timer or hidden mode.

Expected evidence is an unchanged early alternating wake and roughly the
`2.989L` approach, followed by a visibly tighter clockwise recovery arc after
the pass and renewed posterior shedding as radial closing resumes. Reject the
mechanism if it activates materially during broad approach, causes persistent
angle/rate/acceleration saturation, fails to restore target closing, or repeats
the upper exit without a distinct recovery arc.

```text
bookshelf_consulted: true
source_domain: biological fast-start turning and sensor-modulated robotic-fish CPG control
source_mechanism: large-error C-start-like curvature burst released by observed directional response
transferable_invariant: recruit a short strong distributed bend only while target error is large and motion is target-receding, then restore the propulsive wave when target-closing motion appears
nontransferable_details: species-specific C-start curvature and timing, published robot gains, clock phase, linkage geometry, exact vortex phase, and task-specific routes
policy_translation: derive turn sign and error from normalized full-quadrant target_body_L, derive radial response from its projection onto velocity_body_U, gate bounded joint-center curvature and posterior carrier relief by large error times receding motion, and release on restored closing
falsification: reject if broad-approach wake or closest distance degrades, the burst remains saturated instead of releasing, radial closing is not restored, or termination repeats the same upper-boundary hook without a distinct recovery arc
```
