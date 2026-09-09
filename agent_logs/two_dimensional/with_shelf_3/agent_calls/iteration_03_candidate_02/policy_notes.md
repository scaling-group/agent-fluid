# Multi-Wake Target-Policy Candidate Notes

## Evidence read before the policy edit

- The assigned parent guidance preserves the naive oscillator's traveling-bend
  scaffold and records the original missing capability: the target-blind seed
  moved its head only `-3.545L` upstream while falling `-13.300L`, came no
  closer than `8.615L`, and left the lower domain after `50.127` release-time
  units. Its propulsion was useful, but it lacked target-direction regulation.
- The current shared prewarm sheet shows the held fish above and downstream of
  the fully developed, interacting four-cylinder wakes. It is the common
  initial condition, not candidate-specific evidence.
- All four current sampled solvers have the same executable parameter tuple and
  equations despite comment-only file differences. Their released keyframe
  sheets are byte-identical: the fish turns toward the target, maintains a
  visible posterior-lagged body wave, crosses the wake field on a compact
  diagonal trajectory, and enters the `0.75L` target circle. Each reaches at
  `39.7374` release-time units with `1.9338L` mean distance and `0.93985`
  progress. This is useful deterministic repeatability evidence, but it is one
  controller result rather than four independent parameter tests.
- Inherited logs supply the informative allocation contrast. The full
  `10 deg` anterior center plus `5 deg` posterior share in
  `solver_ad1db499142c` loses the propulsive traverse: its sheet ends outside
  the useful wake corridor after moving `(+2.195,-1.302)L`, with a downstream
  domain exit at `18.683` and negative progress. A less anterior-heavy
  `8/5.2 deg` allocation reaches in `42.856`, while the current total-budget
  `5.4/6.6 deg` allocation reaches in `39.737`. These are not a controlled
  monotonic sweep, but together they bound the supported structure to a roughly
  balanced split with modest posterior emphasis.
- The successful controller reaches the measured joint velocity and
  acceleration envelopes and records RMS relative crossflow `0.2268`, lateral
  force `53.74`, and moment `761.95`. Only maxima and aggregate loads are
  available; the keyframes show no repeated targetward yaw reversals. Therefore
  the evidence does not identify a signed wake-disturbance residual or justify
  weakening the propulsive rhythm merely to reduce envelope contact.

## Bookshelf consultation

bookshelf_consulted: true
source_domain: fish-swimming, robotic-fish turning, and wake-interaction mechanisms were reviewed; no source primitive is adopted for this edit
source_mechanism: none; the rollout does not show thrust collapse during the successful turn, repeated wake-driven yaw reversal, or a failed terminal approach requiring a new shelf mechanism
transferable_invariant: preserve a directional posterior-lagged traveling wave and do not confuse alternating wake motion with persistent target error
nontransferable_details: published gains, gait envelopes, exact vortex phases, species kinematics, and task-specific routes
policy_translation: keep the demonstrated bearing-to-total-curvature architecture and all gait parameters; make one small evidence-led redistribution of the owned curvature budget rather than using the shelf to justify gain tuning
falsification: reject the redistribution if it loses capture, slows arrival or worsens mean distance materially, collapses the visible traveling wave, or increases angle saturation and force/moment loads beyond the demonstrated successful envelope

## Candidate hypothesis

Keep the validated `12 deg` total curvature request, bearing saturation,
state-feedback oscillator, and velocity-derived posterior lag exactly as in the
repeated successful controller. Change only the owned anterior share from
`0.45` to `0.40`, so the saturated centers become `4.8/7.2 deg` rather than
`5.4/6.6 deg`. This is one bounded allocation test motivated by the successful
posterior-weighted split and the anterior-heavy failure, not a claim that the
sparse comparison proves monotonic benefit.

The next CFD rollout should retain the early targetward turn and diagonal wake
crossing while testing whether slightly more posterior steering authority
reduces the distance integral or arrival time without losing capture. Because
formal evaluation happens after this worker exits, no improvement is claimed
here. Later workers should compare termination, release time, mean distance,
trajectory topology, joint-limit residence, effort, and lateral force/moment;
the current `39.7374` capture is the falsification baseline.
