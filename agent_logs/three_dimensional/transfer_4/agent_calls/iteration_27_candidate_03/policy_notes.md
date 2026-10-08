# Range-qualified recovery of terminal posterior damping

## Visual and quantitative diagnosis before editing

- I read the workspace and assigned-parent guidance, all four sampled solver
  policies, scores, observations, metrics, diagnostics, and trajectories, plus
  the inherited v19--v22 policies, optimization notes, and completed rollout
  evidence. Every inspected episode reports direct uniform still-water
  initialization with `U_infinity=(0,0,0)`, no prewarm, no cylinders, and
  capture termination.
- I inspected both the top-down vorticity and oblique Lambda2 rows in the
  combined sheets for the sampled v20 scalar leader, the v16 prefill, the two
  exact v12 repeats, and the inherited v21/v22 regressions. All visibly
  self-propel from rest. They retain a coherent alternating top-down street and
  compact three-dimensional posterior structures through capture, without
  passive advection, wake breakup, domain interaction, or out-of-plane
  instability. The informative failures are terminal allocation/response
  failures, not propulsion or gross wake-topology failures.
- The two sampled v12 policies are exact repeats at `18.0125T`, score
  `-0.064599`, and mean distance `1.950823L`; they are determinism evidence,
  not two mechanisms. The symmetric v16 posterior-wave envelope captures at
  `18.0235T`, improves final target-course alignment/absolute yaw from
  `0.0678/1.0891 rad/T` to `0.1818/0.4200 rad/T`, and reduces near posterior
  acceleration-ceiling residence from `75.38%` to `72.47%`, while retaining
  score `-0.064545` and the coherent wake.
- The v19 conserved forward steering allocation improves v16 final alignment
  and yaw again to `0.1957/0.2875 rad/T`, but regresses score/mean distance to
  `-0.064778/1.950985L`. The sampled v20 positive-yaw-power selector becomes
  the scalar leader at `18.0070T`, `-0.064028`, and `1.950358L`, but releases
  too much of v16's terminal damping: final alignment falls to `0.1092`, final
  absolute yaw rises to `0.9840 rad/T`, and near posterior acceleration-limit
  residence returns to `75.83%`.
- The assigned parent's completed v21 posterior-rate half-cycle selector is a
  concrete negative result. It retains capture and the same two-view wake, but
  score/mean distance regress to `-0.065267/1.951343L`; direct trajectory
  recomputation gives final head-target course alignment `0.0743` and absolute
  yaw `1.3579 rad/T`. The inherited v22 gait-demodulated yaw feedback also
  retains capture and the wake but reaches only `-0.065191/1.951273L`, with
  final alignment `0.1287` and absolute yaw `1.0486 rad/T`. Thus neither raw
  posterior phase nor a rollout-fitted yaw observer safely selects the shared
  terminal steering response.

## Single policy hypothesis

Start from the evaluated v20 scalar leader, preserving its odd body-frame
target-to-curvature map, anterior state-feedback carrier, posterior lag and
emphasis, phase-consistent reserve, route controller, conserved v19
longitudinal allocation, half-cycle steering, reversal-preserving rate
governor, and positive-yaw-power relief through the outer approach.

Add one continuous terminal regime mechanism: use remaining distance normalized
by the established approach distance to blend the posterior-relief selector
from v20's yaw-power-qualified behavior back to v16's symmetric behavior only
in the inner capture approach. The existing misalignment and absolute-yaw gates
still determine whether relief is needed. This does not add course/yaw gain,
change total mean curvature, identify gait phase, or alter transit. It aims to
retain v20's outer-approach closure while restoring v16's evidenced damping
before capture, after the v21/v22 evidence showed that instantaneous phase and
fitted yaw decomposition are unsafe selectors.

Expected evidence is exact v20 behavior outside the inner approach, capture
and coherent wake retention, v20-like mean distance/arrival, and final
alignment/yaw and posterior limit residence moving toward or beyond v16.
Falsify the mechanism if behavior changes outside its range gate, capture or
score regresses materially, v20's closure gain disappears, terminal
alignment/yaw or posterior saturation fails to improve jointly, reflection
fails, or either wake view deteriorates.

bookshelf_consulted: true
source_domain: terminal capture scheduling combined with Lighthill-style posterior reactive propulsion
source_mechanism: preserve the posterior traveling wave while closure is being built, then continuously reduce excess posterior oscillatory work in the near-capture regime
transferable_invariant: separate outer-approach propulsion from inner-approach damping with normalized body-frame range and measured motion gates rather than clock time or instantaneous gait phase
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, exact vortex phases, fixed capture radius, world coordinates, and task-specific routes
policy_translation: blend the evaluated positive-yaw-power relief selector continuously to the evaluated symmetric posterior envelope as normalized approach range closes, while retaining the existing body-frame misalignment and yaw gates and conserving the odd mean bend
falsification: reject if pre-gate actions change, capture or distance integral worsens materially, final alignment/yaw and posterior load do not improve together, reflection fails, or either coherent wake row deteriorates

## Lightweight validation after editing

- The required dedicated check-runner was invoked, but its pinned
  `gpt-5.4-mini` model is unsupported by this account. Running its immutable
  commands directly gives PASS for the guidance-materiality/notes check and
  PASS for the solver-boundary check. Julia is not installed or discoverable,
  so the executable include/action probe cannot run in this shell; no CFD was
  run.
- The deterministic static guard passes: all `66` direct `params.FIELD`
  references resolve among the `68` fields returned by
  `target_policy_params`; both public functions occur exactly once, the
  candidate is nonempty, raw delimiters balance, and no clock, step, random
  source, file I/O, mutable global, cylinder coordinate, or world-route input
  appears.
- Replaying only the new range selector on the completed v20 trajectory leaves
  it exactly inactive at and above `0.65` normalized approach range
  (`1.365L`), so all preceding actions remain the evaluated v20 contract. It
  becomes fully symmetric below `0.40` normalized range (`0.84L`). Across the
  inner range, mean posterior relief rises from v20's `0.1519` to `0.3335`,
  changing mean posterior-wave authority from `0.9393` to `0.8666`; at the
  sampled capture state the selector is fully symmetric. Simultaneously
  reflecting yaw and moment leaves selector magnitude unchanged to numerical
  precision. These are activation and algebra checks, not new CFD evidence;
  EvE must evaluate the capture, wake, load, and terminal-motion hypothesis
  after this worker exits.
