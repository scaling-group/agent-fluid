# Candidate diagnosis and hypothesis

## Evidence diagnosis before policy edit

All four sampled evaluations report `uniform_direct` initialization with
`U_infinity=[0,0,0]`, no cylinders, and valid combined top-down/oblique sheets.
The images therefore show self-generated motion rather than advection or a
prewarmed wake.

- `solver_610ca5f49cc1` is the only semantic success. Its top-down row shows a
  coherent alternating wake throughout a smooth target-directed translation,
  and the oblique row shows compact paired caudal Lambda2 structures rather
  than a stalled or disorganized body wake. Distance decreases from `12.3277L`
  to capture at `0.7482L` and `19.228T`; local-flow magnitude remains below
  about `0.025U`, planar force coefficient below `0.032`, and moment
  coefficient below `0.017`. The gait is productive despite beat-scale yaw
  spanning roughly `[-3.17,3.20] rad/T`. Its weakness is actuator demand:
  direct acceleration requests exceed the downstream limit on about
  `61.9%/72.0%` of rows and joint-rate limits are touched on about
  `13.9%/16.6%`.
- `solver_6f7220e1f457` preserves a similarly coherent wake and reaches
  `1.0927L` at `19.058T`, but its full geometry-held redirect carries the fish
  below the target and onward to a boundary exit at `32.071T`. The top-down
  sheet visibly curls away after the near pass; metrics confirm distance grows
  to `9.5549L`. Its behind-target `atan` request can remain saturated near
  `+/-pi`, so it lacks the successful candidate's bounded response release and
  direction-cosine attenuation.
- `solver_d282288428b4` produces a straight, coherent axial street but passes
  far above the target: closest approach is `4.9765L` before exit. Its
  invertible turn-rate error compares target-scale response with beat-scale yaw
  and therefore repeatedly changes steering sign instead of creating mean
  route curvature.
- The assigned prefill, `solver_9494a759fc59`, combines posterior-only
  curvature, an inverse response gate, and per-joint `tanh` acceleration
  compression. Both visual rows show weak translation followed by a sharp
  upward curl; it exits at `9.576T` after improving only to `11.7021L`.
  Because this bundle removes all over-limit requests while also losing the
  useful trajectory, acceleration smoothing cannot be credited as an
  improvement and should not be separated from allocation inferences.

The assigned parent guidance and inherited score logs already reject
scalar-only curvature tuning. The new sampled capture supplies the missing
positive boundary: keep normalized target geometry authoritative over turn
sign, distribute a modest mean bend with opposite signs across the joints,
and let raw yaw response reduce but never reverse that bend.

## Policy hypothesis

Adopt the sampled capture architecture as one candidate: a joint-state
traveling-bend carrier, normalized body-frame lateral direction cosine for the
route request, opposite-sign `4 deg` anterior / `10 deg` posterior mean
curvature, and a one-sided yaw-response gate limited to `35%` release. This is
a mechanism selection from completed CFD evidence, not a scalar retune of the
failed prefill. In the repeated fixed episode it should retain the coherent
wake and capture topology. Falsify it if the released evaluation does not
capture, loses monotone broad-scale progress, changes to a boundary-exit
topology, or materially worsens rate/acceleration saturation. The existing
high action demand remains an explicit later target; do not bundle an untested
soft limiter into this recovery candidate.

bookshelf_consulted: true
source_domain: robotic-fish direction tracking layered on a low-dimensional CPG, with classical slender-swimmer posterior emphasis
source_mechanism: bounded target-driven mean-curvature asymmetry superposed on a traveling bend, with observed turn response releasing the redirect
transferable_invariant: persistent body-frame target geometry must own steering sign while anterior steering remains modest and posterior lag continues to carry propulsion
nontransferable_details: published gains, dimensional beat frequency, species envelopes, full-body splines, exact vortex phase, and source-task routes
policy_translation: normalize target lateral displacement by head distance; map it to bounded opposite-sign joint biases; use clamped measured yaw only as a one-sided partial release; retain joint-state phase and posterior lag
falsification: reject if capture is lost, the alternating 3D wake collapses, yaw release chatters into sign reversal, broad-scale distance ceases to improve, or actuator saturation worsens
