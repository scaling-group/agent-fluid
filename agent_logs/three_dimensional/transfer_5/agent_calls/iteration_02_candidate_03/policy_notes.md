# Phase-2 candidate diagnosis and hypothesis

## Evidence diagnosis

- All four sampled rollouts satisfy the experiment contract: direct uniform
  still-water initialization with `U_infinity=(0,0,0)`, no cylinders, and no
  prewarm snapshot. The assigned parent guidance and its inherited
  `solver_f578f8771e8a` optimization note attribute the transferred seed's miss
  to a possible yaw-to-bend polarity mismatch plus acceleration clipping.
- The seed `solver_24bf67867ea8` is genuinely self-propelled. Its top-down row
  forms a coherent alternating wake and its oblique Lambda2 row shows a
  persistent three-dimensional vortex train. It advances from `12.3277L` to a
  `4.7800L` minimum at `17.85T`, then passes below the target and exits the
  lower boundary at `27.49T`. At least one raw joint command exceeds the
  `1800 deg/T^2` envelope on `98.0%` of recorded steps.
- The inherited response-gated, polarity-inverted allocator was falsified by
  its completed rollout `solver_f578f8771e8a`: it reaches only `12.1727L`,
  curls upward, parks the posterior joint at the `45 deg` angle limit, loses
  the seed's detached alternating wake, and exits the upper boundary at
  `7.99T` with `13.1942L` final distance. Bounded raw commands therefore did
  not rescue the wrong redirect topology. A second strong full-controller
  C-bend blend, `solver_7ddfece27e92`, produces the same upper-exit class by
  `9.01T` and improves minimum distance by only `0.466L`.
- The graded oscillator-center/tail-tangent C-bend in the assigned prefill,
  evaluated as `solver_d594e3893325`, is the only sampled semantic success.
  Its top-down frames retain a compact alternating reverse wake while the
  path bends toward the target; the oblique row confirms coherent 3D vortex
  shedding through capture. It captures at `25.388T`, reaches `0.74947L`, and
  remains finite. This is strong evidence to preserve its bend polarity,
  body-frame geometric gate, drive relief, and continuous release rather than
  replace them with a stronger redirect.
- The captured controller still returns raw acceleration outside the physical
  envelope on at least one joint for `83.4%` of recorded steps, with maxima of
  about `4584/6217 deg/T^2`; the evaluator then hard-clips those requests.
  Replaying a fourth-order smooth projection on the recorded raw commands
  changes the hard-clipped action by `64.3 deg/T^2` on average (`97.6 deg/T^2`
  RMS), while reducing individual joint samples at or above `95%` authority
  from `53.9%` to `38.1%`. This is an algebraic envelope check, not a CFD
  counterfactual.

## One candidate hypothesis

Retain the successful C-bend controller and add one final, component-wise
fourth-order smooth projection into the configured `1800 deg/T^2` actuator
envelope. The projection is nearly identity below the envelope, asymptotes to
the physical limit without a hard command discontinuity, and leaves the
evidenced target geometry, bend polarity, oscillator, and redirect release
unchanged. It introduces no clock, route, mutable state, or scalar propulsion
retuning.

Falsification: reject the projection if the new rollout loses capture, delays
arrival materially, erases the compact alternating wake, increases joint-angle
or velocity saturation, or changes the useful target-directed arc into either
sampled upper-exit curl. A lower raw-command saturation rate alone is not an
improvement if trajectory semantics or wake coherence regress.

bookshelf_consulted: true
source_domain: biological C-start redirects and robotic-fish mean-curvature steering
source_mechanism: large observed direction error invokes bounded posture curvature and releases continuously back into the propulsive rhythm as alignment returns
transferable_invariant: keep target-referenced mean turning distinct from the traveling-wave carrier and bound the combined actuation without changing its observed response polarity
nontransferable_details: species-specific C-start shapes, published gains and frequencies, exact vortex phase, prescribed maneuver timing, full-body kinematics, and task-specific routes
policy_translation: retain the successful normalized body-frame bearing gate that shifts the two-joint oscillator toward a graded same-sign C-bend, then apply a component-wise smooth projection to the physical acceleration envelope
falsification: loss of capture, coherent wake, or target-directed curvature, or recurrence of the upper-exit curl, invalidates the transfer even if raw commands remain bounded
