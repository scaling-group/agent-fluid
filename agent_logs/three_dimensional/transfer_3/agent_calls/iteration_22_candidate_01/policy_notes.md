# Four-rollout promotion of outer traveling-bend limiter coupling

## Evidence and visual diagnosis before candidate selection

- All four assigned solver examples are independent evaluations of the same
  `v33` policy (identical policy SHA-256
  `5f7d9f8a00edfd6a327ecb1048e1d6cb56ac5de9558be3a6fde80dc656781f9a`).
  They satisfy the frozen contract: direct uniform initialization in still
  water with `U_infinity=(0,0,0)`, no cylinders or prewarm, finite dynamics,
  and capture from `12.327720 L`. Each reproduces capture at
  `23.435516 T`, score `-0.4079736071`, mean distance `2.305032573 L`,
  final distance `0.749060333 L`, 4,261 steps, and 265 moving-window shifts.
  The byte-identical combined keyframe sheets show that this agreement extends
  beyond the scalar score.
- I inspected the complete combined v33 sheet from release to capture,
  including every top-down mid-plane vorticity panel and every oblique
  body/Lambda2 panel. The fish is self-propelled from quiescent flow, follows a
  compact continuously closing arc, sheds a coherent alternating wake behind
  the posterior body, and retains finite three-dimensional Lambda2 structures.
  The terminal panels show a quiet held-bend glide rather than thrashing,
  collision, passive advection, wake collapse, a loop, an exit precursor, or
  out-of-plane instability.
- The sampled population contains no distinct failed-policy image: all four
  current policies and combined sheets are byte-identical. The strongest
  available visual contrast is therefore the inherited v29 captured baseline,
  whose complete top-down and oblique sheet I also inspected. It has the same
  coherent self-propulsion and stable terminal-glide topology but captures at
  `25.118523 T`, with score `-0.5280772274`, mean distance
  `2.429087214 L`, final distance `0.746135294 L`, and 268 window shifts.
  I do not infer a visual failure that the evidence does not contain.
- The inherited optimizer logs isolate the policy difference: v33 adds only a
  parameter-owned `12%` blend from independently clipped outer accelerations
  toward a common scale of the raw two-joint carrier, and the normalized
  distance gate makes it exactly dormant in the validated below-`4 L`
  terminal band. Relative to v29, its capture is `1.683006 T` earlier and its
  mean distance is lower by `0.124054641 L`; the center path is also slightly
  shorter (`13.65690 L` versus `13.70935 L`). The inherited telemetry reports
  no joint-stop dwell or inside-`4 L` command above `30 rad/T^2`. Peak lateral
  force and yaw moment rose only modestly (about `0.02647/0.01520` versus
  `0.02620/0.01499`), so the evidence supports this small outer-only coupling,
  not more coupling or terminal-wide coupling.

## Candidate hypothesis

Promote the evaluated `v33_partially_coupled_saturation` policy unchanged as
this workspace's exactly one candidate. Preserve its state-feedback oscillator,
posterior lag, target-angle redirect, closure preview, shared terminal mean
bend, helpful-crossflow and settled-response gates, center-velocity intercept
corridor, and paired terminal release. Outside `4 L` only, retain the sampled
`12%` blend from componentwise clipping toward common-scale limiting of the raw
two-joint carrier. Inside `4 L`, retain the independently limited terminal
allocation exactly.

This is a controlled fourth reproduction of the actuator-coordination
mechanism, not scalar-only gain tuning or a new same-regime stack. The current
evidence has already reproduced the semantic improvement across four assigned
rollouts; changing its amount or activation now would discard that unusually
clean result without a sampled failure signature to repair. The new CFD run
occurs after this worker exits and is not claimed as evidence here. Falsify the
promotion if it fails to reproduce capture near `23.4355 T` and the lower
distance integral, changes the compact path or either wake view, delays or
loses capture, introduces terminal interference, joint-stop dwell, instability,
or material force/moment growth.

bookshelf_consulted: true
source_domain: classical traveling-wave and elongated-body swimming together with coupled-oscillator robotic-fish control
source_mechanism: preserve coordinated anterior-to-posterior traveling-bend structure and posterior lag while enforcing a bounded actuator envelope
transferable_invariant: common bounded scaling preserves the direction of an over-limit coordinated two-joint rhythmic command better than unrelated component flattening
nontransferable_details: published gains, dimensional cadence, species-specific kinematics and actuator envelopes, full-body waves, exact phase lags, vortex phase, capture geometry, and task-specific routes
policy_translation: retain the reproduced small parameter-owned blend toward common-scale limiting only for the outer raw carrier, preserve normalized body-frame target feedback, and keep the mechanism dormant throughout the terminal reallocation band
falsification: reject on non-reproduction of the faster capture and lower distance integral, terminal-command interference, changed target path, lost capture, joint-stop dwell, material load growth, instability, or degradation of either wake view

## Non-CFD implementation audit

- The prescribed check-runner agent was invoked, but its pinned
  `gpt-5.4-mini` model is unavailable on this account. I therefore ran its
  three configured checks directly and separately. The material-guidance
  check, finite two-acceleration Julia contract check, and solver edit-boundary
  check all pass. The rendered `README.md` initially marked the same assigned
  parent twice; removing only one duplicate marker repaired the guidance check
  without changing the parent or evidence set.
- The selected policy remains byte-identical to all four evaluated v33 samples.
  A separate deterministic schema audit finds all 79 direct `params.FIELD`
  references in the 80-field object returned by `target_policy_params()`; only
  the version label is intentionally unreferenced. These are contract and
  reproduction checks only, not new coupled-flow evidence.
