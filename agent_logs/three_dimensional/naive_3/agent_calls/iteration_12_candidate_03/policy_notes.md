# Velocity-course steering candidate

## Visual diagnosis and inherited evidence

- All four sampled rollouts and the assigned parent's completed rollout report
  direct uniform still-water initialization with `U_infinity=(0,0,0)`, no
  cylinders, and no prewarm. Their translation is therefore self-propelled,
  not ambient advection; peak sampled body speed is about `0.95--1.04U` while
  peak local flow is only `0.027--0.037U`.
- The sampled `2.989L` response-released case is the strongest current broad
  approach. Its top-down row shows a coherent alternating vorticity street
  through roughly `18T`, and its oblique row shows persistent three-dimensional
  Lambda2 structures. After the pass, the anterior oscillation collapses toward
  zero, the posterior joint settles near the `-12 deg` mean-curvature request,
  radial motion becomes target-receding, and the fish hooks into the upper
  boundary. Thus visible wake production during approach does not imply course
  recovery after target bearing enters the rear quadrant.
- The sampled anterior half-cycle stiffness variant is the informative visual
  failure: both rows remain rhythmic, but the trajectory reaches only `4.859L`,
  peak speed falls to `0.947U`, and raw acceleration-envelope exceedance rises
  to about `53/64%` for joints 1/2, compared with about `34/45%` in the
  `2.989L` response-released reference. More phase-dependent stiffness is not a
  supported way to improve the approach.
- The assigned parent's receding-gated distributed burst preserves the early
  alternating wake and changes closest approach only from `2.989L` to
  `2.959L`. By `21T` it has settled into nearly fixed bends near
  `(-14,-20) deg` with almost zero requested acceleration; radial motion remains
  receding, final distance worsens to `6.575L`, raw acceleration-envelope
  exceedance rises to about `42/49%`, and termination is again the upper
  boundary. A response gate cannot release a static redirect when that redirect
  never restores the response used by the release condition.
- A separate sampled optimizer lineage supplies the semantic contrast: its
  speed-gated body-frame velocity-course controller kept the zero-centered
  traveling carrier, reached `0.857L`, and changed termination from the common
  upper hook to a left-boundary near miss. Its inherited log reports a coherent
  three-dimensional wake, `1.052U` peak swimming speed, and only `0.031U` peak
  local flow. The later predicted-miss half-cycle edit worsened that approach to
  `0.903L`, so the supported transferable mechanism is course-angle feedback,
  not the terminal relief layered on it.

## Policy hypothesis

Preserve the anterior Van der Pol oscillator, posterior lagged traveling wave,
and bounded posterior mean-curvature channel. Replace the dimensional
`bearing - gain * lateral_velocity` steering residual with the wrapped signed
angle between the full-quadrant body-frame target ray and measured body-frame
velocity course. Blend continuously back to target bearing only at low speed,
where course direction is undefined. This makes actual lateral drift enter as
an angular course error without a fixed route, timer, or new actuation mode.

The expected result is the same coherent alternating propulsion with earlier
cross-track correction, a sub-`1L` pass, and a non-upper-boundary trajectory.
Reject the mechanism if it loses the alternating wake, materially raises
joint-limit occupancy beyond the already high carrier baseline, cannot
reproduce the inherited sub-`1L` approach, or returns to the same upper hook.

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and classical posterior traveling-wave propulsion
source_mechanism: close the slow steering loop around measured motion direction while preserving the rhythmic carrier
transferable_invariant: compare the body-frame target ray with actual swimming course and map only their bounded angular mismatch into mean curvature, leaving posterior lag to sustain thrust
nontransferable_details: published CPG gains, linkage geometry, species-specific gait envelopes, dimensional speeds, clock phase, exact vortex phase, and task-specific routes
policy_translation: form full-quadrant target bearing from normalized target_body_L, form course bearing from velocity_body_U, wrap their difference, blend to target bearing only below measurable translation, and use the bounded result as posterior mean curvature while keeping the anterior oscillator unchanged
falsification: reject if the 3D alternating wake or broad approach degrades, acceleration-limit occupancy rises materially, closest distance does not recover the inherited sub-1L trajectory, or the upper-boundary hook persists
```
