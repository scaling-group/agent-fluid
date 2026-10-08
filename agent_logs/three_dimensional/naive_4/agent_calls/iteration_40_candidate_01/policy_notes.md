# Candidate diagnosis and hypothesis

## Evidence read before the edit

- All four sampled rollouts report direct uniform initialization with
  `U_infinity=[0,0,0]`, no cylinders, and capture. The assigned-parent log also
  records capture (`-0.039816`, final `0.745761L`), so the remaining problem is
  route and actuation quality rather than discovering basic target steering.
- In both combined sheets inspected, the top-down row progresses from no wake
  at release to a strong, spatially regular alternating vortex street by
  `4-8T`; the street remains organized through the target crossing. The
  oblique row likewise shows discrete alternating three-dimensional structures
  shed behind a translating fish, with no visible wake collapse or passive
  background advection. Thus the established traveling-bend carrier is useful
  and should remain intact.
- The strongest finite sample (`solver_1a8c73736b49`, duplicated by
  `solver_e4b4c0604a5d`) captures at `15.686007T`, has distance integral
  `1.916135L`, final distance `0.743392L`, and uses 226 window shifts. Its
  posterior command is at the acceleration ceiling for `22.34%` of samples,
  posterior excursion reaches `34.17 deg`, and peak body-frame lateral force
  and yaw moment are `0.03250` and `0.02036` in the logged normalizations.
- The informative contrast is the prefilled
  `solver_502dfb1f0223`. It restores target-opposing posterior-wave authority
  when demodulated yaw becomes target-aiding. The two wake views stay visibly
  coherent, but every `8/6/4/2/1.25L` milestone is delayed, capture moves to
  `15.708008T`, distance integral rises to `1.918172L`, shifts rise to 231,
  mean posterior demand rises from `25.199` to `25.251 rad/T^2`, and posterior
  acceleration-limit residence rises to `22.51%`. This is a closed-loop route
  regression, not a propulsion or stability failure.
- The other sampled response handoff (`solver_a3ebfdcbb7c5`) is also worse at
  `15.713508T` and `1.917987L`, while increasing posterior limit residence to
  `23.42%`. Together with the inherited negative lesson, this argues against
  another yaw-threshold handoff or a scalar increase in wave authority.

## Policy hypothesis

Use the duplicated best translational-response controller as the baseline.
Preserve its anterior oscillator, base posterior traveling wave, target-directed
mean curvature, response corrections, approach law, force gate, and all
actuator projections. Add one reflection-equivariant half-cycle allocator only
to the already bounded low-speed posterior-wave increment: when steering demand
is appreciable, infer the target-opposing beat lobe from the posterior wave and
the signed steering command, and smoothly withhold supplemental boost on that
lobe. The base wave is never removed, zero steering leaves the boost unchanged,
and the allocator never exceeds the evaluated boosted endpoint. This tests a
new controller mechanism rather than a gain-only edit.

Expected result: retain the two-view coherent wake and capture while avoiding
the sampled cost of strengthening target-opposing posterior motion, improving
one or more route milestones or distance integral and not increasing posterior
limit residence. Reject the transfer if it delays milestones/capture, worsens
the distance integral or crossing, disrupts wake coherence, or merely changes
effort without trajectory benefit.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning and biological mean-curvature-plus-tail-beat control
source_mechanism: observed-phase half-cycle amplitude asymmetry around an intact traveling wave
transferable_invariant: allocate only bounded supplemental rhythmic authority by beat side and signed turn demand while preserving the propulsive carrier
nontransferable_details: published gains, duty ratios, oscillator frequencies, species-specific kinematics, exact vortex phase, and task-specific routes
policy_translation: use normalized two-joint state feedback to attenuate only the low-speed supplemental posterior-wave increment on the target-opposing lobe; leave the base wave and established body-frame navigation unchanged
falsification: reject if capture, route milestones, distance integral, wake coherence, limiting, or the force/moment envelope regress relative to the duplicated translational-response sample
