# Evidence-preserving multi-wake candidate

## Visual and completed-rollout diagnosis

- The assigned parent, the prefilled solver, and all four sampled solvers use
  the same policy (SHA-256 `452903db...9781`). Their trajectory CSVs and
  combined keyframe sheets are byte-identical, so the samples represent one
  reproducible nominal trajectory rather than four controller comparisons.
  Every compact observation confirms direct uniform still-water initialization
  with `U_infinity=(0,0,0)`, no cylinders, and no prewarm. Every rollout
  captures at `16.604496T`, after 237 moving-window shifts, at `0.743958L`,
  with scored distance integral `1.998146L` and score `-0.113729`.
- I inspected the combined sheet from release through capture in both views.
  The top-down row shows self-propelled left/down progress on a shallow
  target-crossing arc and an alternating red/blue mid-plane wake connected to
  the posterior body. The oblique row shows compact three-dimensional
  Lambda2 structures connected to the tail and traveled path through the
  crossing. With zero imposed flow this is propulsion rather than advection;
  neither view shows wake breakup, collision, boundary exit, instability, or
  a discontinuity attributable to moving-window recentering.
- The completed trajectory supports that reading. Distance falls from
  `12.327720L` to first crossing in 3019 steps; the final inertial velocity is
  `(-1.10010,-0.27006)U`. The active final beat, `1.132762U` crossing speed,
  `0.409227 rad` heading error, and `2.238745 rad/T` yaw rate do not establish
  a terminal defect in a no-dwell, first-crossing objective. The existing
  one-sided speed guard retains reversal commands despite contact with the
  released joint-speed envelope, and the inherited peak planar force/moment
  envelope remains about `0.037165/0.018356`.
- There is no distinct failed visual artifact to compare: all sampled and
  available inherited sheets are the same successful payload. The closest
  informative failure is therefore metric-level only. Inherited
  closure-qualified yaw-response release crossed one integration step earlier
  but made the crossing shallower and regressed distance integral and score to
  `0.744276L`, `1.998380L`, and `-0.114037`, without a meaningful feasibility
  or load benefit. The inherited local-flow phase subtraction similarly
  regressed to `0.745252L`, `1.999280L`, and `-0.115121`; completed target-rate,
  moment, posterior-relief, and projected-corridor variants yielded no
  surviving positive mechanism.
- Multiple completed generations have now selected and reproduced this exact
  controller without a new mechanism or semantic improvement. This triggers
  the structured bookshelf review. The shelf's traveling carrier, bounded
  steering asymmetry, response-residual, and approach-hold families are
  already embodied by the incumbent or covered by completed negative
  controls. The duplicate nominal trace identifies no new body-frame error
  signal for another feedback channel.

## Sole candidate and falsifiable hypothesis

Select the prefilled normalized body-frame two-joint policy byte-for-byte as
the workspace's sole candidate. It preserves the demonstrated full
posterior-lagged carrier, raw target geometry and anterior course center,
mean-preserving yaw and lateral-response demodulation, phase-compatible
posterior steering, smooth acceleration bound, and narrow one-sided
joint-speed guard. No sibling, terminal gate, storage-window cue, or
scalar-only gain retune is introduced.

This is an evidence-constrained null translation, not a same-worker claim of
CFD improvement. Formal evaluation should reproduce semantic capture, the
two-view connected wake, arrival, route cost, crossing depth, joint and action
envelope, force, and moment. Falsify preservation if that nominal envelope
does not reproduce. Reopen one compact bounded primitive only after a
completed nonduplicate or held-out pose, target, inflow, or imposed-wake
rollout isolates a repeatable body-frame propulsion, route, response,
feasibility, or load deficit.

bookshelf_consulted: true
source_domain: classical traveling-wave swimming and sensor-modulated robotic-fish direction tracking
source_mechanism: preserve a productive posterior-lagged rhythmic carrier and recruit a separate bounded residual only for an observed directional or disturbance-response deficit
transferable_invariant: productive carrier-correlated motion must be separated from persistent route or disturbance error before changing the carrier or adding feedback
nontransferable_details: published gains, dimensional frequencies, species-specific envelopes, exact vortex phases, fixed schedules, world-frame coordinates, and task-specific routes
policy_translation: null translation; retain the existing normalized two-joint carrier and response separation because all supplied physical payloads are the same successful trace and completed terminal or residual perturbations regress target cost without a feasibility or load benefit
falsification: test one bounded state-feedback primitive only after nonduplicate or held-out evidence isolates its target error, and reject it if capture, route cost, crossing depth, wake connectivity, joint feasibility, effort, force, or moment worsens

## Evidence boundary

All numerical and visual outcomes above belong to completed assigned, sampled,
or inherited evaluations. The selected candidate receives formal CFD only
after this worker exits. Exact nominal repetition demonstrates determinism,
not robustness to changed pose, target, inflow, or imposed wake; the absence
of a failed sheet is not treated as an image-level failure comparison.
