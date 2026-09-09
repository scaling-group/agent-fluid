# Candidate diagnosis and hypothesis

## Evidence read before the edit

- All four sampled evaluations report `uniform_direct` initialization,
  `U_infinity=(0,0,0)`, no cylinders, finite `100T` horizon completion, and
  valid top-down and oblique 3D keyframes. This is self-propelled still-water
  evidence rather than prewarm advection.
- In both visual rows, the `solver_6eb170b0d70a` course-hold scaffold and the
  assigned `solver_ba444c755721` parent shed coherent alternating 3D wakes and
  follow repeated target-return loops. The best scaffold turns into a tighter
  family of loops and reaches `1.241L`; the parent's target-crossing-gated
  anterior burst opens the later orbit and reaches only `1.987L`. There is no
  visible collision, domain exit, wake singularity, or numerical instability;
  the failure is a stable miss.
- The trajectory data makes the visual distinction sharper. The best scaffold
  has mean/final distance `4.157/2.082L`, spends `0.473%` of the horizon inside
  `1.25L`, and after `40T` retains mean joint-speed/action norms of
  `1.372/15.829`. The parent has `3.887/3.522L`, never enters `1.25L`, and after
  `40T` its corresponding norms fall to `0.012/0.046`, with every late sample
  below a `0.05 rad/T` joint-speed norm. The ungated anterior-burst sample and
  joint-state posterior-stroke sample likewise settle to late joint-speed
  norms of only `0.010` and `0.021`. Their finite body speed near closest pass
  is therefore residual coast, not continuing gait authority.
- At the best `1.241L` miss, speed is still `0.669U`, course error is
  `1.692 rad`, course dot is `-0.121`, yaw magnitude is only `0.129 rad/T`, and
  joint-speed norm is `0.282 rad/T`. Excess yaw is not the terminal defect, so
  yaw damping or more static anterior curvature is contradicted. The parent
  demonstrates that even a fully-behind-gated anterior equilibrium burst can
  quench the oscillation and perturb the useful loop topology.

## One candidate mechanism

Start from the evidenced `1.241L` terminal course-hold policy, removing the
parent's failed anterior burst. Add one continuous gait-stall release to the
existing course-response curvature reserve. Only when normalized joint-speed
activity is low, the target is fully behind, distance is terminal, and course
error is large, smoothly withdraw the extra response curvature while retaining
the base C-turn and state-feedback carrier. Moving the equilibrium away from a
nearly static C-bend should re-excite the measured joint-state oscillator
without a clock, route, added drive gain, or posterior acceleration residual.
The release vanishes on the approach and whenever joint motion is healthy.

bookshelf_consulted: true
source_domain: biological C-start release and sensor-modulated robotic-fish CPG turning
source_mechanism: release a strong asymmetric bend back into a traveling propulsive rhythm instead of holding a static C-bend
transferable_invariant: persistent steering must retain or recover directed joint-wave activity; maneuver release should depend on measured state and response
nontransferable_details: species-specific C-start timing, body envelopes, published oscillator gains, dimensional frequencies, and prescribed turn routes
policy_translation: use normalized two-joint speed plus body-frame target direction, distance, and course error to smoothly release only the terminal course-response curvature reserve while preserving the base C-turn and lagged two-joint carrier
falsification: reject if the first recovery changes materially, late joint motion or coherent wake still collapses, clamp or load residence rises, or minimum distance and residence inside 1.25L fail to beat the 1.241L scaffold
