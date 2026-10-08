# Candidate diagnosis and hypothesis

The sampled rollouts all use direct uniform still-water initialization and all
capture, so the useful comparison is the strongest finite result against the
most informative regression rather than a change in termination class. The two
byte-identical local-consistency artifacts score `-0.064599` and capture at
`18.0125T`; the assigned parent scores `-0.072146` at `17.8695T`, while the
consensus-qualified reserve scores `-0.073937` at `17.7870T`. Both inspected
combined sheets show sustained self-propulsion: their top-down rows retain an
alternating downstream vortex street from release to capture, and their oblique
rows retain organized three-dimensional Lambda2 structures without visible
wake collapse or passive advection. Peak planar force and yaw moment also stay
in the same `0.039--0.041` and `0.019--0.020` classes.

The score-positive local guard preserves first-`3T` speed near `0.252U` and
improves mean score-distance, but it expands center path/cross-track from the
parent's `13.0071L/0.6102L` to `13.2330L/0.7417L` and lowers mean near-target
course alignment from `0.787` to `0.664`. The consensus candidate tightens the
route to `12.9495L/0.5193L`, yet its first-`3T` speed falls to `0.2459U` and it
gives back the score gain. Thus another closure or translation gate would
repeat a demonstrated tradeoff. The local guard's consistency reference is the
combined posterior target, so mean-curvature steering can veto or admit an
otherwise identical oscillatory work stroke. That is a specific coupling to
remove while leaving the carrier, head-range closure qualifier, posterior work
sign, steering law, and actuator governor intact.

Candidate hypothesis: start from the reproducible local-consistency policy,
but compute the one-sided work-direction guard from the zero-mean lagged
posterior wave target. The normalized product of wave tracking error and
measured posterior velocity is reflection invariant and uses only current
two-joint state. It withdraws added positive work when the posterior joint is
moving away from the propulsive wave, without treating the bounded steering
offset as oscillator phase. Falsify this candidate if it loses capture, erases
the early/mean-distance benefit, fails to reduce the `13.2330L/0.7417L`
path/cross-track, raises the established load class, or disrupts either visual
wake view.

bookshelf_consulted: true
source_domain: robotic-fish coupled-oscillator control and classical traveling-bend propulsion
source_mechanism: coordinate posterior phase lag as an oscillatory gait variable while steering is supplied as a separate bounded mean offset
transferable_invariant: reinforce only state-observed posterior motion that is consistent with the zero-mean traveling-wave component, keeping rhythmic phase and mean curvature as distinct control roles
nontransferable_details: published CPG gains, clock phase, species-specific envelopes, dimensional cadence, exact vortex phase, and task routes
policy_translation: use normalized joint angle and rate to gate the existing posterior work pump against its lagged wave target, excluding mean-tail steering curvature from the consistency reference
falsification: reject if capture or early closure is lost, path and cross-track do not contract, loads rise, or the coherent top-down and oblique wake class degrades
