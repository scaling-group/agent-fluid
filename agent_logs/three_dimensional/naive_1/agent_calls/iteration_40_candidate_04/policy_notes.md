# Multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before editing

- All four sampled episodes satisfy the frozen experiment contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite moving-window transport, and capture
  termination. The two executable-identical common-envelope redistribution
  samples are the strongest current pair: they capture at
  `18.8265--18.8815T`, score `-0.20106` to `-0.20041`, and have score-defined mean
  distances `2.08855--2.08896L`. The clean geometry-envelope ablation captures
  at `18.6010T` and `2.09042L`. The prefilled rearward multiplier captures at
  `18.9640T` and `2.09072L`, but the assigned guidance's reconstruction shows
  that its target stays forward, so the branch is not exercised and the result
  establishes non-interference rather than recovery.
- I inspected both rows of the combined keyframe sheets for the best
  redistribution sample and the clean-envelope sample from direct release to
  first crossing. Both begin without a wake, translate by self-propulsion in
  quiescent water, grow a coherent alternating target-bending top-down street,
  and retain compact bilateral/caudal Lambda2 structures through capture.
  Neither sheet shows collision, wake collapse, domain exit, or instability,
  and their visual similarity does not justify ranking the narrow score spread
  as a new physical mechanism.
- Trajectory diagnostics agree with the images. Across the four current
  captures, anterior/posterior acceleration contact is
  `60.85--61.17%`/`72.95--73.27%`, rate contact is
  `10.88--11.07%`/`14.73--14.96%`, peak planar force is
  `0.03066--0.03259`, and peak yaw moment is `0.01603--0.01656`. The
  redistribution pair has the best mean-distance band but is not actuator
  relief, and the inactive rearward branch improves neither route nor loads.
- The inherited optimizer logs supply the required failure contrast. Three
  policies with the same target-progress response-release semantics differ
  only in comments and parameter/local names: two capture at `18.6835T` and
  `18.7220T`, with mean distances `2.09750L` and `2.09370L`, while the third
  misses at `1.44371L` and exits left at `30.9375T` with final distance
  `8.98965L`. I inspected both rows of a capture and that failure. The failure
  remains self-propelled with an energetic alternating street and compact
  caudal 3D structures through approach; after bypassing the target, the
  top-down wake stretches into long paired bands and the compact oblique
  structures thin before exit. Its finite diagnostics, continued translation,
  and lower late rate contact identify route divergence, not initial
  propulsion collapse or numerical instability. Its peak planar force/moment
  (`0.03507`/`0.01792`) also exceed the current sampled capture bands.
- Therefore replacing yaw-sign response with signed bearing-window progress is
  capture-compatible but not semantically robust and is not a performance
  improvement over the current redistribution samples. The assigned guidance
  already rejects further response, terminal, distance, recovery, and
  allocation compounds around this carrier. The defensible candidate is the
  simpler evidence-backed redistribution controller: remove the prefilled
  inactive rearward multiplier and preserve the executable policy represented
  by both strongest current samples. This is an evidence-selected rollback,
  not a scalar gain change or a claim that prior rare misses are solved.

## Structured bookshelf transfer

bookshelf_consulted: true
source_domain: biological burst redirect and closed-loop robotic-fish direction tracking
source_mechanism: preserve a rhythmic traveling-bend carrier while sensed route response qualifies release from target-signed redirect curvature
transferable_invariant: body rotation and target-relative route improvement are distinct observations, so steering release must be judged against actual route evidence
nontransferable_details: published gains, dimensional cadence, duty ratios, species-specific C-start kinematics, exact vortex phases, world coordinates, and task-specific routes
policy_translation: the target-progress replacement was considered but not adopted because three semantically equivalent completed rollouts include a coherent-wake left exit; retain normalized body-lateral mean curvature, displacement-only half-cycle redistribution, posterior lag, non-inverting yaw-response release, and final acceleration projection, and remove only the unexercised rearward branch
falsification: reject this selection if it loses capture or either coherent wake row, leaves the established `2.08855--2.08896L` route band across independent runs, or raises actuator/load contact; revisit target-progress release only if independent multimodal repeats eliminate its miss topology and beat this route/load band rather than merely adding another capture

## Exactly one candidate hypothesis

The candidate tests whether selecting the simplest replicated carrier is more
reliable than retaining an unexercised recovery branch or repeating a failed
response-observation substitution. Target geometry continues to own turn sign;
one-sided correcting-yaw release cannot invert the request; observed anterior
displacement redistributes both steering and common amplitude relief between
beat halves; and the posterior lag preserves the traveling bend. The candidate
changes no propulsion or steering scalar from the strongest current pair.

Only the inactive `rearward_route_boost` path is removed from the prefill. No
target-progress, velocity, flow, force, moment, terminal, allocator, or recovery
compound is added. The policy uses no explicit time, step, world coordinate,
mutable state, or memorized phase. Formal CFD runs only after handoff, so this
worker claims only the completed prior evidence above, not an unevaluated
outcome for the new candidate.
