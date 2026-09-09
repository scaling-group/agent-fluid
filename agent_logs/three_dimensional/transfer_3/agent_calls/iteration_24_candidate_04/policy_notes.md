# Candidate diagnosis and hypothesis

## Evidence read before the edit

- All four sampled evaluations report `uniform_direct` initialization with
  `U_infinity=(0,0,0)`, no prewarm, `capture` termination, and finite dynamics.
- The combined sheets for the strongest finite sample
  `solver_8c5ed84c4bcd` and the most informative negative control
  `solver_6c54dcec8495` were inspected from release through capture. In both
  the top-down row develops a coherent alternating vorticity street behind
  the body, while the oblique row develops body-attached and shed Lambda2
  structures. The fish translates toward the target and bends onto the
  capture arc; it is self-propelled rather than advected by ambient flow.
  Neither sheet shows wake collapse, domain exit, collision, or instability.
- The visuals are deliberately not used to rank these close trajectories.
  Their trace local-flow RMS is only `0.01798--0.01816U`, while all retain the
  same visible wake topology. The useful distinction is therefore route and
  actuator response: the actuator-consistent phase gate captures at
  `18.6725T`, score `-0.13362`, mean scored distance `2.02129L`, with
  anterior/posterior acceleration-limit occupancy `42.15%/76.11%` and
  force/moment RMS `0.01350/0.00703`. The assigned-parent complementary
  handoff captures at `18.7495T`, score `-0.14192`, with lower
  `41.36%/74.16%` occupancy and `0.01336/0.00696` loads, so globally replacing
  half-cycle amplitude authority with phase saves effort but loses route
  performance.
- Two current physical-response ablations also preserve capture but do not
  beat the actuator-consistent gate. Releasing posterior phase whenever yaw
  moment helps captures at `18.7880T` and `-0.13976`; requiring near-satisfied
  yaw error captures at `18.7715T` and `-0.13713`. The latter lowers occupancy
  to `40.96%/75.39%` and loads to `0.01335/0.00695`, showing that response
  conditioning is the less harmful release semantic, but direct removal of
  the phase actuator remains slower.
- Inherited optimizer logs add captures at scores `-0.14930`, `-0.15029`,
  `-0.15198`, and `-0.15441`; they do not overturn the sampled semantic
  ordering. The assigned-parent guidance also reports that raw hydrodynamic
  yaw moment opposes requested correction in `65.6%` of strong-response
  samples, so instantaneous moment is a fast response signal rather than a
  replacement for the slow LOS route request.

## Policy hypothesis

Preserve the best sampled actuator-consistent posterior phase recruitment and
the coherent LOS-rate C-bend carrier exactly. When normalized hydrodynamic yaw
moment already helps and the recoil-conditioned yaw error is near closure,
relieve only the half-cycle amplitude-asymmetry channel. This is a bounded,
reflection-equivariant allocation: the product of yaw-error direction and
body yaw moment is invariant under reflection, and no range, time, route, or
world coordinate is introduced. It tests whether the direct moment releases
were slow specifically because they removed useful phase steering, while the
parent result suggests that some amplitude relief can reduce redundant load.

Reject the mechanism if it loses capture, arrives later than the established
`18.931T` replicated half-cycle bound, breaks the alternating wake, or exceeds
the actuator-consistent sample's `0.01350/0.00703` force/moment RMS. A result
within the sampled arrival spread but below the parent load is evidence only
for effort relief, not improved route control.

bookshelf_consulted: true
source_domain: wake-interaction studies and sensor-modulated robotic-fish CPG control
source_mechanism: preserve useful fluid-induced motion and modulate only a residual rhythmic steering channel from measured response
transferable_invariant: separate slow target geometry from fast hydrodynamic response, and relieve the smallest redundant actuator contribution only after the requested response is being satisfied
nontransferable_details: organized-vortex-street phase, species and robot kinematics, published gains, dimensional frequencies, and source-task routes
policy_translation: retain normalized body-frame LOS and joint-state phase feedback; use the reflection-invariant product of normalized yaw-error direction and `moment_z_L2`, gated by yaw-error closure, to reduce half-cycle amplitude asymmetry without suppressing the carrier or posterior phase actuator
falsification: reject if capture is lost, arrival exceeds 18.931T, wake coherence degrades, or force/moment RMS exceeds 0.01350/0.00703; do not extrapolate beyond direct low-flow still water without disturbance evidence
