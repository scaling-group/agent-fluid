# Multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before editing

All four sampled evaluations satisfy the frozen evidence contract: they start
directly from uniform still water with `U_infinity=(0,0,0)`, contain no
cylinders or prewarm, remain finite under moving-window transport, and end in
`capture`. I inspected both the top-down vorticity row and the oblique
body/Lambda2 row in every combined keyframe sheet, then cross-checked the
views against `wake_metrics.csv`, `wake_diagnostics.json`, trajectory
histories, executable policies, assigned-parent guidance, and inherited worker
notes.

The four fish are visibly self-propelled rather than advected. Each develops a
coherent alternating top-down street and compact three-dimensional caudal
structures while following a broad target-directed curve into the capture
circle; no sampled sheet shows a collision, wake breakdown, or exit. The two
independent ungated geometry-scheduled policies are the strongest replicated
mechanism: `solver_02eaf03fe1d2` and `solver_8687829e1d01` capture in
`18.6505T` and `18.6835T`, score `-0.206060` and `-0.205783`, and have the same
executable controller despite comment-only differences. The response-coupled
prefill is visually indistinguishable and captures in `18.6615T`; its
`0.011T` separation from the first ungated result does not support multiplying
gait relief by yaw response.

The distinct terminal-lateral-velocity/range-relief composition
`solver_072da2f3a45e` keeps the wake coherent but follows a slightly lower,
longer approach and captures in `19.0520T`. It also leaves acceleration contact
near `61%/73%` and rate contact near `11%/15%`, matching the geometry-scheduled
family. Together with the inherited route-residual and joint-velocity phase
failures, this rules out another instantaneous velocity injection, velocity-led
phase estimate, or pointwise rate barrier.

The replicated geometry scheduler is useful redirect control, not demand
relief. In reconstructed phase statistics for its two rollouts, the
target-aligned anterior half-cycle has correcting yaw on `57.1--57.2%` of rows,
whereas the target-opposed half-cycle has correcting yaw on only
`10.2--11.1%`. Posterior acceleration still contacts its envelope on
`74.8--76.3%` of opposed-half-cycle rows. This provides an evidence-backed
location for a phase-preserving actuator experiment without changing target
sign, posterior lag, frequency, or mean-curvature allocation.

## Single-candidate policy hypothesis

Use the replicated ungated geometry-scheduled redirect/cruise policy as the
carrier. Retain its normalized body-frame target request, one-sided
correcting-yaw curvature release, opposite-sign mean curvature,
displacement-only half-cycle steering, traveling-bend oscillator, posterior
lag, and final acceleration projection. Add one compatible asymmetric-flapping
mechanism: preserve the evidenced `15%` misalignment-driven gait relief on the
whole beat, then allow at most `5%` additional relief only as observed anterior
displacement enters the target-opposed half-cycle. The target-aligned
half-cycle therefore remains exactly on the replicated carrier, and the total
relief never exceeds the already sampled `20%` envelope.

Expect capture and both coherent wake views to survive while less rhythmic
effort is spent in the half-cycle with little observed correcting response.
Falsify the mechanism if capture is lost; arrival or route quality leaves the
replicated capture band; the inherited downward/left exit returns; the
top-down street or oblique caudal structures lose coherence; posterior
acceleration/rate contact or planar loads fail to improve; or target-owned
steering sign, displacement phase, and the returned acceleration envelope are
not preserved. The new CFD outcome is unavailable to this worker and is not
claimed as evidence.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning with asymmetric flapping, bounded by classical traveling-wave propulsion
source_mechanism: redistribute rhythmic amplitude across observed beat halves while retaining a target-directed low-dimensional traveling rhythm
transferable_invariant: normalized body-frame target geometry owns turn sign, while observed joint displacement may reduce effort on a weak-response half-cycle without replacing the traveling wave or changing its clock
nontransferable_details: published gains, duty ratios, dimensional frequencies, robot geometry, motor models, species-specific kinematics, exact vortex phases, world-frame paths, and task-specific routes
policy_translation: preserve the replicated two-joint geometry-scheduled carrier and add a positive bounded displacement-phase gate that only increases gait relief on the target-opposed half-cycle; keep both curvature shares, posterior lag, and final projection unchanged
falsification: reject if capture or coherent wake is lost, route or arrival leaves repeat variability, the aligned half-cycle changes from the parent, demand or loads do not improve, steering sign reverses, phase is destabilized, or returned acceleration exceeds the owned envelope
