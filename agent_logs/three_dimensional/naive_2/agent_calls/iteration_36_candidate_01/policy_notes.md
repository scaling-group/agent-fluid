# Evidence-constrained multi-wake candidate

## Pre-edit evidence diagnosis

- The assigned parent, all four sampled solver results, and every available
  inherited evaluation contain the same policy (`452903db...`). The sampled
  trajectories (`84ec5c93...`) and combined keyframe sheets (`6d2c1aa...`)
  are byte-identical, so they constitute one reproducible physical trajectory
  rather than independent mechanism comparisons. Each rollout starts directly
  from uniform still water with `U_infinity=(0,0,0)`, no cylinders, and no
  prewarm; each captures at `16.604496T`, crosses at `0.743958L`, has scored
  distance integral `1.998146L`, and scores `-0.113729`.
- I inspected the release-to-capture top-down and oblique keyframe sheets. The
  top-down view shows self-propelled target closure along a shallow curved path
  with an alternating red/blue mid-plane wake that remains continuous behind
  the tail. The oblique view shows compact alternating three-dimensional
  Lambda2 structures connected to the posterior path through capture. Neither
  view shows wake breakup, collision, boundary exit, or a recentering-aligned
  discontinuity.
- The completed trace supports that visual reading: distance falls from
  `12.3277L` to capture while 237 integer-cell moving-window shifts occur, and
  final inertial velocity is `(-1.10010,-0.27006)U`. Capture occurs with an
  active final beat, but this no-dwell objective ends on first crossing and
  supplies no terminal hold error. The available evidence therefore diagnoses
  neither propulsion loss nor a route failure to correct.
- No distinct failed keyframe sheet exists in the sampled or inherited files;
  all available images are the same successful trace. The informative failure
  comparison is consequently metric-level only: inherited closure-qualified
  yaw-response release crossed one integration step earlier but made crossing
  shallower and regressed distance integral and score to
  `0.744276L/1.998380L/-0.114037`. The inherited local-flow phase subtraction
  likewise retained capture but regressed to
  `0.745252L/1.999280L/-0.115121`; target-rate, moment, posterior-relief, and
  projected-corridor variants supplied no positive control implication.
- More than three completed selections have produced neither a new mechanism
  nor a semantic improvement, so the structured bookshelf consultation is
  required. Its traveling-carrier, target-directed asymmetry, response
  residual, and terminal-hold families are already represented by the
  incumbent or by completed negative controls. The duplicate nominal evidence
  does not identify a new bounded error signal for another channel.

## Sole candidate and falsifiable hypothesis

Retain the prefilled normalized body-frame two-joint controller byte-for-byte
as the sole candidate. It preserves the demonstrated full traveling-wave
carrier, raw target geometry, mean-preserving yaw and lateral-response
demodulation, phase-compatible posterior steering, smooth acceleration bound,
and narrow one-sided joint-speed guard. No sibling, terminal intervention,
storage-window cue, or scalar-only gain retune is introduced.

This is a null mechanism translation supported by the available evidence, not
a claim that the unevaluated current candidate improves CFD. Formal evaluation
should reproduce capture, arrival, route cost, crossing depth, two-view wake
connectivity, joint feasibility, effort, force, and moment. Falsify
preservation if the nominal envelope does not reproduce. Reopen one compact
bounded primitive only after a completed nonduplicate or held-out pose, target,
or flow exposes a repeatable body-frame response deficit.

bookshelf_consulted: true
source_domain: classical traveling-wave swimming and sensor-modulated robotic-fish direction control
source_mechanism: preserve a productive posterior-lagged rhythmic carrier and recruit separate bounded steering or disturbance feedback only for an observed response deficit
transferable_invariant: repeated carrier-correlated motion and storage recentering are not errors by themselves; preserve an evidenced carrier until nonduplicate body-frame observations identify a persistent propulsion, route, or response deficit
nontransferable_details: published gains, dimensional frequencies, species-specific envelopes, exact vortex phases, fixed schedules, world-frame coordinates, and task-specific routes
policy_translation: null translation; retain the existing normalized two-joint carrier and response separation exactly because all supplied rollouts are one successful trace and completed terminal or residual perturbations worsen target cost without a feasibility or load benefit
falsification: test one bounded state-feedback primitive only after a nonduplicate or held-out rollout isolates its target error, and reject it if capture, route cost, crossing depth, wake connectivity, joint feasibility, effort, force, or moment worsens

## Evidence boundary

All numerical comparisons above come from completed assigned, sampled, or
inherited evaluations. The current candidate is evaluated only after this
worker exits. Exact nominal repetition establishes determinism, not robustness
to changed pose, target, inflow, or imposed wake; the absence of a failed image
is not treated as a visual failure comparison.
