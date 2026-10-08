# Evidence-selected v31 exploitation candidate

## Visual and quantitative diagnosis before candidate selection

- I read the workspace and guidance contracts, the assigned-parent guidance
  and inherited worker notes, every sampled solver score, observation,
  diagnostic, trajectory, policy, and both rows of the combined keyframe
  sheet. All four current solver samples have byte-identical policies,
  trajectories, and keyframes. Each is a finite capture from direct uniform
  still water with `U_infinity=(0,0,0)`, no prewarm, no cylinders, and no
  boundary or numerical failure. They are determinism evidence for v31, not
  four controller mechanisms.
- In the top-down mid-plane row, v31 self-propels from rest along a broad
  target-directed arc and maintains a coherent alternating traveling wake
  through capture. The oblique Lambda2 row confirms compact three-dimensional
  posterior structures and a stable body rather than passive advection or a
  planar rendering artifact. I also inspected the assigned parent's
  target-normal hydrodynamic-work result. It preserves the same two-view wake,
  so its failure is an observation-to-actuator failure rather than wake loss.
- V31 reproducibly captures at `18.0125T` with score/mean distance
  `-0.0640004/1.950346L`, observed distance integral `1.336756L`, center path
  and head cross-track `13.2149L/0.7327L`, and final course alignment, speed,
  and absolute yaw `0.1297/0.8806U/0.8077 rad/T`. Its approach remains fast
  and oblique, and near anterior/posterior acceleration-ceiling residence is
  `69.29/75.89%`; this limitation is not mistaken for a solved terminal state.
- The assigned parent's target-normal hydrodynamic-work rectifier arrived
  slightly earlier and improved the observed integral to
  `18.0070T/1.336729L`, but worsened score/mean distance to
  `-0.064651/1.950863L`, final alignment/yaw to
  `0.1133/0.9884 rad/T`, and head cross-track to `0.7331L`. Instantaneous
  alternating force-velocity work did not identify a helpful slow terminal
  response even though its posterior-wave modulation remained bounded.
- The sampled carrier-demodulated anterior half-cycle relief is an even
  sharper negative control. It retains the `18.0125T` capture and changes the
  observed integral by less than `6e-8L`, but leaves path, approach alignment,
  and both joints' acceleration-ceiling residence at the v31 class; final
  absolute yaw improves by only `0.0009 rad/T`, while speed and final distance
  are slightly worse. Its counterfactual selector was reachable on `9.64%` of
  approach samples, so reachability of a fitted residual does not establish
  useful actuator authority. Together with the inherited posterior positive-
  work regression, this rules out another relief-floor, work-scale, or
  half-cycle-gain sweep.

## Single policy hypothesis

Keep the prefilled `dogfish_3d_course_consensus_posterior_duty_ratio_v31`
unchanged as the single candidate. It is the best fully evaluated tradeoff and
preserves the odd normalized body-frame route map, state-derived anterior
carrier, posterior lag and emphasis, phase-consistent work reserve, bounded
approach envelope, conserved mean-bend allocation, course-consensus duty
surface, half-cycle steering, and reversal-preserving rate governor.

This is evidence-led exploitation after three distinct terminal translations
failed to improve closure and terminal state together. It is not a claim that
v31's terminal crossing is good, nor is exact repetition claimed as a new
mechanism. Falsification is deterministic: this materialization should
reproduce the sampled v31 capture and metric class. A later architecture
should be orthogonal to closing-stride drive relief, instantaneous
hydrodynamic-work rectification, and carrier-demodulated positive-work relief;
it should be rejected unless it improves observed closure and approach-average
and final terminal state together without changing useful transit.

```text
bookshelf_consulted: true
source_domain: elongated-body reactive propulsion, feedback-modulated robotic-fish rhythmic control, and wake-interaction studies
source_mechanism: retain a posterior-emphasized traveling rhythm and separate slow route response from fast gait-locked force, velocity, and joint-phase signals
transferable_invariant: preserve the coherent state-derived traveling wave when bounded scalar energy relief and instantaneous work rectification retain the wake but fail to improve closure and terminal response together
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, full-body kinematics, exact vortex phases, world coordinates, target location, capture radius, and task-specific routes
policy_translation: no new shelf primitive is adopted; keep the evaluated v31 two-joint feedback law and close posterior positive-work, target-normal work, and carrier-demodulated anterior relief as scalar-tuning branches for this fixed pose
falsification: reject the exploitation materialization if it does not reproduce the sampled capture class; reject a later mechanism if transit changes or capture, observed closure, path, approach-average and final alignment/yaw, coherent wake structure, and non-migrating joint-limit residence do not improve together
```

## Lightweight validation

- The mandated check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unsupported on this account. Running its immutable checks directly gives
  PASS for the notes/guidance materiality check and PASS for the solver edit
  boundary. Julia is not installed, so the executable include/action probe
  cannot run; no CFD was attempted.
- Static contract checks find one definition of each public function, all `66`
  direct `params.FIELD` references covered by the `68` fields returned from
  `target_policy_params()`, and no explicit elapsed time, step count,
  randomness, file I/O, cylinder coordinate, fixed target coordinate, or
  memorized-route input.
- The retained candidate SHA-256 is
  `8b35036121fc14a9221cc081f234535a877aad2b6c1b0364a94ab7a5ac582a6e`,
  exactly matching all four current sampled v31 solvers. This is a
  materialization check against completed evidence, not a same-worker CFD
  result.
