# Joint-speed viability candidate

## Evidence and visual diagnosis

- All four sampled rollouts use direct uniform still-water initialization with
  `U_infinity=(0,0,0)`, no cylinders, and no prewarm snapshot. All capture at
  about `18.27T`. In the combined sheets, the top-down row shows the same
  target-directed arc and regular alternating reverse wake through capture,
  while the oblique row shows compact three-dimensional Lambda2 structures at
  `12T`, `16T`, and capture. Peak fish speed is about `1.329U` and peak local
  flow only `0.03154U`, so the trajectory is self-propelled rather than
  advected. Preserve the target-ray/velocity-course feedback, zero-centered
  anterior oscillator, posterior lag, terminal steering reserve, and global
  posterior angle-viability projection.
- The highest scalar sample, the fixed-width brake at `-0.247735`, is the
  informative mechanical failure. It reaches exactly `-45 deg` at joint 2 and
  peaks at `0.17183/0.07699` force/yaw moment. The global stopping-risk sample
  captures at `0.74863L`, stays near `-42.998 deg`, and lowers those peaks to
  `0.03716/0.01907`; its visually indistinguishable wake confirms that the
  kinetic-margin barrier, not a route change, removed the hard-stop event.
- The three global-barrier variants expose the remaining non-improvement.
  Adding a final policy-output clamp changes raw maxima from roughly
  `3430/5066 deg/T^2` to `1800/1800 deg/T^2`, but the clipped and unclipped
  variants have identical score, capture time, trajectory extrema, wake,
  speed, local flow, joint motion, force, and moment. Downstream actuator
  clipping already imposed the same physical action, so feasibility-by-clamp
  is useful contract hygiene but not a new control mechanism.
- The feasible sampled trace still returns exactly the acceleration limit in
  `1704/3323` anterior samples and `1542/3323` posterior samples. More
  specifically, joint velocities sit exactly at `260 deg/T` in `147` and `85`
  samples, respectively, and every such sample still commands acceleration in
  the current velocity direction. This is avoidable outward work at the rate
  boundary, even though the angle barrier has already removed the terminal
  collision spike. The inherited optimizer notes explicitly leave raw/applied
  acceleration occupancy as a separate allocation problem rather than a
  reason for more stopping-risk gain tuning.

## Policy hypothesis written before the solver edit

Keep the captured controller and its posterior angle-viability barrier intact.
Add one symmetric, state-dependent joint-speed viability projection after the
existing command construction: normalize each observed joint speed by the
owned `260 deg/T` limit, smoothly reduce only acceleration in the current
motion direction above a `0.90` speed fraction, and reduce its admissible
ceiling to zero at the rate boundary. Acceleration opposing joint motion must
pass through unchanged so the carrier can reverse without a new bang-bang
brake. Retain the final acceleration clamp as a safety contract, but do not
count it as the mechanism.

Static replay on the assigned trace says this projection would alter `254`
anterior and `132` posterior samples, first after the gait has formed, while
leaving all commands below the normalized speed onset and all inward reversal
commands unchanged. That replay is only a scope check; the new CFD outcome is
not available to this worker. The expected signature is retained capture and
alternating three-dimensional shedding, no joint-angle contact, lower
joint-rate-limit occupancy than `147/85` samples, and no force/moment regression
above `0.0372/0.0191`. Falsify the candidate if it loses capture or the
sub-`1L` route, materially weakens the wake or speed, increases arrival time
enough to worsen the score without a clear viability benefit, restores angle
contact, or merely relocates saturation into maximum inward braking.

```text
bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and actuator-aware rhythmic swimming
source_mechanism: sensor feedback modulates a low-dimensional propulsive rhythm while preserving the carrier rather than replacing it with raw high-frequency action
transferable_invariant: preserve the evidenced traveling rhythm and remove only work that pushes an observed joint farther into a normalized actuator boundary, releasing the correction when headroom returns
nontransferable_details: published CPG gains, dimensional cadence, linkage geometry, species-specific kinematics, exact vortex phase, source actuator ratings, and task-specific routes
policy_translation: retain normalized target_body_L versus velocity_body_U course steering and the two-joint carrier; use phi_dot normalized by the owned joint-velocity limit to smoothly cap only acceleration aligned with joint motion, while preserving inward reversal and the posterior angle barrier
falsification: reject if capture or coherent alternating shedding is lost, rate-limit occupancy does not fall, inward maximum braking replaces outward saturation, either angle boundary is touched, or force and yaw-moment peaks exceed the sampled global-barrier ceiling
```
