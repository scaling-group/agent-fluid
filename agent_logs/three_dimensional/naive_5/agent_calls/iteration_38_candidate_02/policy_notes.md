# Candidate diagnosis and hypothesis

## Evidence read before editing

- All four sampled rollouts confirm direct uniform still-water initialization
  (`U_infinity=[0,0,0]`), moving-window transport, and `capture` termination.
- In both the top-down vorticity and oblique Lambda2 sheets, the fish is
  self-propelled rather than advected: an organized alternating wake grows
  behind it, remains coherent through the long approach, and bends with the
  late target-directed hook. The `b3cc38ade37a` and `f71a78911244` combined
  sheets show no wake collapse, domain-exit precursor, or visibly spurious
  moving-window yaw. Their terminal topology is similar even though their
  feedback additions differ.
- Metrics agree with the images. The sampled policies have no angle, speed, or
  acceleration contacts. Peak planar force/yaw moment spans only
  `0.01891--0.02063/0.01009--0.01065`. The three middle-recovery variants
  capture at `25.812--25.916T`, mean distance `2.49601--2.49689L`, and the same
  shallow-hook visual route, so posterior reaction, moment gating, force
  gating, and command yielding do not supply an evidenced new middle-course
  mechanism.
- The paired `64a9b2cc44b2` and `b3cc38ade37a` policies share the force-qualified
  baseline; `b3cc38ade37a` adds upstream anterior restoring-phase duty
  asymmetry. It improves distance at `8T` from `10.431L` to `10.308L` and at
  `16T` from `6.102L` to `5.898L`, lowers mean distance from `2.49601L` to
  `2.45777L`, and captures `0.3025T` earlier. Its early centerline is visibly
  lower and useful, its coherent wake survives, and actuator contacts remain
  zero. The tradeoff is a modest rise in peak force/moment to
  `0.02063/0.01065` and greater course error after `12T`, so scalar strengthening
  of the duty authority is not supported.
- The assigned-parent optimizer log reports the same strongest sampled capture
  (`0.748598L` at `25.509T`) but contains no additional trajectory or load
  artifact. It supports the scalar outcome only; the policy, diagnostics, and
  visual sheets above provide the mechanism evidence.

## One-candidate policy hypothesis

Use the sampled upstream duty-ratio mechanism without increasing its authority:
target/course geometry selects the turn side, anterior joint position supplies
within-beat phase, and the controller weakens restoring acceleration on the
useful bend side while strengthening the opposite return. Preserve the
evidenced posterior traveling-wave vectoring, target-line response,
capture-corridor modulation, coordinated command compression, and joint
viability guards. Remove the inherited `1.75--4.5L` load-qualified recovery
branch rather than combining the duty primitive with a middle residual already
falsified by four clustered rollouts. This makes the new CFD run an isolated
test of the one positively separated upstream mechanism.

Expected evidence: a route separated from the non-duty family by `8T`, lower
early/middle distance and earlier capture than the assigned parent, the same
organized top-down and oblique wake, zero actuator contacts, and loads no worse
than the sampled duty policy. Falsify the candidate if the early route matches
the non-duty family, capture is lost, wake coherence degrades, any actuator
contact returns, or peak force/moment exceeds `0.02063/0.01065` without a
meaningful trajectory benefit.

```text
bookshelf_consulted: true
source_domain: robotic-fish CPG turning and classical traveling-wave swimming
source_mechanism: asymmetric flapping duty ratio applied to a phase-separated propulsive bend
transferable_invariant: alter the duration or restoring strength of the target-side half-cycle while retaining wave direction and posterior lag
nontransferable_details: published gains, clock phases, species-specific amplitudes and frequencies, full-body kinematics, and task-specific routes
policy_translation: use normalized body-frame course geometry for side and anterior joint position for phase; apply one bounded upstream restoring-phase asymmetry under existing state-feedback and viability guards
falsification: reject if early course and distance do not separate from the non-duty family, or if capture, coherent wake structure, actuator viability, or the sampled load envelope degrades
```
