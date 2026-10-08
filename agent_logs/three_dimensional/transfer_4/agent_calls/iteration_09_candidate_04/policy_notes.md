# Complementary route-to-course capture candidate

## Visual and quantitative diagnosis before the policy edit

- All four sampled rollouts use direct uniform still water with
  `U_infinity=(0,0,0)`, no prewarm snapshot, and no cylinders; all terminate
  by capture. I inspected both rows of the combined sheets for the strongest
  sampled policy and the informative terminal-load-relief regression. The
  top-down rows show self-propulsion from rest and a coherent alternating wake
  along the same nearly straight target-directed topology. The oblique
  Lambda2 rows retain compact three-dimensional posterior structures through
  approach, with no passive advection, wake collapse, collision, or
  out-of-plane instability. The scalar differences therefore reflect route
  and capture geometry, not the existence or loss of propulsion.
- The posterior-priority baseline captures at `17.8585T`, with score
  `-0.09355786`, mean score-distance `1.980025L`, observed distance integral
  `1.367044L`, center path `12.8148L`, and maximum head cross-track `0.5347L`.
  Its fast approach is tangential: mean course alignment inside `2.1L` is
  `0.8703`, falling to `0.3742` at capture while yaw rate is
  `-3.0781 rad/T`.
- Two terminal-only interventions do not survive as score improvements.
  Adding normalized target-to-course correction captures `0.0055T` earlier,
  shortens center path by `0.0054L`, and raises near/final course alignment to
  `0.8737/0.3848`, but worsens mean score-distance to `1.980854L` and score to
  `-0.09460147`. Tail-load-conditioned posterior relief similarly improves
  near/final alignment to `0.8769/0.3941` and lowers near yaw RMS from `2.1104`
  to `2.0746 rad/T`, but worsens mean score-distance to `1.981849L` and score
  to `-0.09585435`. Neither changes the visible wake topology. These results
  reject terminal correction or posterior attenuation as stand-alone reasons
  to disturb the sampled baseline.
- The co-windowed line-of-sight residual is the only positive sampled addition
  to the posterior-priority drive. It lowers mean score-distance to
  `1.973290L`, observed distance integral to `1.359145L`, and improves score to
  `-0.08710319` while retaining capture at `17.8750T` and the coherent wake.
  Its tradeoff is a slightly longer `12.9663L` center path, `0.5454L` maximum
  cross-track, higher near speed (`0.8973U`), and more tangential approach:
  mean/final course alignment are only `0.8137/0.1134`. Because that route
  residual already releases between `2.1L` and `1.0L`, the remaining defect is
  a near-course handoff rather than missing far-route authority.

## One policy hypothesis

Start from the strongest sampled posterior-priority plus line-of-sight policy.
Preserve its anterior phase-plane envelope, posterior lag and emphasis,
cadence, odd target-to-curvature map, half-cycle steering, and
reversal-preserving rate governor. Add one complementary handoff in guidance:
as the co-windowed line-of-sight route residual releases, continuously blend
in a bounded correction from the signed angle between measured body-frame
velocity and the body-frame target vector. Suppress it at low speed and while
the far-route residual is active. This uses normalized target-relative state,
not time, coordinates, target identity, or a memorized route, and it does not
withdraw carrier energy.

Expected evidence is preservation of the line-of-sight candidate's early
distance-integral gain and two-view wake, with better mean/final course
alignment and no material increase in path, arrival, yaw, force/moment, or
joint-limit residence. Falsify the handoff if it loses capture, erases the
`1.973290L` mean-distance advantage, increases path/cross-track or load scale,
causes switching or oversteer, or fails to improve tangential terminal
alignment. The new CFD result is not available in this worker and is not
claimed here.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish direction tracking and terminal capture control
source_mechanism: separate persistent route correction from a continuous near-target course-angle hold while preserving the rhythmic propulsive carrier
transferable_invariant: use one target-relative feedback layer for accumulated route drift and hand off continuously to measured yaw/slip correction near capture without coasting or weakening the traveling bend
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, exact vortex phases, target coordinates, and task-specific routes
policy_translation: retain the sampled co-windowed body-frame line-of-sight residual outside approach, then use its complementary release gate and measured target-to-velocity cross angle to blend in a bounded odd two-joint steering correction at finite speed
falsification: reject if capture, early distance integral, path, loads, reflection symmetry, or top-down and oblique wake coherence worsen materially, or if near/final course alignment does not improve
