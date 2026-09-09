# Multi-wake candidate diagnosis and hypothesis

## Evidence read before the policy edit

- The shared prewarm sheets are byte-identical across all four sampled
  examples. They show the held fish above and downstream of a fully developed,
  asymmetric four-cylinder vortex field, so release differences are
  candidate-controlled rather than different initial wakes.
- Three independently evaluated `oscillator_energy_gain=2.1` examples are also
  byte-identical in their released keyframe sheets and metrics. The fish turns
  toward the target, crosses into the useful wake corridor, and follows a
  compact diagonal route to first entry at `73.859` time units. This is
  self-propelled progress rather than passive advection: mean velocity x is
  `-0.14784` versus local-flow x `-0.08219`, giving `0.06565` mean
  upstream-relative x speed. Mean distance is `2.480L`, command energy is
  `51797`, and RMS force/moment are `24.94/410.68`; both acceleration commands
  touch the candidate's `28` guard.
- The only distinct sampled alternative changes the same gain from `2.1` to
  `2.2`. It remains finite and reaches the target, so this sample contains no
  failure rollout; it is the most informative weak finite comparison. Its
  keyframes show a deeper lower route and later final correction. Arrival
  regresses to `77.726`, mean distance to `2.541L`, upstream-relative x speed
  to `0.06006`, energy to `55790`, and RMS force/moment to `26.42/423.30`.
  Yet its peak anterior angle/speed fall from `0.5259/3.1505` to
  `0.5156/3.1319`, and posterior speed falls from `3.3229` to `3.3203`.
  Uniformly raising the signed energy-feedback coefficient therefore mixes a
  potentially useful excess-energy damping effect with a harmful increase in
  below-orbit energy recovery; peak reduction alone did not predict route,
  effort, or load quality.
- Inherited logs reinforce the need to judge route and distance jointly: one
  prior successful result arrived faster at `72.699` with lower energy and
  loads (`50630`, `21.05/379.50`) but had worse mean distance `2.511L` and
  score `-0.6125` than the `2.1` anchor. The assigned parent also documents
  nonlinear route changes from steering-gain interpolation, acceleration-guard
  interpolation, and tail-speed damping, so none of those mechanisms is
  combined with this probe.

## Single candidate hypothesis

Keep the evaluated `2.1` controller unchanged whenever normalized oscillator
energy is at or below its requested orbit, but use coefficient `2.2` only when
energy exceeds one and the signed feedback is dissipative. This isolates the
small peak-state reduction visible in the uniform `2.2` rollout without its
extra below-orbit energy injection. All gait, steering, tail, and acceleration
parameters remain at the deterministic `2.1` anchor values.

The candidate succeeds only if it preserves the compact target approach and
does not regress arrival, mean distance, or upstream-relative propulsion while
reducing peak overshoot, effort, or load. A deeper lower detour, later closure,
or increased command energy falsifies the split and should send later workers
back to the exact uniform `2.1` anchor. The current candidate has no CFD result
yet; this is a deliberately isolated, normalized state-feedback probe for the
post-worker evaluation.
