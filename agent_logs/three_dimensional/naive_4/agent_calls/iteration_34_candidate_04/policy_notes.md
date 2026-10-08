# Carrier-demodulated load-consensus rejection candidate

## Evidence diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen direct-uniform still-water
  contract: `U_infinity=(0,0,0)`, no cylinders or prewarm, finite dynamics,
  and capture. I inspected the sampled-best and prefilled combined sheets from
  release through capture. Their top-down rows show the release transient
  developing into a coherent alternating wake behind a smooth target-directed
  arc, so the fish is self-propelled rather than advected. Their oblique
  body/Lambda2 rows retain compact paired caudal structures without wake
  collapse, collision, virtual-boundary exit, or out-of-plane instability.
  No failed-termination sheet is allocated, so the weaker finite prefill and
  inherited logged regressions are the informative controls.
- The carrier-demodulated yaw-moment policy is the sole material winner in the
  current sample. Relative to the prefill it advances capture from
  `15.768509T` to `15.735508T`, lowers the distance integral from `1.924067L`
  to `1.919818L`, improves final distance from `0.745720L` to `0.744372L`,
  and uses 231 rather than 232 moving-window shifts. Its combined wake sheet
  remains coherent in both views. The reusable result is the bounded
  non-carrier moment correction, not a visually stronger vortex or a scalar
  curvature retune.
- The three other sampled policies have distinct source hashes but
  byte-identical trajectories and combined sheets at `15.768509T`,
  `0.745720L`, and score `-0.041674176`. Their terminal line-of-sight
  rewrites are therefore not route diversity. The inherited adverse axial
  load relief is also negative: it delayed capture to `15.785009T`, worsened
  distance integral to `1.925588L`, and scored `-0.043610` despite lower
  limiting and lateral load. This candidate preserves the positive axial
  response allocator and does not add another terminal or carrier-relief gate.
- On the prefill route regime (`t>4T`, distance `>2L`), normalized anterior
  joint position and velocity explain `95.97%` of yaw-moment variance and
  `96.01%` of lateral-force variance. Their residual 5th/50th/95th
  percentiles are `-0.00329/0.00008/0.00304` for moment and
  `-0.00572/0.00047/0.00584` for lateral force. With smooth trace-scaled
  opposition gates, both residuals oppose the requested redirect on 534
  route samples. Moment-only and force-only states instead show mean
  ten-step absolute course-error changes of about `-0.077` and `-0.055 rad`,
  while agreement states remain nearly flat at `+0.0029 rad`. This is a
  retrospective association rather than causality, but it supports one small
  consensus-only addition instead of independent lateral-force authority.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and wake-disturbance rejection
source_mechanism: preserve a rhythmic traveling-bend carrier while separating repeatable locomotor loads from hydrodynamic disturbances and responding only to corroborated adverse feedback
transferable_invariant: retain the anterior rhythm, posterior traveling wave, and slow target-directed mean turn; subtract joint-phase-predicted body loads and add bounded steering only when independent normalized lateral-force and yaw-moment residuals both oppose the requested turn
nontransferable_details: published gains, species-specific envelopes, dimensional frequencies, exact Strouhal values, exact tail or vortex phase, source wake geometry, source force scales, clock-defined events, and task-specific routes
policy_translation: retain the sampled positive axial-response carrier and moment-residual correction; predict body-frame lateral force from normalized anterior joint state and add a smaller posterior mean-curvature increment only inside the existing reliable route gate when both moment and lateral-force residual opposition gates agree, fading the increment before the established approach
falsification: reject if capture or any route milestone regresses, distance integral worsens, the coherent two-view wake or force envelope degrades, posterior limiting grows without route benefit, or the consensus branch changes no feasible route action

## One candidate hypothesis

Produce exactly one candidate by preserving the prefilled carrier, navigation,
approach, terminal translational-line response, force allocation, mean-first
actuation, and exact actuator projection. Transfer the sampled winning
carrier-demodulated yaw-moment correction, then give it one smaller compatible
load-consensus increment. The new increment cannot act from lateral force
alone: it opens only after reliable forward translation, an active raw target
redirect, and simultaneous non-carrier moment and lateral-force opposition.
It fades with the established approach proximity so terminal shaping is not
redefined. Non-finite load observations select their carrier predictions and
therefore remove sensory correction.

The carrier-force coefficients and residual scale come from the allocated
trace in normalized body-frame units; the literature contributes only the
separation-and-corroboration invariant. The falsifiable expectation is that
the consensus increment arrests the route-error plateaus while retaining the
moment policy's earlier capture and coherent wake. A lower load or command
statistic without milestone or distance-integral benefit is not success.
Formal CFD occurs after this worker exits, so no result for this candidate is
claimed here.

## Non-CFD verification after the edit

- Candidate SHA-256 is
  `37457767619f518dc1d5b074545273525c37b9e36c54bd8369e700bd89961beb`.
  Static schema validation resolves all 60 direct `params.FIELD` references
  against exactly 60 fields returned by `target_policy_params()`, with no
  missing or unused field. The prescribed lightweight Julia contract returns
  two finite bounded accelerations.
- A deterministic 20,000-pair sweep across target side and distance,
  body-frame velocity and axial/lateral force, yaw moment, bearing and yaw
  response, and joint phase returns finite actions inside the declared
  acceleration limit with zero lateral-reflection error. It exercises the
  consensus branch on 1,139 pairs. Non-finite force and moment probes return a
  finite carrier-only sensory fallback.
- Counterfactual reconstruction on the prefill trace changes 322 posterior
  commands and no anterior commands relative to the same candidate with only
  the new consensus ceiling set to zero; mean and maximum changes are
  `0.0731` and `1.3377 rad/T^2`. Reconstruction on the sampled winning
  moment-policy trace changes 334 posterior commands, with mean and maximum
  changes `0.0797` and `1.3001 rad/T^2`. Neither trace gains a new exact
  acceleration-limit hit. This establishes feasible, non-clamp-equivalent
  support but does not predict the unevaluated closed-loop response.
- Guidance materiality, the lightweight Julia policy contract, and solver
  editable-boundary checks pass. The configured check-runner was invoked but
  its pinned `gpt-5.4-mini` model is unavailable for this account; its three
  prescribed commands were therefore run directly and separately. The first
  materiality run exposed two identical assigned-parent markers in the
  rendered workspace `README.md`; removing only the duplicate repaired that
  inherited metadata defect without changing the assigned parent. No CFD was
  run.
