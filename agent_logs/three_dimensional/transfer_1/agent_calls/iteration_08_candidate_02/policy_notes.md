# Steering-preserving saturation candidate

## Evidence and visual diagnosis before editing

- All four sampled evaluations satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, finite dynamics, and
  `capture`.  Three evaluations reproduce the progress-gated posterior-thrust
  controller exactly at `26.0425 T`, score `-0.69471683`, and distance integral
  `2.59751 L`; the completion-gated control captures at `26.4110 T`, score
  `-0.71050181`, and distance integral `2.61340 L`.  The repeated improvement
  is therefore deterministic evidence for preserving the posterior residual.
- I inspected the combined top-down vorticity and oblique Lambda2 sheets for a
  reproduced posterior-thrust capture and the weaker completion-gated capture.
  Both show self-propelled motion from quiescent water: an alternating sheet and
  compact three-dimensional structures develop behind the posterior body,
  remain coherent through the broad target-signed arc, and enter the capture
  disk without collision or wake collapse.  The posterior-thrust sheet does
  not justify a more dramatic wake; its useful difference is target approach.
- Trajectory metrics support that reading.  At `24 T`, posterior thrust is at
  `2.0645 L` rather than `2.2456 L`, and mean/max speed increases from
  `0.5013/0.6669` to `0.5081/0.7170 L/T` without increasing the sampled peak
  force/moment coefficients (`0.02974/0.01484`).  The inherited aligned-cadence
  result is a negative control: it captures at `26.5430 T`, is at `2.304 L` at
  `24 T`, and raises peak force/moment to about `0.0319/0.0159`.  Earlier
  terminal drive relief and outward-speed guarding also delayed or lost the
  otherwise useful capture, so another carrier or speed gain is not isolated.
- The reproduced best trajectory exposes a different limitation: its
  componentwise projected action touches at least one `1800 deg/T^2` bound in
  `84.35%` of logged rows and `90.81%` after `20 T` (`69.46%` head, `38.18%`
  tail, `23.30%` both).  The policy currently sums the carrier and target
  steering before projection.  When the carrier already exceeds the bound,
  a smaller opposite-sign steering term can be erased by that final clamp,
  even though half-cycle asymmetry is the intended turning mechanism.

## One-candidate policy hypothesis

Retain the evaluated completion-gated redirect, progress-gated posterior lag,
target guidance, joint-state oscillator, and parameter-owned acceleration
limit.  Change only command allocation: project each carrier contribution to
the actuator envelope first, then add and project the bounded target-steering
residual.  Same-sign steering still uses the existing bound; opposite-sign
steering can reduce the saturated carrier half-cycle instead of being masked.
This translates the existing half-cycle steering into an actuator-feasible
amplitude/duty asymmetry without adding a clock, route, world coordinate,
wake phase, or scalar carrier increase.

Expected evidence is the same coherent posterior wake and semantic capture,
with a tighter target-signed arc or earlier arrival because steering remains
effective during the heavily saturated middle and terminal route.  Falsify
the mechanism if capture is lost or delayed beyond `26.0425 T`, distance
integral exceeds `2.59751 L`, the alternating wake or posterior-thrust benefit
degrades, force/moment grows materially, or reduced saturated half-cycles cost
more closure than the restored steering supplies.  The new candidate has no
same-worker CFD evidence; evaluation occurs after exit.

bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping and sensor-modulated CPG direction tracking
source_mechanism: target feedback produces turning by bounded half-cycle amplitude or duty asymmetry while the rhythmic carrier persists
transferable_invariant: a smaller target-steering residual must retain authority over the useful half-cycle even when the propulsive carrier reaches the actuator envelope
nontransferable_details: published gains, robot geometry, dimensional cadence, prescribed duty ratios, species-specific kinematics, exact vortex phases, and task-specific routes
policy_translation: project the two observed-joint-state carrier accelerations first, then apply and project the existing normalized body-frame target steering so opposite-sign steering can unload a saturated half-cycle
falsification: reject if capture time or distance integral regresses, carrier coherence or posterior thrust is lost, loads increase, or saturation-aware steering fails to tighten the target-directed arc
