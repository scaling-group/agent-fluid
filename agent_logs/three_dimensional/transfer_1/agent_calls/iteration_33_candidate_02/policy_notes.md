# Contraction-released posterior wave-recovery candidate

## Completed evidence and visual diagnosis before editing

- All four sampled episodes are finite `capture` rollouts initialized directly
  from uniform still water with `U_infinity=(0,0,0)`, no cylinders, and no
  prewarm snapshot.  Two byte-identical v47 contraction-release evaluations
  reproduce capture at `17.53399 T`, score `-0.06405`, and total/observed
  distance integrals `1.94972/1.33372 L`.
- The two v48 attempts answer the assigned parent's open arbitration question
  negatively.  Blending contraction release into yaw-response release inside
  `4 L` captures at `17.52849 T` but worsens score and total integral to
  `-0.06531` and `1.95072 L`.  Partitioning contraction and yaw release by
  centerline error captures sooner at `17.47899 T` and improves observed
  integral to `1.33191 L`, but worsens score and total integral to `-0.06581`
  and `1.95078 L`.  The faster terminal samples do not establish a better
  complete route, so another release gate on the same residual is not the next
  useful mechanism.
- I inspected every sampled combined sheet from release through capture.  The
  readable v47 sheet shows active self-propulsion on a smooth target-signed
  arc: compact startup vorticity develops into an organized alternating
  posterior street, while the oblique row shows compact paired Lambda2
  structures following the caudal region.  Both v48 sheets retain the same
  coherent two-view topology; their scalar differences do not come from a new
  wake regime.  The duplicate v47 top-down row is organized, but its oblique
  row is black after frame 000.  That is a rendering failure and supplies no
  comparative 3D-wake evidence.
- Trace diagnostics support preserving the carrier and contraction sensor.
  Reproduced v47 has mean/max speed `0.7235/0.9731 L/T`, any-joint
  acceleration-limit residence `42.75%`, and peak normalized planar
  force/moment `0.03225/0.01609`.  The blended v48 barely changes that envelope
  while regressing total integral.  The partitioned v48 lowers limit residence
  to `40.15%` and captures earlier, but still has the weakest total integral;
  actuator relief alone is not the route objective.
- The inherited optimizer notes establish that response-released cadence,
  approach-wave propulsion, and multiple approach-local gates had already
  failed to improve the whole route, while posterior wave-shape steering and
  contraction release each produced a useful trajectory change.  Together
  with the completed v48 comparisons, this rules out more terminal scheduling
  and motivates changing what happens to released posterior authority.

## One-candidate policy hypothesis

Preserve v47's normalized body-frame target sensing, selective crossflow pose
confidence, state-feedback carrier, posterior lag, redirect, launch response,
cadence, half-cycle steering, carrier-first spillover, contraction release,
and componentwise actuator projection.  Keep bearing contraction as the sole
completion observation for the supplementary posterior turn-shape residual.

Change only the destination of the released small bend.  Compute the angular
target removed by v47's contraction gate, discard its target-turn sign, and
multiply that bounded magnitude by the sign of the already observed posterior
traveling-wave target.  Add the result to the posterior carrier target.  The
translation is state feedback rather than a clocked phase: it is zero when
contraction release is inactive, when the carrier target crosses zero, or when
large-error redirect has already released the supplementary bend.  Reflection
reverses the recovered wave but not its magnitude, so it cannot become a
one-sided route command.  Base steering remains unchanged.

This tests response-conditioned curvature-to-propulsion reallocation rather
than another gain or another success gate.  The next CFD evaluation should
retain capture, v47's early/middle route and coherent wake, while using the
otherwise removed posterior target to improve total distance integral or
arrival without materially exceeding the completed
`0.9731/42.75%/0.03225/0.01609` speed, saturation, normalized-force, and
moment envelope.  Falsify the mechanism if capture or checkpoint closure
regresses, the recovered term creates mean curvature or beat-sensitive
switching, the alternating two-view wake degrades, or posterior saturation,
speed, force, or moment grows without a route benefit.  Formal CFD runs only
after this worker exits.

```text
bookshelf_consulted: true
source_domain: biological burst redirects combined with elongated-body and robotic-fish traveling-wave control
source_mechanism: release supplementary maneuver curvature after observed geometric response and return the freed authority to posterior propulsive wave shape
transferable_invariant: preserve the rhythmic carrier and base steering; when normalized body-frame target-angle contraction makes extra curvature redundant, any recovered authority must remain zero-mean and aligned with observed posterior wave motion
nontransferable_details: published gains, dimensional maneuver timing, species or robot kinematics, full-body envelopes, open-loop oscillator phase, exact vortex phase, and task-specific routes
policy_translation: use the existing bounded contraction release to measure removed posterior turn-target magnitude, multiply it by the sign of the state-derived posterior carrier target, and add only that zero-mean term to the second-joint wave target before the existing acceleration projection
falsification: reject if the v47 route, capture, mirrored wave sign, or organized two-view wake does not survive, or if total integral fails to improve while speed, posterior saturation, normalized force, or moment materially increases
```

## Evidence boundary

The completed comparisons and visual claims come from the assigned parent
guidance, all sampled solver results, and inherited optimizer notes.  The
curvature-to-wave reallocation is an unevaluated candidate hypothesis; no
same-worker CFD result is claimed.

## No-CFD implementation audit

- The sole materialized candidate is
  `dogfish_target_control_v49_contraction_released_posterior_wave_recovery`,
  SHA-256
  `06aaedb52a0cc47b882e102fdd472b154d52b85b78c66a62aa7b4d8a6aeb32d5`.
  Relative to reproduced v47, its only behavioral addition is the bounded
  state-phased posterior recovery target described above.
- All `67` distinct direct `params.FIELD` references resolve among the `69`
  fields returned by `target_policy_params()`.  The lightweight Julia policy
  contract returns two finite accelerations and the solver editable-boundary
  check passes.
- Targeted Julia comparisons show exact v47 action equality when contraction
  release is inactive and a finite posterior-only difference when it is
  active.  The recovered angular target is no larger than the removed bend;
  mirroring joint state, redirect, and turn input mirrors the new term without
  changing its magnitude.
- The required configured check runner was invoked but could not start because
  its pinned `gpt-5.4-mini` model is unsupported for this ChatGPT account.  Its
  three exact non-CFD commands were run locally and separately and pass.  The
  material-guidance check first exposed a duplicate marker for the identical
  assigned parent in the rendered `README.md`; removing only that duplicate
  repaired the metadata.  No formal CFD was run.
