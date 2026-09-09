# Predictive common-carrier rate barrier

## Prior evidence and visual diagnosis

All four sampled episodes satisfy the direct uniform still-water contract and
capture. The strongest finite sample is the prefilled uncancelled-work
governor: it advances every `10/8/6/4/2/1L` milestone to
`6.496/8.938/11.220/13.459/16.027/17.347T`, captures at `17.688T`, and lowers
the distance integral to `1.96419L`. Its top-down row shows self-propelled,
target-directed motion with a coherent alternating wake rather than passive
advection; the oblique Lambda2 row shows the same traveling three-dimensional
wake remaining organized through the terminal bend. The slowest sampled
carrier guard also retains a coherent wake and capture, so there is no sampled
non-capture failure in this batch; it is used as the informative regression at
`18.111T/2.00209L`.

The fastest route does not validate the inherited mechanism as a rate/load
protector. Relative to the shared phase-preserving governor, its head path
grows from `12.198L` to `12.330L`, mean absolute commands change from
`18.84/17.54` to `18.34/17.16 rad/T^2`, residence above 90% of the joint-rate
envelope rises from `17.6/13.7%` to `18.6/13.4%`, and peak planar force/yaw
moment rises from `0.02729/0.01435` to `0.03198/0.01651`. The peak occurs at
`9.592T`, still `7.445L` from capture, during a large posterior outward pulse:
`qdot2=3.799 rad/T` and `a2=27.63 rad/T^2`. A guard that waits until the
instantaneous rate exceeds 98% of the envelope cannot act on that impending
excursion.

## Policy hypothesis

Preserve the complete response-aware capture scaffold and exact
carrier/steering decomposition. Replace the reactive rate-times-work trigger
with one predictive common-carrier barrier. For each joint, use normalized
rate margin and the outward components of the carrier and steering
accelerations to estimate whether a short, gait-phase-derived lookahead would
consume the margin. The most restrictive joint sets one common carrier scale,
while target-conditioned steering and inward carrier reversal remain
available. This is a feedback-architecture test, not a steering, gait, or
terminal scalar tune.

Falsification: reject the mechanism unless CFD retains capture, the coherent
two-view wake, and the `17.688--17.990T` timing class while lowering the
prefill's `18.6/13.4%` greater-than-90%-rate residence and
`0.03198/0.01651` peak force/moment without a path wider than `12.330L` or a
new terminal hook. If it slows into the older guarded class without recovering
headroom, restore the sampled uncancelled-work governor and test load feedback
separately.

bookshelf_consulted: true
source_domain: classical slender-body swimming and low-dimensional CPG control
source_mechanism: phase-lagged anterior-to-posterior traveling bend
transferable_invariant: preserve the relative phase of the two-joint propulsive carrier when feedback withdraws rhythmic authority
nontransferable_details: published gains, species-specific envelopes, dimensional frequencies, exact vortex phase, and task-specific routes
policy_translation: derive a bounded common carrier scale from normalized joint-rate margin, carrier direction, and state-feedback gait phase while leaving body-frame target steering residuals intact
falsification: reject if the wake loses its traveling structure, capture/timing regresses outside repeat variation, or joint residence, load peaks, path width, or terminal yaw worsens
