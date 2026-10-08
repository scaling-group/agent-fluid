# Evidence-constrained multi-wake policy selection

## Pre-edit visual diagnosis

- The four sampled policies and combined keyframe sheets are byte-identical to
  the prefilled candidate. Their compact observations all report direct
  uniform still-water initialization with `U_infinity=(0,0,0)`, no cylinders,
  no prewarm, and capture at `16.604496T` after 237 moving-window shifts. Each
  reaches `0.743958L`, has scored distance integral `1.998146L`, and scores
  `-0.113729`; the four samples are one reproducible physical trajectory, not
  four independent mechanism tests.
- I inspected the combined sheet from release through capture in both views.
  The top-down row shows self-propelled closure along a shallow curved route
  with an alternating red/blue mid-plane wake continuously connected to the
  posterior body. The oblique row shows compact alternating three-dimensional
  Lambda2 structures following the tail and traveled path through the final
  crossing. Neither row shows passive advection, wake breakup, a
  moving-window-shift discontinuity, collision, boundary exit, or instability.
- The completed diagnostics support the visual reading: distance falls from
  `12.3277L` to first crossing, final inertial velocity is
  `(-1.10010,-0.27006)U`, and the inherited peak planar force/moment envelope
  is about `0.0372/0.0184`. The active final beat and finite yaw are not a hold
  error because this task terminates at first crossing with no dwell.
- No distinct failed keyframe sheet exists in the sampled or inherited
  artifacts; all supplied images show this same successful trace. The valid
  informative-failure comparison is therefore metric-level: inherited
  closure-qualified yaw-response release crossed one step earlier but made
  crossing shallower and regressed distance integral and score to
  `0.744276L/1.998380L/-0.114037`; local-flow phase subtraction similarly
  regressed to `0.745252L/1.999280L/-0.115121`. Target-rate, moment,
  posterior-relief, and projected-corridor descendants also yielded no
  positive control implication.
- The assigned parent contains three consecutive completed selections of the
  same policy, trajectory class, and semantic result. That stagnation triggers
  the required bookshelf consultation. The shelf's traveling carrier,
  target-directed asymmetry, response residual, phase modulation, and
  terminal-hold families are already implemented or lack a diagnosed error;
  the current nominal duplicates provide no new bounded body-frame signal that
  identifies another mechanism.

## Sole candidate and falsifiable hypothesis

Retain the prefilled normalized body-frame two-joint controller byte-for-byte
as the sole candidate. It preserves the demonstrated full traveling-wave
carrier, raw target geometry, mean-preserving yaw and lateral-response
demodulation, phase-compatible posterior steering, smooth acceleration bound,
and narrow one-sided joint-speed guard. This is a null mechanism translation,
not scalar-only gain tuning and not a same-worker claim of CFD improvement.

Formal evaluation should reproduce semantic capture, arrival, route cost,
crossing depth, connected two-view wake, joint feasibility, effort, force, and
moment. Falsify preservation if that nominal envelope fails to reproduce.
Reopen one compact bounded primitive only when a completed nonduplicate or
held-out pose, target, inflow, or imposed-wake rollout exposes a repeatable
body-frame propulsion, route, response, feasibility, or load deficit.

bookshelf_consulted: true
source_domain: classical traveling-wave swimming and sensor-modulated robotic-fish CPG direction control
source_mechanism: preserve a productive posterior-lagged rhythmic carrier and recruit a separate bounded steering or disturbance mechanism only for an observed response deficit
transferable_invariant: carrier-correlated motion and storage recentering are not errors by themselves; preserve an evidenced traveling carrier until nonduplicate body-frame observations identify a persistent propulsion, route, or response deficit
nontransferable_details: published gains, dimensional frequencies, species-specific envelopes, exact vortex phases, fixed schedules, world-frame coordinates, and task-specific routes
policy_translation: null translation; retain the normalized two-joint carrier and response separation exactly because all supplied rollouts are one successful trace and completed terminal or residual perturbations worsen target cost without a feasibility or load benefit
falsification: test one bounded state-feedback primitive only after a nonduplicate or held-out rollout isolates its target error, and reject it if capture, route cost, crossing depth, wake connectivity, joint feasibility, effort, force, or moment worsens

## Evidence boundary

All numerical comparisons above come from completed assigned, sampled, or
inherited evaluations. The current candidate receives formal CFD only after
this worker exits. Exact nominal repetition establishes determinism, not
robustness to changed pose, target, inflow, or imposed wake, and the absence of
a failed image is not treated as an image-level comparison.
