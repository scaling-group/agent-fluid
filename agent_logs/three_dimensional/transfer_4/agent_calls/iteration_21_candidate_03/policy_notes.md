# Signed terminal target-course residual

## Visual and quantitative diagnosis before editing

- I read the assigned guidance and inherited optimizer notes, all four sampled
  policies, scores, observations, metrics, diagnostics, and trajectories, and
  both the top-down vorticity and oblique Lambda2 rows of the combined
  keyframe sheets. Every sample is a stable capture from direct uniform still
  water with `U_infinity=(0,0,0)`, no prewarm, and no cylinders. The fish
  visibly self-propel from rest, the top-down sheets retain an alternating
  advecting wake, and the oblique sheets retain compact posterior
  three-dimensional structures through capture. There is no passive
  advection, wake breakup, collision, or out-of-plane instability. The
  inherited carrier-recovery regression has the same wake class, so route and
  terminal state—not gross vortex existence—remain the useful discriminants.
- Three samples reproduce the phase-consistent parent trajectory exactly,
  including the nominally terminal-partitioned policy whose extra-work gate
  has no realized authority: score/mean distance `-0.064599/1.950823L`,
  capture at `18.0125T`, center path `13.2330L`, and head cross-track
  `0.7417L`. The alignment-qualified posterior-wave envelope in the assigned
  sample keeps the first-`3T` distance/speed exactly
  `12.214593L/0.2519U`, matches every mean-distance window through `16T`, and
  retains the coherent wake in both views. It modestly improves score/mean
  distance to `-0.064545/1.950801L` while delaying capture only `0.0110T`.
- The envelope produces a genuine terminal semantic improvement: center path
  drops to `13.2111L`, head cross-track to `0.7232L`, near/final
  target-course alignment rises from `0.6637/0.0678` to
  `0.6722/0.1818`, near/final absolute yaw rate falls from
  `1.9970/1.0891` to `1.8883/0.4200 rad/T`, and near posterior
  acceleration-ceiling residence falls from `75.38%` to `72.47%`. It is not a
  complete terminal controller: below `2.10L`, the mean signed sine of the
  target/velocity course error remains `0.5951` and reaches `0.9833` at
  capture, while mean speed remains `0.8866U`. An unsigned posterior envelope
  can reduce lateral energy and yaw but cannot choose the corrective side.
- The inherited carrier-energy interpolation is the informative failed
  comparator: it retained capture and both visual wake structures and improved
  arrival/path/alignment, but regressed score/mean distance to
  `-0.073525/1.959839L` with worse distance in every interval after `3T`.
  Together with the exact-output terminal phase partition, this rules out
  another phase-reference interpolation or scalar envelope-floor tune as the
  next mechanism.

## Single policy hypothesis

Preserve the assigned policy's odd target-to-curvature map, anterior
state-feedback oscillator, posterior lag/emphasis, phase-consistent reserve,
far/middle route observer, approach handoff, half-cycle steering,
alignment-qualified posterior envelope, and reversal-preserving rate
governor. Add one signed terminal course residual. Compute the normalized
body-frame cross product between the target vector and measured velocity,
bound it with an odd map, and gate it by the existing normalized approach and
measured-speed authorities. Add the result after the existing approach
attenuation so it can select the corrective side even when geometric steering
has been deliberately softened near capture. It is identically zero outside
`2.10L`, at rest, and when velocity is target-aligned; reflection flips its
sign.

On the assigned trajectory, the bounded residual has mean absolute authority
`0.1603` below `2.10L` versus mean absolute inherited turn request `2.5779`,
and reaches `0.3395` versus request `2.3459` at capture. Thus it is a modest
directional correction rather than a replacement gait or a scalar-only gain
change. The expected signature is exact pre-approach invariance and retention
of the sampled-best distance integral, with lower signed course error, higher
near/final target-course alignment, and no reversal of the envelope's path,
yaw, or terminal posterior-load gains. Falsify the mechanism if behavior moves
before `2.10L`, capture is lost or materially delayed, score/mean distance
regresses, course alignment and path do not improve, actuator pressure merely
migrates to the anterior joint, reflection fails, or either visual wake view
loses coherence.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish direction tracking and terminal capture staging
source_mechanism: retain a propulsive traveling wave while a signed velocity-to-target residual corrects terminal course instead of suppressing all lateral motion
transferable_invariant: line-of-sight geometry and unsigned drive relief do not determine inertial course direction; terminal stabilization should use a bounded signed target-course error while preserving the propulsive carrier
nontransferable_details: published gains, dimensional cadence, species-specific amplitude envelopes, full-body kinematics, exact vortex phases, world coordinates, capture radius, and task-specific routes
policy_translation: normalize the body-frame cross product of target vector and measured velocity, gate it by normalized approach and measured speed, and add its odd signed correction to the two-joint turn request after ordinary approach attenuation without changing the oscillator or posterior envelope
falsification: reject if pre-approach behavior changes, capture or sampled-best mean distance is lost, terminal course/path/yaw does not improve, saturation migrates without benefit, reflection fails, or either coherent wake view deteriorates

## Lightweight validation

- The required dedicated check-runner was invoked, but its pinned
  `gpt-5.4-mini` model is unavailable to this account, so the checker agent
  could not start. Running its immutable checks directly first exposed a
  duplicate assigned-parent marker in the rendered workspace `README.md`;
  removing only that duplicate left the parent selection unchanged. The
  material-guidance check now passes, and the repository boundary check passes
  with `candidate_target_policy.jl` as the only solver difference.
- No Julia executable is installed or discoverable under the available system
  paths, so the exact Julia load probe cannot run here. The deterministic
  schema guard passes: all `64` direct `params.FIELD` references name fields in
  the `66`-field object returned by `target_policy_params`, no returned field
  is duplicated, the candidate is non-empty, and delimiters balance.
- Focused formula probes confirm that the new residual is exactly zero outside
  approach, at rest, and on a target-aligned course. Reflecting target and
  velocity lateral components flips `-0.337676` to `+0.337676` with unchanged
  magnitude. Replaying the gate on the assigned trajectory gives the bounded
  activation reported above. These are contract and mechanism checks, not CFD
  evidence; EvE must evaluate the capture and trajectory prediction after this
  worker exits.
