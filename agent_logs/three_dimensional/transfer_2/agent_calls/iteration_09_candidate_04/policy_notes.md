# Terminal steering-priority bridge candidate

## Evidence diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen evidence contract: direct
  uniform quiescent initialization with `U_infinity=[0,0,0]`, no cylinders,
  no prewarm, finite dynamics, and moving-window transport. Their translation
  and wakes are therefore self-generated rather than imposed advection.
- Both rows of every combined keyframe sheet were inspected, with the
  strongest finite near miss (`solver_0c4c66457a74`, `1.076L`) compared
  against the assigned persistent-route parent (`solver_016c2732900a`,
  `2.996L`) and the sampled sector-intercept predecessor
  (`solver_a81796f958a5`, `2.579L`). The top-down row retains an alternating
  wake through approach and turning, while the oblique Lambda2 row retains
  compact three-dimensional structures. The best child is self-propelled and
  numerically stable; wake breakup or absent thrust is not the limiting
  failure.
- Steering-priority allocation is a semantic improvement, not a scalar-only
  fluctuation. Relative to the sector-intercept predecessor it improves the
  closest approach from `2.579L` to `1.076L`, mean distance from `6.913L` to
  `6.178L`, and raw acceleration-envelope exposure from `82.76%` to `74.65%`.
  It does not capture: joint-rate-limit exposure rises slightly from `12.59%`
  to `13.09%`, the target passes posterior-lateral, and the fish exits the
  upper edge at `37.823T` and `6.307L`.
- The assigned parent's broad upper hairpin and the three completed recapture
  variants already falsify another behind-gate threshold, persistent route
  term, or late curvature-gain edit. The useful opening is narrower. Replay of
  the strongest trace shows the existing closing-sector allocator active
  through the deep approach, but its gate drops to zero as windowed closing
  speed changes sign near the `1.076L` pass. At approximately `25.80T`, the
  target remains normalized posterior-lateral at about
  `(forward,lateral)=(-0.36,0.93)` and recapture still requests nearly full
  signed curvature. Nevertheless the allocator releases, allowing a
  carrier-dominated posterior raw command near `+75.8 rad/T^2` while the
  decomposed steering request is about `-21.8 rad/T^2`; downstream clipping
  therefore loses the requested sign during a terminal beat phase.
- The strongest path needs only `0.326L` more head progress to cross the
  `0.75L` capture radius. Preserve its approach and existing curvature rather
  than add steering amplitude. The missing capability is continuity of finite
  actuator allocation across the closing-to-passage transition.

## Policy hypothesis

Start from the evaluated steering-priority sector-intercept policy. Preserve
its carrier, target-ahead sector gate, bounded curvature, posterior recapture,
and every raw command outside the established `2.10L` approach region. Add one
continuous terminal priority bridge: as distance falls from the existing
approach boundary toward the normalized capture scale, let the already-active
posterior-lateral recapture request keep first claim on the same acceleration
envelope after positive closing speed disappears. Combine this bridge with the
existing intercept priority using a maximum, so it cannot weaken the proven
sector allocation and introduces neither extra curvature nor a stored stage.
Release it continuously if the target returns forward, lateral error closes,
or distance grows back outside the approach region.

The falsifiable expectation is exact preservation of the sampled command
before the terminal bridge exceeds the intercept gate, followed by fewer
wrong-sign clipped posterior phases near `1.1L` and capture or a closest
approach below `1.076L`. Reject the mechanism if it changes the common far
approach, increases joint-rate exposure materially, destroys the coherent
wake, or retains the same early upper-left exit without closer progress.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish turning and terminal capture control
source_mechanism: large-error bounded curvature with observed-response release into the propulsive rhythm, plus continuous near-target authority scheduling
transferable_invariant: when a limited-actuator redirect is already useful, preserve corrective authority through the closing-to-passage transition and restore the carrier continuously as body-frame target error or proximity releases
nontransferable_details: species-specific C-start shapes, published gains, dimensional cadence, clock timing, exact vortex phase, gait envelopes, and task-specific routes
policy_translation: combine the existing normalized body-frame closing-sector priority with a distance-scheduled posterior-lateral recapture priority inside the approach region; allocate the unchanged two-joint steering request before carrier acceleration without hidden time or state
falsification: reject if far or pre-terminal commands change, the `1.076L` miss does not improve, terminal clipping retains the carrier's wrong sign, rate exposure worsens materially, propulsion collapses, or the same upper-left exit remains

## Pre-evaluation checks

- All `74` direct `params.FIELD` references resolve among the `76` fields
  returned by `target_policy_params()`; only metadata fields are not read by
  the controller. The candidate contains no time, elapsed-step, random,
  cylinder, file-I/O, or world-target-coordinate dependency.
- Same-state replay over all `6,877` recorded states of the evaluated
  steering-priority rollout produces finite outputs. Exactly `6,290` states
  remain unchanged and all `587` changed states are inside `2.10L`; there are
  zero far-region changes. On this fixed trace, reconstructed raw-command
  envelope exposure falls from `75.135%` to `74.815%`. This algebraic replay
  is not a prediction of the new closed-loop path.
- At the diagnosed `25.801T`, `1.081L` state, the sampled command is
  approximately `(-62.8,+75.8)rad/T^2`. The terminal bridge is `0.748`, keeps
  the unchanged recapture steering request, and produces approximately
  `(-39.3,+10.0)rad/T^2`; it prevents the posterior carrier phase from
  reversing the requested steering sign without adding curvature.
- A deterministic `1,296`-state grid over normalized distance, mirrored
  body-frame target angle, closing speed, joint state, and yaw response is
  finite. The new terminal and combined allocation gates are reflection
  invariant, and the allocator is odd under reflected carrier and steering
  components.
- The configured check-runner was invoked, but its pinned `gpt-5.4-mini`
  model is unavailable for this ChatGPT account. Its three prescribed no-CFD
  checks were run directly and separately. The guidance check initially
  exposed two identical assigned-parent markers in the rendered `README.md`;
  the duplicate listing was removed without changing parent identity, after
  which the reusable-guidance check passed. The lightweight Julia public
  contract and solver editable-boundary audit also pass. Formal CFD remains
  deferred to EvE after this worker exits.
