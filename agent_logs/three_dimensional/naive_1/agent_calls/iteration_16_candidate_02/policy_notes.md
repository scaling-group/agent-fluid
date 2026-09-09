# Wake Policy Candidate Notes

## Evidence diagnosis

- All four sampled episodes use direct uniform still-water initialization at
  `U_infinity=(0,0,0)` and terminate in capture at `18.6505--18.7550T` with
  mean distance `2.09340--2.09542L`; there is no sampled failure-class rollout
  in this parent set.
- The combined sheets agree with those metrics. From release to capture, the
  fish self-propels toward the target behind a coherent alternating top-down
  street; the oblique row retains compact caudal Lambda2 structures without a
  collision, domain-exit, or instability precursor. Differences among the
  sheets are small enough that raw score does not identify a new wake topology.
- The assigned response-coupled parent captures at `18.6615T`, mean distance
  `2.09362L`, and final distance `0.74900L`. Geometry-only envelope schedules
  span `18.6505--18.7550T` and `2.09340--2.09542L`, so coupling the envelope to
  correcting yaw is inside the repeat band rather than an attributable gain.
- The common unresolved feature is actuator pressure. Across the four sampled
  trajectories, public accelerations sit at the final `31.4159 rad/T^2`
  projection on about `60.6--61.0%` of anterior rows and `73.0--73.2%` of
  posterior rows; joint-rate contact remains about `10.9--11.2%` and
  `14.8--15.1%`. Prior outward rate barriers lost capture, so another
  pointwise rate taper is not supported.
- No inherited `logs/optimize/` artifact was present in this workspace; the
  durable parent guidance and the four sampled CFD artifacts are the available
  inherited evidence.

## Policy hypothesis

Keep the assigned parent's oscillator, posterior lag, target-signed
differential curvature, displacement-only half-cycle allocation, one-sided
response release, envelope schedule, and every numerical parameter unchanged.
Replace only independent per-joint acceleration clipping with a single bounded
ray projection: when either raw acceleration exceeds the envelope, multiply
both by the same positive scale. This retains the instantaneous two-joint
command direction and relative anterior/posterior allocation while satisfying
the exact public acceleration limit. It is a control-allocation mechanism, not
a scalar gain retune.

Expected evidence is capture with the existing target-directed top-down street
and compact caudal 3D structures, while the paired command spends less time in
the independently flattened corner of the action box and rate contact does not
increase. Reject the mechanism if it loses capture, leaves the
`2.0934--2.0955L` route band, weakens the wake, or increases rate contact; a
lower count of independently clipped commands alone is not improvement.

bookshelf_consulted: true
source_domain: classical fish-swimming reactive-thrust models and coupled rhythmic robot-fish control
source_mechanism: a directed traveling bend with posterior lag and coordinated low-dimensional joint drive
transferable_invariant: preserve the direction and relative allocation of the two-joint traveling-bend command when enforcing a hard actuator envelope
nontransferable_details: published gains, species-specific envelopes, dimensional beat rates, exact body waves, vortex phases, and task routes
policy_translation: apply one positive state-dependent scale to both raw joint accelerations whenever their maximum magnitude exceeds the normalized acceleration limit
falsification: reject on loss of capture, route-band departure, degraded top-down or 3D wake coherence, or increased rate contact even if command clipping statistics look smaller
