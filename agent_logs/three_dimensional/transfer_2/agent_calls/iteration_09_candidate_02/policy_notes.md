# Candidate wake-policy notes

## Evidence diagnosis before policy edit

The four sampled L64 rollouts all satisfy the direct-uniform still-water
contract (`U_infinity=0`) and all terminate in capture, so there is no current
semantic failure to repair.  In both the top-down mid-plane and oblique
Lambda2 rows, the fish is self-propelled rather than advected: it leaves a
coherent alternating wake, maintains a traveling body bend, and follows a
smooth left/down approach without visible loss of the planar free-swim mode or
an unstable three-dimensional wake event.  The useful distinction is arrival
efficiency.  The unmodulated terminal course redirect captures at `20.971T`
with a trajectory distance integral of `157.510 L*T`.  Moving the same course
redirect outward to `8L` changes little (`20.653T`, `157.174 L*T`).  Adding
line-of-sight lead improves it to `20.471T`, `156.422 L*T`.  State-derived
half-cycle steering is the strongest sampled mechanism: it captures at
`20.207T`, reaches `6.420L` by `12T` rather than `6.696L`, and lowers the
integral to `152.044 L*T` while keeping per-joint residence above 90% of the
smooth `31 rad/T^2` command bound in the same approximate `34--37%` band.

The combined sheets also show that the last approach is a broad, continuous
arc rather than a last-instant snap.  The independently positive line-of-sight
lead therefore has a plausible role as a small terminal phase lead, but the
winning half-cycle mechanism must remain the carrier/steering scaffold.

## Policy hypothesis

Retain the sampled half-cycle course-redirect policy exactly as the propulsive
and phase-shaped scaffold.  Add the sibling's observed line-of-sight rotation
to the existing near-field course-error redirect.  The rate is reconstructed
from recent body-frame bearing rate plus recent body yaw rate, is active only
while closing inside the existing approach window, and changes the redirect
signal rather than adding an actuator channel.  This small compatible
combination should begin the already bounded C-bend before course error grows,
without disturbing far-field propulsion.

Falsification: reject the combination if it loses capture; captures later than
the `20.207T` half-cycle parent; fails to lower distance integral or improve
middle/terminal progress; destroys the coherent wake; increases joint-angle
limit residence; or materially increases command-bound residence, force, or
yaw moment.  The new CFD result is not available to this worker and is not
claimed here.

```text
bookshelf_consulted: true
source_domain: robotic-fish CPG turning and closed-loop direction tracking
source_mechanism: state-derived half-cycle asymmetry with sensor-led modulation of a rhythmic steering command
transferable_invariant: preserve the propulsive rhythm, concentrate bounded steering on the useful joint-state half-cycle, and lead terminal course correction with observed target-direction rotation
nontransferable_details: published gains, dimensional frequencies, species-specific amplitudes and duty ratios, exact vortex phase, and task-specific paths
policy_translation: retain q1-dot-derived half-cycle steering and add closing-gated body-frame line-of-sight rate to the existing approach- and course-gated two-joint C-bend redirect
falsification: reject if arrival timing or distance integral regresses, capture is lost, or wake coherence, joint/command residence, force, or moment worsens
```
