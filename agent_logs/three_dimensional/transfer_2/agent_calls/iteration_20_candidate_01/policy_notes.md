# Wake-policy candidate notes

## Evidence diagnosis

- All four sampled evaluations are valid direct-uniform, quiescent releases
  (`U_infinity=(0,0,0)`), contain both requested visual views, remain stable,
  and terminate by capture. Thus their translation is self-propulsion rather
  than background advection.
- The best finite sample, `solver_2dfe05597921`, captures at `19.3545T` with
  distance integral `2.07892L` and score `-0.18968`. The prefilled exact
  response-gated policy, `solver_26d7454466f5`, captures at `19.5910T` with
  distance integral `2.09637L` and score `-0.20651`; the byte-identical
  `solver_1af6c62469a7` reaches `19.3600T/2.08911L/-0.19989`, establishing
  appreciable repeat variation for the same controller.
- In both the best and prefill combined sheets, the top-down row develops a
  coherent alternating wake behind the body from release through the nearly
  straight middle transit. The final frame shows the same pronounced late
  hook into the capture circle rather than collision, reversal, or domain
  exit. The oblique Lambda2 row likewise shows bounded alternating 3D wake
  structures and a continuous self-propelled track; neither view supports a
  new wake-loss or instability diagnosis. The small scalar spread therefore
  does not identify another posterior carrier, lag, response, or terminal-gate
  adjustment.
- The assigned guidance's body-frame reconstruction instead reports
  `0.530--0.549 rad` mean absolute velocity-course error beyond `6L`, exactly
  where the current redirect weight is zero. This is a distinct observation
  and feedback-placement deficiency: the policy controls body-to-target
  bearing while far but postpones feedback on the direction of actual
  translation until approach.
- The assigned parent optimizer contributes a score-only inherited failure,
  `solver_a13e9b0c8e27`, which exits the domain after only reaching `11.895L`.
  No policy, trajectory, or visual diagnostics for it are inherited here, so
  it is evidence to preserve the complete sampled capture scaffold, not
  evidence for a causal gain or mechanism claim.

## Candidate hypothesis

Replace the prefill's approach-only wrong-sign-yaw posterior bend with one
small pre-approach course residual. Preserve the captured oscillator,
target-vector steering, drive relief, terminal redirect, half-cycle steering,
and posterior traveling-wave lag unchanged. Compute velocity course and target
direction in the body frame, smoothly gate their wrapped error by observed
speed and by the complement of approach weight, and add only a bounded mean
tail curvature. This introduces no time, route, coordinates, raw world-frame
direction, or new oscillator state.

The residual should begin at zero from rest, align translation earlier once
speed is established, fade out as the already-supported approach redirect
takes over, and preserve the coherent traveling wake. The formal evaluation
should support it only if far/middle course error and the late-hook path shrink
beyond byte-identical repeat variation while capture, command/rate residence,
joint margin, force/moment loads, and both wake views remain non-worse.

bookshelf_consulted: true
source_domain: sensor-feedback robotic-fish direction tracking over a rhythmic CPG, with classical target-derived mean-curvature turning
source_mechanism: retain the propulsive traveling rhythm and add a bounded feedback residual from directional tracking error
transferable_invariant: correct persistent mismatch between desired and actual translation with the smallest bounded state-feedback residual that preserves propulsion
nontransferable_details: published gains, dimensional beat timing, clock-driven CPG phase, species-specific kinematics, exact wake phase, and task-specific routes
policy_translation: use wrapped body-frame target-versus-velocity course error, normalized by its existing scale and gated by body-frame speed, to add a small pre-approach tail-curvature residual that fades into the existing terminal redirect
falsification: reject if far/middle course error or path length does not improve beyond exact-policy repeat variation, or if capture, command/rate residence, joint margin, force/moment loads, or top-down/oblique wake coherence regress
