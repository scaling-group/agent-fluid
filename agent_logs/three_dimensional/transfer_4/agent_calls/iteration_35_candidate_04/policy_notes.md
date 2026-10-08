# Evidence-selected course-consensus posterior duty

## Visual and quantitative diagnosis before editing

- I read the workspace and guidance contracts, the assigned parent, all four
  sampled policies, scores, observations, metrics, diagnostics, trajectories,
  and combined keyframe sheets, plus the available inherited optimizer notes.
  Every sampled rollout is a finite capture from direct uniform still water
  with `U_infinity=(0,0,0)`, no prewarm, no cylinders, and no boundary or
  numerical termination.
- In both the top-down mid-plane vorticity row and oblique Lambda2 row, the
  sampled v31 scalar leader and the informative v26 regression visibly
  self-propel from rest, follow the same gently curved target-directed route,
  shed a coherent alternating reverse wake, and retain compact three-
  dimensional posterior structures through capture. The v20 and v25 sheets
  show the same wake class. There is no passive advection, standing reciprocal
  wiggle, wake breakup, boundary interaction, or out-of-plane instability.
  The unresolved behavior is terminal allocation rather than propulsion.
- V31 has the best sampled score/mean-distance pair at
  `-0.0640004/1.950346L`, but its observed distance integral `1.336756L` is
  worse than v20's `1.336706L` and v25's `1.336693L`; the scalar ordering is
  partly a deeper discrete capture crossing and smaller terminal-hold term.
  V31 captures at `18.0125T` with final course alignment `0.1297`, absolute
  yaw `0.8077 rad/T`, target-normal speed `0.8732U`, and `75.89%` near
  posterior acceleration-ceiling residence. Its coherent wake therefore does
  not establish broadly improved approach control.
- The assigned v26 one-sided slip feather preserves capture and the same
  two-view wake while improving final alignment/yaw to
  `0.1728/0.6545 rad/T`, center path/head cross-track to
  `13.2064L/0.7265L`, and near posterior ceiling residence to `74.11%`, but
  it regresses score/mean distance to `-0.0641495/1.950469L`. The inherited
  balanced slip duty (`-0.064451`), posterior phase reset (`-0.064554`),
  response-triggered mean-bend extension (`-0.064408`), steering-headroom
  allocation (`-0.064495`), and posterior phase-energy envelope
  (`-0.064963`) all retain capture but fail to improve closure and terminal
  state together. I therefore do not add another slip-duty gain, force-power
  placement, yaw/course loop, mean-bend share, or saturation envelope.
- I considered validating v31's extra duty with positive co-windowed closing
  speed divided by body speed. Replay of the complete v31 guidance equations
  rejects that proposal before finalization: course/turn consensus already
  makes duty authority positive on only `21/394` approach samples, and those
  samples nearly all have efficient radial closure. The additional progress
  gate would reduce summed duty authority by only `1.06%` while leaving all
  `2,874` pre-approach samples unchanged. It is therefore redundant, not a
  meaningful new response mechanism, and I removed it rather than presenting
  an effectively inactive architectural change.

## Final single policy hypothesis

Materialize the evaluated v31 course-consensus posterior-duty controller as
the one final candidate. Relative to the assigned v26 parent, it improves the
available score/mean-distance evidence from
`-0.0641495/1.950469L` to `-0.0640004/1.950346L` while preserving capture,
arrival class, the coherent two-view wake, odd body-frame route map,
state-feedback anterior oscillator, posterior lag and emphasis, v20 approach
envelope, conserved v19 mean-bend allocation, phase-consistent work reserve,
half-cycle steering, cadence, and reversal-preserving rate governor.

This is deliberate evidence-based exploitation after several completed
terminal mutations failed, not a claim that v31 solved terminal control. Its
known boundary remains the worse observed distance integral and weak terminal
alignment/yaw/load state described above. The immediate falsification is
deterministic: the materialized policy should reproduce the sampled v31
capture class and metrics. A later worker should only depart from it with an
orthogonal mechanism whose replay has nontrivial authority and whose CFD
improves observed closure and terminal state together.

```text
bookshelf_consulted: true
source_domain: elongated-body propulsion, terminal capture control, and sensor-modulated robotic-fish CPG control
source_mechanism: preserve a posterior-emphasized traveling rhythm and introduce phase-specific sensory modulation only when completed evidence shows nonredundant authority
transferable_invariant: retain the coherent lagged posterior wave and bounded body-frame feedback; reject a nominally new gate when its observation is already implied by the active selector
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, full-body burst kinematics, exact vortex phases, world coordinates, target location, capture radius, and task-specific routes
policy_translation: no new bookshelf primitive is added; retain the evaluated v31 state-feedback carrier and course-consensus duty surface after replay showed that an added normalized progress validator was redundant
falsification: reject the exploitation baseline if it does not reproduce the sampled capture and metric class; revisit a primitive only when its replay has material independent authority and CFD improves closure plus terminal alignment, yaw, path, and non-migrating limit residence together
```
