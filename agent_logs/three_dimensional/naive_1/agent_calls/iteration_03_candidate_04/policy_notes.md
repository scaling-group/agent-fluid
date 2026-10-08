# Phase 2 candidate diagnosis and hypothesis

## Evidence read before the edit

All four sampled evaluations use the required direct uniform still-water
initialization (`U_infinity=[0,0,0]`), with no cylinders or prewarm snapshot.
The combined sheets therefore show self-generated motion.  In the naive
prefill's top-down row, the alternating caudal wake initially carries the fish
left, but the body and wake curl toward the upper boundary; the oblique row
confirms a coherent three-dimensional posterior wake rather than missing
propulsion.  The trace agrees: distance improves from `12.328L` to `12.078L`,
then worsens to `12.380L` at the upper exit at `8.547T`.

The strongest sampled controller is the anterior velocity-gated half-cycle
law (`solver_8596fba5898a`).  Its two visual rows retain the alternating 3D
wake and show more leftward translation than the seed (`1.49L` versus about
`0.93L`).  Its minimum/mean/final distances improve to
`11.782/11.823/11.797L`, and it survives to `8.981T`, so phase-conditioned
anterior asymmetry is a useful mechanism.  It does not solve route control:
the same visible clockwise curl reaches center `y=15.202L` and terminates
`left_domain`.  Near closest approach, body-frame bearing is already strongly
negative while lateral body velocity is positive, a persistent slip away
from the requested target side.  Both joint rates still touch `260 deg/T`,
and raw acceleration requests exceed the actuator bound on about 44% of
samples, versus roughly 32--34% in the seed.

Actuator placement also matters.  Posterior-only half-cycle scaling reaches
only `12.006L` and finishes at `12.205L`; the shared anterior/posterior
aligned residual reaches `12.140L` and finishes at `12.686L`.  All three leave
through the upper boundary.  The inherited prediction that one-sided
half-cycle drive would change that topology is therefore only partially
supported: it improves target progress and preserves the carrier, but does
not produce enough reversing moment after bearing changes sign.

## One candidate hypothesis

Keep the seed's zero-centered anterior oscillator and posterior lag.  Replace
the best candidate's one-sided anterior steering residual with bounded
push--pull half-cycle work: a target-relative residual proportional to
observed joint-1 speed accelerates motion toward the requested bend and brakes
motion toward the opposite bend.  Because it vanishes at zero joint speed, it
cannot create the static bent equilibrium seen in the failed moving-mean
controllers.  Add only compatible body-frame slip feedback to the turn
request: lateral velocity toward the target unloads steering, while the
best rollout's opposite-sign slip strengthens the correction.  Use a lower
residual bound than the one-sided candidate because it acts during both
moving halves of the carrier.

The expected semantic change is preservation of the alternating wake and
leftward propulsion while bearing reversal produces an earlier counter-turn,
avoiding the upper exit.  Falsify the mechanism if closest/final distance does
not beat `11.782/11.797L`, the same upper-exit topology remains, the carrier
collapses, or rate/acceleration saturation becomes more persistent.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning and biological asymmetric flapping
source_mechanism: redistribution of propulsive work between target-selected half-cycles of a continuing rhythm
transferable_invariant: strengthen motion toward the requested bend and oppose motion toward the other bend while preserving the zero-centered traveling wave
nontransferable_details: published gains, dimensional beat frequency, species-specific kinematics, prescribed duty ratios, exact vortex phases, and task-specific routes
policy_translation: normalized body-frame bearing and lateral slip select a bounded turn request; observed anterior-joint speed gates a signed residual during both moving half-cycles while the inherited posterior lag remains unchanged
falsification: reject if the alternating wake or leftward propulsion collapses, actuator saturation grows, closest/final distance fails to improve, or the clockwise upper-boundary exit persists
