# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before the policy edit

- The assigned parent preserves the `0.55`-period, `28 deg`
  posterior-lagged traveling bend and adds a gait-relative circular bearing
  filter to a bounded `12 deg` total-curvature request split `45/55`. Its
  completed rollout reaches the `0.75L` target at `36.564` released time with
  `1.808L` mean distance, so this is the reachability scaffold rather than a
  target-blind seed that should be replaced.
- The common prewarm sheet shows the held fish above and downstream of four
  fully developed, interacting vortex streets. The released sheets show the
  filtered policies making an early targetward turn, maintaining an active
  posterior traveling bend, crossing those streets on a compact diagonal, and
  entering the capture circle directly. The motion is self-propelled rather
  than passive downstream advection; there is no visible collision precursor,
  terminal overshoot, or repeated wake-driven loss of turn sign.
- The two strongest sampled solvers use the same filtered equations and a
  `40/60` anterior/posterior split. Their identical completed replays reach at
  `35.6895`, improve mean distance to `1.7619L`, and score `0.11216`. Relative
  to the assigned `45/55` prefill, they reduce total command energy from
  `51,805` to `50,871`, lateral-force RMS from `66.17` to `59.28`, and moment
  RMS from `901.74` to `821.23`, while preserving capture and improving
  arrival. Mean command energy is slightly higher (`1425` versus `1417`), the
  posterior peak angle is slightly larger (`0.575` versus `0.562 rad`), and
  both policies touch the acceleration envelope; this is navigation/load
  evidence for the allocation, not an efficiency or actuator-headroom claim.
- The instantaneous-bearing `40/60` sample also reaches the target, but later
  at `37.955`. Together the samples separate the two useful ingredients:
  posterior-weighted total curvature retains propulsion and lowers aggregate
  loads, while short circular bearing history improves the compact approach.
  The two exact filtered `40/60` replays establish deterministic repeatability
  only at the common wake snapshot, not held-out wake robustness.
- The inherited route-trend child is a concrete negative result. Adding a
  bounded `bearing_window_rate` correction to the successful filtered `45/55`
  controller produced a downstream `left_domain` exit after `16.956`, head
  displacement `(+2.175,-0.874)L`, no approach inside `12.424L`, and only
  `8.64` mean command energy. That falsifies its stated capture and propulsion
  boundaries. This candidate excludes trend feedback rather than guessing at
  its sign or scale from aggregate diagnostics.

## Bookshelf consultation

bookshelf_consulted: true
source_domain: biological swimming, robotic-fish direction tracking, and organized-wake interaction mechanisms were reviewed; no new source primitive is adopted
source_mechanism: none; the sampled trajectory already turns, self-propels through the wake, and captures without a signed disturbance event or terminal miss that would identify a missing primitive
transferable_invariant: preserve the directional posterior-lagged traveling wave and distinguish persistent target geometry from fast wake motion before adding another feedback path
nontransferable_details: published gains, species or robot kinematics, dimensional frequencies, exact vortex phases, actuator allocations, and task-specific routes
policy_translation: no shelf-derived translation is added; promote the exact filtered `40/60` controller supported by two completed sampled CFD replays, with all propulsion and filter parameters unchanged
falsification: reject the promotion if the downstream replay loses capture, exceeds the `36.564` parent arrival, worsens the `1.808L` parent mean distance, reverses the compact diagonal topology, or raises loads without the sampled navigation benefit

## Candidate hypothesis

Produce exactly one evidence-selected candidate: retain the parent's circular
body-frame bearing filter, bounded total-curvature law, state-feedback
oscillator, and velocity-derived posterior lag, and change only the owned
curvature allocation from `45/55` to the twice-completed `40/60` split. This
does not use the bookshelf to extrapolate a scalar gain; it promotes an exact
sampled controller and deliberately avoids the falsified bearing-trend child.

The downstream evaluation should reproduce target capture near `35.69`
released time and `1.762L` mean distance with force and moment below the
filtered `45/55` parent. No new CFD outcome is claimed by this worker. Later
held-out wake or target evidence should test whether the apparent advantage is
robust beyond the shared prewarm snapshot.
