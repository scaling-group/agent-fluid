# Candidate diagnosis and hypothesis

The four sampled evaluations are direct-uniform, quiescent-water captures.  The
three phase-neutral-yaw/carrier-first policies reproduce the same `23.9305 T`,
`0.74819 L` capture and the same combined keyframe sheet.  Their top-down row
shows a clean alternating wake building behind the posterior body by `4 T` and
remaining coherent through the target-directed arc; their oblique row confirms
compact three-dimensional paired structures rather than passive advection.
The common-mode gait-rejection variant preserves that wake and improves capture
to `23.6390 T`, mean distance to `2.44217 L` from `2.45000 L`, and score to
`-0.54451` from `-0.55178`.  Its benefit is not a launch improvement: distance
is worse at `2 T` (`12.2844` versus `12.2755 L`), `4 T` (`11.9833` versus
`11.9354 L`), and `12 T` (`8.4411` versus `8.4209 L`), but better by `20 T`
(`3.2502` versus `3.3791 L`).  Thus the sampled positive mechanism belongs to
middle/late steering, while the visible sparse opening wake and small early
distance change remain the isolated opportunity.  No current sampled rollout
has a failure termination; the informative failure boundary is inherited from
the transferred carrier, which approached to `4.7800 L`, then diverged and
left the domain.  The completion-gated redirect, phase-neutral route feedback,
and carrier-first allocation that resolved that failure are protected.

Policy hypothesis: start from the best common-mode gait-rejection capture and
add one posterior traveling-bend initiation term.  When normalized body speed
and joint-speed phase activity are both near zero, extend the posterior joint
on the already observed opposite-sign side of the anterior bend.  Gate the term
continuously out as either body motion or joint cycling appears, and make it
yield to target-steering load.  This uses the nonzero released joint shape to
start a directional head-to-tail wave without a clock, elapsed-time stage, or
global carrier increase.  It should strengthen the first visible posterior
wake and improve distance at `2--4 T`, while leaving the established route
controller effectively unchanged.  Reject it if early distance does not
improve, if capture/mean distance regress, if it reactivates during established
turning, or if wake coherence, speed/acceleration-limit residence, force, or
yaw moment exceeds the sampled envelope materially.

bookshelf_consulted: true
source_domain: classical elongated-body swimming and state-feedback rhythmic locomotion
source_mechanism: a nonreciprocal traveling bend with posterior kinematic emphasis, represented by a joint-state oscillator rather than a clocked waveform
transferable_invariant: initiate thrust by giving the observed anterior-to-posterior bend a direction and tail emphasis, then release extra authority once locomotor response is present
nontransferable_details: published gains, dimensional frequencies, species envelopes, full-body waveforms, exact vortex phases, and task-specific routes
policy_translation: use body-frame speed and dimensionless joint-rate activity to gate a bounded posterior target displacement proportional to the observed centered anterior bend; attenuate it with normalized steering load and retain the proven common-mode guidance and carrier-first projection
falsification: reject if `2--4 T` closure is not better or if later capture, mean distance, coherent two-view wake, actuator residence, force, or moment regresses
