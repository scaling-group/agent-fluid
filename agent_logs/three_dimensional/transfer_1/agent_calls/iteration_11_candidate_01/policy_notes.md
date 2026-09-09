# Wake-policy candidate diagnosis

## Evidence read before editing

- All four sampled episodes report direct uniform initialization in still water
  with `U_infinity=[0,0,0]`, no cylinders, and no prewarm. Their finite motion
  and alternating wakes therefore establish self-propulsion rather than
  ambient advection; none terminated for numerical instability.
- Both rows of the combined keyframe sheets were inspected. The sampled
  LOS-guarded achieved-course policy is the only semantic success: it retains
  a coherent top-down alternating vortex street and compact oblique Lambda2
  structures through capture at `0.7493448L` and `18.6065T`. The sampled
  terminal mean-curvature policy retains a substantial wake but turns below
  the target, misses at `1.5454L`, and exits through the lower boundary. The
  prefilled phase-compensated rate policy also preserves a wake, but does not
  acquire the required route and approaches only `3.0031L` before its left
  exit. These comparisons support the successful carrier/course structure,
  not more bearing gain, carrier attenuation, cadence relief, or static
  curvature.
- The assigned parent's inherited logs materially narrow the apparent
  success: a replay of the exact LOS-guarded policy bytes with matching case,
  geometry, and IBM hashes missed at `1.7715L` and returned to the lower-exit
  topology. Both the capture and repeat failure kept an alternating terminal
  wake and about `0.82--0.85L/T` pass speed, while acceleration was clamped on
  roughly `69--73%` of rows and both joints touched the speed limit. The
  failure is therefore a fragile steering-release decision in a saturated
  close pass, not missing propulsion or insufficient scalar authority.
- Parent trace projection supplies a discriminating observation. Below `2L`,
  release-active rows in the repeat failure project a closest pass of at least
  `1.27L`, whereas most release retained by the captured trace already lies in
  an approaching capture-compatible corridor. Normalized target/velocity
  intercept geometry can veto unsafe release without adding acceleration.

## Candidate mechanism and falsification

Start from the completed LOS-rate-guarded achieved-course controller. Preserve
its joint-state traveling bend, cadence schedule, shared course steering,
phase-compensated yaw-response release, and LOS-rate re-engagement. Add one
continuous intercept-compatibility guard inside a body-frame distance gate.
Project the current target vector onto measured inertial velocity: target and
velocity dot product distinguishes approach from recession, while their cross
product divided by speed estimates closest-pass distance. Retain steering
release only when the projected ray is approaching and passes through a smooth
target corridor; otherwise retain the already-existing bounded steering. This
guard never amplifies steering and is inactive in the far field.

Expected test: reproduce broad course acquisition and the coherent terminal
wake while preventing response-based release on a projected miss, yielding a
repeatable capture or at least improving the inherited exact-policy repeat's
`1.7715L` pass without increasing saturation or loads.

Falsification: reject if closure changes outside the terminal gate, the
alternating wake weakens, closest approach does not improve on `1.7715L`, the
same lower-exit topology remains, action/rate saturation or loads increase, or
the guard oversteers a trajectory whose projected ray was already inside the
capture corridor. A single new capture would still require replay before it
is called robust.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish direction tracking and adaptive prey-capture control
source_mechanism: preserve rhythmic propulsion while sensed target-relative interception geometry gates release of bounded steering
transferable_invariant: a locomotor response may release target steering only when normalized target-relative motion is compatible with interception
nontransferable_details: published gains, robot or species kinematics, dimensional cadence, prescribed CPG or vortex phase, learned task routes, and source-specific corridor sizes
policy_translation: multiply the existing terminal response release by a smooth body-frame approach-alignment and projected-pass compatibility guard while leaving the two-joint carrier and steering authority unchanged
falsification: reject if far-field closure changes, the coherent wake weakens, the inherited repeat-failure pass does not improve, capture is lost on the useful topology, or saturation and loads worsen

## Non-CFD verification

- Recomputing the frame-invariant projection from sampled world-frame traces
  confirms the sign and scale: at closest approach the captured trace has
  approach alignment `0.3185` and projected pass `0.7103L`, while the terminal
  mean-curvature failure has alignment `0.3910` but projected pass `1.4224L`.
  The prefilled phase-rate failure never enters the `2.75L` guard. This is an
  observation-discrimination check, not a claim about closed-loop CFD.
- The material-guidance checker and editable-boundary checker pass. A static
  audit finds no `params.FIELD` reference missing from `target_policy_params`.
  The mandated Julia smoke could not run because Julia is not installed in the
  workspace environment; no CFD or runtime outcome is claimed.
