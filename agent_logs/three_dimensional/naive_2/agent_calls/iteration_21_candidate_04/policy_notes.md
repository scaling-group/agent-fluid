# Candidate diagnosis and hypothesis

## Evidence read before editing

- All four sampled evaluations use direct uniform still-water initialization
  with `[0,0,0]` background flow and terminate in capture. The best scalar
  sample is `solver_d32fb3a02de7` (`-0.0244375`, `15.9830T`); the least
  favorable capture is `solver_4a4abee43950` (`-0.0303135`, `16.0435T`).
- Both rows of those combined keyframe sheets were inspected. The top-down
  row shows the fish translating under its own oscillation along a direct
  targetward route while shedding a coherent alternating vortex street. The
  oblique row shows compact paired Lambda2 structures forming behind the
  posterior body rather than a background wake advecting the fish. Neither
  comparison shows a collision, wake breakup, or terminal loop before capture.
- `solver_d32fb3a02de7`, `solver_16135cb555bf`, and
  `solver_4a4abee43950` contain the exact same policy bytes. Their capture-time
  range (`15.9830--16.0435T`) and score range
  (`-0.02444---0.03031`) therefore establish a repeatability band. The
  response-released posterior-pulse variant `solver_8e5a36c75b2e` also
  captures at `16.0160T`; its score and 95%-of-limit joint-rate occupancy
  remain inside the exact-policy repeat spread. Its peak planar force/moment
  are only about 3--5% below the repeat minima and are unreplicated, so the
  single run is not evidence for a distinct load or scalar improvement.
- Cross-checking the trajectories reveals a more specific terminal defect.
  A centered linear reconstruction of body lateral velocity from the two
  joint rates is stable across all four rollouts (head-rate coefficient about
  `-0.130`, tail-rate coefficient about `+0.070`) and explains about 88% of
  lateral-velocity variance over the full route and 98.1--98.4% inside `3L`.
  The policy nevertheless feeds raw instantaneous lateral velocity into its
  constant-course closest-pass predictor. Thus beat-correlated carrier sway,
  rather than only route translation, drives terminal predicted miss and its
  steering request.
- The assigned parent also records a step-20 `left_domain` near miss at
  `1.03698L`; broader inherited evidence rejects carrier braking and repeated
  static-bend tuning. The sampled captures instead support preserving the
  traveling carrier and changing the semantics of terminal prediction.

## Policy hypothesis

Reconstruct a bounded fast lateral carrier component from normalized joint
rates and subtract it only from the body-frame lateral velocity used by the
terminal time-to-closest and signed-miss calculation. Keep raw translational
velocity for the proven far-field course controller, and do not alter the
oscillator, mean-bend, posterior pulse, or actuator envelope. This should make
the approach request respond to the route residual instead of the beat phase
without sacrificing the direct self-propelled trajectory.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG modulation and wake-control signal separation
source_mechanism: preserve the rhythmic traveling carrier while deriving route correction from a slower residual rather than its fast locomotor oscillation
transferable_invariant: navigation and capture prediction should separate carrier-correlated sway from target-relative translation before recruiting steering authority
nontransferable_details: published CPG gains, species-specific envelopes, dimensional frequencies, exact gait or vortex phase, and task-specific routes
policy_translation: use the two observed joint rates to reconstruct a bounded lateral carrier velocity, subtract it only in normalized body-frame terminal course prediction, and leave the two-joint propulsive feedback law intact
falsification: reject if capture is lost, arrival and distance integral worsen beyond the exact-policy repeat band, wake coherence degrades, or joint-rate occupancy and normalized force or moment rise
