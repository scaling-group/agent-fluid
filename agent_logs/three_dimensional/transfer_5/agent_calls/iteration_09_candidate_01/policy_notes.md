# Balanced half-cycle terminal-curvature candidate

## Visual and quantitative diagnosis before editing

- All four sampled policies are valid direct-uniform still-water rollouts:
  `U_infinity=(0,0,0)`, no cylinders or prewarm snapshot, stable dynamics, and
  capture. In the best sampled v24 sheet and the slower v23 sheet, the
  top-down row shows self-propelled motion along the same broad target-directed
  arc with a strong alternating vortex train; the oblique row confirms
  coherent paired three-dimensional structures through capture. The visible
  topology is unchanged at keyframe resolution, so trajectory histories carry
  the terminal comparison. The inherited semantic failure boundary remains
  the weak-wake upper exit caused by replacing this carrier with opposite-sign
  static posture.
- The v24 phase-demodulated controller is the strongest sampled progress
  result: capture at `23.8315T`, scoring mean distance `2.434073L`, and mean
  closing speed `0.683U` inside `3L`. The v25 hard direction-consensus gate is
  later (`23.8590T`) without a material terminal cleanup, while the v26
  yaw-directed branch is also later (`23.8535T`, mean distance `2.434214L`)
  and slightly worsens mean absolute yaw/cross-track speed inside `3L` to
  `1.687 rad/T` and `0.239U`. Inside `1L`, its cross-track speed rises to
  `0.391U` versus v24's `0.381U`. Direction arbitration is therefore not the
  evidenced lever to extend.
- The completed inherited half-cycle experiment provides a different useful
  trajectory despite a worse scalar score. Applying v24's terminal curvature
  only on the supporting stroke captures later at `23.9085T` with mean
  distance `2.434609L`, but lowers peak yaw from `3.208` to `2.991 rad/T`,
  mean cross-track speed inside `3L` from `0.239` to `0.220U`, and inside
  `1L` from `0.381` to `0.266U`; its two-view sheet retains the coherent
  wake. The hard gate removed too much mean correction/closing authority, but
  its state-synchronized redistribution produced the clearest sampled
  terminal-course improvement.
- All compared policies have zero sampled angle-limit exposure and nearly the
  same joint-speed-cap exposure, so posture range or another projection gain
  is not the missing capability. The next test should preserve the v24
  carrier, terminal direction, and average curvature while changing only how
  that curvature is distributed over the observed stroke.

## Policy hypothesis

Use v24 as the sole base. Infer stroke direction from normalized posterior
tangent velocity, as in the completed half-cycle experiment, but replace its
zero-on-the-opposing-stroke gate with a bounded multiplier centered on one.
The supporting stroke receives more of the existing terminal curvature and
the opposing stroke receives less, while neither loses all correction and a
symmetric beat retains approximately the v24 mean authority. This is a new
state-feedback allocation mechanism, not a cadence or curvature-gain probe;
the traveling-wave oscillator, same-sign redirect, response release,
carrier-rejected course/yaw signal, and smooth final projection remain intact.

Expect capture and both coherent wake views to survive, with arrival/mean
distance closer to v24 than the hard half-cycle result and terminal cross-track
speed, yaw, or lateral load materially below v24. Falsify the mechanism if
capture is lost, arrival exceeds `23.91T` or mean distance exceeds `2.43461L`
without a compensating route/load improvement, the alternating wake weakens,
or joint-speed/command exposure grows.

## Bookshelf transfer

```text
bookshelf_consulted: true
source_domain: robotic-fish CPG half-cycle amplitude and duty-ratio turning
source_mechanism: generate mean turning by state-synchronized asymmetric strokes while retaining a propulsive rhythmic carrier
transferable_invariant: redistribute a bounded route-scale turn residual toward the observed supporting stroke without suppressing the traveling-wave carrier or all corrective authority on the opposite stroke
nontransferable_details: published gains, dimensional cadence, robot linkage kinematics, species-specific envelopes, exact oscillator or vortex phase, and prescribed routes
policy_translation: normalized body-frame target, velocity, and yaw retain the v24 terminal request; normalized posterior tangent velocity modulates the existing two-joint curvature above and below its unit mean with bounded state feedback
falsification: reject if capture or alternating-wake coherence is lost, or if arrival, distance integral, terminal yaw/course, loads, joint speed, and command exposure do not improve jointly over v24 and the hard half-cycle result
```
