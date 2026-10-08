# Terminal phase-allocated velocity-course candidate

## Visual diagnosis and inherited evidence

- All four sampled solver rollouts and the assigned parent's inherited
  rollouts report direct uniform `U_infinity=(0,0,0)` initialization, no
  cylinders, and no prewarm. Translation is self-propelled: the top-down rows
  show alternating shed vorticity and the oblique rows show three-dimensional
  Lambda2 structures during the target approach, while sampled local flow is
  far smaller than swimming speed.
- The sampled `2.989L` response-released case is the strongest of the four
  current solver examples. It preserves the alternating wake to about
  `1.03U`, but its posterior joint settles near `-12 deg` after the pass, wake
  production weakens, and its trajectory hooks into the upper boundary. The
  `4.859L` anterior half-cycle stiffness case is the informative failure: it
  still sheds alternating structures, yet peak speed falls to about `0.95U`
  and raw acceleration-envelope exceedance rises to about `53/64%`. Thus an
  oscillatory-looking wake does not rescue poorly allocated anterior work.
- The assigned parent's body-frame target-ray/velocity-course controller is
  the only inherited mechanism with a semantic trajectory improvement. It
  preserves the traveling wake, reaches `0.857L`, and exits the left boundary
  instead of repeating the upper hook. At the `19.058T` closest point it is
  still moving at `0.845U` with course error about `-1.42 rad`, so the miss is
  a high-speed, nearly tangent pass rather than low-speed course noise.
- Static terminal curvature has now been tested in both anterior signs without
  capture. An `8 deg` distributed center shift improves the closest point only
  to `0.838L` while raising peak anterior excursion from `26.3` to `34.3 deg`;
  the assigned parent's opposite-sign `6 deg` assist plus terminal posterior
  escalation reaches only `0.866L` and drives the posterior joint to
  `44.4 deg`. Further center shifting or posterior-cap escalation is therefore
  unsupported.
- At the course controller's closest point, anterior angle and yaw moment are
  both negative (`q1=-25.5 deg`, `C_M=-0.0077`) and measured yaw rate is
  `-0.248 rad/T`, while the negative course request requires positive yaw in
  this convention. The broader `4--12T` calibration is consistent: mean yaw
  moment is about `-0.0077/+0.0078` on negative/positive anterior-angle
  halves. The terminal miss therefore contains a directly observable
  counter-moment half-cycle, not merely insufficient scalar steering gain.

## Policy hypothesis written before the solver edit

Start from the inherited speed-gated body-frame velocity-course controller,
which is the only mechanism to produce a sub-`1L` pass and a new termination
topology. Preserve its zero-centered anterior oscillator, posterior lag,
damping, and `12 deg` mean-curvature cap. Inside the final `3L`, when wrapped
course error remains large, use anterior joint angle only as a beat-side
marker and reduce posterior traveling-wave work on the half-cycle whose
measured yaw-moment sign opposes the requested turn. Leave the useful half at
full strength. Distance or course alignment restores the symmetric carrier
continuously.

This changes cycle-resolved work allocation without a static joint center,
clock, hidden mode, route, higher carrier peak, or increased curvature cap.
The falsifiable expectation is the reproduced sub-`1L` approach followed by a
small positive-yaw correction that crosses the `0.75L` capture circle, with
posterior angle and acceleration occupancy no worse than the course parent.
Reject the mechanism if the alternating 3D wake or broad approach degrades,
the closest point does not beat `0.838L`, limit occupancy rises materially, or
the fish again misses without a distinct tighter terminal arc.

```text
bookshelf_consulted: true
source_domain: robotic-fish CPG turning and asymmetric-flapping control
source_mechanism: sensor-gated unequal work across the two propulsive half-cycles
transferable_invariant: preserve the traveling carrier while reducing only the cycle-resolved work whose measured yaw-moment direction opposes the requested turn, and restore symmetric propulsion with geometric alignment
nontransferable_details: published gains, duty ratios, clock phase, linkage geometry, species-specific envelopes, exact vortex phase, dimensional speeds, and task-specific routes
policy_translation: compare normalized body-frame target ray with measured body-frame velocity course; gate terminal correction by normalized distance and wrapped course error; infer beat side from anterior joint state and relieve only the posterior carrier half with the rollout-calibrated counter-moment sign
falsification: reject if the inherited sub-1L approach or alternating 3D wake is lost, closest distance does not beat 0.838L, actuator-limit occupancy rises, or capture and termination topology do not improve
```
