# Wake-policy diagnosis and hypothesis

## Evidence read before editing

All four sampled evaluations report `uniform_direct` initialization,
`U_infinity=[0,0,0]`, no cylinders, and `left_domain`.  The combined sheets
were inspected in both their top-down mid-plane vorticity row and oblique 3D
body/Lambda2 row.  They agree on a self-propelled broad approach with a
coherent alternating wake through roughly `12T`, followed by a high-side hook
rather than target capture.  This is not passive advection.

The strongest scalar result, the approach-hold candidate, finishes at
`6.158L` after reaching `3.592L`, but its visible wake weakens and its joints
settle near `(0,-12) deg` while it coasts upward.  The posterior-relief example
keeps a visibly oscillatory wake longer but reaches only `3.162L` and still
hooks upward.  The full-quadrant static redirect reaches `2.999L`, freezes near
`(-10,-12) deg`, and coasts out.  Thus neither freeing posterior reserve nor a
static centered bend supplies corrective yaw.

The assigned-parent response-released redirect is the most informative
failure.  It reaches `2.989L` at `17.66T` with full-quadrant bearing about
`-1.23 rad`, then changes from weak corrective yaw (`+0.07 rad/T`) to wrong-way
yaw (`-0.55 rad/T`) by `18T`.  By `20T`, bearing is about `-2.13 rad`, yaw is
still wrong-way at `-0.13 rad/T`, and the joints have nearly settled at
`(0.8,-13.3) deg`; it exits at `6.387L`.  Reconstructing the implemented gate
from the logged trajectory gives only about `0.02` authority at `20T` and
about `0.05` at termination.  Its positive-only squared yaw-response factor
therefore treats stalled wrong-way yaw almost like successful correction, and
moving the anterior oscillator center lets the carrier fall into the shifted
equilibrium.  Acceleration already occupies the cap in approximately 34% of
joint-1 and 45% of joint-2 samples, so adding more posterior drive is not the
supported remedy.

## Candidate hypothesis

Keep the demonstrated full-quadrant bearing-minus-slip request, posterior mean
curvature, and lagged traveling carrier.  Replace the moving anterior center
with a bounded turn-side half-cycle reference selected from `(phi1,
phi_dot1/omega)`.  The base Van der Pol spring remains zero-centered; when the
large-error redirect is active, only the predicted turn-side half-cycle gets a
small curvature boost.  A signed yaw-response sigmoid stays nonzero when yaw
is stalled or wrong-way and releases only after yaw becomes corrective.  This
should preserve rhythmic restart while generating an active asymmetric bend
after the pass.  The next evaluation should reject the mechanism if it loses
the early coherent wake, materially increases limit occupancy, fails to beat
the `2.960L` broad-approach reference, or repeats the upper exit without a
distinct corrective arc.

bookshelf_consulted: true
source_domain: biological and robotic-fish turning with sensor-modulated rhythmic control
source_mechanism: state-phased half-cycle amplitude asymmetry with response-based redirect release
transferable_invariant: persistent heading error requires a nonreciprocal turn-side stroke while the propulsive rhythm remains available, and redirect authority should release only after measured corrective yaw
nontransferable_details: published gains, duty ratios, species kinematics, dimensional beat frequencies, exact vortex phases, and task-specific routes
policy_translation: use normalized full-quadrant body-frame target geometry and lateral slip for turn sign, normalized heading rate for response, and observed joint angle and velocity for phase; apply one bounded anterior half-cycle reference while retaining the lagged posterior carrier
falsification: reject if the coherent early wake collapses, acceleration-limit occupancy materially rises, closest approach does not beat 2.960L, or no distinct recovery arc precedes another upper-boundary exit
