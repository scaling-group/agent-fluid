# Candidate wake-policy notes

## Evidence diagnosis

- All four sampled episodes satisfy the direct-uniform still-water contract
  (`U_infinity=0`, no prewarm) and terminate by capture. There is no sampled
  failure-class image, so the strongest finite capture
  (`solver_02eaf03fe1d2`) was compared with the lowest-score assigned parent
  (`solver_2e35da543303`) as the most informative weak outcome. No inherited
  optimizer log exists under this rendered workspace; the assigned parent
  guidance and the four solver evidence bundles are the available history.
- In both combined sheets, the top-down row shows self-propelled translation
  with a coherent alternating vorticity street directed along the target
  route. The oblique row shows compact, alternating Lambda2 structures
  concentrated near the posterior body/caudal region rather than passive
  advection or wake breakup. Both fish turn toward the target and capture;
  neither sheet suggests a propulsion failure or a numerical instability.
- The assigned half-cycle parent captures at `18.8815T`, score `-0.213890`,
  and mean-distance score term `2.10234L`. Adding a 15% target-lateral-error
  gait-amplitude relief captures at `18.6505T`, score `-0.206060`, and
  `2.09340L`. A response-coupled version independently gives `18.6615T`,
  `-0.206097`, and `2.09362L`. Their near agreement supports the common
  geometry-scheduled redirect/cruise mechanism, while giving no evidence that
  the extra response coupling matters.
- The terminal range/velocity compound is weaker (`19.0520T`, `-0.210566`,
  `2.09874L`) and its top-down route reaches farther below the target-side
  corridor before recovering. It does not justify stacking terminal velocity
  feedback onto the candidate.
- Policy-side acceleration projection remains active. A trajectory
  reconstruction gives parent rate-contact fractions about `11.0%/15.2%`
  and acceleration-contact fractions `60.7%/73.4%`, versus
  `11.0%/15.1%` and `61.0%/73.2%` for the strongest geometry-scheduled
  capture. Thus the sampled improvement is route/arrival evidence, not demand
  relief.

## Policy hypothesis

Start from the assigned capture-class differential-curvature carrier and add
one mechanism: reduce only the oscillator limit-cycle amplitude by as much as
15% in proportion to the absolute normalized body-frame lateral target
fraction. Preserve target-owned steering sign, displacement-only half-cycle
redistribution, one-sided correcting-yaw release, posterior lag, mean-curvature
shares, and exact acceleration projection. This should make mean curvature
relatively more authoritative during redirect and restore the full rhythmic
carrier continuously as the target returns to the body axis, reproducing the
two sampled faster target-directed trajectories without a clock or route
memory. Falsify the transfer if it loses capture, breaks either coherent wake
view, leaves the parent route/arrival band, or is interpreted as saturation
relief without lower contact fractions.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG and averaging-based turning
source_mechanism: sensed route error modulates rhythmic amplitude separately from mean turning offset
transferable_invariant: preserve a traveling-wave carrier while bounded target geometry continuously reallocates authority between rhythmic propulsion and asymmetric mean curvature
nontransferable_details: published gains, clock phase, robot or species kinematics, dimensional frequency, exact vortex phase, and task-specific routes
policy_translation: use absolute normalized body-frame lateral target fraction to mildly reduce the joint-state oscillator envelope while retaining target-signed two-joint differential curvature and posterior lag
falsification: reject if capture or the target-directed coherent wake is lost, route and arrival regress to the parent band, or demand statistics are claimed to improve without measured lower saturation
