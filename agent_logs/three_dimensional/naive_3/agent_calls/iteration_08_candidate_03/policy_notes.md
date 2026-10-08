# Candidate wake-policy diagnosis

The four sampled rollouts all use direct uniform still-water initialization
(`U_infinity=0`) and end by leaving the upper virtual boundary.  The top-down
and oblique sheets show self-propulsion rather than advection: a coherent,
alternating three-dimensional wake develops by `8T`, while the trajectory
advances at about `0.7--0.9U`; the body-frame local flow remains only about
`0.01--0.03U`.  All variants descend productively at first, then pass well
above the target and hook upward.  Their closest distances are `2.989L`,
`2.999L`, `3.162L`, and `3.592L`, followed by `left_domain`.

The most informative contrast is between the continuously beating posterior-
relief policy and the full-quadrant redirect policies.  Posterior relief keeps
the visible vortex street but cannot reverse the post-pass yaw.  Carrier-wide
hold and anterior-center redirects instead leave the high-error departure with
nearly fixed joints: the static redirect is approximately `(-0.17,-0.21) rad`
from `18T`, and the response-gated redirect approaches `(0,-0.21) rad` by
`20T`.  Thus freed actuator reserve, a static C-like bend, and a gate driven by
beat-contaminated instantaneous yaw are not equivalent to active corrective
work.  The inherited sequence reinforces the same boundary: the unrelieved
bearing/slip carrier reached `2.960L`, while later changes retained
`left_domain` even when closest distance returned to about `2.99L`.

Policy hypothesis: restore the unrelieved, zero-centered anterior carrier and
the full-quadrant body-frame target angle.  When target error is large, use
anterior joint angle as observable beat side and asymmetrically shape the
restoring stiffness: relax the target-directed bend half and strengthen the
counter half.  The posterior joint continues to lag the observed anterior
state, so the longer/larger useful half becomes an active traveling bend
rather than a held shape.  A joint-only envelope check rejected an additive
half-cycle drive because it raised raw acceleration clipping from about
`43/44%` to `71/65%`; a `0.30` bounded stiffness asymmetry retained 37 zero
crossings in `12T`, shifted mean anterior bend by about `-2.2 deg` for a
negative request, and kept anterior clipping near `42%`.  This should preserve
the coherent cruise wake, keep correction available after the target passes
behind, and produce a distinct recovery arc.  Reject the hypothesis if it
loses the alternating wake, persistently occupies angle/acceleration limits,
fails to beat the `2.960L` broad-approach reference, or repeats the upper exit
without bearing recovery.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning and asymmetric flapping
source_mechanism: target-directed half-cycle amplitude asymmetry superposed on a rhythmic traveling bend
transferable_invariant: preserve the propulsive rhythm while strengthening only the beat half that supplies the requested turn
nontransferable_details: published gains, duty ratios, species kinematics, clock phase, exact vortex phase, and task-specific routes
policy_translation: map full-quadrant normalized body-frame target geometry to a bounded turn request; infer beat side from anterior joint angle; smoothly relax anterior restoring stiffness on the requested side and strengthen it on the counter side; let the posterior joint follow the observed lagged state
falsification: reject if wake coherence or rhythmicity collapses, limit occupancy materially rises, closest distance does not beat 2.960L, or the same upper-boundary hook remains
