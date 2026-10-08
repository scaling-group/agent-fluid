# Intercept-corridor terminal response-release candidate

## Evidence and visual diagnosis before the policy edit

- The assigned parent is the prefilled v28 course-supported response-release
  policy. Two sampled copies reproduce capture at `25.1185226 T`, score
  `-0.5281032175`, mean distance `2.4291077322 L`, and final distance
  `0.7461626530 L`. All four current samples use direct uniform initialization
  in still water with `U_infinity=(0,0,0)`, no cylinders or prewarm, and finite
  moving-window dynamics.
- The sampled v29 intercept-corridor candidate is the strongest finite result:
  it retains the same capture step while improving score to `-0.5280772274`,
  mean distance to `2.4290872138 L`, and final distance to `0.7461352944 L`.
  The force-veto alternative is second at `-0.5280861775`, `2.4290942804 L`,
  and `0.7461447120 L`. These separations are terminal and small, so they do
  not justify changing the established outer gait or increasing release
  authority.
- I inspected the complete combined sheets for the best intercept candidate,
  the force-veto alternative, and the inherited v27 mean-unloading regression.
  In every top-down row the fish self-propels along the same compact
  target-directed arc, sheds a coherent alternating wake, and hands off to a
  quiet held-bend glide near capture; there is no passive advection, late loop,
  collision, or boundary-exit precursor. The oblique rows show finite organized
  three-dimensional Lambda2 packets following that arc and no out-of-plane or
  numerical instability. The v27 regression is therefore a subtle terminal
  allocation failure, not a visible wake collapse.
- Telemetry agrees with that visual diagnosis. Below `1.6 L`, the intercept
  candidate has mean distance `1.175529501 L`, mean speed `0.649624126 L/T`,
  peak force norm `0.002192956`, peak moment `0.000565029`, and action maxima
  `0.0977169/0.246102 rad/T^2`. The parent has `1.175532128 L`,
  `0.649620858 L/T`, `0.002237375`, `0.000565449`, and
  `0.0979403/0.245643`; thus the measured gain is not bought with a material
  load or command increase. In contrast, shared mean unloading lowers commands
  but regresses to score `-0.5295582789`, mean distance `2.430257 L`, and final
  distance `0.747692645 L`, so reduced effort alone is not a useful terminal
  objective.

## Policy hypothesis

Promote the measured v29 intercept-corridor mechanism as the single candidate.
Preserve the parent's state-feedback oscillator, posterior lag, target-angle
redirect, closure preview, two-joint mean-curvature equilibrium, helpful-
crossflow response gate, coupled carrier release, and command limits. Replace
only the optional course-angle support with a bounded constant-velocity
intercept measure: compute normalized body-frame cross-track miss from target
geometry and body velocity, and earn the same maximum `3.5%` paired release as
that miss enters the sampled compact corridor. Positive closure, late proximity,
helpful relative crossflow, and settled two-joint response remain independent
mandatory gates.

This is an approach-hold feedback semantic, not scalar-only gain tuning. It is
exactly inactive outside the inherited late response regime, does not change
mean bend, beat side, joint roles, or oscillator phase, and has already produced
the best sampled scalar and terminal-distance result without changing the
capture step or visible wake. Its advantage is only one sample and about
`2.6e-5` in score over v28, so later evidence must reproduce it. Reject it if
capture is delayed or lost, outer motion changes, predicted miss or distance
regresses, a late loop appears, or oscillation, saturation, joint-stop dwell,
force/moment growth, instability, or wake degradation returns.

bookshelf_consulted: true
source_domain: biological burst-response release and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: relax corrective rhythmic allocation only after measured target-relative translation demonstrates an adequate intercept
transferable_invariant: preserve the propulsive traveling-bend scaffold and release a redirect continuously from bounded observed geometric response
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, duty ratios, clock or vortex phase, capture radius, and task-specific routes
policy_translation: normalized body-frame target and velocity vectors form a bounded predicted-miss corridor gate for the inherited small coupled release while closure, proximity, helpful crossflow, and settled joint response remain required
falsification: reject on non-reproduction, outer-path change, increased release authority, changed mean bend or phase, delayed or lost capture, worse miss or distance, renewed joint stops or saturation, load growth, instability, or wake loss
