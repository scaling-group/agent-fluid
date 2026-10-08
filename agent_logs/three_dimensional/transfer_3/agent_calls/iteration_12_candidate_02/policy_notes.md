# Crossflow-supported terminal carrier-release candidate

## Evidence and visual diagnosis before the policy edit

- All sampled solver rollouts satisfy the frozen contract: direct uniform
  still-water initialization with `U_infinity=(0,0,0)`, no cylinders or
  prewarm, active moving-window transport, finite dynamics, and capture. Three
  reproduce the prefilled paired-release baseline exactly at score
  `-0.5283387731`, capture `25.1185226 T`, mean distance `2.429293780 L`, and
  final distance `0.746410191 L`.
- I inspected both rows of the combined keyframe sheets for that baseline, the
  strongest sampled finite controller (`solver_44f6e53e7268`), and the
  assigned-parent anterior-redistribution regression. The top-down views show
  self-propulsion along the same compact targetward arc, with a coherent
  alternating wake through the outer approach and a smooth held-bend terminal
  translation. The oblique views confirm finite three-dimensional Lambda2
  structures and no collision, domain-exit precursor, passive advection, or
  instability. The terminal policy differences are too late and small to
  distinguish reliably in the coarse sheets, so their interpretation comes
  from the trajectories and diagnostics rather than vortex appearance alone.
- The assigned parent's zero-sum anterior curvature redistribution is a
  concrete negative result: it reduces final heading error from `0.66697` to
  `0.64836 rad` and slightly raises crossing speed, but regresses score to
  `-0.5288433734`, mean distance to `2.429624931 L`, and final distance to
  `0.747277439 L`. Better body alignment or more anterior leverage is not, by
  itself, better capture geometry.
- Two crossflow mechanisms separate the useful actuator translation. Directly
  scaling both held-curvature targets under productive crossflow regresses to
  score `-0.5285807072`, mean distance `2.429484621 L`, and final distance
  `0.746665657 L`. In contrast, using the same physical cue only after joint
  settling to reduce the terminal-equilibrium blend and recover the existing
  carrier improves score to `-0.5281078349`, mean distance to
  `2.429111372 L`, and final distance to `0.746167541 L`, at the same
  `25.1185226 T` capture time. It preserves the baseline inside-`4 L` peak
  action, force, and moment values because it activates only on the late
  approach.

## Policy hypothesis

Replace the prefilled baseline with the strongest sampled architecture while
leaving its outer traveling-wave carrier, target-angle redirect, closure
preview, two-joint curvature equilibrium, paired response release, and command
limits unchanged. During only the final `1.6 L`, compute a reflection-
equivariant support signal from normalized body-frame target side, body-relative
crossflow, positive range closure, proximity, and actual equilibrium settling.
When those observations agree that lateral response is already target-helpful,
reduce the shared terminal-equilibrium allocation by at most the declared
fraction and recover the existing mean-centered carrier for both joints. The
cue cannot choose a beat phase, add total mean bend, redistribute bend between
joints, or alter the outer route.

The sampled evaluation predicts an unchanged outer two-view wake and a compact
capture with lower mean/final distance than the prefill. Reject this mechanism
under a fresh rollout or held-out geometry if capture is delayed or lost,
distance integral or crossing depth regresses, the outer trajectory changes,
the cue acts with wrong-sign crossflow or absent closure, or saturation,
joint-stop dwell, force/moment spikes, instability, or low-drive looping
returns. The new formal evaluation occurs after this worker exits; no
same-worker CFD result is claimed.

bookshelf_consulted: true
source_domain: wake interaction, adaptive swimming, and sensor-modulated robotic-fish control
source_mechanism: preserve useful flow-induced lateral response by relaxing corrective hold into an already proven traveling carrier
transferable_invariant: when normalized body-frame target geometry, relative crossflow, positive closure, and joint response agree that lateral motion is useful, reduce only the corrective equilibrium allocation while preserving the propulsive carrier
nontransferable_details: cylinder geometry, inflow speed, exact vortex phase, Karman synchronization, species kinematics, published gains, dimensional thresholds, and task-specific routes
policy_translation: smoothly gate a bounded paired reduction of terminal-equilibrium weight from `target_body_L`, `relative_flow_velocity_body_U`, `window_closing_speed_L`, range, and two-joint tracking error; recover only the existing mean-centered carrier
falsification: reject if the gate changes the outer path, activates without helpful crossflow and closure, delays or loses capture, worsens mean/final distance, or restores wake loss, saturation, joint stops, load spikes, instability, or looping

## Non-CFD implementation audit

- The candidate is byte-identical to the strongest sampled evaluated policy,
  so the edit transfers the evidenced controller rather than extrapolating a
  scalar gain from it.
- The deterministic schema audit resolves all 74 direct `params.FIELD`
  references in the returned 75-field parameter object. The configured
  lightweight multi-wake state returns two finite commands, and the boundary
  checker confirms that only the allowed candidate policy differs under
  `solver/`.
- These checks establish schema completeness, contract validity, and edit
  scope only. They do not replace the post-worker CFD evaluation.
