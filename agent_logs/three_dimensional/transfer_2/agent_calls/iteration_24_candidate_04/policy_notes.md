# Proprioceptive traveling-carrier governor candidate

## Visual and diagnostic evidence before the policy edit

- All four sampled evaluations satisfy the frozen contract: direct uniform
  `U_infinity=(0,0,0)` initialization, no cylinders or prewarm, finite moving-
  window transport, stable dynamics, and `capture` termination. They arrive in
  `19.1620--19.3545T`, with distance integrals `2.06924--2.07983L`; this is an
  actuator-use refinement inside a successful trajectory class, not a missing-
  propulsion or steering-sign repair.
- Both rows of the combined keyframe sheets for the strongest finite sample
  (`solver_bf9554cfba28`) and the weakest-score exact-policy repeat
  (`solver_e59354c14c2c`) were inspected from clean release through capture.
  The top-down views show self-propulsion, an organized alternating posterior
  vortex street, and the same smooth target-side hook. The oblique views show
  compact three-dimensional Lambda2 structures shed behind the caudal region,
  without passive advection, collision, wake breakup, or instability. There is
  no visible wake-topology improvement in the stronger repeat; the useful
  comparison is trajectory and actuator residence within one coherent class.
- The response-aware handoff is byte-identical in three samples but spans
  `19.1620--19.3380T`, score `-0.18047-- -0.19093`, integral
  `2.06924--2.07983L`, and head path `12.304--12.370L`. The simpler distance-
  only handoff captures at `19.3545T/-0.18968/2.07892L` on a `12.416L` path.
  Thus the response gate retains a modestly shorter route, but its timing and
  integral effect are not separable from repeat variation; do not tune that
  gate or add another approach/corridor/slip steering residual.
- Across the four current samples, anterior/posterior commands reside above
  90% of the smooth bound for `35.52--35.99%/33.79--33.99%` of samples, and
  joint rates reside above 99% of the hard envelope for
  `8.22--8.35%/4.35--4.44%`, despite zero 99%-angle-limit residence. Peak
  planar force/yaw-moment coefficients remain in the narrow
  `0.02523--0.02542/0.01333--0.01356` class. Inherited step-23 analysis further
  found that carrier acceleration shares the joint-velocity sign in about
  `82--83%/78%` of already rate-limited samples. This localizes avoidable
  outward propulsive drive at the rate envelope rather than a need for less
  steering or global amplitude/frequency tuning.
- The inherited redirect-reserve test is a negative architecture boundary: a
  near-target command-budget gate changed command and rate residence only
  marginally while widening the path and worsening the integral. The rate
  events occur mainly outside `4L`, so the new mechanism must be proprioceptive
  and trajectory-wide, while leaving target steering and approach authority
  intact.

## One-candidate hypothesis

Preserve the evaluated response-aware capture scaffold, its normalized body-
frame target mapping, distance/closing relief, velocity-course redirect,
posterior amplitude-to-lag handoff, joint-phase asymmetry, and final soft
limiter. Algebraically separate the two-joint traveling carrier from steering
and approach terms. When the maximum normalized joint speed enters the final
part of the known rate envelope and either normalized carrier acceleration is
still aligned outward with its joint velocity, smoothly attenuate both carrier
components by one common bounded factor. Leave inward carrier drive unchanged,
and restore the exact parent carrier below the threshold. The shared factor
preserves the wave relationship and does not reduce route or redirect terms.

Expected signature: preserve capture, the coherent top-down and oblique wake,
early distance milestones, the `12.30--12.37L` response-aware path class, zero
angle-limit residence, and the sampled force/moment class while materially
reducing rate-envelope residence and outward command at that envelope without
raising near-bound command residence. Falsify if early propulsion or wake
coherence weakens, capture timing/integral/path leave the response-aware repeat
envelope, loads or joint margin regress, or rate residence does not fall. If
falsified, restore the exact response-aware scaffold; do not tune the failed
redirect reserve or lower a global gait gain.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and bounded biological traveling-wave propulsion
source_mechanism: use proprioceptive feedback to keep an established rhythmic gait inside the actuator envelope without suppressing task steering
transferable_invariant: continuously remove only outward propulsive drive near a normalized joint-rate boundary while preserving the phase-related two-joint traveling wave and releasing the governor when motion turns inward
nontransferable_details: published gains, dimensional cadence, species-specific amplitudes and envelopes, robot motor models, full-body waveforms, clock phase, exact vortex phase, world coordinates, and task-specific routes
policy_translation: derive a smooth gate from normalized joint speed and carrier-acceleration alignment, then apply one common scale to both carrier components under the unchanged two-joint acceleration contract while retaining body-frame target and approach feedback
falsification: reject unless rate-bound residence and wasted outward command fall while capture, early progress, short path, joint margin, load class, and coherent top-down and oblique wakes stay inside the response-aware evidence bounds
