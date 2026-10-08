# Candidate diagnosis and hypothesis

The four sampled rollouts all report direct uniform still-water initialization
with `U_infinity=(0,0,0)`, capture, finite dynamics, and zero actuator contacts.
Their top-down rows show self-propulsion rather than advection: the body lays
down a coherent alternating reverse-street-like wake, translates steadily down
the target corridor, and makes a late target-side hook.  Their oblique rows
show the same compact three-dimensional Lambda2 structures remaining attached
to the traveling bend through capture, without visible wake collapse.  No
sampled rollout is a true failure; the most informative negative comparison is
the carrier-relief descendant, whose visually unchanged route captured latest
at `26.3615T`.  The best scalar descendant uses translation-consistent
line-of-sight side selection (`0.748338L`, `26.2460T`), while the earliest
arrival suppresses an opposing line-of-sight residual in a fixed middle/near
distance corridor (`0.748591L`, `26.2405T`).  The latter improves the `24T`
distance from the assigned parent's `1.8992L` to `1.8864L`, but raises peak yaw
moment slightly from `0.009789` to `0.009903`; all four retain the same peak
force, joint envelope, and coherent two-view wake.

The candidate preserves the evaluated oscillator, posterior lag/modulation,
redirect, line-of-sight response magnitude, and all feasibility guards.  Its
single change is a coordinate-free course-consistency projection: when speed
makes the body-frame velocity/target cross product observable, smoothly remove
only the fraction of the history-based line-of-sight residual that opposes the
direct course request.  Agreement and low-speed states pass through exactly.
Unlike the sampled course-priority descendant, the gate depends on sensory
conflict rather than a fixed distance corridor, so held-out target geometry
does not inherit a task-specific switching range.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and fish half-cycle steering
source_mechanism: preserve a self-sustaining traveling rhythm while bounded sensory feedback modulates only the useful steering half-cycle
transferable_invariant: when two target-response signals conflict, attenuate the corrective residual in proportion to the reliability of the direct kinematic course signal without weakening the propulsive carrier
nontransferable_details: published CPG gains, oscillator phases, robot geometry, species kinematics, dimensional frequencies, fixed routes, and exact vortex timing
policy_translation: use normalized body-frame speed and the velocity/target cross product to project only the opposing line-of-sight response toward zero; retain the two-joint state-feedback oscillator, posterior follower, redirect, and guards
falsification: reject if CFD loses capture or coherent two-view propulsion, worsens arrival or mean distance against the sampled course-priority result, raises force or yaw moment, creates actuator contacts, or produces no more than another milliscale-equivalent fixed-pose trace
