# Candidate wake-policy notes

## Evidence and visual diagnosis before editing

- The only sampled Phase 2 solver is the assigned common naive prefill
  `solver_5434ff87b2ba`; no inherited optimizer logs or successful comparison
  rollout are present. Its diagnostics confirm direct uniform still-water
  initialization (`U_infinity=(0,0,0)`), no cylinders, and a valid 3D moving
  window, so its failure is usable controller evidence.
- Both top-down vorticity and oblique Lambda2 views show self-propelled motion
  and an increasingly coherent alternating tail wake. The useful mechanism to
  preserve is the joint-state oscillator with posterior phase lag. The visible
  trajectory nevertheless curls toward the upper boundary while the target
  remains down-left; the long curved wake at 6--8.6T is sustained wrong-way yaw,
  not passive advection in the quiescent fluid.
- The trace cross-check agrees: distance improves only from 12.328L to a
  12.069L minimum, then worsens to 12.365L; heading moves from 0.506 rad to a
  minimum of -1.186 rad, body speed reaches 0.628L/T, both joint rates reach the
  260 deg/T limit, and the run exits the upper virtual boundary at 8.596T.
  With zero target/asymmetry commands throughout, the evidence supports adding
  directional feedback rather than retuning the carrier alone.

## Single candidate hypothesis

Preserve the anterior Van der Pol oscillator and posterior lag, but add one
bounded mean-curvature steering mechanism to the posterior target. Form its
command from normalized body-frame bearing plus normalized heading rate: target
bearing supplies the persistent turn request, while yaw-rate lead reverses the
bias when the body is already rotating too quickly. This should retain the
observed propulsive wake, prevent the seed's large yaw overshoot, turn down-left
toward the target, and replace `left_domain` with longer target-directed travel
or capture. It is falsified if the turn initially has the wrong sign, minimum
distance does not improve below 12.069L, the same upper-boundary topology
persists, or biased curvature destroys propulsion or increases saturation.

bookshelf_consulted: true
source_domain: robotic-fish direction tracking by tail-beat/mean-curvature bias
source_mechanism: sensor feedback adds a bounded average bend to a propulsive rhythm
transferable_invariant: persistent body-frame lateral target error should modulate mean curvature while measured yaw response releases the turn before overshoot
nontransferable_details: published gains, clocked CPG phase, robot linkage geometry, species kinematics, dimensional frequencies, and any task route
policy_translation: use state.bearing and state.heading_rate to bias the posterior lag target of the existing two-joint state-feedback oscillator through a bounded tanh command
falsification: reject if turn sign is wrong, min distance is not below 12.069L, upper-boundary exit repeats, or propulsion/saturation degrades
