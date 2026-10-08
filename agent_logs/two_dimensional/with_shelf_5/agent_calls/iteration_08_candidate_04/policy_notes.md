# Multi-wake target-policy candidate notes

## Evidence-first diagnosis

The shared prewarm sheet establishes the common initial condition: four mature,
interacting vortex streets reach the held fish at the upper-right release
location.  The inherited `left_domain` failure provides the control contrast.
Its released sheet shows no sustained targetward turn before the fish leaves
the right boundary after `16.7914` time; head displacement is
`(2.175,-0.869)L`, progress is `-0.1471`, and mean streamwise velocity differs
from local flow by only `0.0154U`.  The small visible bend and low relative
crossflow agree with advection rather than controlled upstream swimming.

Three sampled copies of the prefilled controller are dynamically identical.
Their released sheets show an immediate correct-sign redirect, a coherent
posterior wake, and a nearly straight upstream-diagonal traverse into the
merged wakes and target.  They reach the `0.75L` boundary after `43.9505`, with
`2.1391L` mean distance and score `-0.259248`.  Mean velocity
`(-0.2471,-0.1020)` versus local flow `(-0.1342,-0.1556)` confirms a material
self-propelled upstream component.  This is strong evidence to preserve the
bearing-to-curvature command, traveling-bend carrier, posterior lag, and
target-favored half-cycle bias.

The remaining limitation is cap-dominated actuation: both joints attain the
`260 deg/time` rate and `1800 deg/time^2` acceleration limits.  The sampled
posterior rate guard lowers RMS lateral force/moment from `49.44/701.26` to
`43.46/649.26`, but still reaches both caps, delays arrival to `44.2420`, raises
mean distance to `2.1450L`, and worsens score to `-0.265017`.  Inherited
response-conditioned release lowers loads further but delays capture to
`46.6730`; restricting that release to a small-bearing window reaches in
`43.8955` yet raises force/moment to `55.12/764.85` and also scores worse.
These results do not support more threshold tuning of terminal relief or a
larger scalar drive.

## Policy hypothesis

Change one timing mechanism while preserving the evaluated authority.  The
current half-cycle gate uses centered anterior angle alone, even though angle
and normalized angular velocity together identify oscillator phase.  Replace
that position-only signal with a modest phase-leading combination
`head_wave + k*qd1/omega`.  For either turn sign this starts the bounded
posterior steering bias while the anterior bend is moving into the favored
side and withdraws it before the bend has fully reversed.  A sinusoidal
position-plus-velocity phase shift retains a half-cycle duty fraction and thus
approximately preserves the existing cycle-average posterior curvature; no
steering or propulsion gain is increased.

Expected evidence is retention of the direct diagonal and target success, with
better mean distance, arrival, or command/load efficiency than the prefill
because posterior steering is aligned more effectively with the traveling
bend.  Reject the mechanism if it restores the broad `93`-time dogleg, delays
or loses capture, increases cap/load evidence without better distance
progress, or remains indistinguishable from the position-only gate.

bookshelf_consulted: true
source_domain: robotic-fish asymmetric CPG turning and elongated-body reactive propulsion
source_mechanism: infer beat phase from oscillator position and velocity before allocating target-directed posterior asymmetry
transferable_invariant: phase-selective steering should use local oscillator phase to place a bounded posterior bias within the traveling bend while preserving mean curvature and carrier dynamics
nontransferable_details: published gains, dimensional frequencies, robot or species kinematics, exact duty ratios, vortex phases, cylinder coordinates, and task-specific routes
policy_translation: retain the sampled bearing command and two-joint carrier, but phase-lead the posterior half-cycle gate with normalized anterior joint velocity under a parameter-owned bounded state-feedback term
falsification: reject if the direct diagonal or capture is delayed or lost, mean distance and effort do not improve, or force, moment, and saturation increase without better progress

## Pre-evaluation verification

The required guidance-semantic, Julia policy-contract, parameter-schema, and
solver-boundary checks pass.  A no-CFD sweep over `3,375` combinations of
distance, bearing, joint angle, and joint rate returns finite actions; the
anterior action remains exactly parent-identical, the phase lead changes the
posterior action in `2,160` states, and zero anterior rate exactly recovers the
parent gate.  A full sinusoidal phase sample retains gate mean `0.5`, and the
zero-error joint equilibrium remains zero.  No formal CFD was run; performance
remains a hypothesis for the post-worker evaluation.
