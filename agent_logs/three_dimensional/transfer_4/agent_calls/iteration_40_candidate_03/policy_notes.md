# Terminal differential-preserving acceleration allocation

## Visual and quantitative diagnosis before editing

- I read the workspace and guidance contracts, the assigned-parent guidance,
  all four sampled policies, scores, observations, metrics, diagnostics,
  trajectories, and combined keyframe sheets, plus the inherited optimizer
  notes and completed results. The four sampled policy files, trajectories,
  and keyframe sheets are byte-identical v31 repeats. Each is a finite capture
  from direct uniform still water with `U_infinity=(0,0,0)`, no prewarm, no
  cylinders, 251 moving-window shifts, and no boundary or numerical failure.
  They are determinism evidence for one controller, not four mechanisms.
- I inspected both visual rows from release through capture for sampled v31
  and the informative completed closing-stride anterior-envelope regression.
  The top-down mid-plane row shows self-propulsion from rest, target-directed
  turning, and a coherent alternating reverse wake; the oblique Lambda2 row
  shows compact three-dimensional posterior structures and no out-of-plane
  instability. The regression preserves that wake topology. Its failure is
  therefore terminal allocation and closure, not propulsion creation, route
  polarity, passive advection, collision, or wake breakup.
- V31 reproducibly captures at `18.0125T`, with score/mean distance
  `-0.0640004/1.950346L`, observed distance integral `1.336756L`, center path
  `13.2149L`, and head cross-track about `0.7361L`. Its useful transit ends in
  a fast oblique crossing: mean approach/final course alignment is
  `0.6688/0.1297`, final speed is `0.8806U`, and final absolute yaw remains
  large (`0.8077 rad/T` by the inherited windowed diagnostic). Near anterior
  and posterior acceleration-ceiling residence is `69.29/75.89%`.
- The completed anterior-envelope regression improved only its instantaneous
  final alignment/yaw, to `0.1957/0.3716 rad/T`, while delaying capture to
  `18.0180T` and worsening score, mean distance, and observed integral to
  `-0.0650022/1.951162L/1.336802L`. The inherited carrier-amplitude,
  common-cadence, posterior signed-work, duty/sign, mean-bend-share, and
  steering-headroom tests likewise fail to improve closure and terminal state
  together. The completed carrier-demodulated anterior half-cycle test is
  also effectively inactive in CFD: versus v31 it changes neither arrival nor
  ceiling residence, alters mean/final distance only from
  `1.950346/0.748395L` to `1.950353/0.748404L`, and leaves approach/final
  alignment at `0.6688/0.1298`. Another scalar envelope or sparsely reachable
  half-cycle gate is therefore unsupported.
- The remaining actuator-level defect is visible directly in the sampled
  action history. At least one joint is at the acceleration ceiling in
  `97.8%` of all v31 samples and every sample below `2.10L`; both are at a
  ceiling in `40.8%` of approach samples, with same-sign double saturation in
  `20.6%`. Independent component clamps collapse the joint differential to
  zero in those same-sign events even when the raw state-feedback law asks for
  a nonzero traveling-wave or steering differential. This supports changing
  saturation geometry rather than reducing cadence, amplitude, or signed
  work.

## Single policy hypothesis

Preserve v31's normalized body-frame route law, state-derived anterior
carrier, posterior lag and emphasis, phase-consistent work reserve, conserved
mean-bend allocation, course-consensus duty surface, half-cycle steering, and
reversal-preserving rate governor. Add one approach-only joint allocation
primitive before the existing per-joint safety governors: compare the raw
two-joint acceleration differential with the differential left by independent
box clipping, and, only when both requests reach the same box corner and erase
that differential, move the pair continuously toward the closest in-box pair
that preserves it without reversing either acceleration. The projection gives
up common-mode acceleration before joint-to-joint structure; it adds no turn
request, changes no cadence or target, and remains exactly inactive for
opposite-sign or single-joint saturation, when the commands fit the physical
box, or outside the established moving, misaligned approach.

This is deliberately a partial projection, so the first rollout tests the
mechanism without fully replacing v31's evaluated clamp behavior. Distance,
speed, alignment, the box limit, and differential-loss magnitude are invariant
under lateral reflection, while both joint commands and their preserved
difference reverse. Expected evidence is retained transit and coherent wake,
with less same-sign differential collapse and improved approach-average
alignment/yaw or path without moving ceiling residence between joints.
Falsify if any pre-approach output changes; capture, arrival, or observed
distance integral regresses materially; common-mode withdrawal weakens the
posterior wake; alignment/yaw/path and non-migrating residence do not improve
together; reflection fails; or either visual row deteriorates.

```text
bookshelf_consulted: true
source_domain: elongated-body reactive propulsion and feedback-modulated robotic-fish turning
source_mechanism: retain a posterior-lagged traveling wave while superimposing bounded joint asymmetry for direction control
transferable_invariant: when an actuator envelope is active, preserve the two-joint differential that carries wave direction and steering before expendable common-mode acceleration
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, exact vortex phases, full-body kinematics, world coordinates, target location, capture radius, and task-specific routes
policy_translation: during only the normalized moving misaligned approach and same-sign double saturation, project raw anterior/posterior accelerations toward the closest same-quadrant physical-box pair that preserves their requested differential, then retain the existing joint-rate governors and hard limits
falsification: reject if transit changes, capture or observed closure regresses materially, the coherent posterior wake weakens, reflection fails, or approach alignment, yaw, path, and non-migrating joint-limit residence do not improve together
```

## Lightweight validation after editing

- The mandated `.codex/agents/check-runner.toml` was invoked, but its pinned
  `gpt-5.4-mini` model is unsupported on this account. Running its immutable
  checks directly gives PASS for guidance materiality after removing only the
  duplicate copied-parent marker from the rendered workspace `README.md`, and
  PASS for the solver boundary. No CFD was run.
- Julia is not installed, so the executable include/action probe cannot run.
  Deterministic static checks find one nonempty candidate, one definition of
  each public function, balanced delimiters, and all `68` direct
  `params.FIELD` references among the `70` fields returned by
  `target_policy_params`. They find no explicit clock, elapsed time, step
  count, randomness, file I/O, mutable global state, cylinder input, fixed
  target coordinate, or memorized route.
- A 100,000-case algebraic audit of the new allocator keeps every output in
  the acceleration box (floating-point excess below `4e-15`), produces no
  sign reversals, is exactly inactive outside same-corner double saturation,
  and reverses both outputs exactly under simultaneous lateral reflection.
  These are contract and mechanism checks on the pending policy, not a claim
  about its downstream CFD response.
