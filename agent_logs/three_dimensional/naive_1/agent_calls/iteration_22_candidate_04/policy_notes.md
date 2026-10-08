# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four assigned rollouts are finite `capture` episodes from the required
  direct uniform still-water initialization: `U_infinity=(0,0,0)`, no
  cylinders, no prewarm snapshot, and no numerical instability. There is no
  literal failure example in this sample. The two independently authored
  water-relative axial-recovery policies are instead the strongest finite
  reference and reproduce each other exactly at `23.424515T`, 4,259 steps,
  `0.749902L` crossing, `2.184349L` score-metric mean distance, and
  `-0.287480` score. Relative to the prefilled inertial-speed composition at
  `23.864521T`, `2.192138L`, and `-0.294271`, measuring locomotor recovery
  through local water is a completed semantic improvement, not merely a
  hoped-for robustness benefit.
- Every top-down sheet shows continuous target-directed body translation on
  the established S-shaped approach with an attached alternating red/blue
  caudal street from release through capture. The water-relative recovery
  reaches the target circle sooner without changing that useful route class,
  so it is self-propulsion rather than advection or an early terminal coast.
  Every assigned oblique Lambda2 row is a black render artifact. Those rows
  were inspected but provide no independent three-dimensional wake evidence;
  the inherited complete speed-recovery control remains the applicable 3D
  wake bound.
- The independently sampled adverse-yaw-moment residual adds a small bounded
  posterior offset only when measured hydrodynamic moment opposes the
  target-side turn. Against the same prefilled inertial-speed controller, it
  advances capture from `23.864521T` to `23.545517T`, lowers mean distance
  from `2.192138L` to `2.188316L`, and improves score from `-0.294271` to
  `-0.291201`. Its peak normalized force/moment fall from
  `0.029479/0.015344` to `0.029290/0.015223`; mean action rises only from
  `57.572` to `57.906`, and anterior/posterior rate-cap occupancy remains
  nearby at about `12.08/6.49%`. This is evidence for a distinct measured-load
  pathway, not for increasing the reactive-rudder gain.
- The strongest water-relative recovery has a finite comparison envelope:
  mean action `58.289`, mean action inside `1.5L` `45.013`, anterior/posterior
  rate-cap occupancy about `11.74/6.65%`, and peak normalized force/moment
  `0.029780/0.015287`. Its `2T` distance remains `12.222539L`, identical to
  the prefill, so the improvement occurs after initial wake formation. The
  moment residual acts on the posterior target while axial recovery acts on
  anterior oscillator energy, making their composition a compact test of two
  independently positive and physically separate feedback paths.

## One candidate hypothesis

Use the reproduced water-relative axial-recovery policy as the complete
baseline: retain its joint-state traveling carrier, local-water-relative
lateral route feedback, full target geometry, anterior redirect,
phase-selective posterior carrier, reactive-rudder sign, and phase-qualified
terminal relief. Add exactly the completed adverse-moment residual from the
independent sample. When the measured normalized yaw moment opposes the
current target-side turn and exceeds its dead band, apply a smooth bounded
posterior offset with the calibrated response sign; release it continuously
on small target error or non-adverse load. This preserves every carrier
half-cycle and does not convert fast hydrodynamic load into a route command.

The evaluation should show whether the two observation-level improvements
compose. Falsify the candidate if capture is lost or later than the reproduced
`23.424515T` reference, score is below `-0.287480`, mean distance exceeds
`2.184349L`, the top-down S-route or attached alternating wake degrades, or
mean/near action, `11.74/6.65%` rate-cap occupancy, `0.029780` peak force, or
`0.015287` peak moment materially worsen. Even a positive fixed-pose result
would not establish multi-wake or 3D-wake robustness without changed-flow or
pose evidence and a valid oblique render.

bookshelf_consulted: true
source_domain: wake-interaction control and sensor-modulated robotic-fish rhythmic locomotion
source_mechanism: preserve the traveling propulsive carrier while separating slow target-route feedback from a small fast residual that rejects only target-opposing hydrodynamic yaw load
transferable_invariant: use normalized body-frame target sign and measured yaw moment to recruit bounded posterior rejection only for adverse load, leaving route geometry and joint-state phase responsible for steering and propulsion
nontransferable_details: published gains, dimensional thresholds and frequencies, species or robot kinematics, exact vortex phases, prescribed maneuver timing, cylinder geometry, fixed coordinates, and task-specific routes
policy_translation: retain the strongest sampled local-water-relative axial and lateral feedback unchanged and compose the independently positive smooth adverse-moment gate into the posterior phase-lag target
falsification: reject if capture is lost or later than 23.424515T, score falls below -0.287480, mean distance exceeds 2.184349L, or route, wake, action, saturation, force, or moment envelopes worsen
