# Step 37 multi-wake target-policy diagnosis and hypothesis

## Evidence read before editing

- All four sampled solver episodes satisfy the frozen contract: direct-uniform
  initialization in still water with `U_infinity=(0,0,0)`, no cylinders or
  prewarm, finite moving-window transport, and capture termination. Three are
  executable-equivalent common-envelope redistribution policies and capture at
  `18.7165--18.8815T`, with score-defined mean distance
  `2.08855--2.09266L`. The distinct clean-envelope ablation captures at
  `18.6010T` and `2.09042L`.
- The assigned parent's newly evaluated clean-envelope policy is byte-identical
  to that sampled capture but misses: it reaches `1.16972L` at `19.1620T`,
  continues turning downward to heading `1.2640 rad`, and exits left at
  `33.0825T` and `10.05586L`. Another inherited byte-identical clean execution
  captures at `19.0795T` and `2.10426L`. Clean separation therefore no longer
  has a no-known-miss robustness advantage; redistribution and clean-envelope
  carriers both have mixed inherited semantics even though the current sampled
  batch favors redistribution three captures to one.
- I inspected the combined two-view sheet for the best-integral sampled
  redistribution capture and the assigned-parent clean failure from release to
  termination. Both begin in quiescent fluid and form an energetic alternating
  top-down street with compact bilateral/caudal oblique Lambda2 structures.
  The successful path bends through the target and retains those structures at
  first crossing. The failure also remains self-propelled and wake-coherent,
  but after the target circle appears broadside its path bends downward and
  away; there is no visible collision, advection, wake collapse, or numerical
  instability to explain the miss.
- Metrics corroborate that semantic distinction. The three current
  redistribution captures contact the anterior/posterior acceleration limit
  on `60.85--61.00%`/`72.97--73.27%` of rows and the rate limit on
  `11.01--11.20%`/`14.88--15.07%`, with peak planar force/moment
  `0.03065--0.03171`/`0.01600--0.01632`. The clean failure has comparable
  `64.46%`/`70.41%` acceleration contact and `0.03067`/`0.01590` peak load;
  its lower rate contact is not relief because capture is lost. Thus coherent
  wakes and ordinary loads do not resolve the controller's structural
  independent clipping, which repeatedly projects each joint separately and
  changes their raw acceleration ratio.
- Inherited negative evidence closes pointwise rate barriers, velocity or flow
  route residuals, posterior phase voting, posterior-only gait allocation,
  phase-conditioned target filtering, terminal compounds, and stacked
  recovery/arbitration. The inherited guidance leaves a coupled demand
  allocator open only as a separate bounded ablation that preserves the
  target-signed curvature and interjoint carrier.

## Structured bookshelf transfer

bookshelf_consulted: true
source_domain: Lighthill/Taylor traveling-wave propulsion and coupled-oscillator robotic-fish control
source_mechanism: preserve a directed posterior-lagged traveling bend and coordinated low-dimensional rhythmic command under an actuator bound
transferable_invariant: when bounded actuation is unavoidable, preserve the instantaneous two-joint command direction so anterior steering and posterior lag remain coordinated instead of clipping each component independently
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, full-body waveforms, exact vortex phases, world coordinates, task-specific routes, and source actuator models
policy_translation: retain the target-signed half-cycle redistribution carrier unchanged, but radially scale the raw two-joint acceleration vector into the existing normalized infinity-norm envelope whenever either component exceeds the policy-owned limit
falsification: reject if capture or either coherent wake row is lost, the downward near-miss/left-exit topology recurs, mean distance leaves the sampled redistribution `2.08855--2.09266L` band without compensating load or limit relief, or rate contact and planar loads materially worsen

## Exactly one candidate hypothesis

The current policy independently clamps `raw_a1` and `raw_a2`. Because one or
both components exceed the envelope on most rows, that projection repeatedly
changes the acceleration ratio that defines the anterior/posterior traveling
bend. The candidate makes one architectural change: compute a common scale
from the larger raw magnitude and multiply both raw accelerations by it. This
is the radial projection of the raw command into the same
`1800 deg/T^2` infinity-norm envelope, so the public action remains bounded
while its two-joint direction is preserved.

Expected result: retain the redistribution carrier's capture-class route and
both coherent wake views while reducing unequal clipping distortion and
therefore rate contact or load demand. This is a coupled demand-allocation
ablation, not scalar gain tuning. It changes no steering, propulsion, response,
or envelope parameter; adds no clock, velocity/flow residual, terminal or
recovery branch, world coordinate, mutable state, or memorized route. Formal
CFD occurs only after handoff, so no result is claimed for this unevaluated
candidate.
