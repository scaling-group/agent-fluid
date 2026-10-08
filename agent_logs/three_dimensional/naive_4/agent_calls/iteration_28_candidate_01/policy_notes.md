# Forward-speed-gated posterior-emphasis candidate

## Evidence diagnosis before the policy edit

- All four current solver examples are exact replications: policy SHA-256
  `650a2d0d74c0edd84a42a13119a7df8a6eafbe4dbed2b73256434fb2dbb2e6e2`,
  combined-sheet SHA-256
  `c36dbb9685d5d1640376c1b3a97371d0152ca379974f4496819c96593437e72c`,
  direct uniform still-water initialization with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, capture after 2,919 steps at `16.054371T`, 239 moving
  shifts, final/minimum distance `0.745845616L`, distance integral
  `1.929839552L`, and score `-0.046899933`. The result is self-propelled and
  finite, but the allocation provides no new controller or trajectory evidence.
- I inspected the strongest current combined sheet and the distinct inherited
  step-24 regression (`solver_e808cf9d855f`) from release through capture.
  In both top-down rows, the release disturbance develops into a coherent,
  alternating reverse-street-like wake and the fish follows a smooth
  target-directed arc. Both oblique body/Lambda2 rows show compact paired
  caudal structures without collision, wake collapse, virtual exit, or
  out-of-plane instability. Their terminal differences are below sheet
  resolution. No sampled failed-termination sheet is present in this
  workspace; the inherited route-wide residual failure is therefore used only
  as logged scalar/trajectory evidence, not as a new visual claim.
- The trace identifies a route-scale opportunity before those terminal gates
  can act. From release to `0.5T`, mean forward speed is approximately zero;
  it is only `0.105U` over `1-2T`, first crosses `0.25U` near `3T`, and reaches
  about `0.35U` at `4T`. Distance falls only from `12.328L` to `12.002L` by
  `3T`. Yet posterior acceleration-limit residence is zero throughout the
  first `4T`, posterior excursion stays below `19.2 deg`, and the visual wake
  is organized by `4T`. This supports testing more early posterior wave
  authority rather than another terminal scalar or phase gate.
- The existing terminal lineage is mature and narrow. The current
  carrier-demodulated response improves its net-rate parent by only
  `8.2e-6L` at the crossing with the same arrival step and two-view wake;
  translational-slip half-cycle relief changed only four terminal samples and
  scored `-0.046923`, broader bearing-rate lobe relief regressed to
  `-0.046998`, and an inherited route-wide residual brake missed capture at
  `0.785816L` before exiting at `29.293T`. These results rule out another
  terminal onset/curvature retune and constrain the new mechanism to leave all
  navigation and approach logic intact.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: Lighthill-style reactive tail propulsion and sensor-modulated robotic-fish CPG control
source_mechanism: emphasize posterior traveling-wave motion while measured propulsive translation is weak, then return continuously to the established carrier as forward response develops
transferable_invariant: preserve the anterior rhythm and directional bend while allocating temporary posterior wave authority from observed forward-speed deficit rather than elapsed time
nontransferable_details: published thrust laws and gains, species-specific amplitudes, dimensional frequencies, exact Strouhal values, clock-defined burst duration, exact vortex phase, and task-specific routes
policy_translation: retain the evaluated two-joint oscillator, steering, redirect, approach, terminal response, allocation, and limit projection; outside the established approach proximity, multiply only the posterior traveling-wave component by a bounded smooth gain while normalized body-frame forward speed is below the evidenced organized-wake regime, with exactly unit gain after recovery
falsification: reject if the coherent alternating two-view wake is lost, posterior limiting or force/moment peaks grow materially, early distance milestones do not advance, the established target-directed route changes adversely, or capture is delayed or lost

## One candidate hypothesis

Add one state-feedback launch/recovery mechanism to the assigned-parent
controller. While valid normalized body-frame forward speed is at or below
`0.10U`, increase only the posterior traveling-wave target by at most 25%; fade
that increment smoothly to zero by `0.35U` and suppress it continuously inside
the established approach proximity. The gate contains no time, route,
world-position, or external phase signal. Outside approach, it reopens after a
genuine forward-speed loss, so it is a feedback recovery action rather than a
memorized launch schedule. The anterior oscillator, mean steering and redirect direction,
one-sided wave relief, approach settling, carrier-demodulated line-of-sight
response, posterior mean-first allocation, and exact velocity-boundary
projection remain unchanged.

The falsifiable expectation is a visibly earlier build-up of the same coherent
traveling wake and earlier distance milestones, without changing the mature
steering/terminal roles after forward speed reaches `0.35U`. The chosen support
is trace-derived: it covers the low-speed interval with available posterior
acceleration and releases at the first observed organized-wake/forward-speed
regime. It is a new observation-to-actuator mechanism, not a global amplitude
or frequency retune. No new CFD outcome is claimed by this worker; formal
evaluation occurs after exit.

## Non-CFD verification after the edit

- Candidate SHA-256 is
  `f915d466444cf8efad27707431c558749510254354be3998c294348dbb001f25`.
  Static schema validation resolves all 51 direct `params.FIELD` references
  against the 51 fields returned by `target_policy_params()`.
- A deterministic sweep of 20,000 paired states across target side and
  distance, body-frame forward/lateral velocity, bearing and yaw response, and
  joint phase returns finite bounded commands with zero lateral-reflection
  error. The non-finite observation fallback also remains finite.
- Counterfactual evaluation on the assigned parent's recorded states changes
  only posterior feasible action on 562 of 2,919 reconstructed samples, from
  release through `3.657503T`, with forward-speed support from `-0.0145U` to
  `0.3486U`. Anterior action is exactly unchanged, all later reconstructed
  actions are unchanged, maximum posterior-command difference is
  `6.8291 rad/T^2`, mean difference on support is `2.3759 rad/T^2`, and no
  changed candidate command reaches the acceleration limit. This verifies
  that the branch is neither terminal leakage nor a clamp-equivalent wrapper;
  it does not predict the unevaluated closed-loop hydrodynamic response.
- The configured `.codex/agents/check-runner.toml` was invoked, but its pinned
  `gpt-5.4-mini` model is unavailable for this account. Its three prescribed
  checks were run directly and separately: guidance materiality, the
  lightweight Julia policy contract, and solver editable-boundary enforcement
  all pass. No CFD was run.
