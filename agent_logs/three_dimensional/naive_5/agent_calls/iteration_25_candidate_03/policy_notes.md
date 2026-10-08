# Posterior wave-shape promotion with a terminal-allocation boundary

## Evidence diagnosis before editing

- All four sampled episodes satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm snapshot, and inertial
  moving-window transport. All terminate in capture, so there is no sampled
  semantic failure. The assigned parent is the duplicated anterior
  capture-corridor response policy; the no-terminal-residual sample is the
  informative mechanism control.
- The combined sheets for the assigned parent, the no-terminal-residual
  control, and the highest-scoring posterior sample were inspected in both
  views. Their top-down rows show self-propulsion from rest, a coherent
  alternating vortex train through the long approach, and the same late
  correct-sign hook into the target disk. Their oblique rows show compact,
  connected three-dimensional wake structures through the turn. The wake
  trails the moving fish, and neither row shows imposed advection,
  moving-window yaw, wake breakup, or boundary interaction.
- The assigned parent captures at `0.749089539L` and `26.301020T`, with mean
  score distance `2.519875243L`. Its anterior course-response residual first
  changes an action at `24.299009T` and `1.746692L`, but relative to the
  no-terminal-residual control it moves the centerline by at most
  `0.002771L`; the inherited evidence therefore does not support increasing
  this residual or retuning its capture-corridor thresholds.
- The posterior phase-lag sample captures at `0.748829007L` and
  `26.295521T`, with mean score distance `2.519670835L` and the best sampled
  score, `-0.616845595`. Relative to the assigned parent it moves the
  centerline by at most `0.002788L`. More importantly, relative to the
  no-terminal-residual control its new action begins only at `1.646831L`,
  moves the centerline by at most `0.000591L`, and changes a two-joint action
  by at most `0.438599 rad/T^2`. The two visual rows cannot resolve a route or
  wake-topology change.
- Peak planar force/yaw moment are identical across all four samples at
  `0.0188344/0.00978884`. Their maximum joint angle, speed, and acceleration
  are also identical at `0.772361 rad`, `4.512809 rad/T`, and
  `29.725850 rad/T^2`, below the respective hard envelopes. Thus the posterior
  sample preserves the established coordinated soft envelope and angle/rate
  guards, but its milliscale distance difference is not evidence that more
  terminal lag modulation will add capture clearance.
- Inherited optimizer logs already reject terminal damping, recoil,
  reverse-wave braking, deeper-curvature scalars, and a binary instantaneous
  projected-intercept hold. Together with the two new allocation comparisons,
  that closes scalar tuning of the current terminal correction family at this
  fixed pose. Held-out geometry or a genuinely different response observation
  is needed to establish robustness; duplicated shallow boundary crossings do
  not do so.

## Policy hypothesis

Promote the highest-scoring sampled posterior wave-shape policy exactly as the
single candidate. Preserve the evaluated traveling-bend carrier, target-line
response, redirect, coordinated acceleration envelope, and reflection-
equivariant angle/rate guards. Only when the existing normalized approach,
projected-miss, closing, response-deficit, and course/target-line agreement
gates coincide, modulate posterior lag from anterior joint-state phase. This
is conservative evidence-based selection, not a claim that the terminal
mechanism has a useful resolved effect.

The candidate should reproduce capture, the coherent two-view wake, zero
actuator contacts, and the sampled load envelope. Falsify the promotion if its
rollout loses capture, changes the carrier outside the terminal gate, restores
limit contact, raises loads, or fails to reproduce the sampled trajectory. A
repeat of the `0.748829L` crossing establishes only deterministic transfer at
the fixed initial condition. Do not interpret a repeat as support for more lag
gain; require a visibly different useful route, materially deeper clearance,
or held-out capture before reopening terminal allocation.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning and sensor-modulated direction tracking
source_mechanism: bounded inter-joint phase-lag modulation of a productive rhythmic carrier
transferable_invariant: steering modulation should be conditional on normalized target error and inadequate observed response while leaving the useful traveling carrier unchanged elsewhere
nontransferable_details: published gains, dimensional beat frequencies, robot or species kinematics, full-body waveforms, exact vortex phases, and prescribed routes
policy_translation: retain body-frame target-line feedback and use anterior joint-state phase to modulate only posterior lag when approach, projected miss, closing, response-deficit, and turn-side agreement all hold
falsification: reject if capture, wake coherence, actuator viability, or load exposure worsens; even repeat capture does not justify scalar lag tuning unless route or clearance changes materially

## Non-CFD implementation audit

- The candidate byte-matches the evaluated highest-scoring posterior sample
  (`4580d9f06d20a060094449ada814d6b20af73e17fb186c33f5dbd88478df90d3`).
  This establishes exact policy provenance, not a new CFD claim.
- The required checker agent was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable for this account. Its three prescribed commands were then run
  directly and separately: the reusable-guidance/schema check, finite
  two-joint Julia contract, and solver editable-boundary check all pass.
- The rendered workspace initially marked the same guidance parent twice; only
  the duplicate `prefill` marker was removed so the semantic-delta check could
  identify the already assigned parent unambiguously. No CFD was run.
