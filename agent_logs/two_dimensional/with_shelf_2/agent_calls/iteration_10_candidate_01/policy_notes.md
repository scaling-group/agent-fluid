# Wake-policy candidate notes

## Evidence read before editing

- The shared prewarm sheet shows the held fish above and downstream of four
  staggered cylinders after their interacting vortex streets have developed.
  This is the common initial condition, not candidate-specific evidence.
- All four sampled released-episode sheets terminate at `target_reached`; no
  sampled failure keyframe is available. The strongest finite example is
  `solver_2156a215b931` and the weakest sampled success is
  `solver_a864f827be48`, which is also the prefilled policy. Their six-frame
  sheets show the same useful topology: a visible zero-centered traveling wake,
  self-propelled upstream/downward motion from the upper-right release, and a
  broad correction into the merged cylinder wakes before capture. The parent
  has a visibly larger late lateral excursion, while the course-consistency
  example retains a compact target approach. The sheets do not resolve
  beat-scale causality, so this diagnosis is cross-checked only at episode
  scale.
- The prefilled progress-deficit envelope reached at `46.31`, with `1.7357L` mean
  distance, score `0.145334`, command-energy mean `1027.9`, and force/moment RMS
  `393/3878`. Body-speed-normalized positive closure reached at `45.48`, with
  `1.7244L`, score `0.156386`, `1034.1`, and `405/4029`. Adding bounded course
  consistency reached at `45.61`, with the best sampled `1.7222L` mean distance
  and `0.158830` score, `1028.6` command-energy mean, and `453/4406` force/moment
  RMS. All retain target success and nearly the same diagonal trajectory.
- The inherited propulsive-priority allocator is the informative failure
  boundary, but has no sampled keyframe here: it passed below capture and
  collided at `58.93` after a `1.872L` closest approach with `537/4995` loads.
  I use that inherited result only to reject broad propulsion reallocation, not
  to claim visual details that are unavailable.

## Policy hypothesis

Replace the prefilled policy's stall-rewarded posterior envelope with the sampled
body-speed-normalized positive-closure residual, then apply the already sampled
course-consistency multiplier only to that small residual. The sign of
`bearing * bearing_window_rate` distinguishes decreasing from increasing
absolute body-frame bearing without memorizing a route. The proven oscillator,
posterior lag, heading-response steering, yaw-load steering gate, and smooth
acceleration limit remain unchanged. This is a mechanism change from rewarding
stalls to rewarding observed closure that is also course-consistent, not a
scalar gain sweep.

The expected result is preservation of target capture and the productive
traveling-wake topology, with mean distance and score improved relative to the
prefilled policy. It is not expected to beat the normalized-closure variant's
arrival time, and the sampled load increase prevents stronger modulation.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG and residual CPG path-following control
source_mechanism: sensor feedback modulates a low-dimensional propulsive rhythm or residual instead of replacing it with raw high-frequency actuation
transferable_invariant: preserve the established traveling wave and condition only a small posterior residual on normalized positive closure and decreasing absolute body-frame bearing
nontransferable_details: published gains, oscillator parameters, species-specific envelopes, task routes, and exact vortex phases
policy_translation: normalize positive windowed closing speed by observed body speed, infer course convergence from bearing times bearing-window rate, and bound their product before it scales only the progress-earned posterior residual under the existing yaw-gated two-joint controller
falsification: reject the transfer if capture or upstream diagonal topology is lost, mean distance does not improve over the prefilled progress-deficit policy, or the already higher force/moment and saturation burden grows without a compensating trajectory benefit
