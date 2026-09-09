# Wake-policy candidate diagnosis

## Evidence read before candidate selection

- All four sampled rollouts use direct uniform still-water initialization with
  `U_infinity=[0,0,0]`, no cylinders, and no prewarm. Their motion is therefore
  self-propulsion rather than ambient advection. I inspected both rows of each
  combined sheet. All four captures sustain a strong alternating top-down
  vorticity street and compact paired oblique Lambda2 structures through the
  terminal approach; there is no visual carrier collapse to repair.
- Three sampled policies are exact-byte evaluations of
  `dogfish3d_intercept_guarded_speed_reserve_v1`. They captured at
  `0.7466--0.7494L` and `18.2050--18.6010T`. The assigned parent's new
  `dogfish3d_speed_reserve_projected_miss_turn_v1` also captured, at
  `0.7477L` and `18.5405T`. It preserved the same wake class and comparable
  force, yaw-moment, action-clamp, and speed-limit envelopes: returned action
  clamps on about `68.5%/71.0%` of rows, exact speed-limit residence is about
  `10.6%/11.4%`, peak force magnitude is about `0.0306`, and peak yaw moment
  is about `0.0161`.
- The new projected-miss controller did not improve the scalar or arrival
  evidence. Its score `-0.16291` is below all three exact speed-reserve scores
  (`-0.15856`, `-0.15828`, and `-0.15140`), and it crossed at `18.5405T`, near
  the slow end of their arrival range. This is not evidence of regression in
  the semantic success class, but neither is one threshold crossing evidence
  that projected-miss steering is robust.
- The informative inherited total-command-governor failure reached only
  `1.3877L` and exited below at `32.5985T`. Its top-down and oblique sheets
  still show active alternating wake structures after the miss, while its
  speed-limit residence fell to about `6.9%/7.2%`. Together with the four
  sampled captures, this continues to separate terminal path geometry from
  thrust production and rejects another saturation-first allocation edit.
- Earlier lineage evidence contains a `0.7493L` response-conditioned capture
  whose exact bytes later missed at `1.7715L`. The three exact speed-reserve
  captures were what cleared that fragility boundary. Applying the same
  reproducibility standard to projected-miss steering is more informative
  than combining it immediately with an unevaluated yaw/slip, corridor, or
  actuator mechanism.

## Candidate and falsification

Submit the prefilled projected-miss policy byte-for-byte (SHA-256
`cd57377d579c511a8ec3ed1240e804f421d2994c5b6fc7f2796bbae664849173`) as
exactly one reproducibility candidate. It retains the evaluated joint-state
traveling bend, achieved-course route servo, phase-compensated response/LOS
release, projected-intercept guard, sparse outward-carrier reserve, and the
new bounded signed projected-miss blend inside `2L`. No gain, schema, comment,
or version change is made, so a divergent outcome cannot be attributed to a
second controller edit.

Expected test: repeat capture near the evidenced `18.54T` approach while
preserving the coherent top-down and oblique wake, terminal speed, load
envelope, and reflection-equivariant body-frame behavior. If it captures
again, projected-miss steering has repeat evidence but still does not outrank
the three-repeat speed-reserve baseline on arrival or scalar score.

Falsification: if the exact bytes miss the `0.75L` disk, reproduce the lower
exit, weaken the traveling wake, or materially raise load/saturation, treat
the first projected-miss capture as threshold-fragile and revert to the
three-repeat speed-reserve baseline before testing a distinct terminal
mechanism. Even with another capture, reject claims of improved efficiency or
arrival unless those metrics become meaningfully better than the baseline
range.

bookshelf_consulted: true
source_domain: rhythmic robotic-fish direction tracking and terminal capture or position-hold control
source_mechanism: preserve a self-sustaining propulsive carrier while bounded sensor-derived interception feedback shapes only the slower steering objective
transferable_invariant: evaluate terminal steering geometry independently from propulsion, and require repeat evidence before stacking another feedback primitive onto a threshold capture
nontransferable_details: published gains, dimensional cadence, species or robot kinematics, exact beat or vortex phase, learned routes, and task-specific paths
policy_translation: retain the parent's normalized body-frame target/velocity projected-miss blend and two-joint carrier exactly; adopt no new shelf primitive until its first capture is reproduced
falsification: reject the retained mechanism if an exact repeat loses capture or wake coherence, recreates the lower exit, raises loads or saturation, or fails to beat the baseline on any claimed efficiency metric

## Non-CFD verification

- SHA-256 confirms that the candidate remains byte-identical to sampled
  solver `solver_5c1f6245a363`; this is the controlled independent variable.
- The required guidance-delta and deterministic parameter-schema audit passes
  after removing the duplicate assigned-parent marker in the rendered root
  README. The documented Julia wrapper passes the finite two-joint policy
  contract, and the solver editable-boundary audit passes. No CFD was run.
