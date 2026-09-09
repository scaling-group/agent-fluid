# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

All four sampled evaluations satisfy the experiment contract: direct uniform
initialization, `U_infinity=[0,0,0]`, no cylinders, finite stable dynamics, and
`capture` termination. The three exact speed-reserve rollouts capture at
`0.74846--0.74953L` in `18.2875--18.6010T`; the sampled unsupported-bearing
qualifier captures at `0.74986L` in `18.6560T`. Thus the sheets contain no
visual failure example. I compared the strongest scalar result
(`solver_ac993a461b7c`) with the weakest (`solver_6f904f98394f`) and checked
the other two sheets; the assigned parent's inherited lower exits are used
only through their available score and guidance records, not as unseen visual
evidence.

In both compared views the fish is self-propelled rather than advected: from
quiescent release it develops roughly `0.84L/T` terminal speed while the
top-down row lays down a persistent, alternating signed-vorticity street. The
oblique row shows bilateral Lambda2 structures remaining attached to the
traveling posterior bend through the final target crossing. There is no
visible terminal carrier collapse, collision, domain exit, or unstable wake.
The four terminal poses differ substantially even though all cross the tight
capture boundary, so coherent propulsion alone does not remove the known
terminal branch sensitivity.

The metrics agree with the visual reading. The sampled qualifier has mean
distance `2.03725L`, terminal speed `0.8369L/T`, head/tail action clipping
`68.75%/70.70%`, speed-limit residence `10.32%/11.29%`, peak planar force
coefficient about `0.0314`, and peak yaw-moment coefficient about `0.0165`.
Those values remain in the inherited speed-reserve envelope. Its policy hash
differs from the three sampled baseline hashes only by a bounded route-request
qualifier; drive, intercept release, steering allocation, and carrier reserve
are unchanged. A second exact-byte qualifier result in inherited optimizer
evidence also captures (`0.74881L`, about `18.3205T`), whereas the assigned
parent's inherited response-released mean-curvature bend and its opening-only
posterior wave-shape successor still exit after closest passes of `1.17905L`
and `1.60570L`. The inherited guidance further records that the curvature
variant reduced or entrained joint motion and failed to produce a propelled
second approach; the successor's scalar record supplies no semantic recovery
counterexample, and no unavailable visual behavior is inferred for it.

## Candidate hypothesis

Use an exact policy replay of the sampled
`dogfish3d_outer_unsupported_bearing_v1` qualifier as a third independent
repeat. Preserve raw speed-gated achieved-course steering and every evaluated
propulsion/allocation term. Only in the outer terminal annulus, admit a smooth
body-frame target-bearing residual when achieved-course error is already near
zero; make the residual exactly zero in the far field and inside the existing
intercept guard. This targets the inherited disagreement signature (offset
bearing with nearly centered course) without changing successful first-pass
carrier mechanics or installing another post-pass curvature controller.

Falsification: reject this qualifier as a reliability mechanism if the exact
repeat loses capture, joins the lower-exit branch, changes far-field closure,
weakens either wake view, or leaves the repeat-backed actuator/force/moment
envelope. A new CFD result is not available to this worker and is not claimed
here.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG direction tracking and classical target-geometry turning
source_mechanism: bounded sensor-feedback modulation around a separately sustained propulsive rhythm
transferable_invariant: preserve the traveling bend while adding only a body-relative direction correction unsupported by the achieved-course request
nontransferable_details: published gains, oscillator timing, species kinematics, actuator layout, exact phases, and source-task routes
policy_translation: gate normalized body-frame bearing into the route request only in the evidenced outer-terminal disagreement state; do not alter either joint's carrier or fixed steering allocation
falsification: reject on an exact-repeat miss, altered far-field closure, weaker alternating top-down or oblique wake, or actuator/load metrics outside the repeat-backed envelope
