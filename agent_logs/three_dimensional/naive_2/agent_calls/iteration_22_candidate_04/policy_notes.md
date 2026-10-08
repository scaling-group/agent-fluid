# Approach-bearing carrier-residual candidate

## Visual and metric diagnosis before the edit

- The assigned parent is `optimizer_bf8405575646`, and the prefilled policy is
  its joint-phase-demodulated yaw/lateral-response carrier with a one-sided
  speed guard. All four sampled solvers satisfy the released direct-uniform
  still-water contract: `U_infinity=(0,0,0)`, no cylinders, no prewarm, finite
  dynamics, an active moving window, and capture. The two
  `452903db...` samples capture at `16.604496T`, score `-0.113729`, and scored
  distance integral `1.998146L`; the two `3323ffe...` controls capture one
  `0.0055T` step later at score `-0.115560` and integral `1.999656L`.
- I inspected both rows of the combined keyframe sheets for a strongest
  `452903db...` capture and a weaker `3323ffe...` control. Both top-down rows
  show self-propelled targetward translation, a shallow target-crossing arc,
  and a coherent alternating vorticity street. Both oblique rows show finite,
  tail-connected three-dimensional Lambda2 structures through capture. There
  is no sampled semantic failure; the weaker capture is the informative
  controlled comparator. The visual similarity agrees with a residual
  response change, not a different gait or passive advection.
- Metrics narrow the inherited benefit. Lateral carrier residualization moves
  the final head crossing about `0.020L` lower, advances capture by one step,
  and lowers the distance integral by `0.001510L`, while mean absolute actions
  remain nearly unchanged (`21.733/22.674 rad/T^2`). It also raises peak planar
  force/moment from `0.035828/0.017759` to `0.037165/0.018356` and slightly
  raises speed-near-limit residence. The established full carrier and the
  narrow speed guard should therefore be preserved; stronger actuation is not
  supported.
- The inherited logs show a completed negative response test outside the four
  sampled solvers. Adding bounded approach-only phase-demodulated inertial
  line-of-sight-rate feedforward to this same parent still captured one step
  earlier (`16.598995T`) and retained the connected two-view wake, but worsened
  score to `-0.118996`, scored distance integral to `2.002387L`, and final
  crossing distance to `0.749034L`. Predicting target-line rotation is not the
  next steering mechanism, and its gain should not be retuned from this result.
- A different phase contamination remains in the successful parent. On its
  completed trajectory, a two-term regression of raw bearing against
  `q1_carrier` and `q1_dot` explains `99.7%` of bearing variance from
  `3--6.5L` and `97.8%` inside `3L`; fitted carrier coefficients remain close
  across the two bands (`-0.906/-0.0233` and `-0.931/-0.0215`). Thus the raw
  bearing that currently forms the nominally slow posterior route request is
  itself dominated by anterior beat phase. This is distinct from the failed
  LOS-rate feedforward: it removes an observed carrier component from the
  existing proportional route cue rather than adding a predictive yaw request.

## Sole candidate hypothesis

Preserve the evaluated parent everywhere outside the existing approach gate.
Within that gate, reconstruct the carrier-correlated bearing as
`-0.92*q1_carrier - 0.022*q1_dot` and subtract it from measured bearing before
forming only the posterior `route_turn_state`. Keep raw bearing in the
centerline gate and keep the raw-course anterior center unchanged, so neither
the demonstrated far route nor the anterior carrier/target interaction is
reinterpreted. All lateral, yaw-response, half-cycle, acceleration, and speed
guard mechanisms and gains remain unchanged.

The intended invariant is that slow body-frame target geometry, not the
rhythmic heading excursion produced by the carrier, should select posterior
turn sign. The approach gate makes this a bounded response-level experiment
and preserves the sampled route until `6.5L`. Falsify it if capture is lost,
the pre-approach trajectory changes, the residual bearing remains phase-
correlated, posterior turn sign still reverses with every beat, the connected
wake changes class, or arrival, distance integral, joint contact, saturation,
force, or moment worsens. No CFD result is claimed for this unevaluated child.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and phase-compatible turning asymmetry
source_mechanism: separate the rhythmic locomotor carrier from the slower observed target-direction signal that modulates turning
transferable_invariant: remove an evidence-calibrated joint-phase component from body-frame route geometry before that residual selects bounded posterior steering
nontransferable_details: published gains, dimensional beat frequency, robot or species kinematics, prescribed paths, maneuver timing, and exact vortex phase
policy_translation: preserve the full two-joint carrier and raw anterior course response; within the existing approach gate subtract fitted anterior angle/velocity bearing phase from the posterior route cue
falsification: reject if capture, the inherited far route, residual phase separation, target-crossing arc, connected wake, joint envelope, effort, force, moment, or score regresses

## Evaluation boundary

Later evaluation should compare semantic capture and both visual rows first,
then arrival, scored and observed distance integrals, approach-bearing
correlation with centered anterior joint phase, posterior turn-sign reversals,
head crossing geometry, joint contact, speed/acceleration residence, mean
action, and peak force/moment against the two exact prefilled captures. The
completed fixed-pose regressions calibrate an observer but do not establish
held-out pose, flow, carrier-family, or morphology robustness.
