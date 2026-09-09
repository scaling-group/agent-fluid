# Constant-authority posterior phase-rotation candidate

## Evidence diagnosis before editing

- All four sampled evaluations are valid direct-uniform still-water rollouts:
  `U_infinity=[0,0,0]`, no cylinders, no prewarm, and no numerical
  instability. Their combined sheets show a self-propelled fish rather than
  advection: the top-down row retains a long alternating vorticity street and
  the oblique row retains compact three-dimensional Lambda2 structures from
  release through closest approach and lower-boundary termination.
- The four sampled paths share the same control failure. Each approaches on a
  diagonal, passes laterally outside the `0.75L` capture radius, rotates onto a
  steep downward course, and stays powered until `left_domain` near `31T`.
  The response-selected posterior brake reaches `2.385L`; anterior duty
  asymmetry reaches `2.433L`; a response-gated posterior equilibrium S-bend
  reaches `2.536L`; and the assigned parent's posterior lag modulation is the
  best of this set at `2.326L`. The parent's mean distance is `6.725L`, speed
  remains about `0.687U` at its minimum, and anterior/posterior command clamp
  residence remains about `0.749/0.355`, so the small closest-approach gain is
  not a semantic recovery or an actuator-reserve gain.
- Reconstructed target-ray/course error in the parent stays positive for all
  `907` samples inside `3L` and averages about `1.56 rad`; the wake remains
  coherent there. The phase selector therefore activates on the intended
  persistent miss, but the rollout falsifies the claim that its present
  variable-lag implementation is enough to change the lower-exit class.
- Inherited completed logs rule out repeating nearby branches. Measured-response
  anterior half-cycle relief reaches only `2.478L`; target-behind anterior
  damping reaches `2.293L` but worsens mean distance and exits earlier; a
  target-behind differential burst redirect reaches `2.499L`; and a
  course-selected differential equilibrium S-bend reaches `2.469L`. Together
  with the sampled duty failure, these results contradict another anterior
  relief/duty edit, static C/S-bend reallocation, post-overshoot hold, burst
  redirect, or scalar brake retune.

## Visual diagnosis

The top-down and oblique rows agree that propulsion and wake coherence survive
the miss; there is no collision, passive carry, tight curl, or vortex collapse
to repair. The nearly identical long wake and lower-exit leg across policies
show that the missing capability is a material rotation of translational
course during the first approach. The assigned parent changes posterior lag
by changing the coefficient of the joint-velocity quadrature. That changes
both phase and the norm of the posterior wave coefficients, so its modest
closest-approach gain cannot be attributed cleanly to phase steering rather
than incidental posterior-authority modulation.

## Policy hypothesis

Preserve the assigned parent's cruise curvature, posterior response brake,
body-frame course selector, joint-state phase selector, distance/speed gates,
and command reserve. Replace only the variable lag coefficient with a bounded
rotation of the posterior joint-angle/joint-velocity quadrature vector. The
rotation retains the base coefficient norm `sqrt(1 + tail_lag_gain^2)` while
changing posterior wave shape on the selected half-cycle, isolating phase
steering from tail-amplitude scaling. Because course direction and anterior
joint velocity both reverse under reflection, their product selects the same
scalar rotation in mirrored states and the two joint commands still mirror.

Support requires retained cruise progress and coherent wake plus capture, a
useful new termination class, or a material improvement below `2.326L` with
course recovery. Falsify the mechanism if it preserves the powered lower exit
without a material minimum-distance gain, changes far-field behavior, raises
clamp/load residence, produces a tight curl, or degrades the alternating wake.

```text
bookshelf_consulted: true
source_domain: classical traveling-wave swimming and sensor-modulated robotic-fish CPG control
source_mechanism: steer an established posterior-emphasized traveling bend through bounded state-selected phase or wave-shape modulation
transferable_invariant: modulate posterior phase while preserving wave direction and propulsive coefficient magnitude, so steering does not silently become an amplitude command
nontransferable_details: published gains, dimensional frequencies, species envelopes, robot geometry, full-body waveforms, clocked phase, exact vortex phase, fixed routes, and source-task turn angles
policy_translation: rotate the normalized two-joint posterior angle/velocity quadrature coefficients by a bounded invariant selected from body-frame target-ray/course error and measured anterior joint velocity; keep the established brake and all cruise feedback unchanged
falsification: reject if cruise wake or progress changes, clamp/load residence rises, a tight curl appears, or closest approach and the powered lower-exit class do not materially improve beyond the 2.326L parent
```

## Evaluation boundary

Formal coupled CFD runs only after this worker exits. Static replay can verify
coefficient norm, reflection equivariance, locality, schema, finite bounds, and
activation scale; it cannot establish a new trajectory or score.

## Implemented candidate and non-CFD audit

The candidate changes only the parent's posterior quadrature mapping. Its
maximum rotation `0.30 rad` first-order matches the parent's lag-to-phase
strength, `0.50 / (1 + 0.8^2) = 0.305 rad`, while every tested rotation keeps
the coefficient norm at `1.280624847487` to floating-point tolerance. Replay
on the completed parent states realizes at most `0.13731 rad` rotation. The
mean maximum joint-action difference from the parent is `0.0152 rad/T^2`
beyond `4L`, `0.7849 rad/T^2` from `3--4L`, and `1.2985 rad/T^2` inside `3L`;
this establishes the intended approach localization but predicts no coupled
flow outcome. Mirrored finite probes have zero command residual, a grid of
extreme finite observations stays within `+/-28 rad/T^2`, and all direct
`params.FIELD` references are declared by `target_policy_params()`.
