# Candidate diagnosis and hypothesis

No inherited `logs/optimize` directory was present at assignment, so the
available provenance is the assigned course-response parent and guidance plus
the four sampled solver and optimizer evidence bundles.

All four sampled sheets are valid direct-uniform, zero-inflow still-water
rollouts.  Their top-down vorticity and oblique Lambda2 rows show
self-propulsion rather than imposed advection, but sharply different steering
outcomes:

- The assigned course-response parent (`solver_d146183ecace`) barely develops
  a trailing vortex street before curling upward and leaving at `8.646 T`.
  Its minimum is only `12.2257 L` (at `5.533 T`), forward speed is just
  `0.361 L/T` at `8 T`, and the center exits at `y=15.2002 L`.  The weak,
  short oblique wake and curved track agree with the metrics: speed-gated
  course plus beat-scale yaw error acting through posterior mean curvature
  displaced the propulsive wave instead of settling a slow route response.
- The compact bearing/curvature sample (`solver_b6bb94d9cdaf`) retains the
  clearest bounded alternating wake and the best score, but reaches only
  `5.3570 L` and passes roughly `5 L` above the target before an upper exit.
  Its yaw rate oscillates to about `+/-3 rad/T`, so instantaneous yaw braking
  is not a reliable cycle-mean route signal; controller-bound residence is
  also high (`24.3%/48.7%` of joint rows above 95% of `31 rad/T^2`).
- The branch-heavy sign-flipped 2D transfer (`solver_e450df1efa49`) makes the
  closest sampled pass (`4.1281 L`) and forms a strong coherent wake, yet its
  nearly horizontal above-target route reverses progress and exits left at
  `9.1538 L`; raw acceleration is beyond the physical envelope on most rows.
  The bearing-response release sample (`solver_59bc4ebdddec`) is bounded and
  coherent but also exits upward after reaching only `7.5311 L`.

The reusable feature is the joint-state oscillator with posterior lag.  The
failure shared by the compact controllers is steering through a mean tail
offset whose sign or authority is repeatedly changed by sub-cycle rate
signals; the assigned parent's added course loop makes that failure more
severe.  This candidate therefore tests one different steering actuator:
body-frame bearing smoothly strengthens the posterior target on one observed
joint-state half-cycle and weakens it on the other.  Zero bearing restores the
unchanged symmetric traveling bend.  There is no static curvature, course
feedback, yaw-rate feedback, clock, route, or anterior steering path.

Expected evidence: the alternating top-down/oblique wake should remain as
coherent as the bounded bearing sample, forward progress should recover from
the assigned parent's collapse, positive initial bearing should no longer
produce the same rapid upper curl, and cycle-mean bearing should contract
without persistent actuator-limit residence.  Falsify the mechanism if the
wake or forward speed still collapses, if the same upper-boundary topology
occurs before `15 T`, if closest distance does not improve on the parent's
`12.2257 L`, or if the half-cycle gate merely recreates saturated static-bend
behavior.  Improvement beyond the sampled `5.3570 L` bounded minimum is the
stronger test; no prior evidence supports terminal scheduling yet.

bookshelf_consulted: true
source_domain: robotic-fish CPG and asymmetric-flapping control
source_mechanism: sensor-gated half-cycle amplitude asymmetry on a posterior-lag propulsive rhythm
transferable_invariant: persistent body-frame route error may bias the strength of one observed-state half-cycle while zero error restores the symmetric traveling wave
nontransferable_details: published gains, duty ratios, clock phases, species kinematics, exact vortex phases, and task-specific routes
policy_translation: map bounded body-frame bearing to a bounded multiplicative asymmetry of the lagged posterior target using its own sign as beat phase
falsification: reject if propulsion coherence or forward speed collapses, the rapid upper exit remains, bearing fails to settle, or actuator-limit residence grows
