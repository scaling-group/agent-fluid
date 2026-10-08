# Evidence-selected carrier-phase-residual redirect

## Visual diagnosis recorded before the policy edit

- All four sampled rollouts satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, finite dynamics, and
  capture at `0.745-0.747L`. I inspected both rows of every combined
  keyframe sheet. Each top-down row develops a coherent alternating red/blue
  wake by the early frames and retains it through capture; each oblique row
  shows compact three-dimensional Lambda2 structures behind the traveling
  bend. The fish therefore self-propel rather than advect, and none of the
  current score differences is explained by wake collapse or instability.
- The prefilled closing-conditioned redirect is a strong baseline:
  `solver_4c0e1314ad61` captures at `16.225T`, scores `-0.063208`, and
  spends `21.3%` of samples at the posterior acceleration limit. The
  assigned-parent log proposed response-gated terminal wave unloading; its
  evaluated child `solver_1199437e225a` preserves the same two-view wake and
  the same `5L`, `2L`, and capture times, but scores worse
  (`-0.064416`). The independently sampled bearing-rate phase lead likewise
  leaves every milestone unchanged and regresses to `-0.065510`. These
  terminal-only additions do not survive the sampled evidence.
- The carrier-phase-residual gate does survive it.
  `solver_a0cc85d2f5b2` preserves the coherent two-view wake and capture,
  reaches `5L` at `12.106T` instead of `12.177T`, reaches `2L` at
  `14.905T` instead of `15.026T`, and captures at `16.044T` instead of
  `16.225T`. Its score improves to `-0.058311`. Mean/max planar force
  (`0.01571/0.03926`) and mean/max yaw-moment magnitude
  (`0.00797/0.01945`) remain comparable to the prefill
  (`0.01559/0.03890` and `0.00793/0.01954`). The cost is a modest increase
  in posterior hard-limit residence from `21.3%` to `22.7%`, which is a
  follow-up diagnostic rather than grounds to discard an earlier, better
  capture.
- The visible route remains smooth and target-directed, but the residual
  candidate changes the late crossing topology: it arrives from the
  upper-right side of the capture circle on a shallower downward course,
  whereas the three `16.225T` variants arrive farther right with stronger
  downward velocity. This is a meaningfully different useful trajectory, not
  a scalar-only fluctuation.
- A further wake-disturbance residual is not supported in this still-water
  sample. After removing the joint-phase carrier component, local body-frame
  crossflow correlates only `0.01-0.06` with the remaining route error in
  transit; adding local flow, lateral force, and yaw moment to the phase model
  worsens held-segment prediction on both the residual and prefill traces.
  Relative crossflow is correlated but is dominated by the already-used body
  velocity. Adding that redundant channel would confound self-induced wake
  response with persistent navigation error.

## Policy hypothesis

Promote the sampled carrier-phase-residual redirect as the one candidate
without changing its evaluated parameters or stacking another terminal
mechanism. It retains the prefill's joint-state oscillator, posterior lag,
posterior-only mean bend, attenuation-only opposing-wave relief,
closing-conditioned redirect onset, and mean-first acceleration allocation.
The only architectural difference from the prefill is the already sampled
one-quarter subtraction of the normalized joint-phase response from
high-authority redirect-gate selection. Redirect direction and wave/actuator
fallbacks still use the raw measured response, and a pointwise guard admits
the residual command only when it requests no more posterior acceleration
than the raw controller.

This is an evidence-selected exploit, not a claim that the current worker has
new CFD evidence. The expected result is reproduction of the coherent wake,
earlier milestones, and capture class of the sampled residual policy.
Falsify its reusable value if a repeat loses capture, arrives later than the
`16.225T` prefill, returns the former upper-exit topology, materially raises
force/moment loads, or increases posterior limit residence without preserving
the route and score gain.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and residual path control
source_mechanism: preserve the rhythmic locomotion carrier while assigning high steering authority to the slower observation residual rather than repeatable carrier-phase response
transferable_invariant: separate fast joint-phase-correlated motion from persistent target-course mismatch before opening a high-authority redirect
nontransferable_details: published CPG gains, clock phase, species-specific envelopes, dimensional speeds and distances, prescribed vortex phases, and task-specific routes
policy_translation: normalized anterior joint angle and velocity estimate the repeatable odd carrier component; only a bounded partial residual selects the posterior redirect gate while raw-error steering and a pointwise acceleration fallback preserve the captured two-joint carrier
falsification: reject if coherent propulsion or capture is lost, arrival exceeds the prefill, loads or posterior limiting materially increase, or the former upper-exit topology returns

## Candidate boundary

- No published numerical setting is transferred. The phase coefficients and
  partial residual are retained because this exact normalized body-frame
  translation has positive sampled CFD evidence.
- No scalar-only gain change, clock, route coordinate, target identity,
  mutable state, or new flow/load channel is introduced.
- Formal CFD is deferred to EvE after this worker exits.

## Non-CFD verification

- The candidate is byte-identical to the positively sampled
  carrier-phase-residual policy (SHA-256
  `52b2408e05588a07ff94afb18e94b6d98e59656df032a85b5840486cfdcf0177`).
- The required dedicated check runner was invoked, but its pinned
  `gpt-5.4-mini` model is unavailable for this ChatGPT account. Its three
  prescribed commands were run directly. The guidance check initially found
  that the rendered workspace README listed the same assigned parent twice;
  removing only the duplicate listing restored unique provenance. The
  material-guidance, Julia policy-contract, and solver-boundary checks then
  passed.
- A source-level schema audit confirms that all `32` direct
  `params.FIELD` references are owned by `target_policy_params()`. A
  deterministic `6,561`-state sweep over normalized joint state,
  body-frame target geometry, and body velocity returns finite,
  acceleration-bounded actions with lateral-reflection equivariance.
