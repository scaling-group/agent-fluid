# Terminal course-authority candidate

## Visual diagnosis and inherited evidence

- All four sampled rollouts and the assigned parent's completed rollout report
  direct uniform still-water initialization with `U_infinity=(0,0,0)`, no
  cylinders, and no prewarm. Their translation is self-propelled: sampled peak
  body speeds are `0.947--1.038U`, while peak local-flow speed is only
  `0.027--0.032U`.
- The sampled `2.989L` response-released rollout is the strongest broad
  approach among the four solver examples. Its top-down row shows an
  alternating vorticity street through the approach and its oblique row shows
  three-dimensional Lambda2 structures, but after the pass the wake fades and
  the trajectory hooks sharply into the upper boundary. The controller has a
  propulsive approach but no effective recovery.
- The sampled anterior half-cycle stiffness rollout is the informative
  failure. Both visual rows remain rhythmic, yet closest approach worsens to
  `4.859L`, peak speed falls to `0.947U`, and raw acceleration-envelope
  exceedance rises to about `53/64%` for joints 1/2. Further phase-dependent
  anterior stiffness is unsupported.
- The prefilled distance-conditioned carrier hold also remains an upper exit
  and reaches only `3.592L`; its terminal scheduling begins during the broad
  approach and reduces the demonstrated carrier. This is evidence against
  early drive relief, not against a steering-only terminal schedule around a
  controller that already reaches the capture neighborhood.
- The assigned parent's speed-gated body-frame velocity-course controller
  preserves the zero-centered traveling carrier, a coherent alternating 3D
  wake, `1.052U` peak speed, and only `0.031U` peak local flow. It independently
  reproduces the inherited `0.857L` near miss and changes the common upper hook
  to a left-boundary exit. At the closest point (`19.058T`) speed is `0.845U`,
  target bearing is `-1.019 rad`, and wrapped target-ray/course error is
  `-1.421 rad`; the bounded turn request is therefore already saturated.
  Steering-scale tuning cannot supply the missing final authority. Raw
  acceleration-envelope exceedance is already high at about `58/68%`, so a
  global curvature increase would also burden the evidenced broad approach.

## Policy hypothesis

Start from the assigned parent's reproducible velocity-course controller.
Preserve its anterior Van der Pol oscillator, posterior phase-lag carrier,
full-quadrant target ray, speed-gated course-angle observation, and far-field
`12 deg` posterior mean-curvature limit. Add one smooth distance-conditioned
terminal allocation: below `3L`, raise only the saturated posterior
mean-curvature ceiling, reaching `18 deg` by `1L`. Do not damp or shift the
carrier.

The expected result is the same broad approach and alternating wake, followed
by enough extra corrective curvature inside the final two body lengths to move
the reproduced `0.857L` pass across the `0.75L` capture boundary. Reject the
mechanism if closest approach does not improve, the broad trajectory changes
before `3L`, the alternating wake degrades, raw limit occupancy rises
materially, or termination reverts to the upper-boundary hook.

```text
bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking, classical posterior traveling-wave propulsion, and terminal capture scheduling
source_mechanism: preserve the rhythmic propulsion loop while scheduling a bounded slow steering channel for the terminal regime
transferable_invariant: once target-directed propulsion is established, allocate additional bounded curvature only where the observed terminal course error has saturated, without suppressing the traveling carrier
nontransferable_details: published controller gains, dimensional speeds, linkage or species kinematics, clock phase, exact vortex phase, and task-specific routes
policy_translation: retain the full-quadrant body-frame target-ray versus velocity-course error and joint-state carrier, then use normalized distance_L only to raise the posterior mean-curvature ceiling smoothly inside 3L while leaving anterior drive and posterior lag unchanged
falsification: reject if the sub-1L approach is not retained, capture is not improved, broad-approach wake or trajectory changes before 3L, acceleration-limit occupancy rises materially, or the upper-boundary hook returns
```
