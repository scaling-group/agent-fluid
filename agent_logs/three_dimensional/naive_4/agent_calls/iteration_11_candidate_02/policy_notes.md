# Attenuation-only carrier-phase redirect

## Pre-edit evidence diagnosis

- All four sampled rollouts satisfy the frozen experiment contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders, no prewarm snapshot, and finite capture termination. I inspected
  both rows of their combined keyframe sheets. The release frames have no
  developed wake; by `4T` each actuated fish has begun translating and shedding
  an alternating red/blue top-down street. The oblique row retains compact
  three-dimensional Lambda2 structures behind the posterior traveling bend
  through capture. There is no visible passive advection, wake collapse,
  boundary excursion, or numerical instability.
- The useful ablation failure is the prefilled terminal-wave-unload policy
  `solver_1199437e225a`, not a failed termination. It captures at `16.2250T`,
  scores `-0.064416`, and has observed distance integral `1.32274L`. The three
  carrier-phase-residual samples `solver_a0cc85d2f5b2`,
  `solver_5739c176b0d4`, and `solver_bf77448adfd7` all capture at `16.0435T`,
  score `-0.058311`, and reduce the observed integral to `1.31388L`; their
  top-down path and two-view wake topology are visually indistinguishable from
  one another and remain coherent. Thus phase separation improves the useful
  trajectory before the terminal regime, whereas deeper terminal unloading
  does not.
- The three tied best results also define a negative boundary. The replayed
  phase-residual implementation and the velocity-limit command projection
  produce exactly the same score, horizon, distance history, and capture
  geometry as the first evaluated phase-residual policy. The inherited logs
  explain why: the rate-limit projection removes commands whose state update is
  already clipped, while comment-only replay cannot change the law. Neither is
  evidence for another route improvement. Earlier inherited evidence also
  rejects shared anterior bias, two-sided lobe amplification, short-window
  bearing-rate lead, full zero-bend holds, and indiscriminate carrier shrink.

## One policy hypothesis

Start from the evaluated carrier-phase-residual winner and add one compact
route-confidence mechanism. Compute the raw high-authority redirect gate and
the existing normalized joint-phase-residual gate, then use their minimum.
Consequently, fast carrier-correlated response may veto strong curvature but
can never manufacture route authority that the raw body-frame
target-versus-course error did not request. Preserve the state-feedback
oscillator, posterior traveling wave, raw redirect direction, one-sided
opposing-wave relief, mean-first posterior allocation, and closing-conditioned
approach law.

The expected useful change is fewer phase-created strong-redirect intervals
on the faster captured route, without weakening self-propulsion or changing
the terminal response scaffold. Falsify the candidate if it loses capture,
delays the `5L/2L/1.2L` milestones or final arrival relative to `16.0435T`,
raises joint-limit residence or normalized loads materially, suppresses the
alternating 3D wake, or later traces show that the vetoed intervals represented
persistent course correction rather than beat-synchronous sway. The new CFD
rollout occurs only after this worker exits; no same-worker trajectory benefit
is claimed.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and residual path-following control
source_mechanism: preserve a rhythmic locomotor carrier while slow sensor feedback selects bounded route authority
transferable_invariant: fast joint-phase-correlated response may reduce confidence in a persistent route error but must not create a stronger route command
nontransferable_details: published CPG gains, clock phase, species-specific envelopes, dimensional frequencies, exact vortex phases, and source-task routes
policy_translation: normalized anterior joint angle and velocity estimate beat-synchronous sway; the residual may only attenuate the raw body-frame target-versus-course redirect gate, while raw response retains turn sign and the two-joint traveling-bend contract
falsification: reject if capture or early progress regresses, wake coherence is lost, loads or limit residence rise materially, or the veto removes course correction that persists across carrier phase

## Non-CFD verification

- A deterministic sweep over `32,805` normalized body-frame and joint states
  returned finite actions inside the owned acceleration envelope and exact
  lateral-reflection equivariance.
- Replaying the evaluated-best states through both policies leaves every
  anterior command exact and changes `35/2,917` posterior commands. The mean
  absolute posterior command changes from `25.51530` to `25.51560 rad/T^2`,
  with maximum pointwise difference `0.240 rad/T^2`. All 35 differences are
  slight magnitude increases caused by posterior target tracking after the
  mean-route gate is lowered. This is a fixed-state counterfactual, not wake or
  trajectory evidence; the formal rollout must determine whether the semantic
  veto changes milestones and whether the negligible command increase has any
  load consequence.
- The required dedicated check-runner was invoked but could not start because
  its pinned `gpt-5.4-mini` model is unavailable for this account. Running its
  three prescribed commands directly passes the material-guidance check, Julia
  policy contract, and solver editable-boundary check. A separate schema audit
  confirms that all `32` direct `params.FIELD` references are returned by
  `target_policy_params()`.
