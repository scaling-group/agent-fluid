# Candidate diagnosis and hypothesis

## Evidence read before editing

- All sampled and inherited episodes are finite, direct-uniform still-water
  releases with `U_infinity=[0,0,0]`, no cylinders, and no prewarm. Their
  motion is self-propulsion; every completed episode still terminates
  `left_domain`, so this worker has no success result to claim.
- Both rows of the compact sheets were inspected. The scalar-leading sampled
  policy (`solver_5c5f9d80447b`) maintains an alternating mid-plane street and
  compact oblique Lambda2 structures but follows the shallow upper/left route
  and reaches only `3.0031L`. The sampled mean-curvature and energy-guarded
  alternatives turn below the target and reach `1.5454L` and `1.7708L` while
  retaining the same lower-exit class. These are controller failures, not
  ambient advection or numerical instability.
- The assigned parent's completed carrier-aligned steering rollout
  (`solver_29c53815bb3b`) is a semantic improvement over every sampled solver:
  its coherent carrier brings the head to `0.9532L` at about `18.75T`, compared
  with `1.1444L` for inherited carrier recovery. At closest approach it still
  moves at about `0.782L/T`, and normalized head/tail phase-plane energy is
  about `0.84/0.83`. The top-down street and oblique structures remain visible
  through the turn, so the remaining `0.2032L` capture gap is not terminal
  carrier collapse.
- At that closest row the target angle is about `1.175 rad`, achieved course
  about `-0.369 rad`, and the course request is saturated with the correct
  sign while the fish continues below the disk. Output acceleration is at the
  physical envelope on about `70.9%/68.8%` of the full trace. Reconstructing
  the parent's owned controller over its `14--20T`, `<4L` regime shows why its
  nominal factor-two phase pulse does not provide its nominal mean authority:
  acceleration-aligned steering is added where the carrier already consumes
  same-sign headroom, so clipping leaves only about `26.6%/31.4%` of the
  intended signed head/tail steering increment. The issue is phase choice
  under the actuator envelope, not a missing scalar course gain.

## One candidate mechanism

Preserve the assigned parent's normalized target-versus-achieved-course servo,
distance gate, cadence, full state-feedback oscillator, posterior lag, and
hard output envelope. Change only the terminal duty-allocation observable:
gate each joint's steering pulse by its normalized signed joint velocity
instead of its carrier acceleration. Steering is therefore concentrated while
that joint is moving toward the requested mean bend, including the phase where
the restoring carrier has usable opposite-sign headroom, rather than being
added mainly at already saturated acceleration extrema. The carrier term is
never scaled or suppressed, and mirroring target, joint state, and course
reverses the output exactly.

On the parent's recorded terminal states this motion-aligned allocation would
raise the signed steering increment surviving the clamp from about
`1.12/2.14` to `1.43/3.56 rad/T^2` for head/tail without changing the far-field
law. CFD after this worker must determine whether that counterfactual actuator
advantage survives the changed trajectory.

Falsification: reject the mechanism if behavior outside `4L` changes, the
alternating terminal wake or normalized carrier reserve degrades, output or
joint-speed saturation grows materially, closest approach does not beat
`0.9532L`, or the same below-target lower exit remains. If it produces more
surviving steering but still misses, later work should test a response-released
terminal yaw/slip primitive rather than more course gain, cadence relief,
static mean curvature, or carrier attenuation.

bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping and duty-ratio turning
source_mechanism: use observed beat motion to concentrate bounded steering on the half-cycle moving toward the requested bend while retaining the propulsive rhythm
transferable_invariant: a target-directed turn can be realized by redistributing steering within an observed joint-state cycle, but the useful phase must leave physical actuator headroom and preserve the traveling carrier
nontransferable_details: published gains, robot or species kinematics, dimensional cadence, prescribed clock phase, exact vortex phases, and task-specific routes
policy_translation: retain the normalized body-frame course servo and two-joint traveling bend, then gate each terminal steering share by signed normalized joint velocity rather than same-sign carrier acceleration
falsification: reject if the 0.9532L near-capture is not improved, terminal wake or carrier energy weakens, saturation grows, far-field closure changes, or the below-target left_domain class survives
