# Hydrodynamic-opposition phase-release replicate

## Evidence diagnosis recorded before the policy edit

- All four sampled rollouts satisfy the frozen contract: direct uniform
  `U_infinity=(0,0,0)` initialization, no cylinders or prewarm, finite
  dynamics, and capture. In the fastest actuator-consistent and slower
  complementary combined sheets, the top-down rows show body-led target
  progress with coherent alternating vortex streets from release to capture.
  Their oblique rows retain compact three-dimensional Lambda2 structures
  behind the swimmer. Neither case is passively advected, loses its wake,
  collides, loops, exits the domain, or becomes unstable; route timing and
  actuator use, rather than propulsion creation, separate the candidates.
- The sampled actuator-consistent prefill captures at `18.6725T`, score
  `-0.133625`, and mean distance `2.02129L`, but its exact-policy assigned-
  parent repeat captures at about `19.008T` and scores `-0.154407`. That
  `0.3355T` same-hash spread is larger than the sampled timing gaps among
  actuator consistency (`18.6725T`), complementary handoff (`18.7495T`),
  hydrodynamic opposition (`18.7880T`), and demand lead (`18.7880T`). A single
  fastest arrival is therefore not evidence for more phase authority or
  scalar timing edits.
- The hydrodynamic-opposition rollout is the useful load-side contrast. It
  captures at `18.7880T` with a coherent wake and the same `0.01809U` local-
  flow RMS, while lowering action RMS from `24.95/28.85` to
  `24.41/28.56 rad/T^2`, anterior/posterior acceleration-limit occupancy from
  `42.68/76.41%` to `40.95/74.41%`, and force/moment RMS from
  `0.01350/0.00703` to `0.01306/0.00679`. The complementary amplitude handoff
  also lowers posterior occupancy to `74.48%` and loads to
  `0.01336/0.00696`, but its unconditional phase-linked release does not
  distinguish whether the fluid response is already helpful.

## Policy hypothesis recorded before editing

Replace the prefilled actuator-only selector with an exact replicate of the
sampled hydrodynamic-opposition architecture. Preserve normalized body-frame
bearing and LOS-rate guidance, recoil-conditioned yaw response, distributed
C-bend, response-reversing half-cycle steering, persistent same-side actuator
gating, fixed-norm posterior phase rotation, and componentwise feasibility
projection. Add only the sampled physical-response release: the
reflection-invariant product of requested yaw-response direction and normalized
hydrodynamic yaw moment smoothly releases posterior phase when the fluid moment
already helps the requested turn, while adverse or neutral moment retains the
actuator-consistent path.

This is a robustness test of a previously observed load improvement, not a
claim that the current worker has new CFD evidence. Support requires capture
with both wake views coherent and a material occupancy or load reduction
relative to `76.41%` posterior occupancy and `0.01350/0.00703` force/moment
RMS. Falsify it if capture is lost, arrival exceeds the replicated half-cycle
upper band near `19.052T` without such relief, posterior occupancy exceeds
`76.4%`, or force/moment RMS exceeds `0.01574/0.00810`. Applicability above
the observed approximately `0.018U` local-flow RMS remains untested.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and adaptive wake interaction
source_mechanism: preserve a propulsive rhythm while measured fluid response gates a bounded posterior phase correction instead of cancelling every lateral motion
transferable_invariant: retain the traveling-wave carrier and release corrective phase only when normalized observed yaw moment already supplies the requested body-frame turn
nontransferable_details: published gains, oscillator frequencies, robot geometry, species kinematics, exact vortex phase, dimensional loads, and task-specific routes
policy_translation: multiply the existing actuator-consistent phase gate by a smooth reflection-invariant release formed from yaw-response direction and normalized `moment_z_L2`
falsification: reject if capture or wake coherence is lost, arrival exceeds 19.052T without material load relief, or posterior occupancy and force/moment exceed the established bounds
