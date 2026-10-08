# Candidate diagnosis and hypothesis

## Evidence read before the edit

- All four assigned rollouts confirm the required direct uniform still-water
  initialization (`uniform_direct`, `U_infinity=(0,0,0)`), finite dynamics,
  and capture. The three translational-line-of-sight policies finish in the
  same 2,867 steps at `15.768509T`, `0.745720L`, distance integral
  `1.924067L`, and score `-0.041674`; their combined wake sheets are
  byte-identical. The net-bearing-rate terminal variant is the informative
  negative comparison: it has the same milestones, termination, limit
  residence, force envelope, and visibly identical trajectory, but is
  microscopically worse at `0.745725L`, distance integral `1.924071L`, and
  score `-0.041679`.
- In both rows of the combined sheets, the fish is self-propelled rather than
  advected: the initially quiescent field develops an alternating top-down
  vorticity street by `4T`, followed by a continuous body-attached wake through
  `15.77T`; the oblique Lambda2 views show corresponding alternating compact
  three-dimensional structures. The body follows the target-directed green
  trace without collision, domain exit, wake breakup, or an unstable terminal
  maneuver. The lateral motion is a productive traveling bend, not a standing
  wiggle, although the head and wake continue beat-scale side-to-side motion at
  capture.
- Diagnostics support that reading: the representative best has `232` moving
  window shifts, mean absolute commands `23.431/25.221 rad/T^2`, acceleration
  limit residence `48.83/23.58%`, speed-limit residence `3.56/5.72%`, posterior
  excursion `34.73 deg`, peak body-force coefficients `0.02448/0.03329`, and
  peak yaw-moment coefficient `0.01895`. Milestones are `8L=9.1025T`,
  `6L=10.9890T`, `4L=12.8260T`, and `2L=14.6465T`. Thus the next experiment
  should preserve the carrier and alter feasible early action, not stack a
  fourth terminal-rate gate.
- Reconstructing the current low-speed allocator from the trace shows that the
  optional posterior boost is speed-eligible on 669 samples. A smooth gate
  driven by target-projected force differs by more than `0.1` from the current
  axial-force gate on 38.4% of those samples (95 samples add and 191 remove
  response support by more than `0.05`). A post-edit counterfactual replay of
  the recorded observations through parent and candidate changes 250 of 2,867
  feasible posterior commands, with mean changed magnitude `1.286 rad/T^2`
  and maximum `7.200 rad/T^2`; reflection and invalid-force checks pass. This
  is enough support to test a new trajectory rather than a clamp-equivalent
  wrapper.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: Lighthill elongated-body reactive thrust combined with sensor-feedback modulation of a rhythmic robotic-fish carrier
source_mechanism: preserve a traveling bend with posterior emphasis, while allocating optional rhythmic authority according to measured hydrodynamic response in the desired travel direction
transferable_invariant: a base traveling wave must remain available, and extra posterior authority should be reinforced only when measured force has a positive projection onto the current body-frame goal direction
nontransferable_details: published gains, dimensional tail-beat frequencies, full-body amplitude envelopes, species kinematics, exact vortex or force phase, and source-task routes
policy_translation: replace only the supplemental low-speed boost gate with a smooth positive dot product of normalized `force_body_L` and the unit `target_body_L` vector; retain the proven state-feedback oscillator, steering, approach logic, bounded base/boost endpoints, actuator projection, and axial speed-eligibility envelope
falsification: reject the transfer if it loses capture or coherent two-view wake structure, delays established milestones or increases distance integral, worsens limiting or load envelopes, or produces no feasible action difference from the axial-only parent

## Candidate hypothesis

The axial allocator treats every forward-force lobe as useful even while the
fish is turning and the same load vector points partly away from the target.
Projecting the normalized force onto the instantaneous target direction should
keep low-speed posterior reinforcement during genuinely target-closing reactive
response, withdraw only the optional increment when lateral load makes that
response route-adverse, and admit target-helping lateral-force lobes that an
axial-only test misses. Because the base endpoint remains available and the
change is inactive after the inherited speed-recovery envelope closes, the
candidate should preserve wake formation and all mature-carrier steering. A
positive result requires capture with an earlier post-launch milestone or
lower distance integral, not merely lower command effort.
