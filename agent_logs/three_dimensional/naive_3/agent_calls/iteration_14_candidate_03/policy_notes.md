# Terminal anterior-assist velocity-course candidate

## Visual diagnosis and inherited evidence

- The four sampled solver rollouts, the assigned parent's completed rollouts,
  and the inherited terminal-curvature rollout all report direct uniform
  `U_infinity=(0,0,0)` initialization, no cylinders, and no prewarm. Their
  translation and wakes are controller-generated rather than moving-window
  advection.
- The sampled `2.989L` response-released case is the strongest useful sampled
  approach. Its top-down row shows a coherent alternating vorticity street and
  its oblique row shows persistent three-dimensional Lambda2 structures while
  speed reaches `1.032U`; peak local flow is only `0.032U`. Its posterior
  redirect then settles toward a nearly fixed joint and the path hooks into
  the upper boundary, so a static tail bend does not provide recovery.
- The sampled anterior stiffness-asymmetry case is the informative visual
  failure. It keeps an alternating wake but reaches only `4.859L`, lowers peak
  speed to `0.947U`, and raises raw acceleration-envelope exceedance to about
  `53/64%` for joints 1/2. This rules out another phase-dependent anterior
  stiffness edit.
- The assigned parent's velocity-course controller changes the trajectory
  semantics: it preserves the alternating top-down and oblique wake, reaches
  `0.857L`, and exits the left boundary rather than repeating the common upper
  hook. At its closest point, speed is `0.845U`, full target bearing is about
  `-1.019 rad`, and wrapped target-ray/course error is about `-1.421 rad`.
  The target is passed nearly tangentially while the turn request is already
  saturated, so steering-scale tuning cannot fix the terminal miss.
- The inherited distance-scheduled posterior-curvature continuation improves
  the closest point only from `0.857L` to `0.832L`. At the closest point its
  speed remains `0.858U` and course error remains about `-1.379 rad`, while
  posterior excursions reach `44.3 deg` and raw posterior acceleration exceeds
  the envelope in about `68%` of samples. With only `0.7 deg` of posterior
  angle margin, another posterior curvature increase is unsupported. The
  anterior carrier still peaks near `26.3 deg`, leaving bounded terminal angle
  margin in a different actuator channel.

## Policy hypothesis

Start from the best inherited distance-scheduled velocity-course policy.
Preserve its body-frame target-ray/course error, zero-centered far-field
anterior oscillator, posterior phase lag, and terminal posterior ceiling.
Inside the final `2L`, and only when course error is materially unresolved,
move the anterior oscillator center by at most `6 deg` with sign opposite the
turn request. The sign follows the inherited moment calibration: anterior
angle and yaw moment share sign, whereas required yaw has sign opposite the
course turn request. Smooth distance and alignment gates make the assist vanish
outside the terminal regime or as the measured course aligns, so this is a
short sensor-triggered distributed bend rather than a held route or clocked
mode.

The falsifiable expectation is unchanged broad approach and wake formation,
followed by enough additional correct-sign yaw to move the inherited
`0.832L` tangent pass across the `0.75L` capture circle without pushing the
posterior joint beyond its nearly exhausted angle margin. Reject the mechanism
if the sub-`1L` approach is lost, the alternating wake degrades, anterior
acceleration-limit occupancy rises materially, either joint reaches persistent
angle saturation, or the fish still misses without a distinct tighter
terminal arc.

```text
bookshelf_consulted: true
source_domain: biological fast-start turning and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: a bounded large-error body bend recruited near the target while the traveling carrier remains the cruise scaffold
transferable_invariant: allocate a brief correct-sign bend through an actuator channel with remaining physical margin, and remove it continuously when measured course alignment returns
nontransferable_details: species-specific C-start curvature and timing, published gains, robot linkage geometry, dimensional speeds, clock phase, exact vortex phase, and task-specific routes
policy_translation: retain normalized body-frame target-ray versus velocity-course steering; gate a small anterior oscillator-center offset by normalized distance and wrapped course error, with sign set by the rollout-calibrated anterior-angle/yaw-moment relation, while preserving the posterior traveling wave
falsification: reject if the inherited sub-1L pass or alternating 3D wake is lost, limit occupancy rises materially, angle saturation appears, or terminal distance and termination topology do not improve
```
