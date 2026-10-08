# Phase-2 wake-policy candidate notes

## Inherited and sampled evidence

The assigned parent guidance preserves the common-seed diagnosis: the
joint-state Van der Pol carrier and posterior phase lag self-propel in direct
uniform still water, but the target-blind seed sweeps past alignment and exits
the upper boundary.  The inherited worker note proposed bounded posterior
mean curvature with bearing-trend release.  The four newly sampled completed
rollouts test three posterior mean-curvature variants and one both-joint
centered-bias variant, so they now provide the evidence for the next mechanism.

All four rollouts satisfy the intended evidence contract: direct uniform
`U_infinity=(0,0,0)`, no cylinders, no prewarm, and finite
`left_domain` termination.  The top-down and oblique rows agree that the
posterior-only policies retain self-propulsion and alternating three-dimensional
wake structures.  The strongest sampled policy (`solver_7afa3aa3b5d0`) moves
substantially left, reducing distance from `12.328L` to `9.141L` by `13.129T`,
but its path remains above the target and ends at the upper boundary.  Its
computed body-frame bearing reaches `-1.330 rad`, absolute yaw rate peaks at
`3.097 rad/T`, joint-rate near-limit occupancy is about `10.7%`, and at least
one raw acceleration request exceeds `1800 deg/T^2` on about `78.4%` of trace
samples.  Thus its better score is useful propulsion and surge, not solved
target locking.

The two milder posterior-bias policies terminate sooner at `9.19--9.35T` and
only reach `11.88L` and `11.65L`; adding measured yaw rate inside the static
tail-offset command does not change the upper-exit topology.  More decisively,
the both-joint centered-bias policy visibly loses the alternating carrier,
settles toward a slowly varying bend, and regresses to `13.403L`.  It should
not be repaired by another head/tail bias-gain adjustment.  Across the sampled
set, target-responsive static curvature is directionally better than the
target-blind seed only when it leaves the anterior oscillator untouched, but
it does not supply enough phase-specific reverse-turn authority to contain the
large beat-scale yaw oscillation.

## Policy hypothesis recorded before editing

Retain the strongest sampled joint-state carrier exactly, but replace its
static posterior mean-tangent offset with one bounded half-cycle asymmetry
mechanism.  Infer the posterior beat side continuously from the lagged tail
target already encoded by `(phi1, phi_dot1)`.  Body-frame bearing plus its
short-window trend scales opposite half-cycles in opposite directions: the
requested turn strengthens the useful posterior excursion and weakens the
other, while zero target error restores the symmetric traveling wave.  This
keeps steering synchronized to observed oscillator state without a clock,
hidden stage, world coordinate, or copied vortex phase.  Bound the returned
accelerations at the declared actuator envelope so the policy itself does not
emit the sampled variants' persistent out-of-envelope requests.

Expected evaluation evidence is an alternating 3D wake with the strong
policy's leftward progress, but a smaller sustained body-frame bearing and no
upper-boundary exit near `9--13T`.  Falsify the mechanism if it preserves the
same upper-exit topology, fails to reverse the negative bearing trend, raises
joint-limit occupancy or load spikes, or sacrifices the strong policy's
distance progress without a better termination class or a meaningfully
different useful trajectory.

bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping and duty-ratio turning superposed on classical phase-lagged fish propulsion
source_mechanism: use beat-side-dependent posterior amplitude asymmetry to turn while retaining a traveling propulsive wave
transferable_invariant: a slow target-relative turn request can strengthen one observed oscillator half-cycle and weaken the opposite half-cycle, returning continuously to symmetric propulsion as alignment recovers
nontransferable_details: published gains, duty ratios, clock-driven CPG phase, species-specific envelopes, dimensional cadence, exact vortex phase, and task-specific routes
policy_translation: map bounded body-frame bearing plus its observed window trend to a smooth scale on the lagged posterior target, with beat side inferred only from current joint state
falsification: reject if bearing containment and termination do not improve, if wake coherence or useful progress collapses, or if joint-limit occupancy and hydrodynamic loads worsen
