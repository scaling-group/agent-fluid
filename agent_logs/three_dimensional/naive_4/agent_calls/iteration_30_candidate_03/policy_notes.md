# Terminal translational-slip response candidate

## Evidence diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen experiment contract: direct
  uniform still-water initialization with `U_infinity=(0,0,0)`, no cylinders,
  no prewarm snapshot, finite dynamics, and capture. Three independent samples
  (`solver_07403e1ebc74`, `solver_160318a7df30`, and
  `solver_f1e40eeaa577`) are byte-identical copies of the assigned parent's
  forward-speed-gated posterior-emphasis policy. They also reproduce the same
  combined wake sheet and outcome bit-for-bit: `15.977511T`, 2,905 steps, 238
  window shifts, `0.744402707L` final/minimum distance,
  `1.928580797L` distance integral, and score `-0.045506315`. The remaining
  sample is the carrier-demodulated control at `16.054371T`, 2,919 steps, 239
  shifts, `0.745845616L`, `1.929839552L`, and `-0.046899933`.
- I inspected both rows of the combined sheets for a replicated strongest
  finite rollout and the informative weaker control from release through
  capture. The top-down rows show self-propelled, smooth target-directed motion
  and an organized alternating wake by `4T`; the oblique body/Lambda2 rows
  retain compact three-dimensional caudal structures without wake collapse,
  collision, domain exit, or out-of-plane instability. The qualitative wake
  and route remain similar, so the replicated trace and score differences—not
  a visually dramatic vortex—establish the improvement. No failed termination
  is present in the current sample.
- The assigned-parent note treated its exact replication as a necessary test
  because only one evaluated forward-response rollout then existed. The two
  additional current replicas resolve that uncertainty: the bounded
  low-forward-speed posterior-wave emphasis is deterministic positive evidence
  on this frozen case. Its earlier trace interpretation remains narrow: `8L`
  and `6L` were not advanced versus the control, while `1.25L` and `0.9L` were;
  posterior limiting and peak lateral load also increased. This supports
  preserving the mechanism unchanged, not increasing its scalar gain.
- Reconstructing the normalized seven-sample line-of-sight components from the
  recorded strongest trace exposes a distinct terminal opportunity. Within
  the reliable closing capture corridor below `0.9L`, the translational
  residual `bearing_window_rate - turn_rate_recent` is target-signed reopening
  on all 29 supported samples, with normalized magnitude up to `0.0439`. On
  the final two samples, this residual still reopens absolute bearing even
  though the net bearing rate has turned aiding. The current terminal damper
  uses net bearing rate and therefore aliases body yaw with translational
  line-of-sight slip. The control trace shows the same decomposition boundary,
  but the replicated best trace is the policy being extended.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: terminal approach/holding in swimming control and sensor-modulated robotic-fish direction tracking
source_mechanism: retain the propulsive carrier while damping target-line slip separately from body rotation during a reliable final approach
transferable_invariant: decompose observed line-of-sight rate into body-yaw and translational components, then oppose only the target-signed translational reopening with bounded state feedback
nontransferable_details: published controller gains, species-specific body envelopes, dimensional rates, exact vortex phases, clock-defined maneuvers, and task-specific routes or coordinates
policy_translation: preserve the replicated two-joint carrier and all far/middle navigation; inside the existing closing capture corridor, replace only the terminal net-bearing-rate term by the oscillator-normalized windowed residual `bearing_window_rate - turn_rate_recent`, using the same terminal proximity blend and curvature envelope
falsification: reject the transfer if it does not change feasible posterior action over the evidenced terminal support, delays or loses capture, worsens final distance or distance integral, reopens the earlier route, increases limiting or lateral load without target benefit, or disrupts either view of the coherent wake

## One candidate hypothesis

Keep the replicated forward-speed-gated posterior emphasis and every existing
carrier, steering, redirect, wave-relief, anterior-release, allocation, and
exact-boundary projection branch. In the terminal portion of the already
reliable closing corridor, estimate translational line-of-sight response from
the normalized difference between windowed bearing rate and recent heading
rate. Use target-signed reopening of that residual to gate the existing bounded
`3 deg` posterior mean-curvature damper and use the residual, rather than net
bearing rate, for its direction and continuous magnitude. The middle-approach
carrier-demodulated term still fades into this terminal role, and the two
weights still cannot stack beyond the existing envelope.

This is one response-decomposition mechanism, not a gain sweep. Its
falsifiable expectation is to keep the proven coherent wake, route, and
approximately `15.98T` capture while correcting translational reopening through
the final crossing more persistently than a net-rate damper. EvE's post-exit CFD
evaluation is required before claiming any outcome for this candidate.

## Non-CFD verification after the edit

- Candidate SHA-256 is
  `95df8327d97e72b20b683f32e9a10b1ac1bb4b95596cdac49fbd55bc4c989806`.
  Relative to the replicated evaluated parent, the source diff contains only
  the windowed yaw/line-of-sight decomposition and its substitution into the
  terminal branch; the anterior command and parameter values are unchanged.
- A recorded-state counterfactual over all 2,905 samples of a strongest parent
  trace changes 15 feasible posterior commands, all below `0.9L`, with maximum
  difference `1.26253 rad/T^2` at `15.966512T`. It leaves every anterior
  command identical and leaves the count of exact posterior acceleration-limit
  commands unchanged at 662. This establishes action support but is not a CFD
  outcome.
- The lightweight Julia contract returns two finite accelerations. Static
  schema validation resolves all 51 direct `params.FIELD` references against
  exactly 51 fields returned by `target_policy_params()`, with none missing or
  unused. Material-guidance and solver editable-boundary checks pass. No CFD
  was run.
- The configured `check-runner` was invoked, but its pinned `gpt-5.4-mini`
  model is unsupported for this account. Its three prescribed commands were
  therefore run directly and separately; all pass.
