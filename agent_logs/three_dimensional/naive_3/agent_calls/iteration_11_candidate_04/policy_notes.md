# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- All four sampled evaluations and the assigned parent's completed evaluation
  use direct uniform still water (`U_infinity=(0,0,0)`), no cylinders, and no
  prewarm snapshot. Their finite translation and long alternating wakes are
  therefore self-propulsion rather than advection or initialization leakage.
- I inspected both rows of the combined top-down vorticity and oblique
  body/Lambda2 sheets for the best sampled finite carrier (`2.443L`), the
  prefilled response-redirect failure (`2.601L`), and the assigned parent's
  course-conditioned approach hold (`2.179L`). All three retain coherent
  three-dimensional wakes and nearly coincident inbound paths, pass below the
  target while still powered, rotate toward an almost vertical departure, and
  terminate at the lower boundary. Wake collapse, weak propulsion, and
  numerical instability are not the limiting failures.
- The assigned parent's hold is a completed negative result with a useful
  boundary. Relative to its inherited bounded target-ray counterbend, it
  worsened minimum distance from `2.011L` to `2.179L`; mean distance improved
  only from `8.740L` to `8.700L` and final distance from `9.836L` to `9.717L`,
  while the semantic lower-exit failure remained. At the hold rollout's
  minimum (`18.546T`), speed was about `0.698U`, target-ray closing speed was
  about `0.305 L/T`, and normalized target-ray cross-track speed was about
  `0.628U`. Crucially, the
  normalized body-longitudinal target component was still about `-0.18`: the
  target remained ahead along the fish's negative-body-x forward axis. The
  proximity/course/closure gate therefore reduced posterior propulsion before
  the best available inbound S-bend had completed its pass.
- The sampled `2.443L` carrier and `2.601L` redirect also show high anterior
  command residence and a coherent powered miss, while inherited evidence
  rejects early line-of-sight/slip correction, more anterior curvature,
  persistent geometry-only counterbend, and proximity-only drive relief.
  The remaining narrow test is not another gain change: preserve the best
  completed inbound controller exactly and move any propulsion/steering
  separation to the observed post-pass recovery regime.

## Policy hypothesis

Start from the assigned parent's bounded target-ray posterior counterbend and
course residual, which inherited evidence reports as the best completed
closest approach (`2.011L`). Retain its carrier, curvature, counterbend,
approach envelope, and actuator limit. Retain the tested course-and-closure
posterior-wave hold, but multiply it by a continuous post-pass gate that is
exactly zero while the target remains ahead (`target_body_L[1] <= 0`) and rises
only with normalized behindness. Thus the entire inbound trajectory, including
the prior closest approach, receives full posterior wave authority; after a
miss, the existing mean S-bend keeps steering while excess posterior drive is
reduced to give the fish a chance to redirect rather than power into the lower
boundary.

Expected evidence is the inherited coherent inbound wake and a closest
approach near or below `2.011L`, followed by visibly reduced post-pass wake
strength, a stronger recovery turn, and a termination class or trajectory that
differs from the powered lower exit. Falsify the mechanism if the inbound path
or wake changes before the target passes behind, minimum distance remains near
`2.179L`, the fish coasts without redirecting, actuator/load residence rises,
or the same lower-exit topology persists without useful distance improvement.

```text
bookshelf_consulted: true
source_domain: terminal capture control and Lighthill-style separation of posterior propulsion from steering kinematics
source_mechanism: preserve the traveling carrier through approach, then reduce excess posterior drive only after normalized geometry confirms a missed pass while retaining bounded steering
transferable_invariant: schedule propulsion and steering authority separately only in the observed regime that needs recovery, without perturbing an already useful target-directed carrier
nontransferable_details: published gains, dimensional frequencies, species-specific body waves, exact vortex phases, fixed distances, elapsed-time stages, duty ratios, and task-specific routes
policy_translation: body-frame longitudinal target fraction adds a continuous ahead-versus-behind gate to the existing course-and-closure hold; the two-joint oscillator, bounded S-bend, and all far-field feedback remain unchanged
falsification: reject on any pre-pass trajectory change, minimum worse than the inherited 2.011L counterbend, lost post-pass wake without recovery yaw, higher limit/load residence, or persistence of the powered lower exit
```

## Implemented candidate and pre-CFD checks

The candidate uses the inherited counterbend/course controller and adds one
normalized longitudinal gate to its posterior-wave hold. The gate is exactly
zero for every ahead-target state and rises continuously only after the target
passes behind; no clock, world coordinate, route, case identity, flow phase,
or mutable controller state enters the policy. All active carrier, steering,
gate, and limit values are owned by `target_policy_params`.

The mandated guidance-semantic, Julia contract/schema, and solver-boundary
checks pass. Direct probes also pass reflection equivariance, exact pre-pass
invariance to hold settings, post-pass hold activation, extreme-input
finiteness, and the configured command bounds. All `324` repository non-CFD
assertions pass. Formal CFD is intentionally deferred to the downstream EvE
evaluation, so the candidate's trajectory claims above remain falsifiable
expectations rather than same-worker evidence.
