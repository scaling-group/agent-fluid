# Candidate diagnosis and hypothesis

## Evidence read before editing

- Every sampled and inherited episode is a finite, direct-uniform still-water
  release with `U_infinity=[0,0,0]`, no cylinders, and no prewarm. The visible
  translation is self-propulsion, and every completed rollout still terminates
  `left_domain`; no prior result supports a capture claim.
- Both rows of the compact sheets were inspected. The shallow upper/left
  `solver_5c5f9d80447b` failure retains a coherent alternating mid-plane street
  and compact oblique Lambda2 structures but reaches only `3.0031L`. The
  target-directed `solver_213717a6b100` and prefilled
  `solver_9ddd873113a3` policies also retain visible wakes while turning below
  the target and reaching `1.5454L` and `1.7708L`. These are controlled
  trajectory failures, not advection or numerical instability.
- The inherited carrier-aligned duty policy reaches `0.9532L` with an active
  terminal wake, whereas moving the pulse to the joint-velocity half-cycle
  worsens the pass to `1.2222L`. More nominal actuator headroom is therefore
  not sufficient; useful beat phase cannot be inferred from unclipped impulse
  alone.
- Response-triggered release of shared course steering is the strongest
  completed result at `0.9312L`. Its top-down and oblique rows retain the
  alternating traveling-bend wake through the close pass. At closest approach
  the fish is still moving about `0.840L/T`, target-normal velocity is about
  `+0.839L/T`, and the corresponding inertial line-of-sight rate is about
  `-0.901 rad/T`. The target-versus-course request remains saturated in the
  corrective sign while joint-compensated yaw has already triggered steering
  release. The remaining `0.181L` capture gap is therefore consistent with a
  release condition that recognizes body yaw but not the still-growing
  geometric miss rate.
- Adding target-normal velocity as posterior mean curvature did not solve that
  issue: the inherited slip-response candidate reached `1.0561L` and kept the
  same lower exit. Target-normal motion should guard the evidenced useful
  release mechanism, not become another additive curvature command.

## Policy hypothesis

Preserve the response-released course servo, state-feedback oscillator,
posterior lag, cadence law, and hard actuator envelope. Derive inertial
line-of-sight rate from the normalized body-frame target vector and achieved
velocity. Near the target, allow correct-sign joint-compensated yaw to release
shared steering only while the signed line-of-sight miss rate remains small;
smoothly re-engage the existing course steering as that rate grows. This adds
no steering gain, mean curvature, carrier attenuation, clock, or world route.

On the inherited `0.9312L` trace the new guard is negligible around the first
`3L` crossing, begins cancelling release during the sub-`2L` pass, and is
fully corrective near closest approach. CFD must test whether that
counterfactual timing survives the changed trajectory and moves the head the
remaining `0.181L` into the capture disk.

Falsification: reject if early distance closure or the alternating wake
changes, closest approach does not beat `0.9312L`, the line-of-sight miss rate
does not fall, saturation grows materially, or the same below-target
`left_domain` topology remains. In that case avoid further additive slip
curvature or duty-phase substitutions; test a different bounded steering
actuator with explicit envelope allocation.

bookshelf_consulted: true
source_domain: biological burst redirect and sensor-modulated robotic-fish terminal direction control
source_mechanism: release a strong target-directed turn into the propulsive rhythm only when the observed response is compatible with the desired approach
transferable_invariant: preserve the traveling carrier while geometric approach response, not elapsed phase or route memory, decides whether bounded steering authority may be released
nontransferable_details: species-specific C-start shapes, published gains, robot kinematics, dimensional cadence, prescribed beat or vortex phase, and task-specific routes
policy_translation: use normalized body-frame target and velocity to guard joint-compensated yaw release; re-engage the existing two-joint course steering when signed inertial line-of-sight rate predicts a miss
falsification: reject if it fails to beat the 0.9312L pass or reduce terminal line-of-sight rate, weakens the coherent wake, increases saturation, changes far-field closure, or retains the lower-exit class
