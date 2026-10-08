# Evidence-constrained multi-wake candidate

## Pre-selection visual diagnosis

- All four assigned solver examples, the assigned parent's evaluated solver,
  and the prefilled candidate have the same policy hash. Their trajectories
  and combined keyframe sheets are also byte-identical, so they are one
  reproducible physical trace rather than independent mechanism tests. Each
  starts directly from uniform still water with `U_infinity=(0,0,0)`, no
  cylinders, and no prewarm, and each captures at `16.604496T` with
  `0.743958L` final distance, `1.998146L` scored distance integral, and
  `-0.113729` score after 237 moving-window shifts.
- I inspected the combined sheet from release through termination. The
  top-down row shows a self-propelled shallow target-closing arc and a
  continuous alternating red/blue wake behind the posterior body. The oblique
  row shows compact three-dimensional Lambda2 structures connected to the
  tail path through capture. Neither row shows wake breakup, collision,
  boundary exit, passive advection, or a shift-locked discontinuity.
- The completed trace crosses from `0.751028L` to `0.743958L` over its final
  integration step with velocity `(-1.10010,-0.27006)U`. That active endpoint
  is success under the no-dwell first-crossing objective, not evidence of a
  terminal holding error. The visuals and metrics expose no missing
  propulsion, route, or disturbance-response capability.
- There is no distinct failed keyframe sheet among the current samples or
  inherited files. The valid failure comparison is therefore metric-level:
  closure-qualified yaw-response release retained capture but regressed to
  `0.744276L/1.998380L/-0.114037`, local-flow phase subtraction regressed to
  `0.745252L/1.999280L/-0.115121`, and completed target-rate, moment,
  posterior-relief, and projected-corridor descendants also supplied no
  positive control implication.

## Sole candidate and falsifiable hypothesis

Retain the prefilled normalized body-frame two-joint controller byte-for-byte
as the sole candidate. It preserves the demonstrated full traveling-wave
carrier, raw target geometry, mean-preserving yaw and lateral-response
demodulation, phase-compatible posterior steering, smooth acceleration bound,
and narrow one-sided joint-speed guard. No sibling, scalar-only gain retune,
terminal hold, new residual channel, or moving-window cue is introduced.

This is an evidence-constrained null mechanism translation, not a claim about
the unevaluated current rollout. Formal evaluation should reproduce capture,
route cost, crossing depth, arrival, two-view wake connectivity, joint
feasibility, effort, force, and moment. Falsify preservation if that nominal
envelope does not reproduce; reopen one compact primitive only after a
completed nonduplicate or held-out case identifies a repeatable normalized
body-frame response deficit.

bookshelf_consulted: true
source_domain: classical traveling-wave swimming, sensor-modulated robotic-fish direction control, and adaptive wake interaction
source_mechanism: preserve a productive posterior-lagged carrier and add bounded route, disturbance, or terminal modulation only for a measured response deficit
transferable_invariant: separate rhythmic propulsion from slow target response and treat an added feedback primitive as new only when its normalized observation-to-joint map and falsifiable deficit differ from completed controls
nontransferable_details: published gains, dimensional frequencies, species-specific envelopes, exact vortex phases, world-frame schedules, fixed coordinates, and task-specific routes
policy_translation: null translation; the incumbent already implements the compatible carrier and route-response invariants, while terminal, target-rate, moment, and local-flow variants cover the remaining shelf families and regress completed nominal evidence
falsification: test one bounded state-feedback primitive only after nonduplicate evidence isolates its causal target error, and reject it if capture, route cost, crossing depth, wake connectivity, feasibility, effort, force, or moment worsens

## Evidence boundary

All numerical comparisons are from completed assigned, sampled, or inherited
evaluations. The current candidate will be evaluated only after this worker
exits. Exact nominal repetition establishes determinism, not robustness to a
changed pose, target, inflow, or imposed wake.
