# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

All four sampled rollouts satisfy the experiment contract: direct uniform
still-water initialization, zero background velocity, no cylinders, and
finite `capture` termination.  The complete combined sheets for the broad
closing-deficit relief and the assigned phase-qualified parent show active
self-propulsion rather than advection: alternating mid-plane vortices remain
attached to a long wake, and discrete oblique Lambda2 structures persist from
the developed gait through capture.  The top-down route and wake topology are
nearly unchanged across the terminal schedulers.  The translation-alignment
sample has a blank oblique row, so it supports only a numerical/top-down
comparison, not an independent three-dimensional wake claim.

The response-plus-anterior-stroke parent is the strongest sampled finite
policy.  It captures at `24.310009T`, with score-metric mean distance
`2.223959L` and peak normalized force/moment `0.031649/0.016385`.  Applying
the same 20% closing-deficit relief throughout both strokes captures at
`24.326511T` with mean distance `2.224097L`; replacing closure with normalized
translation alignment captures later at `24.343010T` with mean distance
`2.224020L`.  Thus the reusable signal in this sample is joint-phase control
allocation, not a smoother terminal response variable.  A replay of the
assigned parent below `0.8L` also shows that the existing anterior useful-stroke
gate and a smooth posterior carrier/rudder reinforcement gate agree at the
final crossing but differ earlier in the beat.  This permits a compact test of
whether relief should be restricted to the part of the traveling bend where
the posterior carrier and mean rudder load reinforce one another.

## Policy hypothesis

Preserve the entire evidenced route controller, traveling carrier, rudder
sign, closing-deficit sensor, and 20% relief ceiling.  Add one actuator-aware
phase condition: compute the unsteered lagged posterior carrier from joint
state, form a smooth gate for carrier/rudder reinforcement, and apply terminal
relief only where that gate overlaps the already successful target-side
anterior stroke.  This is intended to remove over-allocated mean tail load
without relieving the rudder during a carrier-opposed phase that contributes
to wave reversal.  It changes no far-route command and does not suppress the
rhythmic carrier.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG and asymmetric-flapping control
source_mechanism: sensory modulation of steering allocation within a continuing rhythmic carrier
transferable_invariant: gate a bounded steering residual by observed oscillator phase so route control does not replace the traveling propulsive bend
nontransferable_details: published gains, clock phase, robot linkage kinematics, species envelopes, exact vortex phase, and task-specific routes
policy_translation: multiply the evidenced closing-deficit and anterior useful-stroke relief by a smooth joint-state gate that is high only when the lagged posterior carrier reinforces the target-signed rudder
falsification: reject if capture is later than 24.310009T, score-metric mean distance exceeds 2.223959L, the pre-terminal route changes, or wake coherence, rate-cap occupancy, action effort, peak force, or peak moment worsens
