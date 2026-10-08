# Multi-wake policy diagnosis and hypothesis

## Evidence diagnosis

- The four sampled released sheets and metrics are exact duplicates of a
  finite success, so they provide a strong deterministic baseline but no
  sampled failure sheet. The shared prewarm sheet shows the fish held above
  and downstream of four fully developed, interacting vortex streets, with
  the target inside the merged second-row wake.
- After release, the policy makes a sharp targetward redirect and then keeps a
  coherent leftward/downward traveling-bend trajectory into the useful wake
  region. Mean fish velocity `(-0.3132,-0.1276)` exceeds mean local-flow
  advection `(-0.2018,-0.1721)` in the targetward streamwise direction, so the
  approach is substantially self-propelled rather than passive drift. It
  captures at `34.7105` with mean distance `1.62283L`.
- The maneuver is still actuator- and load-limited: both joints reach the
  `260 deg/time` speed cap and the `30.0` policy acceleration envelope, while
  relative-crossflow RMS is `0.24023` and force/moment RMS is
  `68.96/1036.40`. The latest inherited step-16 outcome still captures but is
  worse in arrival (`35.0845`), mean distance (`1.63577L`), total energy
  (`47418.8`), crossflow (`0.24277`), and force/moment (`75.85/1146.58`).
- Inherited negative evidence rules out putting prediction into persistent
  mean-route steering: that topology exited after `18.304` with negative
  progress. It also rules out treating speed as a standalone wake proxy.
  New response feedback therefore belongs only on the optional redirect burst.

## Policy hypothesis

Keep the validated oscillator, posterior lag, raw-bearing mean steering and
reserve, base half-cycle asymmetry, signed-moment response, and coherent
two-joint speed release. Add direct targetward yaw response to the existing
surplus-burst release. Normalize observed body-frame `heading_rate` as the
angle turned during one control period relative to the same bearing scale
already used by redirect response. This should stop adding burst asymmetry as
soon as the body—not merely the slower target-bearing window—has begun the
requested turn, without weakening base steering when yaw opposes the target.

bookshelf_consulted: true
source_domain: biological burst turning and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: release a strong redirect after observed targetward heading response appears
transferable_invariant: preserve rhythmic propulsion and gate only surplus turn authority by bounded observed maneuver response
nontransferable_details: species-specific C-start shape, published CPG gains, clock phase, dimensional turn rates, and prescribed routes
policy_translation: multiply only the optional half-cycle burst by a soft target-signed heading-rate release normalized over one control period
falsification: reject if capture is lost, arrival or mean distance regresses, force/moment or limit contact increases, or the released route loses its coherent upstream traverse
