# Response handoff on translationally persistent moment rejection

## Evidence diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen Phase 2 contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite dynamics, and capture. There is no failed
  termination in this allocation, so the duplicated weaker capture and the
  inherited logged regressions are the informative negative controls.
- I inspected all three unique combined sheets from release through capture.
  Their top-down rows show the release transient growing into a coherent
  alternating caudal wake behind a smooth target-directed arc. With zero
  background flow and about `11.6L` of center translation, this is
  self-propulsion rather than advection. Their oblique body/Lambda2 rows retain
  compact alternating three-dimensional structures without wake collapse,
  collision, domain exit, or out-of-plane instability. The visible topology
  is nearly unchanged, so trajectory and response metrics—not vortex
  prominence—separate the policies.
- The assigned-parent translational terminal damper and the moment-only policy
  have distinct source hashes but identical traces and sheets: capture at
  `15.735508T`, final/minimum distance `0.744372L`, distance integral
  `1.919818L`, `231` shifts, and score `-0.037222`. This repeats the inherited
  negative boundary that another terminal line-of-sight decomposition is not
  useful trajectory diversity.
- Translational-response persistence inside the existing `2 deg`
  moment-correction envelope is the sampled winner. It advances the
  `8/6/4/2/1.25L` milestones by `0.0110/0.0385/0.0440/0.0330/0.0440T` and
  capture by `0.0495T`, lowers the distance integral to `1.916135L`, moves the
  crossing inward to `0.743392L`, reduces posterior acceleration-limit
  residence from `23.59%` to `22.34%`, and scores `-0.033442`. The coherent
  two-view wake remains intact. Peak lateral force falls from `0.03380` to
  `0.03250`, although peak yaw moment rises from `0.01920` to `0.02036`; the
  change is a better route response, not generic load relief.
- A sibling that hands moment curvature to carrier-demodulated aiding yaw at
  the existing yaw-residual scale independently improves the same baseline:
  capture at `15.713508T`, distance integral `1.917987L`, final distance
  `0.743858L`, and score `-0.035331`. Its `6/4/2/1.25L` milestones advance by
  `0.0220/0.0330/0.0165/0.0220T`. However, the inherited broader handoff using
  the separate `0.05` response scale lost the entire moment-route gain and
  regressed to `15.768509T`, `1.924377L`, `0.746139L`, and `-0.042067`.
  Response handoff is therefore a mechanism with a sharp normalization
  boundary, not evidence for free scalar tuning.

## Bookshelf transfer

```text
bookshelf_consulted: true
source_domain: biological burst redirect and sensor-modulated robotic-fish CPG direction control
source_mechanism: preserve rhythmic propulsion while bounded anticipatory steering persists until measured target-relative response appears
transferable_invariant: retain the traveling-bend carrier and target-directed base turn, sustain one bounded correction while translation still opposes the requested redirect, and release only that supplemental correction when carrier-demodulated yaw becomes target-aiding
nontransferable_details: published gains, dimensional yaw and moment scales, species-specific burst kinematics, exact tail or vortex phase, clock-defined maneuver stages, source wake geometry, world coordinates, and task-specific routes
policy_translation: start from the sampled translational-persistence policy, retain its normalized body-frame target-slip union inside the existing moment-curvature ceiling, and attenuate only that supplemental posterior mean curvature with the sampled carrier-demodulated aiding-yaw gate; leave the anterior carrier, posterior wave, base redirect, propulsion allocator, and terminal law unchanged
falsification: reject if the translation-persistence milestone gain is erased, capture or distance integral regresses, the coherent two-view wake or force/moment envelope degrades, posterior limiting grows without route benefit, or the handoff changes no feasible posterior action
```

## One candidate hypothesis

Produce exactly one candidate by adopting the sampled-best translational-
response persistence policy and adding the independently positive realized-yaw
handoff to its shared moment/translation correction. The anticipatory branch
still opens only for a reliable target-directed redirect and remains capped by
the same `2 deg` posterior mean-curvature envelope; translational and moment
signals continue to form a smooth union rather than stacked bends. Once
carrier-demodulated yaw becomes target-aiding, only this supplemental branch
releases continuously. Loss of that measured response restores it without
time, memory, route coordinates, or a new gain.

The exact existing `yaw_residual_scale` supplies the normalization because the
sampled sibling at that semantic scale improved the common baseline, whereas
the inherited alternate-scale handoff regressed. This is a small combination
of two response roles, not scalar-only tuning. The falsifiable expectation is
to preserve the best policy's coherent wake and early route gain while
reducing redundant supplemental curvature after realized yaw response,
advancing a later milestone or improving the distance integral. Formal CFD is
post-exit evidence, so no outcome for this candidate is claimed here.

## Non-CFD verification after the edit

- Candidate SHA-256 is
  `13d14dfaf8cb354d8dfc978039e708e682f69054a3f353480f7f4b25c3e54c2e`.
  Static schema validation finds exactly 57 fields returned by
  `target_policy_params()` and the same 57 direct `params.FIELD` references,
  with no missing or unused field. The added translation-response scale is
  owned by the returned parameter object.
- The prescribed lightweight Julia contract returns two finite bounded
  accelerations. A deterministic 2,916-state paired sweep across target
  distance, body-frame translation, joint phase, force, moment, and yaw
  response changes feasible action from the sampled-best policy on 711 states,
  with maximum action difference `1.38042 rad/T^2`. Every action remains within
  the declared acceleration envelope and the maximum lateral-reflection error
  is exactly zero. This establishes non-clamp-equivalent support without
  predicting closed-loop CFD behavior.
- The guidance-materiality and solver editable-boundary checks pass. Only the
  candidate policy changed under `solver/`; no sibling candidate or formal CFD
  rollout was created.
- The configured check-runner was invoked after the files were complete, but
  its pinned `gpt-5.4-mini` model is unsupported for this account, matching the
  inherited infrastructure limitation. Its three prescribed checks were run
  separately on the final files: guidance materiality, the lightweight Julia
  contract, and the solver editable-boundary check all pass.
