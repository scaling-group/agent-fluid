# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- All four sampled rollouts confirm direct uniform initialization in still
  water with `U_infinity=(0,0,0)`, no cylinders, and no prewarm. I inspected
  both rows of every combined keyframe sheet, using the response-selective
  brake (`2.385L` minimum, mean `8.436L`) as the strongest finite sample and
  the assigned-parent gait-yaw residual (`2.541L`, mean `8.449L`) as the
  informative failure. The top-down rows show sustained alternating vortices;
  the oblique rows show compact three-dimensional Lambda2 structures carried
  behind the moving fish. Both follow the same diagonal inbound path, pass
  laterally below the target, turn nearly vertical, and remain powered until a
  lower-boundary `left_domain` exit near `31T`. This is self-propelled terminal
  steering failure, not advection, wake collapse, collision, or instability.
- The sampled alignment-gated carrier reaches `2.443L`; selecting the measured
  error-growing yaw half-cycle to weaken the posterior wave improves that to
  `2.385L`. The assigned parent's attempt to subtract inferred gait yaw from
  the mean-curvature loop worsens the minimum to `2.541L`, and an
  approach-localized response-released posterior equilibrium S-bend reaches
  only `2.536L`. All four retain nearly identical final distance
  (`9.187--9.205L`) and the same lower-exit topology. Inherited logs further
  reject joint-phase counterbends, polarity reversal, repeated brake tuning,
  and persistent posterior equilibrium redirects as completed recovery.
- At the best sampled minimum near `17.87T`, the target remains about
  `1.38 rad` lateral in the full body frame, closure is only about
  `0.014 L/T`, translational speed remains about `0.705U`, and the anterior
  command is only about `7.71 rad/T^2` despite a `28 rad/T^2` bound. Across the
  closest inherited approaches, median closure falls from about
  `0.586--0.606 L/T` at `3--4L` to `0.131--0.163 L/T` inside `2.7L`. The
  terminal miss therefore offers state-local anterior turning reserve even
  though whole-trace clamp residence makes a global drive or command increase
  unsupported.
- I rejected `bearing_window_rate` as a new slow-course estimate: the moving
  window adapter spans only seven solver observations, and inherited evidence
  already reports that a matched-window target-ray lead worsened minimum and
  mean distance. I also reject another isolated half-cycle amplitude edit or
  posterior static residual because completed evidence preserves the same
  failure topology.

## Policy hypothesis

Start from the strongest sampled response-selective brake, preserving its
joint-state oscillator, posterior lag, alignment envelope, measured-yaw
half-cycle selector, and far-field commands. Add one mechanism: a smooth
terminal burst redirect on the anterior mean-curvature equilibrium. It becomes
strong only when normalized distance indicates approach, full body-frame
target direction is materially lateral, and measured head-distance closure
has fallen below the useful inbound regime. Direction-error correction or
restored closure releases it continuously; there is no clock, stage memory,
world coordinate, or prescribed route.

Replay through completed states can establish gate locality and available
command reserve, not CFD benefit. Support requires capture, a useful new
termination class, or a minimum materially below `2.385L` without degraded
mean distance or far-field route. Falsify on early-route change, a short tight
curl, lost alternating/three-dimensional wake coherence, premature speed loss,
greater actuator/load residence, or the same powered lower exit with no useful
minimum-distance improvement.

```text
bookshelf_consulted: true
source_domain: nonsteady biological redirect and closed-loop robotic-fish CPG direction control
source_mechanism: large observed target error requests a strong bounded curvature redirect while geometric recovery releases back into the propulsive traveling wave
transferable_invariant: separate the proven rhythmic carrier from a continuously gated state-feedback redirect, applying extra curvature only when target geometry and lost closure agree that cruise steering is insufficient
nontransferable_details: published gains, dimensional frequencies, species-specific C-start envelopes, robot geometry, clocked CPG phase, fixed burst durations, exact vortex phases, approach radii, and task-specific routes
policy_translation: normalized distance, normalized body-frame target direction, and measured head-distance closure gate a bounded anterior equilibrium residual around the unchanged two-joint oscillator and response-selected posterior brake
falsification: reject on changed far-field route, a tight curl, lost wake coherence or speed, greater actuator or load residence, no material improvement below 2.385L, or persistence of the powered lower exit
```

## Evaluation boundary

The candidate receives formal CFD only after this worker exits. Deterministic
contract, replay, symmetry, and bound checks below do not establish coupled
hydrodynamic improvement.

## Implemented candidate and pre-CFD checks

The candidate starts from the sampled `2.385L` response-selective brake and
adds only the closure-gated anterior equilibrium residual described above. A
first replay exposed an unintended coupling through the posterior lag target;
that coupling was removed because it recreated the inherited static posterior
residual and raised posterior clamp residence. In the final candidate, the
posterior mean, traveling wave, and response-selective brake are exactly the
sampled baseline for every state; the redirect changes only the anterior
equilibrium.

Replaying the gate on all four completed trajectories gives mean weights of
`0.0069--0.0071` beyond `4L`, `0.195--0.203` at `3--4L`, and `0.651--0.671`
inside `3L`. The sampled minima activate it at `0.861--0.910`, where full
direction error is `1.38--1.45 rad` and closure is `0.005--0.014 L/T`.
Across all four traces, the mean absolute anterior-command change is about
`0.033 rad/T^2` beyond `4L`, `0.910 rad/T^2` at `3--4L`, and
`3.151 rad/T^2` inside `3L`; maximum posterior-command difference is exactly
zero. Replayed anterior/posterior clamp fractions are `0.744/0.358`, versus
`0.746/0.358` for the sampled brake. At a reconstructed best-minimum state,
the gate is `0.910` and anterior action is `27.73 rad/T^2`; restoring closure
to `0.60 L/T` releases the gate to `0.0023`. These are locality and reserve
diagnostics, not predictions of the coupled trajectory.

The configured semantic-guidance check, lightweight Julia contract, solver
boundary, deterministic parameter-schema scan, reflection probe, and all
`324` repository non-CFD assertions pass. All `25` direct `params.FIELD`
references are declared by `target_policy_params()`. The reflection probe has
zero numerical residual and extreme tested actions remain finite and bounded.
The rendered workspace `README.md` contained the assigned-parent marker twice;
removing only that duplicate was necessary for the mandated semantic checker
to identify the parent. Formal CFD was not run.
