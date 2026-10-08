# Closing-gated reverse-wave braking candidate

## Evidence diagnosis

- Every sampled observation and diagnostic reports direct uniform still-water
  initialization with `U_infinity=(0,0,0)` and no prewarm. The displacement
  and wake are therefore self-propelled rather than imposed-flow advection or
  moving-window motion.
- Both rows of the assigned parent's combined keyframe sheet show an
  alternating, coherent wake through a capture-scale approach and then a
  pass-through trajectory. The fish reached `0.870635L` at `27.412T` without
  instability, but it still carried about `0.633L/T`; its velocity-defined
  projected miss was about `0.809L`, outside the `0.75L` capture circle. At
  that sample the body was turning rapidly (`heading_rate=1.289 rad/T`) and
  the terminal wave was live (`qdot1=-1.736 rad/T`, posterior command
  `11.683 rad/T^2`), yet the miss exceeded the inherited settled-C best of
  `0.827823L`. Dynamic joint motion and body yaw therefore did not establish
  useful terminal velocity rotation.
- The parent remained a low-load failure: sampled peak planar force and yaw
  moment were about `0.0214` and `0.00979`, close to the low-load
  intercept-qualified comparison (`0.0218/0.00963`) and far below the
  posterior-redistribution failure (`0.212/0.0968`). The problem is not a load
  spike or lost wake coherence. It is insufficient braking/velocity-vector
  correction during a high-speed pass.
- The best sampled scalar score (`solver_b6ed3f84ab58`) is not the useful
  terminal carrier: both visual rows keep it in the upper corridor, it reaches
  only `5.386L`, touches the angle boundary, and has the largest sampled load
  peaks. The parent guidance and inherited logs also show that static bend
  depth, redirect thresholds, isolated-joint pulses, C-to-S recoil, and the
  ordinary terminal traveling wave all preserve `left_domain`. Another gain
  increase or same-direction wave is therefore unsupported.

## Policy hypothesis

Preserve the parent's far-field oscillator, response-calibrated turn side,
redirect, and miss-qualified C-bend. In the terminal miss-veto region, use the
observed windowed closing speed to blend in a small mean-centered anterior
oscillator whose posterior derivative term has the opposite sign from the
propulsive carrier. This reverses the two-joint wave direction only while the
fish is closing too quickly on a predicted miss; when closing speed falls, it
returns continuously to the settled redirect. Start the continuous approach
gate outside the parent's `1.75L` onset so the hydrodynamic braking impulse can
act before the target station, while leaving the evidenced far trajectory
unchanged.

The mechanism should preserve the calibrated curvature side but trade a small
amount of axial momentum for time to rotate the velocity vector into the
capture circle. Reject it if it fails to beat `0.827823L`, if speed does not
fall materially below the parent's `0.633L/T` before closest approach, if it
only increases body yaw without reducing projected miss, or if wake coherence,
angle margin, loads, or limit residence approach the posterior-redistribution
failure.

bookshelf_consulted: true
source_domain: classical traveling-wave propulsion and closed-loop robotic-fish approach control
source_mechanism: wave direction sets the direction of reactive momentum transfer, while observed approach state gates the locomotor mode
transferable_invariant: a bounded reversal of joint-to-joint phase propagation can oppose the propulsive impulse, and measured closing speed can confine that braking load to an urgent near-target approach
nontransferable_details: published gains, dimensional frequencies, species-specific envelopes, exact phases, prescribed stopping distances, and open-loop timing
policy_translation: retain normalized body-frame target and velocity geometry, keep the calibrated same-sign C-bend, and reverse only the posterior joint-state derivative coupling under smooth distance, projected-miss, closing-speed, and angle-headroom gates
falsification: reject if minimum distance does not beat 0.827823L, approach speed is not reduced, velocity does not rotate toward the target, the far carrier changes, or wake/load/limit diagnostics degrade materially
