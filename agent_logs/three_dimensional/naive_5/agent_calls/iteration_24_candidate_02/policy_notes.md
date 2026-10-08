# Candidate diagnosis and hypothesis

## Evidence read before editing

- All four sampled episodes report direct uniform still-water initialization,
  zero background velocity, stable dynamics, and `capture` termination. The
  three baseline descendants terminate at `0.749242L` and `26.2955T`; their
  combined keyframe sheets and trajectories are byte-identical even though two
  policy files differ cosmetically.
- Both rows of the baseline and distinct keyframe sheets were inspected. The
  top-down row shows self-propulsion with a coherent alternating vortex train
  from `8T` through `24T`, followed by a smooth target-directed turn. The
  oblique row confirms that the three-dimensional wake remains compact and
  organized during that turn; there is no visible breakup, passive advection,
  boundary interaction, or initialization artifact.
- The distinct sampled policy adds an anterior half-cycle course-response
  residual inside the existing approach/miss corridor. It reaches
  `0.749090L` at `26.3010T`, but its maximum centerline displacement from the
  baseline is only `0.00277L`; mean distance improves by only `0.000105L`, and
  arrival is `0.0055T` later. Its peak planar force/yaw moment
  (`0.018834/0.009789`), maximum joint angle/rate/acceleration, zero limit
  contacts, and visible wake topology are unchanged. This is not evidence for
  increasing that residual or retuning its corridor thresholds.
- At the baseline capture sample the head-to-target vector and inertial
  velocity imply roughly `0.61L/T` transverse motion but only `0.22L/T`
  closing motion. The successful path therefore still crosses the capture
  boundary shallowly. The inherited results already reject additional
  terminal pulses, braking, static depth, and waveform recovery, so the open
  question is whether the established miss/yaw gate needs a different
  actuator channel rather than more anterior authority.

## Policy hypothesis

Preserve the evaluated line-of-sight response, redirect, traveling-bend
carrier, coordinated command compression, and angle/rate viability guards.
Only while the existing normalized approach-and-projected-miss veto is active,
the target line is still under-responding, and the fish is closing, introduce a
small reflection-equivariant modulation of posterior phase lag. Strengthen
posterior lag on one inferred joint-state half-cycle and weaken it on the
other, producing a target-side wave-shape bias without adding another anterior
acceleration residual or changing the far carrier. This candidate tests a new
actuator allocation; it does not claim an evaluated improvement.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning and closed-loop direction tracking
source_mechanism: bounded phase-lag or wave-shape modulation of a propulsive rhythm
transferable_invariant: steer by changing inter-joint wave shape only when observed target error and inadequate turn response agree, while preserving the carrier elsewhere
nontransferable_details: published gains, clock-driven oscillator phase, robot-specific joint geometry, species kinematics, and any prescribed route or exact vortex phase
policy_translation: use body-frame projected miss, closing speed, reconstructed target-line response, and anterior joint-state phase to modulate only the posterior lag within the existing capture corridor
falsification: reject if capture is lost, the route remains in the same milliscale cluster, the coherent two-view wake breaks up, or angle/rate/acceleration contacts or peak loads return
