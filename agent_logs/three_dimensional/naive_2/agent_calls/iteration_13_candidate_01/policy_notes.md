# Carrier-separated course prediction candidate

## Evidence and visual diagnosis before editing

- All four sampled evaluations use direct uniform still water with
  `U_infinity=(0,0,0)`, no cylinders, and no prewarm.  Their top-down rows
  show body-connected alternating vorticity and their oblique rows show
  compact three-dimensional Lambda2 structures.  The motion is self-propelled
  rather than advected, and none of the outcomes is a numerical instability.
- The prefilled predicted-miss controller is the first sampled semantic
  success: it captures at `16.0105T` and `0.7477L`, keeps both joints below
  `40 deg`, and limits peak normalized planar force/moment to
  `0.0347/0.0172`.  Its compact alternating wake remains connected through
  capture.  In contrast, the three full-circle/response-gated alternatives
  preserve visible propulsion but miss by `2.595--4.650L` and exit the left
  boundary after broad late arcs.  Two of those failures spend
  `24.2--30.5%` of samples with the posterior joint beyond `40 deg` and reach
  peak planar force `0.488--0.753`.  Preserve the capture controller's carrier,
  course geometry, predictive mean bend, and smooth command envelope.
- Capture does not make every internal signal clean.  The successful rollout
  reaches the joint-rate limit on `13.2%/13.5%` of logged head/tail samples,
  and its instantaneous constant-course miss changes by more than `2L` over
  parts of one `0.55T` beat even though the macroscopic approach remains
  targetward.  For example, reconstructed center-course miss moves from about
  `-0.88L` at `13.90T` to `+1.50L` at `14.12T`.  This is capable of alternating
  the sign and strength of the predictive terminal correction.
- A dry diagnostic fit, used only to identify a reusable observation
  mechanism, subtracts a centered one-carrier-period mean from body-lateral
  velocity and regresses the residual on normalized joint state.  Head angle
  plus head rate explain `72.0%, 87.4%, 92.0%, 78.3%` of that beat-scale
  residual in the `66d`, `815`, capture, and `ec8` samples respectively.
  The coefficient signs agree across all four samples.  This supports removing
  a bounded joint-state carrier estimate from the observed lateral velocity;
  it does not support copying a trajectory, using an offline moving average in
  the policy, or changing the evidenced physical carrier.

## Single candidate hypothesis

Keep the successful predicted-miss terminal-curvature architecture unchanged
except for one observation mechanism.  Estimate the beat-correlated component
of normalized body-lateral velocity from current head-joint angle and rate,
then subtract it only in closest-approach geometry.  Continue to use raw
measured target-versus-course error for ordinary steering and measured speed
to fade that feedback at startup; leave the oscillator, posterior lag,
mean-bend actuator, half-cycle steering, and actual propulsion command
untouched.  This should make predicted cross-track miss persist across a beat
instead of alternately recruiting and releasing terminal curvature.

Support requires capture with no slower arrival, or a materially cleaner
target-directed approach with lower joint-rate occupancy while retaining the
low loads and coherent alternating wake.  Falsify if capture is lost, arrival
is delayed, the compensated course turns to the wrong target side, startup
creates a false course request, or angle/rate/load occupancy worsens.  The
current worker runs no CFD, so these remain prospective tests.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and biological burst redirect
source_mechanism: separate predictable rhythmic carrier motion from the slower observed direction error before recruiting a bounded redirect
transferable_invariant: preserve the propulsive rhythm while target-course feedback acts on a carrier-separated response and releases when the macroscopic response is corrective
nontransferable_details: published gains, clock phase, robot linkage geometry, species kinematics, dimensional frequencies, exact vortex phases, and task-specific routes
policy_translation: subtract a bounded normalized joint-state estimate of beat-correlated lateral velocity only when computing predicted miss and time to closest approach, while leaving ordinary course steering and the evidenced two-joint carrier unchanged
falsification: reject if capture, arrival, wake coherence, target-side course, joint reserve, and normalized loads do not remain jointly favorable

## Dry validation only

The first algebraic composition applied the carrier subtraction to ordinary
course steering as well as prediction.  Replaying the captured rollout's
recorded states changed far-field action by `1.547 rad/T^2` on average, so that
composition was rejected before evaluation: it disturbed a behavior the CFD
already supports.  In the retained composition, only closest-approach
prediction uses the separated velocity.  The same replay changes far-field
action by only `0.010 rad/T^2` on average and near-`3L` action by
`0.497 rad/T^2`, confirming that the mechanism is both localized and
semantically active.  Recorded-state replay cannot predict the new trajectory.

A deterministic `58,320`-state grid spanning joint phase/rate, fore/aft and
left/right targets, body velocity, and distance produced finite commands
strictly inside the smooth `30 rad/T^2` envelope and exact reflection
equivariance (maximum error `0.0`).  The mandated guidance-materiality, Julia
policy-contract/schema, and editable-boundary checks all pass.  These are dry
checks, not CFD evidence; the next formal evaluation must decide every
trajectory, capture, wake, load, and actuator falsifier above.
