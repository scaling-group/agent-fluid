# Translation-consistent target-line steering

## Evidence diagnosis before editing

- All four sampled evaluations satisfy the direct-uniform still-water
  contract: `U_infinity=(0,0,0)`, no cylinders, no prewarm, stable dynamics,
  and inertial moving-window transport. Three byte-match the prefilled policy
  and visual sheet and capture at `0.748829L` and `26.2955T`; the coordinated
  carrier control also captures at `0.749242L` and the same arrival time.
- The combined sheets for the best sampled policy and its carrier control were
  inspected from release to termination. Their top-down rows show genuine
  self-propulsion, an organized alternating wake, and the same late hook into
  the capture circle. Their oblique Lambda2 rows show the same compact,
  coherent three-dimensional wake. Neither view shows imposed advection,
  breakup, a boundary interaction, or moving-window-induced yaw. The assigned
  parent's middle-approach arbitration sheet was also inspected and preserves
  this topology while arriving about `0.044T` later.
- Metrics agree with the images. The sampled posterior modulation improves
  final clearance by only `0.000413L` over its carrier control, with mean
  distance `2.519671L` versus `2.519981L`; the peak joint state, acceleration,
  planar force, and yaw moment remain effectively unchanged. The inherited
  arbitration test captures at `0.749581L` with score `-0.617304`, worse than
  the prefill's `0.748829L` and `-0.616846`, and differs from its centerline by
  only about `0.023L`. Other inherited completed tests of collision-cone
  redirect re-entry (`0.749413L`) and terminal posterior half-cycle
  redistribution (`0.749146L`) also remain shallow captures. These results
  reject more terminal amplitude, redirect, corridor, or conflicting-drive
  withdrawal tuning as a semantic improvement.
- The common trace exposes a different observation defect. Recomputing target-
  line rotation directly from normalized body-frame target and translational
  velocity, `(velocity x target)/distance^2`, gives a persistent positive
  rotation throughout the `4.5--1.75L` middle approach and the sub-`1.75L`
  capture approach. In contrast, the inherited
  `bearing_window_rate + turn_rate_recent` estimate flips sign with the gait:
  it is positive for only about `45%` of middle samples and `62%` of near
  samples, with RMS magnitudes near `3.18` and `1.71 rad/T`, versus `0.144` and
  `0.479 rad/T` for the translation-based rate. The folded bearing uses
  `abs(target_body_x)`, so adding body turn does not remove the observed
  tail-beat-scale rotation as its comment assumes. Meanwhile the course cross
  ratio reaches about `0.94` and the projected miss remains about `0.705L` at
  capture. This supports phase rejection in the route-direction observer, not
  more steering gain.

## Policy hypothesis

Preserve the capture-proven traveling-bend carrier, redirect, response-deficit
magnitude, posterior allocation, coordinated acceleration envelope, and
angle/rate viability guards. Add one translation-consistency mechanism inside
the existing anterior target-line response: compute normalized inertial target-
line rotation from the body-frame target/velocity cross product, use its
bounded magnitude as confidence, and smoothly blend the inherited gait-
contaminated turn side toward this translation-consistent side only when course
is observable and both geometric signals request the same target side. Do not
increase the response gain or command envelope. Far, low-speed, or geometrically
disagreeing states retain the evaluated response; the capture-only posterior
channel remains unchanged.

The formal rollout should retain the coherent two-view wake, capture, zero hard
limit contacts, and the sampled load envelope while producing an approach change
larger than the inherited milliscale cluster or a deeper capture. Reject the
mechanism if it loses capture, merely reproduces the same shallow crossing,
chooses the wrong reflected side, destabilizes the wake, or increases limit and
force/moment exposure. The new CFD result is not available in this worker.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish direction tracking and wake-disturbance separation
source_mechanism: sensory route feedback modulates the useful half-cycle while slow target geometry is separated from fast oscillatory body and flow motion
transferable_invariant: preserve the productive carrier and let persistent normalized target-vector kinematics select steering side instead of treating gait-scale yaw as target-line rotation
nontransferable_details: published gains, robot morphology, species kinematics, dimensional frequency, clock phase, exact vortex phase, and task-specific routes
policy_translation: use the normalized body-frame velocity/target cross product divided by target-distance squared as a bounded line-of-sight-side confidence, then blend only the existing response side when it agrees with observable course error
falsification: reject if capture or coherent self-propulsion is lost, reflection symmetry fails, the trajectory remains in the shallow milliscale cluster, or actuator/contact/load exposure rises

## Non-CFD implementation audit

- The required check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable on this ChatGPT account. Its three configured commands were
  therefore run directly and separately after the final edit. The material
  guidance/notes check, finite two-joint Julia policy and parameter-schema
  contract, and solver editable-boundary check all pass. No CFD was run.
- A deterministic grid of 104,976 paired states has finite commands within the
  `30 rad/T^2` policy envelope and zero numerical reflection error. The added
  distance confidence makes the candidate exactly command-identical to the
  sampled parent at and beyond `4.5L` on the frozen trace.
- On that trace the mechanism changes 1,126 of 4,781 commands, with 607 changes
  larger than `0.05 rad/T^2`. Material activation begins near `3.89L`; the
  maximum command difference is `2.65 rad/T^2` near `1.24L`. This establishes
  a bounded and materially testable observer/allocation change, not a claim of
  hydrodynamic improvement before the next formal evaluation.
