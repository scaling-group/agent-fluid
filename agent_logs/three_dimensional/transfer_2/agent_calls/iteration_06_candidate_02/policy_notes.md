# Multi-wake target-policy candidate notes

## Evidence diagnosis before the edit

- All four sampled rollouts satisfy the frozen evidence contract: direct
  uniform still-water initialization (`U_infinity=[0,0,0]`), no cylinders,
  no prewarm, finite dynamics, and moving-window transport. Their translation
  and wakes are self-generated rather than imposed advection.
- Both the top-down vorticity and oblique Lambda2 rows of all four combined
  keyframe sheets were inspected, with the scalar-best recapture rollout
  (`solver_0e39f9f53067`) compared directly against the assigned persistent-
  phase parent (`solver_74dbc2a53e94`) and the phase-selective reference
  (`solver_e3aa71fd7b95`). All retain a coherent alternating wake and compact
  three-dimensional structures through the approach. Local-flow magnitude is
  only about `0.02U` at their closest passes, so absent propulsion, advection,
  or wake breakup does not explain the miss.
- The assigned parent preserves phase authority from body-frame route geometry
  instead of the subcycle yaw-rate aggregate. Relative to the phase-selective
  reference, it improves minimum distance from `3.033L` to the sampled best
  `2.999L`, delays passage slightly from `23.238T` to `23.832T`, and lowers
  raw acceleration-envelope exposure from `93.63%` to `89.62%`. It nevertheless
  leaves the target behind at closest approach (`forward=-1.063L`,
  `lateral=+2.805L`) and exits left at `40.887T`; the keyframes and trace show
  continued westward runout rather than recapture.
- The separately sampled posterior recapture branch is the only candidate that
  changes that late topology. It remains on the common approach through
  `22T`, forms a visible hairpin between `28T` and `40T`, survives to
  `49.319T`, improves mean distance from the assigned parent's `8.086L` to
  `7.107L`, and raises score from `-9.798` to `-8.514`. Its closest approach
  remains `3.031L`, however, and it still exits after the turn with the target
  behind and strongly lateral (`forward=-2.728L`, `lateral=+7.016L`). Thus
  recapture curvature is a positive route mechanism but is not sufficient
  without the parent's persistent pre-passage phase allocation.
- The abeam-burst sample (`solver_a5440e0f837b`) is a useful negative boundary:
  an opposite-polarity mean bend armed before definite passage retains the
  same left-exit topology and worsens the phase-selective reference's closest
  approach from `3.033L` to `3.035L`. The new branch must therefore remain
  exactly dormant while normalized target geometry says the target is ahead.

## Policy hypothesis

Preserve the assigned parent's `0.55T/28 deg` posterior-lagged carrier,
wrong-polarity mean-curvature release, and route-persistent opposing-half-cycle
relief. Add one compatible mechanism already supported by an independent
sample: a bounded posterior mean-curvature recapture branch that activates
only after normalized body-frame forward target position is materially
negative, takes its mirrored sign from lateral target error, and releases
continuously when the target returns forward or lateral error closes. This is
a geometry-gated route maneuver, not a global mean bend or scalar-only gain
edit.

Expected evidence is the assigned parent's unchanged deep approach and low
command exposure until target passage, followed by the sampled recapture
hairpin early enough to avoid the parent's westward exit and either reacquire
or capture the target. Falsify the combination if it changes target-ahead
actions, loses wake coherence or the `2.999L`-class pass, materially increases
limit exposure, produces a premature upper/lower exit, or completes another
hairpin while the target remains behind and strongly lateral.

bookshelf_consulted: true
source_domain: biological C-start redirect and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: preserve a rhythmic propulsive carrier while applying strong bounded curvature only under large observed route error and releasing it on geometric recovery
transferable_invariant: separate persistent target-ahead route allocation from a transient target-behind recapture maneuver, with both driven by normalized body-frame geometry and fast body response unable to declare route completion
nontransferable_details: species-specific C-start shapes, published gains, motor timing, dimensional cadence, clock-driven oscillator phase, exact vortex phase, and task-specific routes
policy_translation: retain route-error-driven opposing-half-cycle relief while the target is ahead; after definite body-frame passage, add a bounded mirror-equivariant posterior mean tangent that vanishes on forward reacquisition or lateral closure
falsification: reject the transfer if target-ahead actions change, the coherent deep approach or low parent exposure is lost, an early boundary turn returns, or the target remains behind after another non-capturing hairpin

## Pre-evaluation checks

- Replaying the candidate and assigned parent over all `7,434` recorded parent
  states leaves all `4,124` target-ahead actions bit-for-bit unchanged. The
  recapture gate first activates at `22.319T`, after the common deep approach,
  and is active on `43.91%` of the completed parent trace.
- On reconstructed recorded observations, raw acceleration-envelope exposure
  changes from `89.67%` to `89.23%` and the peak remains exactly
  `112.973 rad/T^2`. Mean summed absolute request rises from `83.45` to
  `85.05 rad/T^2`, about `1.9%`; this is a bounded counterfactual check, not a
  claim about closed-loop load or trajectory, which remain falsification
  risks for formal evaluation.
- All `63` direct `params.FIELD` references resolve among the `65` fields
  returned by `target_policy_params()`. A `7,776`-action grid spanning mirrored
  forward/lateral target geometry, joint state, and yaw response is finite.
  The added recapture request is exactly antisymmetric under lateral reflection
  (zero numerical error) and its candidate-parent action delta is exactly zero
  whenever the target is ahead. The inherited controller's unequal positive/
  negative route gains remain intentionally preserved and are not attributed
  to the new branch.
- The configured check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable for this account. Its three prescribed non-CFD commands were
  then run directly and separately: the reusable-guidance semantic check,
  lightweight Julia public-contract check, and solver editable-boundary audit
  all pass. The guidance check initially exposed and then passed after removal
  of a duplicate assigned-parent marker in the rendered workspace `README.md`.
  Formal CFD is deferred to EvE after this worker exits.
