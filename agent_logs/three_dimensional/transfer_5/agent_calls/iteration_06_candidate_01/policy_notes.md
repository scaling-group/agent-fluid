# Wake-policy diagnosis and hypothesis

## Sampled rollout evidence

- All four sampled evaluations are valid direct-uniform still-water runs:
  `initialization_mode=uniform_direct`, `U_infinity=(0,0,0)`, no cylinders,
  no prewarm snapshot, and capture. The evidence therefore measures
  self-propulsion rather than advection or inherited flow.
- The best-score `solver_e08e4373a646` and worst-score
  `solver_f2d961b95010` combined sheets are visually indistinguishable at
  keyframe resolution. In both top-down rows a compact alternating wake is
  established by `4T`, follows a broad target-directed arc, and remains
  coherent through capture. Both oblique Lambda2 rows show the corresponding
  three-dimensional paired structures attached to the posterior body, with no
  wake breakup or boundary encounter. Since this generation contains no
  termination failure, `solver_f2d961b95010` is only a relative mechanism
  failure; inherited upper/lower boundary exits remain the topology boundary.
- Adding target-relative terminal course feedback to the v22 carrier is the
  only sampled step-5 change with a clear scalar improvement. Relative to v22
  (`solver_f2d961b95010`), `solver_e08e4373a646` keeps the same `23.8810T`
  arrival but improves score from `-0.537462` to `-0.535986`, mean distance
  from `2.435490L` to `2.434313L`, and final crossing distance from `0.748674L`
  to `0.747178L`. Peak lateral-force/yaw-moment coefficients remain
  `0.02400/0.01409`, and peak heave load returns from v22's `5.448` to `4.349`.
  The residual does not visibly disturb the traveling-wave carrier.
- The other two sampled mechanisms do not justify composition. The approach
  carrier/residual allocator (`solver_8c3d920cc8a5`) reduces command exposure
  above 95% of the acceleration scale from `55.20/38.90%` to
  `53.61/37.26%`, but arrives later at `23.9250T` and has worse mean distance
  `2.435081L`; posterior speed-limit exposure remains `9.29%`. The assigned-
  parent phase-compensated counter-curvature (`solver_74436c6ae2ba`) is fastest
  at `23.7600T`, but its intended damping fails: peak yaw rises to
  `3.471 rad/T`, anterior speed-limit exposure to `20.35%`, and peak lateral
  force/yaw moment to `0.02556/0.01482`, all worse than the course residual.
- The v22 raw-yaw amplitude relief was already a weak negative in the assigned
  parent: versus the inherited v21 capture it arrived one step later, changed
  mean distance by only `-0.000225L`, left peak yaw and posterior speed-limit
  exposure effectively unchanged, and raised peak heave load. The successful
  course residual was evaluated on top of that relief, so its independent
  contribution has not yet been isolated. Its instantaneous target-transverse
  speed is also beat-contaminated (`corr(cross_track_speed, phi_dot1)=0.841`
  inside `3L`), which argues against adding another fitted phase subtraction
  after the assigned parent's failed phase-brake test.

## Candidate hypothesis

Use the evaluated v21 response-released, smoothly projected C-bend carrier and
retain only the sampled target-relative terminal course residual from
`solver_e08e4373a646`. Remove v22's whole-oscillator raw-yaw amplitude relief.
The course residual is a bounded body-frame cross product of the instantaneous
head-to-target vector and swimmer velocity, scheduled continuously inside
`3L`; it changes route steering but never replaces or globally weakens the
joint-state traveling wave. This is a mechanism-isolation candidate, not a
scalar gain probe.

The falsifiable expectation is capture with the same coherent wake and score,
mean distance, or arrival at least as good as the course-residual sample, while
avoiding the v22 heave-load regression and retaining its load/limit envelope.
Reject the ablation if capture is lost, mean distance exceeds `2.434313L`
without a material kinematic/load improvement, arrival is materially later
than `23.8810T`, or wake coherence, yaw, joint-speed exposure, commands, or
loads regress. Because the CFD run occurs after this worker exits, none of
these expectations is claimed as a result here.

```text
bookshelf_consulted: true
source_domain: sensor-feedback direction tracking in robotic-fish CPG control
source_mechanism: preserve a stable rhythmic carrier while a bounded sensory direction residual corrects course
transferable_invariant: separate propulsion from target-relative route correction and test the smallest observation-driven residual that leaves the carrier intact
nontransferable_details: published CPG gains, explicit oscillator phase, robot linkage kinematics, species-specific envelopes, dimensional frequencies, exact vortex phases, and prescribed routes
policy_translation: retain the joint-state traveling-wave C-bend and add only a normalized body-frame line-of-sight transverse-velocity residual to the two-joint steering request inside the terminal band
falsification: reject if the isolated residual loses capture or worsens directness, alternating-wake coherence, yaw, joint-limit exposure, command effort, or load histories relative to the sampled course-residual capture
```
