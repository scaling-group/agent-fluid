# Mean-curvature line-of-sight route residual

## Visual and quantitative diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen flow contract: direct uniform
  still water with `U_infinity=(0,0,0)`, no prewarm snapshot, no cylinders,
  finite dynamics, and capture termination. I inspected both the top-down
  mid-plane row and the oblique Lambda2 row for the sampled posterior-priority
  controller, the best-scoring line-of-sight combination, and the prefilled
  terminal load-relief controller. Each is visibly self-propelled and retains
  a coherent alternating, posteriorly lagged wake through capture; none shows
  passive advection, wake breakup, collision, or out-of-plane instability.
- The posterior-priority controller is the useful physical baseline. It
  captures at `17.8585T`, has mean score-distance `1.980025L`, center path
  `12.8148L`, maximum head cross-track `0.5347L`, RMS yaw rate
  `2.0285 rad/T`, and RMS planar force coefficient `0.01557`. Its top-down
  route is nearly direct and its oblique row retains compact three-dimensional
  posterior structures.
- Adding the co-windowed line-of-sight-rate residual gives the best sampled
  score, from `-0.09355786` to `-0.08710319`, and lowers mean score-distance to
  `1.973290L`. That benefit is not a general course improvement: arrival slips
  to `17.8750T`, center path grows to `12.9663L`, maximum cross-track grows to
  `0.5454L`, RMS yaw rises to `2.0577 rad/T`, and RMS planar force rises to
  `0.01578`. Inside `2.1L`, mean course alignment falls from `0.8703` to
  `0.8137` while mean speed rises from `0.8761U` to `0.8973U`. The combined
  sheet therefore supports a faster but more oblique closing trajectory, not
  a cleaner wake or straighter route.
- The two sampled terminal interventions do not repair that boundary. Relative
  to the posterior-priority baseline, terminal course stabilization scores
  `-0.09460147` and terminal posterior load relief scores `-0.09585435`; their
  trajectories are identical to the baseline outside `2.1L`. Their small
  near-target alignment gains (`0.8737` and `0.8769`) do not improve the
  distance integral, crossing, or semantic termination. This argues against
  another terminal gate or carrier attenuation.

## One policy hypothesis

Preserve the posterior-priority phase-plane oscillator, lagged whole posterior
wave target, cadence scheduling, direction-selective rate governor, and the
best-scoring co-windowed line-of-sight observer. Change one actuator
translation: keep ordinary target geometry and rate error on the existing
mean-curvature plus half-cycle steering path, but send the slow
line-of-sight-drift residual only to the bounded mean tail tangent. This keeps
the evidenced target-relative route signal while preventing it from
amplifying both joint accelerations on every inferred half-cycle.

Expected signature: retain capture, the approximately `17.9T` arrival scale,
the line-of-sight controller's lower distance integral, and the coherent
two-view posterior wake, while bringing center path, cross-track, yaw/force
RMS, and near-target course alignment back toward the posterior-priority
baseline. Falsify the translation if capture or distance integral worsens, the
route correction disappears, path/load statistics remain at the full-path
line-of-sight values, reflected target geometry does not reflect the response,
or the traveling wake becomes standing, disorganized, or weak.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction control and classical mean-curvature turning
source_mechanism: separate a slow route-dependent mean bend from gait-synchronous half-cycle asymmetry while preserving the propulsive oscillator
transferable_invariant: a persistent target-relative route correction can bias bounded mean curvature without injecting the same residual into rhythmic acceleration modulation
nontransferable_details: published CPG gains, dimensional cadence, species-specific joint envelopes, duty ratios, exact vortex phases, and task-specific routes
policy_translation: form the evidenced co-windowed body-frame line-of-sight rate, map it through a bounded odd residual outside the terminal corridor, add it only to the posterior mean-tangent request, and leave the base target loop on the existing two-joint half-cycle steering path
falsification: reject if capture, score-distance, arrival, directness, loads, reflection symmetry, actuator residence, or top-down and oblique traveling-wake coherence worsen relative to the sampled posterior-priority and full-path line-of-sight controllers
