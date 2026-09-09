# Multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before editing

- All four sampled episodes satisfy the frozen contract: direct-uniform
  initialization in still water with `U_infinity=(0,0,0)`, no cylinders or
  prewarm, finite moving-window transport, and capture termination. The two
  executable-identical redistribution rollouts capture at
  `18.8265--18.8815T` with score-defined mean distance
  `2.08855--2.08896L`; the rearward-route composition captures at `18.9640T`
  and `2.09072L` without exercising its rearward branch; and the clean-envelope
  ablation captures at `18.6010T` and `2.09042L`. These differences remain
  inside established route repeatability rather than establishing a new
  semantic outcome.
- I inspected every sampled combined keyframe sheet from direct release to
  first crossing. The top-down rows grow coherent alternating streets along
  target-bending paths, and the oblique rows retain compact bilateral and
  caudal Lambda2 structures. With zero background flow, their translation is
  self-propelled rather than advected. No sampled sheet shows collision, wake
  collapse, domain exit, or numerical instability. The sampled batch has no
  failure-class sheet, so inherited near-miss/left-exit rollouts remain the
  failure contrast rather than relabelling a capture as a failure.
- Metrics corroborate the visual equivalence and expose the unresolved control
  cost. Across the sampled policies, anterior/posterior acceleration contact
  is `60.85--61.17%`/`72.95--73.27%`, joint-rate contact is
  `10.88--11.07%`/`14.73--14.96%`, peak planar force is
  `0.03066--0.03259`, and peak yaw moment is `0.01603--0.01656`.
  Independent final clipping therefore remains structural even when route and
  both wake views are successful; neither envelope choice nor the unexercised
  recovery branch is actuator relief.
- The assigned parent's target-relative response-release replacement has now
  been evaluated in the inherited logs. It preserves both coherent wake rows
  and captures at `18.7220T`, but mean distance `2.09370L`, acceleration
  contact `60.78%/73.21%`, rate contact `11.25%/14.86%`, peak planar force
  `0.03130`, and peak moment `0.01606` do not improve on the sampled
  redistribution carrier. Together with the inherited completed scores from
  steps 35--38, this closes another response-gate iteration: target-bearing
  progress is a useful failure discriminator, but gate replacement alone is
  not demand relief or an established route improvement.
- Inherited optimizer evidence already rejects pointwise joint-rate barriers,
  velocity phase prediction, posterior-state phase voting, posterior-specific
  gait allocation, target-axis observation filtering, terminal compounds, and
  stacked recovery. The remaining explicitly identified architecture question
  is whether independent acceleration projection itself damages the
  instantaneous two-joint traveling-bend allocation.

## Structured bookshelf transfer

bookshelf_consulted: true
source_domain: Taylor/Lighthill traveling-wave propulsion and coupled-oscillator robotic-fish control
source_mechanism: maintain a directed, posterior-lagged traveling bend as a coordinated low-dimensional actuation pattern
transferable_invariant: when a two-joint traveling-bend request exceeds a shared actuator envelope, preserve its instantaneous interjoint direction and lag relationship instead of clipping each component independently
nontransferable_details: published gains, dimensional cadence, species or robot kinematics, full-body envelopes, muscle models, exact vortex phases, world coordinates, and task-specific routes
policy_translation: retain the sampled target-signed redistribution carrier and replace only its two independent final acceleration clamps with one common infinity-norm radial projection of the raw two-joint request onto the same acceleration envelope
falsification: reject if capture or either coherent wake row is lost, the inherited downward near-miss/left-exit topology recurs, arrival or mean distance leaves established spread without compensating demand relief, or acceleration/rate contact and planar loads do not improve materially

## Exactly one candidate hypothesis

The candidate tests one controller mechanism: coupled acceleration allocation.
The current controller independently clips the anterior and posterior raw
requests, so saturation can change their instantaneous ratio and the
posterior-lagged traveling-bend direction. The replacement computes one
positive scale from the larger absolute raw request and applies it to both
joints. It is the identity inside the existing envelope; outside, it lands the
larger component exactly on the same limit while preserving both signs and the
raw interjoint ratio.

Everything upstream remains the prefilled redistribution carrier: normalized
body-lateral target sign, one-sided correcting-yaw release, differential mean
curvature, anterior-displacement half-cycle steering, phase-redistributed
common amplitude relief, and posterior lag. This is a bounded allocation
architecture test, not scalar-only gain tuning. It adds no response, recovery,
terminal, velocity/flow/force, explicit-time, step, world-coordinate, mutable-
state, or memorized-route channel. Formal CFD occurs only after handoff, so no
outcome is claimed for this unevaluated candidate.
