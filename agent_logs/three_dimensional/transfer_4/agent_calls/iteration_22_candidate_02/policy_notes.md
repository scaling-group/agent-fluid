# Course-persistent terminal posterior hold

## Visual and quantitative diagnosis before editing

- I read the assigned parent guidance, all sampled scores, observations,
  metrics, diagnostics, trajectories, and policies, the inherited optimizer
  notes and completed solver logs, and both the top-down vorticity and oblique
  Lambda2 rows of the combined keyframe sheets. The evidence is contract-valid:
  every inspected rollout starts directly from uniform still water with
  `U_infinity=(0,0,0)`, no prewarm, and no cylinders.
- The sampled score leader is the assigned alignment-qualified posterior
  envelope at score/mean distance `-0.064545/1.950801L`, capture at
  `18.0235T`, and center path `13.2111L`. Relative to the three
  episode-equivalent phase-reference samples at
  `-0.064599/1.950823L`, it reduces path from `13.2330L`, raises mean/final
  target-course alignment below `2.10L` from `0.6637/0.0678` to
  `0.6722/0.1818`, lowers mean/final absolute yaw rate from
  `1.9970/1.0892` to `1.8883/0.4200 rad/T`, and lowers terminal posterior
  acceleration-ceiling residence from `75.38%` to `72.47%`, while delaying
  capture only `0.0110T`.
- In both visual rows the fish self-propel from rest, maintain an alternating
  advecting mid-plane street, and shed compact three-dimensional posterior
  structures through capture. There is no passive advection, wake breakup,
  collision, or out-of-plane instability. The last frames instead show an
  energetic, laterally bent crossing: terminal mean speed is still `0.8866U`,
  mean signed target-course sine is `0.5951`, and its magnitude reaches
  `0.9833` at capture. Thus the remaining failure is course settling, not
  propulsion or wake formation.
- Completed inherited alternatives sharpen the negative evidence. Selectively
  restoring the posterior half-cycle thought to aid yaw captures earlier at
  `18.0015T`, but worsens score/mean distance to
  `-0.065358/1.951413L`, widens maximum head cross-track to `0.7377L`, and
  finishes at only `0.0428` alignment with `1.3862 rad/T` yaw. Adding a signed
  course residual to the mean turn request preserves the leader's route but
  also regresses score/mean distance to `-0.064645/1.950875L` and worsens final
  alignment/yaw to `0.1640/0.5884 rad/T`. Their combined sheets retain the
  same gross wake class, so neither more direction-selective posterior work nor
  another small steering residual is supported as the next mechanism.

## Single policy hypothesis

Preserve the sampled leader's odd body-frame curvature map, anterior
state-feedback oscillator, cadence, posterior lag/emphasis, mean steering,
phase-consistent reserve, far/middle route observer, and reversal-preserving
rate governor. Refine only the active terminal posterior envelope so it does
not release merely because yaw rate has momentarily fallen while inertial
course remains strongly misaligned. Inside the established `2.10L` approach,
combine the existing normalized yaw gate with the magnitude of the normalized
body-frame target/velocity cross product. Their bounded continuous union holds
back only posterior oscillatory excursion until both yaw and target-course
slip settle; the anterior carrier and mean steering remain untouched.

The expected signature is exact preservation outside `2.10L` and retention of
the coherent two-view wake, with less terminal posterior work after yaw begins
to fall, lower course-sine magnitude and speed at crossing, a shorter path,
and score/mean distance no worse than the sampled leader. Falsify the mechanism
if pre-approach behavior changes, capture is lost or materially delayed, score
or mean distance regresses, course/path/alignment fails to improve, load merely
migrates to the anterior joint, reflection symmetry fails, or either visual
wake view loses coherence.

bookshelf_consulted: true
source_domain: terminal capture staging, sensor-modulated robotic-fish oscillators, and Lighthill-style posterior reactive propulsion
source_mechanism: preserve the posterior traveling wave for transit, then hold back excess posterior excursion near capture until observed yaw and velocity-to-target course slip have both settled
transferable_invariant: separate propulsive transit from terminal stabilization and qualify posterior drive by normalized observed motion relative to the target rather than by position error or yaw alone
nontransferable_details: published gains, dimensional cadence, species-specific amplitude envelopes, full-body kinematics, exact vortex phases, world coordinates, capture radius, and task-specific routes
policy_translation: form a reflection-invariant terminal motion gate from bounded body turn rate and the magnitude of the normalized body-frame target/velocity cross product, then apply it only to the lagged posterior wave target within the existing distance and misalignment envelope
falsification: reject if behavior changes outside approach, capture or sampled-best mean distance is lost, terminal course/path/alignment does not improve, saturation migrates without benefit, reflection fails, or either coherent wake view deteriorates

## Lightweight validation after editing

- The required dedicated checker was invoked, but its pinned `gpt-5.4-mini`
  model is unavailable to this account. Running its immutable checks directly
  first exposed a duplicate assigned-parent marker in the rendered workspace
  `README.md`; removing only that duplicate preserved the selected parent. The
  rerun passes the material-guidance check, and the repository boundary check
  passes with `candidate_target_policy.jl` as the only solver change.
- Julia is not installed, so the checker's exact Julia load probe cannot run in
  this shell. The deterministic schema guard passes independently: all `63`
  direct `params.FIELD` references resolve among `65` unique fields returned by
  `target_policy_params`, the two public functions remain singular, the file
  is nonempty, and parentheses, brackets, and braces balance.
- Replaying only the proposed gate on the sampled leader's recorded trajectory
  leaves posterior-wave authority exactly `1.0` for all `2881` samples at or
  beyond `2.10L`. Within approach, mean/minimum authority changes modestly from
  `0.9024/0.7498` to `0.8886/0.7462`; the new hold is stronger in `315/396`
  samples and changes final authority from `0.8879` to `0.7564` where course
  sine is `0.9833` but yaw has fallen to `0.4200 rad/T`. Focused probes give
  exactly unit authority outside approach, at rest, and on a target-aligned
  course. Mirroring target lateral component, lateral velocity, and yaw flips
  course sine while preserving authority to machine precision. These are
  contract and activation checks only; EvE must supply the CFD outcome.
