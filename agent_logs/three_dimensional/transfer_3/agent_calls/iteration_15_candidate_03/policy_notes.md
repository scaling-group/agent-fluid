# Adverse lateral-force veto for terminal course release

## Evidence and visual diagnosis before the policy edit

- All four sampled evaluations satisfy the frozen Phase-2 contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite moving-window dynamics, and capture from
  `12.32772 L` at `25.1185226 T`.
- The assigned parent and three sampled solvers are byte-identical v28
  policies. All three evaluations reproduce score `-0.5281032175`, mean
  distance `2.4291077322 L`, and final distance `0.7461626530 L`; this turns
  the inherited one-sample course-supported release into a deterministic
  three-run result. The distinct v26 sample is slightly worse at
  `-0.5281078349`, `2.4291113720 L`, and `0.7461675406 L`, with the same
  capture step.
- I inspected the complete combined top-down vorticity and oblique
  body/Lambda2 sheets for v28 and the informative v26 comparison. Both show
  self-propulsion along the same compact target-directed arc, a coherent
  alternating posterior wake through the outer approach, finite 3D vortex
  packets, and a quiet held-bend handoff into capture. There is no passive
  advection, late loop, collision, boundary-exit precursor, wasteful terminal
  flailing, or numerical instability. The sheets validate outer
  noninterference but are too coarse to rank the terminal difference.
- The terminal telemetry narrows what the reproduced scalar gain means.
  Inside `1.6 L`, v28 slightly worsens mean/final target-course mismatch from
  `0.384358/0.310201` to `0.384401/0.310311 rad` and final speed from
  `0.654029` to `0.653989 L/T`; it also raises peak force norm from
  `0.002135` to `0.002237` and command maxima from `0.09641/0.24315` to
  `0.09794/0.24564 rad/T^2`. Thus the tiny score gain does not validate more
  course-release authority or a claim of better course alignment.
- Target-side lateral force is helpful on 206 of the 226 stored v28 states
  inside `1.6 L`, but it opposes the target side on the other 20, reaching
  `-0.000744 L`-normalized force. The inherited v27 mean-unloading result
  (`-0.529558`) and course-error half-cycle result (`-0.528123`) already
  reject moving the cue onto static bend or beat-side authority. A bounded
  hydrodynamic veto on only the optional v28 increment is the remaining
  independently active test that preserves those negative boundaries.

## Policy hypothesis

Preserve v28's state-feedback oscillator, posterior lag, target-angle
redirect, closure preview, two-joint terminal equilibrium, crossflow-supported
paired release, and all outer-approach commands. Add one response mechanism:
project the already normalized body-frame lateral force onto the normalized
target-side sign; when that force opposes target-side translation, smoothly
veto only the extra course-supported release, while leaving the validated v26
crossflow release and shared mean bend untouched. Helpful or zero adverse
force leaves v28 exactly unchanged.

This is a force-conditioned response veto, not a gain increase, yaw command,
mean-curvature change, joint-role split, beat-side selector, clock, or route.
It should be exactly inactive outside the existing late response regime and
on target-helpful force states, but active on the 20 stored adverse-force
states. Reject it if replay shows a dormant or discontinuous gate, any outer
command changes, delayed or lost capture, worse mean/final distance or course
closure, or renewed carrier oscillation, joint stops, saturation, load growth,
instability, or wake degradation.

bookshelf_consulted: true
source_domain: wake-interaction control and sensor-modulated robotic-fish rhythmic control
source_mechanism: separate slow target steering from a bounded fast hydrodynamic response while preserving helpful lateral motion
transferable_invariant: with a proven traveling carrier and redirect, measured target-opposing lateral force may veto optional release without adding steering authority or cancelling target-helpful flow
nontransferable_details: published gains, species kinematics, dimensional force thresholds, duty ratios, clock or vortex phase, cylinder geometry, and task-specific routes
policy_translation: multiply only the existing late course-supported paired release by a smooth veto formed from normalized body-frame lateral force and normalized body-frame target side; preserve v26 release, mean bend, and all outer commands
falsification: reject if the force gate is inactive on stored adverse states, affects helpful-force or outer states, delays or loses capture, worsens distance/course response, or restores oscillation, saturation, joint stops, load spikes, instability, or wake loss

## Non-CFD implementation audit

- The lightweight Julia contract returns two finite commands, and every one of
  the candidate's 78 direct `params.FIELD` references is owned by the 79-field
  object returned by `target_policy_params()` (the extra field is `version`).
- Stored-state replay against the evaluated v28 parent makes the veto change
  commands on all 20 evidenced adverse-force states out of 226 states below
  `1.6 L`; four reach full veto, and active-state support averages `0.5507`
  under the declared smooth bound. It remains exactly one on all 206
  helpful-force states. Maximum replayed per-joint command difference is
  `0.00771 rad/T^2` and the terminal mean is `0.0000736 rad/T^2`; the measured
  maximum difference outside `1.6 L` is exactly zero.
- The guidance semantic-difference check, lightweight policy contract check,
  parameter-schema guard, and solver boundary check pass. These establish
  provenance, activation, boundedness, finite output, and edit scope only;
  they do not establish a coupled-flow improvement.

The current candidate's CFD evaluation occurs only after this worker exits and
is not claimed as evidence here.
