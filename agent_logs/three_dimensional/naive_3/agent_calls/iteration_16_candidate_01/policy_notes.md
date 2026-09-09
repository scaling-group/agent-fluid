# Candidate diagnosis and policy hypothesis

## Evidence read before the policy edit

All four sampled evaluations report direct uniform still-water initialization
with `U_infinity=(0,0,0)`, no cylinders, and no prewarm. I inspected the
combined keyframe sheets for the strongest sampled response-selected posterior
brake (`solver_563a0d75514e`) and the prefilled joint-phase counterbend
(`solver_cb10b3fc3e7f`), including both the top-down mid-plane vorticity row and
the oblique body/Lambda2 row from release through termination. Both fish
self-propel along the same diagonal approach, shed a sustained alternating
planar wake and compact three-dimensional vortex chain, turn nearly vertically
below the target, and remain powered to a lower-boundary exit near `31T`.
Neither trace shows passive advection, wake collapse, collision, or numerical
instability; the useful difference is terminal trajectory geometry.

The sampled response-selected posterior brake remains the strongest finite
mechanism, reaching `2.385L` at `17.869T` versus `2.512L` for the prefilled
joint-phase counterbend, `2.494L` for full-direction posterior gating, and
`2.536L` for a response-released posterior equilibrium S-bend. At the brake's
minimum, speed is still `0.705U`, heading rate is `2.185 rad/T`, and the local
flow magnitude is only about `0.018U`; the trajectory therefore crosses the
near-target region under its own powered lateral motion rather than ambient
advection. Across the four sampled traces, anterior/posterior command-clamp
fractions remain about `0.72--0.75/0.33--0.36`, and heading rate within `3L`
is anticorrelated with anterior joint rate at `|r|=0.992--0.998`.

The assigned parent's completed response-selected anterior phase brake
regressed to `2.628L` and retained the lower exit. Other inherited completed
tests likewise leave the semantic class unchanged: gait-yaw residualization
reached `2.541L`, a response-selected posterior counterstroke reached
`2.585L`, and a smoother posterior polarity reallocation reached `2.406L`.
Together with the sampled joint-phase counterbend and equilibrium S-bend, this
is negative evidence against another damping-strength edit, yaw/joint-rate
residual coefficient, posterior equilibrium offset, or posterior polarity
change. The long coherent wake and similar load/clamp scales instead leave
posterior wave timing as a distinct actuator-topology hypothesis.

## Policy hypothesis

Start from the sampled `2.385L` response-selected brake and preserve its
anterior oscillator, target-relative mean curvature, alignment envelope,
approach/direction/response gate, posterior authority brake, and exact
far-field carrier. On only the gated error-growing response interval, rotate
the remaining posterior traveling wave by continuously changing its lagged
joint-state mixture. Normalize the position/rate mixture to the cruise
mixture's nominal sinusoidal amplitude, so this is phase-lag modulation rather
than extra drive, a larger command bound, another equilibrium redirect, or a
polarity reversal.

The expected evidence is unchanged diagonal cruise and coherent wake followed
by a meaningfully different terminal bend and smaller lateral near miss.
Capture, a useful new termination class, or a minimum materially below
`2.385L` with retained broad progress supports the mechanism. Falsify it if
far-field behavior changes, the wake shortens or collapses, a tight curl or
load/clamp increase appears, or the same powered lower exit and closest
approach persist. A failure should close off response-gated phase-lag
modulation for this carrier rather than invite scalar tuning of the rotation.

```text
bookshelf_consulted: true
source_domain: robotic-fish CPG turning and classical traveling-bend propulsion
source_mechanism: sensor feedback modulates inter-joint phase lag while preserving the propulsive rhythm and bounded posterior emphasis
transferable_invariant: when propulsion is coherent but steering topology is exhausted, change the timing of the posterior bend under measured target-response gating without increasing nominal wave amplitude
nontransferable_details: published gains, clock-driven CPG phase, robot geometry, species-specific kinematics, dimensional frequencies, exact vortex phases, and task-specific routes
policy_translation: use normalized body-frame target direction and distance plus measured heading rate to rotate the lagged phi1/phi_dot1 posterior target only on the evidenced error-growing response interval, with joint-state phase and nominal-amplitude normalization
falsification: reject if cruise or wake coherence changes, command or load residence worsens, or closest approach and the powered lower-exit topology do not improve over the 2.385L response brake
```

## Evaluation boundary

The candidate receives coupled CFD evaluation only after this worker exits.
Local checks below can establish contract compliance, boundedness, symmetry,
and gate locality, but cannot establish hydrodynamic improvement.

## Implemented candidate and non-CFD checks

The candidate implements only the response-selected phase-lag modulation
described above on top of the sampled posterior brake. Every carrier quantity,
gate threshold, lag shift, brake floor, normalization input, and command bound
is returned by `target_policy_params`.

At a state reconstructed from the strongest sampled rollout near its minimum,
the response weight is `0.913` and the selected lag changes from the cruise
value `0.8` to `-0.113`. The anterior command remains exactly equal to the
sampled brake while the posterior command changes from `-0.306` to
`-9.799 rad/T^2`. At analogous joint state and target direction but `8L`
distance, the maximum command difference is only `0.0086 rad/T^2`, confirming
far-field locality. A deterministic `40,000`-state sweep spanning joint
angles, joint rates, target sides, distances, and yaw rates produced finite
commands within the configured `28 rad/T^2` reserve; mirrored states negate
both commands to floating-point tolerance.

The required material-guidance, lightweight Julia policy-contract,
parameter-schema, and solver-boundary checks pass, as do all `324` repository
non-CFD tests. These checks validate implementation properties only; formal
CFD was not run.
