# Multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before editing

- All four sampled episodes satisfy the frozen contract: direct-uniform
  initialization in still water with `U_infinity=(0,0,0)`, no cylinders or
  prewarm, finite moving-window transport, and capture termination. The two
  executable-identical common-envelope redistribution runs capture at
  `18.8265--18.8815T` with score-defined mean distance
  `2.08855--2.08896L`. The clean geometry-envelope ablation captures at
  `18.6010T` and `2.09042L`. The prefilled rearward multiplier captures at
  `18.9640T` and `2.09072L`, but inherited reconstruction shows its target
  remains forward, so that run establishes non-interference rather than
  exercised recovery.
- I inspected both rows of the combined keyframe sheets for the best-integral
  redistribution capture and the clean capture from direct release through
  first crossing. Both start without a wake, grow coherent alternating
  target-bending top-down streets, and retain compact bilateral and caudal
  Lambda2 structures in the oblique view. With zero background flow, their
  translation is self-propelled rather than advected. Neither sheet shows
  collision, wake collapse, domain exit, or numerical instability, and the
  visual similarity does not support ranking the small score spread.
- Trajectory and diagnostic evidence agrees with the visual comparison.
  Across the four samples, anterior/posterior acceleration contact is about
  `60.85--61.17%`/`72.95--73.27%`, rate contact is about
  `10.88--11.07%`/`14.73--14.96%`, peak planar force is
  `0.03066--0.03259`, and peak yaw moment is `0.01603--0.01656`. Neither
  redistribution nor the unexercised rearward branch is actuator relief.
- The sampled batch contains no failure-class keyframe sheet. The inherited
  lower-Elo evidence supplies the semantic contrast: an executable-equivalent
  clean carrier retains an energetic two-view wake, passes below the target at
  `0.96285L`, and exits left at `33.979T` and `10.44465L`. This is route loss,
  not failed propulsion. Its reconstructed seven-row observation window has
  correcting-sign yaw but non-improving target bearing on `1376/3033`
  yaw-correcting rows, including 315 rows inside `3L`, versus only `8/1603`
  such rows in the best redistribution capture. Body rotation alone is
  therefore not authoritative evidence that the route is correcting.
- Two inherited step-38 workers already proposed target-bearing-window
  response release and subsequently returned capture summaries at scores
  `-0.20612` and `-0.20751`, with final distances `0.74933L` and `0.74577L`.
  Those summaries establish capture compatibility but do not include sampled
  wake, route-integral, load, or saturation evidence and do not improve the
  current sampled score band of `-0.20041` to `-0.20288`. Repeating the
  mechanism here is an evidence-completion replication, not a claimed
  performance improvement. It is preferred over another recovery compound
  because the assigned-parent guidance identifies this observation replacement
  as the remaining falsifiable route-response test.

## Structured bookshelf transfer

bookshelf_consulted: true
source_domain: biological burst redirect and closed-loop robotic-fish direction tracking
source_mechanism: retain target-signed curvature during redirect and release it only after sensed route response appears while a coupled rhythmic carrier preserves propulsion
transferable_invariant: distinguish target-relative route improvement from body rotation when deciding whether to release steering authority
nontransferable_details: published gains, dimensional cadence, robot duty ratios, species-specific C-start kinematics, exact vortex phases, world coordinates, and task-specific routes
policy_translation: preserve normalized body-lateral route sign, non-inverting differential curvature, anterior-displacement half-cycle steering, common-envelope redistribution, posterior lag, and independent final acceleration projection; replace yaw-rate response in the release gate with bounded signed bearing-window response
falsification: reject if capture or either coherent wake row is lost, the below-target near-miss/left-exit topology recurs, sampled arrival or mean distance worsens outside established repeat spread without robustness evidence, or actuator contact or planar loads materially increase; another ordinary capture alone establishes replication, not improvement

## Exactly one candidate hypothesis

The candidate tests one state-feedback mechanism: target-relative response
release. The current gate treats body yaw opposite the route-request sign as a
successful correction, even when translation makes body-frame target bearing
worse. The candidate instead releases the same bounded fraction only while the
signed target bearing decreases over the episode-provided observation window.
Target geometry still owns route sign, and the release remains one-sided, so
the response signal can reduce but never invert curvature.

Everything else is the sampled common-envelope redistribution carrier. The
unexercised rearward multiplier is removed rather than compounded with the new
response observation. This candidate adds no velocity/flow/force residual,
terminal or recovery branch, explicit time, step, world coordinate, mutable
state, or memorized phase. Formal CFD runs only after handoff, so no new outcome
is claimed here.
