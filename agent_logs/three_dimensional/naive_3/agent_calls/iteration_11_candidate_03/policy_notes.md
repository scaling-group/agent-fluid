# Candidate diagnosis and hypothesis

## Evidence read before editing

- All four sampled rollouts report direct uniform initialization in still water
  (`U_infinity=0`), no cylinders, and the same validated L64 moving-window
  contract. Thus the recurring high pass and upper-boundary exit are active
  control failures rather than passive advection or a prewarm artifact.
- The assigned parent (`solver_e496ee6f6139`) is the strongest sampled closest
  approach at `2.989L`. In both the top-down vorticity and oblique Lambda2 rows,
  it carries a coherent alternating wake through the target-directed approach.
  At the `17.66T` minimum the full-quadrant bearing is already about `-1.23rad`,
  lateral slip is `0.22U`, and the response-gated anterior redirect is inactive
  because measured yaw has not yet moved the wrong way. After the pass, the
  redirect intermittently moves the anterior oscillator center; by `20T`,
  `q1=0.01rad` and `qdot1=-0.10rad/T`, the new wake is faint, distance has
  reopened to `3.84L`, and bearing is about `-2.13rad`. The fish then hooks
  upward and exits at `23.43T` with final distance `6.387L`.
- The informative contrast (`solver_eaa778e34ed6`) leaves the anterior joint
  rhythmic and visibly retains an alternating three-dimensional wake to exit,
  but anterior half-cycle stiffness asymmetry acts during the approach: closest
  distance worsens to `4.859L`, peak speed falls to about `0.95U`, and raw
  acceleration-limit occupancy rises to about `53/64%` from the parent's
  `34/45%`. Continued oscillation alone is therefore insufficient; corrective
  work must not perturb anterior restoring stiffness or erase the demonstrated
  approach.
- The other sampled redirects agree with that boundary: carrier-wide approach
  relief (`3.592L`) and held same-sign anterior/posterior bending (`2.999L`)
  both converge toward nearly fixed joints after the pass. The inherited
  step-10 score-only descendant improves closest distance only marginally to
  `2.978L` and still exits, so another redirect gain change is not supported.

## One-mechanism policy hypothesis

Keep the zero-centered anterior Van der Pol carrier, full-quadrant body-frame
target geometry, slip compensation, posterior mean curvature, and base lag
unchanged. Remove the parent's response-gated anterior center shift. When
full-quadrant bearing leaves the broad-approach band, infer posterior wave phase
from the existing lagged tail target and apply a bounded half-cycle envelope:
strengthen the carrier excursion having the requested sign and weaken the
opposite excursion. This produces target-signed cycle-averaged corrective work
while keeping the command rhythmic and within a `0.78..1.22` carrier envelope.
It releases continuously on alignment and uses neither elapsed time nor a
case-specific route.

Expected evidence: match the sampled carrier through the broad approach, retain
an alternating wake after `17T`, move the closest approach below `2.96L`, and
show a distinct recovery arc or better termination class. Reject the mechanism
if it repeats the upper exit without new curvature, loses wake coherence or
speed, or raises limit occupancy toward the anterior-asymmetry failure.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning and elongated-body reactive propulsion
source_mechanism: bounded half-cycle flapping asymmetry applied to a posterior-emphasized traveling wave
transferable_invariant: allocate slightly more posterior wave amplitude to the target-signed half-cycle while preserving alternating lagged propulsion
nontransferable_details: published gains, duty ratios, species envelopes, clock phase, exact vortex phase, and source-task routes
policy_translation: use normalized full-quadrant body-frame bearing and slip for turn sign, and the observed lagged posterior target for beat side; modulate only the posterior carrier envelope
falsification: reject if the broad approach degrades, alternating wake or speed collapses, acceleration-limit occupancy rises materially, or no closer approach/recovery topology appears
