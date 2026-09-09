# Candidate diagnosis and policy hypothesis

## Evidence read before editing

- All four sampled episodes report direct uniform initialization in still water,
  `U_infinity=(0,0,0)`, no cylinders, finite moving-window shifts, and stable
  dynamics. Motion is self-propelled rather than environmental advection.
- The combined sheets show organized alternating top-down vorticity and
  three-dimensional caudal Lambda2 structures. The early-exit response-release
  controller forms a wake but leaves high after only a `7.53L` closest approach;
  the aligned prefill retains a coherent wake and passes above the target at
  `2.58L` before exiting left. This makes route authority, not wake onset, the
  useful control distinction.
- The inherited distance/closing allocation is a real improvement rather than
  a score-only change: `solver_8cbc18979df7` reduces closest approach to
  `1.73L`, extends the episode from `29.47T` to `52.48T`, reduces mean absolute
  joint command from about `23.98` to `14.15 rad/T^2`, and reduces command
  residence above 90% of the soft bound from `53.3%` to `21.9%` relative to
  the aligned prefill. Its top-down route makes a broad arc after the miss,
  while the oblique row shows the strong wake fading during the approach bend.
- The best trajectory isolates the remaining defect. From `18T` to `22T`,
  distance falls from `3.15L` to `1.80L` while the full target angle grows from
  about `-1.18` to `-1.81 rad`. At the `1.73L` closest point the target is
  already astern (`target_body_L[1] > 0`), speed is still about `0.76U`, but
  commands are only about `(0.09, 0.53) rad/T^2` and both joints have settled
  near a static bend. The target stays astern through the broad return arc;
  the ordinary angle clamp aliases this state with a merely lateral target.

## One-candidate hypothesis

Preserve the best rollout's joint-state traveling-wave carrier,
distance/closing drive relief, aligned approach bend, soft command bounds, and
full signed body-frame target angle. Add one continuous re-acquisition
mechanism: the positive longitudinal fraction
`target_body_L[1] / distance_L` raises an aligned anterior/posterior mean bend
only while the target is astern. The existing measured turn-rate brake releases
the request as yaw response develops, and the redirect vanishes continuously
when the target returns to the forward half-plane. This distinguishes an
overshoot from the large lateral-ahead error that the clipped target angle
cannot distinguish, without a clock, route, or world-frame coordinate.

Expected signature: match the evidenced approach allocation until the target
crosses astern near the first pass, then tighten the broad lower return arc and
either capture on re-approach or produce a materially smaller second minimum
before any domain exit. Falsify if the first approach worsens materially, the
same broad arc/left exit persists, joint/command limits rise sharply, or the
coherent far-field wake is disrupted.

bookshelf_consulted: true
source_domain: biological C-start redirect and robotic-fish closed-loop direction tracking
source_mechanism: observation-gated strong curvature for a large directional error, released into ordinary propulsion as measured response restores forward target geometry
transferable_invariant: use normalized body-frame fore/aft target sense and measured yaw response to engage and continuously release a bounded redirect after an overshoot
nontransferable_details: published gains, species-specific C-start shapes, dimensional cadence, full-body kinematics, exact vortex phase, and task-specific routes
policy_translation: preserve the sampled distance/closing approach allocator; add aligned two-joint mean curvature proportional only to the normalized positive longitudinal target component, with the existing turn-rate brake and target-forward crossing providing continuous release
falsification: reject if target-astern curvature does not tighten the return arc or improve re-approach, or if it degrades the first approach, propulsion, wake coherence, or actuator-limit residence
