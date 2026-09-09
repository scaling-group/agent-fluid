# Wake-policy diagnosis and candidate hypothesis

## Evidence read before the edit

- The shared prewarm sheet shows the held fish above and downstream of four
  developed, interacting vortex streets; it is the common initial condition.
- All four sampled solver sheets and their metrics are exact copies of the
  coherent-release success. The fish makes a sharp targetward redirect, keeps
  a traveling two-joint bend, then self-propels left through the mixed wake to
  first capture in `34.7105`, with `1.62283L` mean distance, `46985.9` total
  command energy, `0.24023` RMS relative crossflow, and `68.96/1036.40`
  force/moment RMS. Both joint speed and the `30.0` command envelope are
  touched, so the visible wake passage is successful but not load-relaxed.
- No sampled solver is a termination failure, so no failure keyframe is staged
  for a visual comparison. The inherited guidance supplies the informative
  failures: the target-blind seed exited downward, the opposite-sign steering
  child exited with negative progress, and a slower curvature-equilibrium
  carrier became unstable with extreme load. Those results rule out replacing
  the carrier, steering sign, or acceleration-residual interface here.
- The assigned parent's direct heading-rate replacement preserves the same
  visible redirect-and-upstream topology and reaches in `34.6720`, but worsens
  mean distance to `1.62669L` and force/moment RMS to `91.30/1389.74` while
  only lowering total energy to `46711.7`. An independent inherited log has
  the exact same result. Direct yaw response is therefore not a load-release
  substitute for bearing-window closure.

## Candidate

Preserve the oscillator, posterior lag, bearing-owned mean steering and
reserve, course-slip damping, base/optional half-cycle asymmetry, assisting-yaw
moment response, and coherent two-joint speed release. Replace only the
bearing-window closure factor inside the optional redirect burst with a soft
targetward relative-crossflow response. The sign is body-frame and target
relative: crossflow aligned with the bearing can supply lateral response and
releases surplus burst, while opposing crossflow does not remove established
authority. The normalization scale is the observed dimensionless baseline RMS
(`~0.24`), not a transferred published gain.

Expected test: retain capture and the coherent leftward route while reducing
force/moment load or command/limit contact. Reject the mechanism if capture is
lost, mean distance or arrival materially regresses without a meaningful load
benefit, load rises as it did for heading-rate response, or the same speed and
command contacts remain with no other semantic improvement.

bookshelf_consulted: true
source_domain: organized-wake adaptive swimming and sensor-modulated robotic-fish CPG control
source_mechanism: separate slow route error from fast body-frame wake response and modulate a residual rather than the propulsion carrier
transferable_invariant: persistent target geometry owns mean turning while fast targetward relative crossflow can release only surplus redirect actuation
nontransferable_details: trout Karman-gait timing, species kinematics, published gains and frequencies, exact vortex phase, and source-task routes
policy_translation: keep the two-joint traveling-bend controller intact and replace one optional-burst response factor with bounded same-sign relative-flow crossflow in the body frame
falsification: reject on lost capture, route regression without load benefit, increased force or moment RMS, or unchanged limit contact with no semantic gain
