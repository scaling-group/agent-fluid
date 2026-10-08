# Evaluated forward-response posterior-emphasis candidate

## Evidence diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen experiment contract: direct
  uniform still-water initialization with `U_infinity=(0,0,0)`, no cylinders
  or prewarm, finite dynamics, and capture. Translation is therefore
  self-propelled rather than background advection. Three samples are
  byte-identical copies of the forward-response policy (policy SHA-256
  `f915d466...`), while the assigned parent `solver_197b19357040` is the
  distinct carrier-demodulated baseline (policy SHA-256 `650a2d0d...`).
- I inspected both rows of the combined keyframe sheets for the strongest
  finite sample `solver_07403e1ebc74` and the assigned-parent comparison from
  release through capture. In each top-down row, the release disturbance grows
  into a coherent alternating lateral wake while the fish follows the same
  smooth target-directed arc. Each oblique body/Lambda2 row shows compact
  three-dimensional caudal structures without collision, virtual-boundary
  approach, wake collapse, or out-of-plane instability. The terminal
  difference is below reliable sheet resolution. No sampled failed termination
  exists, so the weaker distinct capture is the informative negative contrast.
- The three evaluated forward-response copies are identical at capture:
  `15.977511T`, 2,905 steps, 238 window shifts, `0.744403L` final/minimum
  distance, `1.928581L` scored distance integral, and `-0.0455063` score.
  Against the assigned parent at `16.054371T`, 2,919 steps, 239 shifts,
  `0.745846L`, `1.929840L`, and `-0.0468999`, this is a replicated
  semantic improvement that retains the two-view wake.
- The traces reject a simple startup-thrust interpretation. The `8L` and
  `6L` milestones are delayed from `9.074996/11.044002T` to
  `9.091496/11.055001T`, and the `4L/2L` milestones are unchanged. The
  benefit appears at `1.25L` and `0.9L`, which advance from
  `15.531978/15.911484T` to `15.493514/15.823509T`. Mean absolute posterior
  acceleration rises from `24.5845` to `25.4727 rad/T^2`, posterior exact
  acceleration-limit residence rises from `21.79%` to `22.58%`, and peak
  lateral force rises from `0.03239` to `0.03334`, although maximum
  posterior excursion falls from `36.43` to `33.12 deg`.
- The inherited step-28 counterfactual established that the branch changed
  feasible posterior action through `3.6575T` rather than wrapping a clamp.
  The completed step-29 evidence then showed that this early perturbation
  accumulated into a later approach/crossing benefit, not earlier route
  progress or lower actuator effort. This rules out stronger scalar gain
  tuning under a generic propulsion claim.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: Lighthill-style reactive tail propulsion and sensor-modulated robotic-fish CPG control
source_mechanism: preserve an anterior rhythmic carrier while allocating temporary posterior traveling-wave authority from measured propulsive response
transferable_invariant: posterior wave authority may respond smoothly to normalized forward-speed deficit while the anterior carrier, steering bend, and approach handoff remain intact
nontransferable_details: published gains, dimensional frequencies, species-specific envelopes, exact Strouhal values, clock-defined burst duration, exact vortex phase, and task-specific routes
policy_translation: retain the evaluated two-joint state-feedback carrier and navigation law; outside approach, scale only the posterior traveling-wave target with a bounded body-frame forward-speed gate that returns exactly to unity after measured recovery
falsification: reject the startup-thrust interpretation because early route milestones did not advance; reject the policy transfer if capture, coherent two-view wake, late approach history, distance integral, joint envelope, or force envelope regresses

## One candidate hypothesis

Materialize the distinct sampled-best forward-response policy as exactly one
candidate. Relative to the assigned parent, it adds only the evaluated bounded
posterior-wave branch: at normalized body-frame forward speed at or below
`0.10U`, the posterior traveling-wave scale may increase by up to 25%; it
fades smoothly to unity by `0.35U` and is suppressed continuously as approach
proximity develops. The anterior oscillator, target/course steering,
response-conditioned redirect, one-sided wave relief, carrier-demodulated
line-of-sight response, approach roles, posterior allocation, and exact
velocity-boundary projection remain unchanged.

The falsifiable expectation is reproduction of the sampled semantic
improvement—coherent wake, capture near `15.98T`, and better late
distance/crossing history—without claiming earlier propulsion milestones or
lower command effort. No same-worker CFD result is claimed; formal evaluation
occurs after this worker exits.

## Non-CFD verification after the edit

- Candidate SHA-256 is
  `f915d466444cf8efad27707431c558749510254354be3998c294348dbb001f25`,
  byte-identical to all three independently evaluated sampled-best copies.
- The lightweight Julia contract returns exactly two finite accelerations. A
  deterministic schema scan resolves all 51 direct `params.FIELD` references
  against the 51 fields returned by `target_policy_params()`.
- The guidance materiality check and solver editable-boundary check pass. The
  first guidance run exposed two identical `prefill` markers for the same
  generated guidance parent in `README.md`; removing only one duplicate
  marker repaired the metadata failure while retaining one authoritative
  parent marker.
- The configured `.codex/agents/check-runner.toml` was invoked, but its
  pinned `gpt-5.4-mini` model is unavailable for this account. Its three
  prescribed non-CFD checks were therefore run directly and separately, and
  all pass. No CFD was run.
