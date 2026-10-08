# Course-slip-qualified terminal posterior envelope

## Visual and quantitative diagnosis before editing

- I read the assigned parent guidance, the sampled solver policies, scores,
  observations, metrics, diagnostics, and trajectories, and the inherited
  optimizer notes and completed evaluations. I inspected the combined
  keyframe sheets from the phase-consistent parent, the strongest sampled
  alignment-qualified envelope, and both later informative regressions. In
  every case the top-down vorticity row shows a self-propelled fish and a
  coherent alternating wake from release through capture; the oblique
  Lambda2 row shows compact three-dimensional posterior structures without
  wake breakup or out-of-plane instability. All runs report direct uniform
  still water with `U_infinity=(0,0,0)`, no prewarm, and no cylinders. The
  unresolved issue is terminal course regulation, not propulsion or wake
  formation.
- Three sampled phase-reference variants are episode-equivalent at
  `18.0125T`, score/mean distance `-0.064599/1.950823L`, center path
  `13.2330L`, head cross-track `0.7417L`, and near/final course alignment
  `0.6637/0.0678`. This is the informative inactive-mechanism failure: changing
  a closure-qualified reserve reference did not alter the visible wake or the
  trajectory.
- The strongest sampled active mechanism is the alignment-qualified posterior
  wave envelope. It leaves the first-`3T` response and all mean-distance
  windows through `16T` unchanged, keeps both wake views coherent, improves
  score/mean distance to `-0.064545/1.950801L`, shortens path/cross-track to
  `13.2111L/0.7232L`, raises near/final course alignment to
  `0.6722/0.1818`, reduces near/final absolute yaw from
  `1.9970/1.0891` to `1.8883/0.4200 rad/T`, and reduces near posterior
  acceleration-ceiling residence from `75.38%` to `72.47%`. Capture is only
  `0.0110T` later at `18.0235T`.
- Its remaining mismatch is specifically lateral course momentum. Below
  `2.10L`, mean signed target/velocity cross product remains `0.5951` and is
  `0.9833` at capture, while signed mean yaw is only `-0.1030 rad/T` and tends
  to zero inside `1.5L`. Thus the existing yaw-only terminal trigger becomes
  weak precisely when course slip remains large.
- Two inherited completed tests constrain the next edit. Direction-selective
  half-cycle relief weakened the validated symmetric damping: score/mean
  distance regressed to `-0.065358/1.951413L`, path/cross-track widened to
  `13.2199L/0.7377L`, and final alignment/absolute yaw worsened to
  `0.0428/1.3862 rad/T`. A signed course residual added directly to the shared
  turn request preserved capture and slightly improved mean near alignment,
  but regressed score/mean distance to `-0.064645/1.950875L` and worsened final
  alignment/absolute yaw from the sampled envelope to
  `0.1640/0.5884 rad/T`. Direct course bias and another half-cycle selector are
  therefore not supported.

## Single policy hypothesis

Use the sampled alignment-qualified posterior envelope as the candidate base,
preserving its odd target-to-curvature map, anterior state-feedback carrier,
far/middle cadence and posterior emphasis, mean steering, phase-consistent
reserve, route observer, approach handoff, half-cycle steering, and
reversal-preserving rate governor. Refine only the terminal envelope trigger:
form the normalized signed target/velocity cross product, take its bounded
magnitude after the existing measured-speed qualification, and combine it
with the observed-yaw trigger. The posterior oscillatory target is relieved
when either appreciable yaw or lateral course slip persists during a poorly
aligned approach. The `0.60` posterior floor, anterior carrier, and mean
steering retain propulsion and turn authority.

This is a new observation-to-allocation path rather than scalar tuning. It is
identically inactive outside `2.10L`, at rest, and on a target-aligned course;
reflection reverses the signed course residual but leaves its scalar relief
authority unchanged. Expected evidence is exact preservation of the sampled
leader before approach, the same coherent wake class, and better near/final
course alignment and path without restoring the large yaw or load of the
phase-consistent parent. Falsify it if pre-approach motion changes, capture or
sampled-best mean distance is lost materially, terminal speed falls without a
course/path gain, yaw/slip or posterior load does not improve, load migrates to
the anterior joint, reflection fails, or either visual wake view deteriorates.

bookshelf_consulted: true
source_domain: terminal capture staging combined with Lighthill-style posterior reactive propulsion and sensor-modulated robotic-fish direction tracking
source_mechanism: near a target, damp measured yaw or slip through bounded posterior-wave allocation while retaining the anterior carrier and enough posterior excursion for propulsion
transferable_invariant: a terminal controller should respond to normalized lateral course momentum as well as yaw because low instantaneous yaw does not imply that inertial velocity is target-aligned
nontransferable_details: published gains, dimensional cadence, species-specific amplitude envelopes, full-body kinematics, exact vortex phases, world coordinates, capture radius, and task-specific routes
policy_translation: compute the bounded body-frame target/velocity cross product, qualify it by measured speed and normalized approach distance, and combine its magnitude with the existing yaw trigger only in the posterior oscillatory envelope
falsification: reject if behavior changes outside approach, capture or sampled-best mean distance is materially lost, terminal alignment/path/yaw or posterior load fails to improve, saturation migrates without benefit, reflection fails, or either coherent wake view worsens

## Lightweight validation

- The required dedicated check-runner was invoked, but its pinned
  `gpt-5.4-mini` model is unsupported for this account, so the checker could
  not start. I ran its immutable commands directly: the material-guidance
  check passes after removing one duplicate assigned-parent marker from the
  rendered workspace `README.md`, and the repository boundary check passes
  with `candidate_target_policy.jl` as the only changed solver file.
- Julia is not installed or discoverable in this execution image, so the exact
  Julia load probe exits with `command not found`. The deterministic schema
  guard passes: all `62` distinct direct `params.FIELD` references resolve
  among the `64` fields returned by `target_policy_params`; the candidate is
  non-empty and parentheses/brackets are balanced.
- Replaying only the allocation formula on the sampled-best trajectory leaves
  authority exactly `1.0` outside `2.10L`. Within approach, mean old/new
  posterior-wave authority is `0.9024/0.8937`; at capture it is
  `0.8879/0.7475`, where signed course error is `0.9833` but yaw is only
  `-0.4200 rad/T`. Reflecting lateral target, velocity, and yaw changes the
  signs of the course residual and yaw but not either magnitude gate, so the
  scalar envelope authority is reflection invariant. These are contract and
  mechanism checks, not CFD evidence; EvE must evaluate the trajectory after
  this worker exits.
