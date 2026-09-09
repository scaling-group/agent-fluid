# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- The assigned parent guidance and inherited worker notes establish a useful
  carrier/steering split. The naive joint-state oscillator self-propels in
  still water but exits the upper boundary at `8.602T`; restrained body-frame
  mean curvature plus posterior alignment gating preserves the traveling wake,
  approaches the target, and extends the episode to about `31T`. All four
  sampled rollouts are finite direct-uniform `U_infinity=(0,0,0)` releases with
  no cylinders or prewarm snapshot, so their motion is controller-driven rather
  than advection or an initialization artifact.
- I inspected both the top-down vorticity and oblique body/Lambda2 rows of the
  strongest finite sample and the informative approach-envelope failure, and
  cross-checked the same trajectory topology in the half-cycle and full-angle
  samples. The `2.443L` parent leaves a long alternating planar vortex chain
  and coherent three-dimensional structures while translating left and down.
  The distance-only envelope still leaves a long wake and follows the same
  cross-below route, but regresses to `2.845L`; this is not wake collapse,
  instability, or passive drift.
- The alignment-gated parent reaches `2.443L` at `17.869T` with speed about
  `0.685U`. The target direction is then about `1.421 rad` off the nose while
  the velocity course is only about `0.213 rad` off it, leaving a `1.208 rad`
  target-versus-course error. Closing falls to approximately zero by `18T`,
  after which the coherent powered motion continues below the target to the
  lower boundary. Anterior acceleration is already clamped near `28 rad/T^2`
  for about `75%` of its trace, so extra command ceiling or undifferentiated
  drive is not supported.
- Three completed semantic variants do not change that outcome: distance-only
  carrier relief reaches `2.845L`, full target-direction gating reaches
  `2.494L`, and away-half-cycle braking reaches `2.501L`; all recede and exit
  below near `29--31T`. Full direction fixes the acute-bearing alias after the
  target passes behind, but the negative result shows that representation or
  braking alone does not create the missing pre-pass course correction.
- The inherited trace diagnosis identifies the instantaneous yaw-rate release
  as a tailbeat-contaminated navigation signal. In the strongest rollout from
  `8--18T`, target-versus-course error averages about `0.61 rad` and has the
  wrong sign for about `13%` of logged samples, whereas the existing
  bearing-minus-yaw-rate request has the wrong sign for about `19%`. From
  `12--18T` those fractions are about `2%` and `7%`, respectively. This
  supports changing the feedback primitive while retaining the evidenced
  curvature bound, rather than scalar gain tuning.

## Policy hypothesis

Preserve the sampled `0.55T`, 28-degree joint-state carrier, posterior lag,
`7 deg` mean-curvature envelope, and acceleration reserve. Replace the
instantaneous yaw-rate release with one course-tracking mechanism: compute full
signed target direction from normalized `target_body_L`, compute the measured
travel direction from normalized `velocity_body_U`, and map their wrapped
difference to mean curvature. A smooth speed confidence uses target direction
itself at release, when a course angle is undefined, and transitions to
target-versus-course error after self-propulsion is established. Full target
direction also keeps the existing posterior alignment gate semantically valid
after a pass.

Expected evidence is the same coherent far-field wake and left/down progress,
followed by a more persistent correct-sign bend before closing vanishes, a
closest approach below `2.443L`, or a better termination class. Falsify this
translation if early propulsion or wake continuity deteriorates, velocity
oscillation produces another alternating steering command, a tight short-wake
curl replaces the useful route, the same powered lower exit remains, or
actuator-limit residence worsens.

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and fish target-to-curvature steering
source_mechanism: superpose a bounded navigation-scale bend on a propulsive rhythm using target direction and measured translational course
transferable_invariant: slow body-frame target-versus-course error should command mean curvature while joint-state feedback continues to supply the traveling bend
nontransferable_details: published CPG gains, clocked phase, robot geometry, species-specific kinematics, dimensional lookahead, exact vortex phases, and task-specific routes
policy_translation: blend full target direction at low normalized speed into wrapped target-versus-velocity-course error, then use that signal for the existing bounded two-joint mean-curvature carrier and full-direction posterior gate
falsification: reject if early target progress or wake coherence degrades, course feedback remains tailbeat-oscillatory, a tight curl appears, closest approach does not beat 2.443L, the lower exit persists, or actuator-limit residence worsens
```
