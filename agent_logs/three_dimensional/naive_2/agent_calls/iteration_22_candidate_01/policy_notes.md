# Lagged-wave terminal follow-through candidate

## Evidence and visual diagnosis before editing

All four sampled rollouts satisfy the frozen evidence contract: direct uniform
initialization in still water with `U_infinity=(0,0,0)`, no cylinders, and no
prewarm. I inspected both rows of the combined sheets for the strongest finite
capture and the informative approach-hold failure. The captured fish follows a
nearly direct route behind compact alternating top-down vorticity and localized
oblique Lambda2 structures; it is self-propelled rather than advected. The
approach-hold failure initially sheds an organized wake, but carrier relief lets
static steering dominate: the body and wake curl into a large turn, both joints
eventually lock at `-45 deg`, and the fish exits high-left. Its `2.703L` closest
pass, `36.3%` sampled joint-angle occupancy beyond `40 deg`, and peak normalized
planar force/moment of `0.713/0.300` reject broad terminal braking.

Three sampled executions of the prefilled predicted-miss policy capture at
`15.983--16.016T` and `0.7472--0.7500L`. Their compact-wake trajectories have
no sampled joint-angle dwell beyond `40 deg` and peak normalized planar
force/moment of only `0.033--0.037/0.017--0.019`. This supports preserving the
full traveling-bend carrier, body-frame course prediction, mean-bend handoff,
and ungated posterior pulse. It is not robust-margin evidence: all three stop
at the capture threshold while still translating at roughly `1.15--1.18L/T`.

The assigned parent's inherited logs provide two closer architectural
falsifications. Releasing the posterior pulse when carrier-separated yaw looked
corrective missed at `1.01175L` and exited left; subtracting an evidence-fitted
joint-rate sway model from the predictor also missed at `1.02506L` and exited
left. Both retained low loads and coherent direct approach wakes. Thus neither
yaw-based release nor a fitted course estimator improved the semantic outcome,
and this candidate does not repeat either mechanism.

At the three sampled capture crossings, the head-joint rate is near reversal
(`0.06--1.02 rad/T` in magnitude) while the lagged posterior joint is still
moving at `4.01--4.54 rad/T`. The current pulse is gated only by head-joint
speed, so it weakens sharply and can nearly disappear during an observed
posterior active stroke even though the remaining body-frame predicted miss is
`0.62--0.65L`. This is a phase-allocation boundary, not evidence for more
carrier amplitude or a scalar gain search.

## Single candidate hypothesis

Preserve the evaluated policy and its parameters, but replace the anterior-only
mid-stroke pulse gate with a lagged-wave phase envelope. The envelope keeps the
existing head-midstroke contribution and extends it only when the posterior
joint is moving away from the target-signed terminal bend; taking the maximum
of those two normalized phase signals avoids double authority. The same bounded
posterior target pulse should then follow the physical traveling wave through
anterior reversal without braking the carrier, adding terminal steering where
the sampled captures show an unserved lagged stroke.

Falsify this candidate if it loses capture, retains only threshold-level
closest approach, changes the direct compact-wake route, creates `>40 deg`
joint dwell or materially larger force/moment peaks, or repeats a left-domain
near miss. A nominal capture alone would reproduce, not validate, the proposed
phase allocation; the useful result would be greater capture margin or repeat
robustness with the established wake/load class.

bookshelf_consulted: true
source_domain: Lighthill-style posterior reactive thrust and robotic-fish phase-lag or half-cycle steering
source_mechanism: concentrate a bounded target-conditioned correction in the lagged posterior stroke while preserving the traveling propulsive rhythm
transferable_invariant: steering phase should follow the observed traveling wave rather than vanish solely because the anterior joint reaches reversal
nontransferable_details: published gains, species-specific envelopes, robot linkage geometry, dimensional frequency, exact vortex phase, and task-specific routes
policy_translation: form a normalized state-feedback phase envelope from anterior joint speed and target-opposed posterior joint speed, then gate the existing body-frame predicted-miss posterior target pulse by their bounded maximum
falsification: reject if capture margin or termination fails to improve together with direct trajectory, compact wake, joint reserve, and low normalized loads

The candidate's CFD evaluation occurs only after this worker exits. All
outcomes above are prior sampled or inherited evidence, not claims about the
new policy.
