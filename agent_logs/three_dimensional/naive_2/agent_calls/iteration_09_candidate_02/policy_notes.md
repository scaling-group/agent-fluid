# Candidate diagnosis and hypothesis

All four sampled rollouts satisfy the direct-uniform still-water contract
(`U_infinity=(0,0,0)`, no prewarm).  Their top-down rows show self-propelled
leftward travel behind compact alternating vorticity, and their oblique rows
confirm a coherent three-dimensional Lambda2 street rather than passive
advection.  The common failure appears after the useful approach: each fish
develops a broad return arc and terminates at the upper virtual boundary near
`y=15.20L`.  The parent tail-bend release travels `15.323L` left and reaches
`3.312L`, but its peak planar force/moment (`0.890/0.414`) exceed the
mean-bend sample (`0.488/0.220` from the sampled trajectories),
and it still occupies a joint-rate limit for `9.4%` of joint samples.  The
continuous hold and mean-bend release approach more closely (`2.703L` and
`2.664L`) but spend `26.4%` and `10.1%` of joint samples near an angle limit.
Thus the repeated high pass is not weak propulsion; it is a directional
response and restoring-half-cycle problem.

The trajectory cross-check supplies a more specific signal.  On the parent,
the normalized target-versus-velocity cross error is already about `-0.73` at
`4T`, `-0.78` at `10T`, and `-0.99` at `16T`, even while instantaneous
full-circle pursuit bearing changes sign with body yaw.  This means actual
translation is persistently on the high side of the desired course before the
closest pass.  The candidate will replace dimensional lateral-slip steering
with a bounded, rotation-invariant course residual once speed is established,
blend back to target bearing at low speed, retain the evidenced joint-rate yaw
phase separation, and keep the full carrier active so both restoring
half-cycles survive.  It will not add another distance threshold or bend
release gate.

bookshelf_consulted: true
source_domain: robotic-fish CPG direction tracking and asymmetric flapping
source_mechanism: sensor feedback modulates a rhythmic carrier through bounded half-cycle asymmetry
transferable_invariant: steer from persistent direction error while preserving the propulsive rhythm and an opposed restoring half-cycle
nontransferable_details: published gains, clocked oscillator phase, robot geometry, species kinematics, and task-specific routes
policy_translation: blend normalized body-frame target bearing into target-versus-velocity course error as speed grows, then apply it to the existing two-joint carrier-relative asymmetry without approach drive relief
falsification: reject if the coherent cruise wake or leftward translation collapses, if closest approach does not retain the sampled 2.664L class, or if angle dwell, load peaks, and the repeated upper-boundary topology do not improve together
