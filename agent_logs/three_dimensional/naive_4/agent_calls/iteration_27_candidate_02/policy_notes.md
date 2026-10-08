# Carrier-demodulated line-of-sight response candidate

## Evidence diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen contract: direct uniform
  still-water initialization with `U_infinity=(0,0,0)`, no prewarm or
  cylinders, finite dynamics, capture after 2,919 steps at about `16.0544T`,
  and 239 moving-window shifts. The motion is self-propelled rather than
  background advection.
- I inspected the combined keyframe sheets for the strongest finite example
  (`solver_b8f061aba429`) and the slightly weaker distinct policy
  (`solver_8474fe870fa5`) from release through capture. Both the top-down
  mid-plane row and the oblique body/Lambda2 row show a smooth target-directed
  arc, coherent alternating wake, and compact three-dimensional caudal
  structures without collision, virtual exit, wake collapse, or instability.
  The current sample has no failed termination class; its informative negative
  contrast is near-equivalence among terminal mechanisms below the sheet's
  visual resolution.
- The assigned-parent net line-of-sight damper is duplicated by
  `solver_8474fe870fa5` and `solver_acb79e618a5d`. It captures at
  `0.745853782L`, has scored distance integral `1.929846378L`, mean posterior
  command about `24.5858 rad/T^2`, posterior exact acceleration-limit
  residence `21.86%`, and the same 2,919-step arrival in both copies.
- The sampled carrier-demodulated policy is independently duplicated by
  `solver_b8f061aba429` and `solver_197b19357040`. It preserves the two-view
  wake, termination, arrival step, and 239 shifts while improving final
  distance to `0.745845616L`, distance integral to `1.929839552L`, mean
  posterior command to about `24.5845 rad/T^2`, and posterior limit residence
  to `21.79%`; peak lateral force rises slightly from about `0.03223` to
  `0.03239`. This is replicated but trace-scale terminal geometry, not a new
  route or held-out robustness result.
- Inherited step-24 through step-26 notes give the relevant negative boundary.
  Translational-slip half-cycle relief altered only four terminal samples and
  reached `-0.046922579`; broader raw-bearing-rate lobe relief regressed to
  `-0.046998432`. The net-rate mean damper then reached `-0.046908385`, and
  subtracting predictable anterior carrier response before middle-approach
  mean damping reached the sampled best `-0.046899933`. The evidence does not
  justify another terminal phase gate or scalar onset/curvature retune.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: closed-loop CPG modulation and robotic-fish path following
source_mechanism: separate a repeatable rhythmic locomotor carrier from a bounded sensory residual command
transferable_invariant: act on persistent navigation response only after removing the predictable joint-state carrier component, while preserving the productive traveling wave
nontransferable_details: published gains, clock-defined CPG phase, species-specific envelopes, dimensional frequencies, exact vortex phases, and task-specific routes
policy_translation: retain the proven state-feedback carrier and predict normalized carrier yaw from anterior joint position and velocity; subtract that prediction from normalized body-frame bearing rate, then apply bounded posterior mean curvature only while closing and predicted-intercept reliability agree
falsification: reject if capture, coherent two-view wake, earlier distance history, scored distance integral, posterior limiting, or force envelope regresses, or if held-out conditions show that the fitted carrier residual aliases productive route response

## One candidate hypothesis

Adopt the replicated sampled-best carrier-demodulated line-of-sight policy as
exactly one candidate. Preserve the established oscillator, posterior lag,
response-conditioned redirect, one-sided wave relief, approach behavior,
redirect handoff, terminal net-rate damper, and exact speed-boundary
projection. In the reliable middle closing corridor, subtract the existing
normalized anterior-joint carrier-yaw prediction from measured bearing rate
and oppose only residual reopening with the already bounded three-degree
posterior mean-curvature envelope; fade continuously into the measured net
bearing-rate terminal response below `0.90L`. This is a feedback-structure
selection supported by two identical evaluations, not scalar-only gain tuning.
Its expected result is reproduction of the sampled `-0.046899933` capture and
unchanged pre-terminal behavior. This worker does not claim a new CFD result.

## Non-CFD verification after the edit

- Candidate SHA-256 is
  `650a2d0d74c0edd84a42a13119a7df8a6eafbe4dbed2b73256434fb2dbb2e6e2`,
  byte-identical to both independently evaluated sampled-best copies
  (`solver_b8f061aba429` and `solver_197b19357040`).
- The lightweight Julia contract returns exactly two finite accelerations.
  All 48 direct `params.FIELD` references resolve against the 48 fields
  returned by `target_policy_params()`.
- The material guidance/notes check and solver editable-boundary check pass.
  The former initially found that the rendered workspace README marked the
  same assigned parent twice; removing only one duplicate `prefill` marker
  repaired that metadata failure.
- The configured check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable for this account. Its three prescribed checks were therefore
  run directly and separately as reported above. No CFD was run.
