# Phase 2 multi-wake policy diagnosis and hypothesis

## Evidence diagnosis before editing

- All four sampled episodes satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no cylinders or prewarm, finite moving-window
  transport, and capture termination. The executable-identical redistribution
  samples capture at `18.8265T` and `18.8815T` with score-defined mean distance
  `2.08855L` and `2.08896L`; the rearward-route composition captures at
  `18.9640T` and `2.09072L`, and the clean-envelope comparator captures at
  `18.6010T` and `2.09042L`. The latter two do not establish improvement:
  inherited reconstruction says the rearward branch was not exercised, while
  executable-equivalent clean and redistribution policies each have inherited
  near-miss/left-exit outcomes.
- I inspected both rows of the combined keyframe sheets for the best-score
  redistribution capture, the fastest clean capture, and the assigned prefill.
  From release to first crossing, each top-down row grows an alternating,
  target-bending vorticity street from quiescent water; each oblique row retains
  compact bilateral/caudal Lambda2 structures. With zero background velocity,
  translation is self-propelled. None shows collision, wake collapse, domain
  exit, or numerical instability. This sampled batch has no failure-class
  sheet, so the inherited completed miss is the semantic failure contrast.
- Sampled trajectory diagnostics support visual equivalence, not demand
  relief: anterior/posterior acceleration contact remains approximately
  `60.85--61.17%`/`72.95--73.27%`, rate contact
  `10.88--11.07%`/`14.73--14.96%`, and peak planar force/moment
  `0.03066--0.03259`/`0.01603--0.01656` across the four captures. Preserve the
  posterior-lagged traveling-bend carrier and independent final projection.
- The assigned parent's inherited allocator hypothesis proposed preserving the
  raw two-joint acceleration ratio with a common scale. Later inherited
  completed evidence falsifies it: the policy formed a weak, smeared early
  wake, reached only `11.5298L`, and exited left at `9.713T`; zero rate contact
  and lower loads came from loss of propulsion and steering, not useful relief.
- The remaining route evidence identifies a response-semantic fault. In an
  inherited clean-policy miss that passed below the target at `0.96285L` and
  exited left, nominally correcting yaw disagreed with improving signed target
  bearing on `1376/3033` correcting-yaw rows, versus only `8/1603` in a
  redistribution capture. The current gate can therefore release curvature
  when the body rotates correctly even though target-relative translation is
  worsening.

## Structured bookshelf transfer

bookshelf_consulted: true
source_domain: biological burst-redirect response release and closed-loop robotic-fish direction tracking
source_mechanism: retain a directed posterior-lagged traveling bend while releasing bounded target-signed curvature only after sensed route error responds
transferable_invariant: use normalized body-frame target-error progress rather than body rotation alone to decide when corrective curvature can be released
nontransferable_details: published gains, dimensional cadence, species-specific burst kinematics, robot duty ratios, full-body waveforms, exact vortex phases, world coordinates, and task-specific routes
policy_translation: preserve body-lateral route sign, displacement-only half-cycle steering, common-envelope redistribution, differential curvature shares, posterior lag, and independent final acceleration projection; replace yaw-rate response release with bounded body-frame bearing-window-progress release
falsification: reject if capture or either coherent wake row is lost, the inherited below-target near-miss/left-exit topology recurs, arrival or mean distance leaves established repeat spread without a semantic benefit, or actuator contact and planar loads materially worsen; one ordinary capture inside repeat spread establishes non-interference only

## Exactly one candidate hypothesis

Materialize one target-progress response-release controller on the assigned
redistribution carrier. The target's bounded body-lateral direction cosine
continues to own route sign; centered anterior displacement still allocates
steering and common amplitude relief by observed half-cycle. Replace only the
response observation: release the same bounded fraction when the existing
body-frame bearing window moves toward zero, rather than when body yaw has the
nominal sign. The one-sided gate can reduce but never reverse target-signed
curvature.

This is one observation-semantic controller mechanism, not scalar-only gain
tuning. It adds no explicit time, step, world coordinate, route, recovery
branch, terminal schedule, flow/force residual, shared actuator budget,
mutable state, or memorized phase. Formal CFD runs only after handoff, so no
outcome is claimed for this candidate.
