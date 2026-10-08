# Candidate diagnosis and hypothesis

## Evidence read before the edit

- The assigned parent guidance preserves the target-aware traveling-wave carrier,
  the successful same-sign geometry-gated C-bend, bounded response release, and
  the fourth-order final-command projection. Its outstanding falsification was
  whether the independently successful release and projection compose.
- All four sampled rollouts are valid direct still-water runs:
  `initialization_mode=uniform_direct`, `flow_velocity_L_per_T=[0,0,0]`, no
  prewarm snapshot, no cylinders, and capture termination. The three v21 files
  differ only in comments/version text and produce the exact same 4341-step,
  23.8755T trajectory (`mean_distance_L=2.43571`). Their top-down and oblique
  sheets are byte-identical.
- Both rows of the combined sheets show self-propulsion rather than advection.
  A strong alternating mid-plane vortex street and compact three-dimensional
  Lambda2 structures persist from release through the curved target approach;
  there is no visible wake collapse, collision, domain exit, or instability.
- The terminal excess-yaw amplitude-relief comparator also captures, but its
  23.8810T arrival is one CFD step later. Its tiny mean-distance change
  (`2.43549L`, only `0.00023L` lower) is not a semantic improvement, and the
  visual route remains effectively unchanged. Peak yaw is still about
  `2.949 rad/T`; both joints still touch `260 deg/T`; posterior rate remains at
  or above 95% of its limit for 406/4342 samples versus 407/4341 in the parent;
  peak lateral load and yaw moment remain `0.0240` and `0.0141`. The inherited
  score logs confirm only the same capture class and threshold-scale final
  distance change.
- The useful remaining defect is arrival-direction control, not propulsion.
  From about 3.5L to capture the fish remains positively closing but executes
  large alternating yaw responses. At the final parent sample it is still
  closing near `0.72L/T` while yawing at `1.781 rad/T`; reducing oscillator
  amplitude did not remove that response. The body-frame target and actual
  velocity are both available, while the inherited scalar `slip_y` path divides
  velocity by `L=64` and therefore contributes negligibly.

## Policy hypothesis

Retain the evaluated carrier and redirect unchanged. Compute the signed angle
between the normalized body-frame target vector and normalized body-frame fish
velocity. When the fish has useful speed, is positively closing, and is within
a continuous approach window, add a bounded opposite-sign residual to the
existing target-derived turn request. This damps only velocity that is aimed
across the remaining target line, rather than suppressing all lateral motion or
coasting. The residual vanishes at rest, when far away, when not closing, and
when velocity already points at the target.

Expected test: retain capture and coherent alternating wake while reducing the
late yaw/rate-limit cycling enough to beat the parent on arrival or mean
distance. Reject the mechanism if capture is lost, arrival is not meaningfully
earlier, the trajectory/wake is unchanged, posterior rate exposure or loads
rise, or cross-track correction opposes useful closing motion.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish direction tracking and biological terminal approach control
source_mechanism: sensor feedback modulates a propulsive oscillator with bounded target-direction and near-arrival yaw/slip correction
transferable_invariant: preserve the traveling-wave carrier while continuously aligning actual travel with the remaining target vector and damping only excess near-target cross-track response
nontransferable_details: published CPG gains, robot or species kinematics, dimensional cadence, exact vortex phase, waypoint routes, and world-frame directions
policy_translation: use normalized body-frame target and velocity to form a bounded signed misalignment angle, then gate its turn residual by observed speed, positive closing, and target proximity under the existing two-joint feedback contract
falsification: reject if capture or wake coherence is lost, arrival/mean distance is not materially better, or joint-rate exposure, lateral load, yaw moment, or terminal oscillation worsens
