# Candidate diagnosis and policy hypothesis

## Evidence read before editing

- The assigned parent is the LOS-lead, half-cycle course-redirect controller.
  All four sampled L64 evaluations are valid direct-uniform still-water runs
  (`U_infinity=(0,0,0)`, no prewarm) and terminate in capture. The parent has
  the best sampled result: score `-0.215976`, capture at `19.706T`, and mean
  distance `2.10594L`. The other captures span `20.036--20.207T` and mean
  distance `2.11794--2.12138L`.
- The combined sheets for the best parent rollout and the lowest-scoring
  sampled rollout were inspected from release through capture. Both top-down
  rows show self-propelled motion with a coherent alternating wake, productive
  lateral oscillation, a nearly straight far/middle-field trajectory, and a
  smooth terminal turn into the capture disk. Both oblique rows show compact
  shed Lambda2 structures that remain organized through the turn; neither
  sheet indicates advection, collision, boundary exit, or instability. There
  is no sampled failure in this batch, so the lowest-scoring capture is the
  most informative contrast.
- Trace/diagnostic cross-check: all runs are stable and capture at
  `0.7462--0.7480L`; peak normalized body-force components remain about
  `0.0133/0.0230` and peak normalized yaw moment about `0.0131`. The carrier
  nevertheless reaches the `260 deg/T` joint-rate limit and spends roughly
  `32--37%` of samples above `27.9 rad/T^2` on each smooth-limited command.
  Thus more far-field gain is not a supported next step.
- Two sampled policies are executable-equivalent LOS-lead controllers (only
  comments/formatting differ), yet their captures differ by `0.330T` and their
  scores by `0.0149`. The smaller single-run separations among the redirect
  variants are therefore not clean evidence for scalar tuning.
- The useful unresolved behavior is terminal allocation. By `16--18T`
  (`3.6--2.1L` in the best run), joint motion and action have almost collapsed
  while the fish coasts at roughly `0.75--0.78L/T`. The unconditional
  distance/closing relief damps the carrier even after the velocity course has
  become useful for interception.
- No inherited `logs/optimize/` artifact is present in this rendered workspace.
  The sampled optimizer guidance independently reports that the allocator plus
  course redirect established capture and that widening the redirect gate was
  not useful, reinforcing a mechanism change at the allocator rather than a
  wider gate or larger steering gain.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG modulation and terminal capture control
source_mechanism: continuously allocate rhythmic propulsion versus turning authority from observed direction-tracking demand
transferable_invariant: preserve the traveling-wave carrier on a stable collision course, but yield actuator headroom continuously when body-frame velocity-course mismatch says a redirect is still required
nontransferable_details: published CPG gains, clock phase, robot geometry, species kinematics, exact vortex phases, dimensional speeds, and task-specific routes
policy_translation: retain the parent oscillator, fore/aft-aware target map, LOS lead, and half-cycle steering; multiply near-target drive relief by a bounded floor-plus-course-demand gate derived from the existing normalized body-frame course signal
falsification: reject if capture is lost or slower beyond replay spread, the same early coasting remains, terminal path curvature grows, wake coherence degrades, or joint-rate/high-command residence and normalized force/moment loads rise materially

## Candidate hypothesis

Add one mechanism: course-demand-gated approach allocation. The existing
redirect signal supplies a bounded, state-derived steering-demand magnitude.
Distance and positive closing speed still define when approach allocation is
available, but only a conservative floor of relief remains on an aligned
collision course; relief increases continuously to the parent value as course
mismatch grows. This should restart/preserve posterior traveling-wave motion
after redirect demand falls, reduce the `3.6--0.75L` coast, and cross the
capture radius earlier without increasing far-field saturation. The current
candidate cannot be claimed improved until its later CFD evaluation.
