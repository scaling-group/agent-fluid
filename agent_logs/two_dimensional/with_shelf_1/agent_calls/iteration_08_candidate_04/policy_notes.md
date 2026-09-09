# Multi-wake candidate diagnosis and hypothesis

## Evidence read before editing

- The shared prewarm sheet confirms the common initial condition: the held
  fish begins above and downstream of four developed, interacting cylinder
  streets, while the target is embedded in the mixed second-row wake. This
  sheet cannot distinguish controllers.
- All four direct solver examples reach the target, so there is no sampled
  failure keyframe to compare. The prefilled raw-bearing scheduler
  (`solver_107fd6f7f029`) visibly executes a sharp clockwise redirect and then
  self-propels left/down through the wake; it reaches after `46.035`, with mean
  distance `2.0695L`, mean command energy `1237.06`, and RMS force/moment
  `51.40/761.46`. Its coherent posterior street and mean velocity
  `(-0.2360,-0.0973)` show active propulsion rather than passive advection.
- The strongest sampled policy (`solver_2b5646fbb020`) adds course-slip
  correction plus joint-state half-cycle steering asymmetry. Its released
  sheet shows an earlier redirect and a straighter, faster targetward traverse;
  it reaches after `36.471`, improves mean distance to `1.6860L`, and raises
  mean velocity magnitude to `(-0.2978,-0.1225)`. The semantic gain is large,
  but mean command energy rises to `1335.33` and RMS force/moment to
  `63.59/953.42`; both joint acceleration and speed maxima still touch their
  envelopes. Thus phase-conditioned steering is useful but should be released
  once the redirect has produced targetward course response.
- The two role-separated course-slip examples are numerically identical and
  reach after `45.727`; they are duplicate evidence. In inherited optimizer
  logs, adding a bounded instantaneous relative-crossflow residual to that
  topology slightly regressed arrival to `45.793` and raised RMS force/moment
  from `49.36/799.31` to `55.50/844.32` despite a modest effort reduction.
  Direct crossflow cancellation is therefore a poor next mechanism. The older
  inherited wholesale slower/smaller carrier replacement remains the concrete
  failure boundary: instability after `121.517`, with RMS force/moment
  `16749.8/290421`.

## Candidate policy hypothesis

Start from the strongest evaluated topology and preserve its `0.55`-period
joint-state carrier, posterior lag, slip-corrected body-frame steering error,
raw-bearing authority reservation, two-joint split, `30.0` command envelope,
and half-cycle sign convention. Add one continuous redirect-response gate:
the half-cycle asymmetry is fully available when the slip-corrected route error
is large, then fades toward symmetric residual steering as targetward course
response removes that error. This translates a burst-redirect invariant
without a clock, stage counter, fixed route, or inferred vortex phase.

Expected evidence is preserved capture and the best policy's decisive initial
redirect, with lower post-redirect actuation/load or a route no slower than the
`45.727` role-separated parent. Retain the mechanism only if it keeps a useful
part of the best policy's `36.471` arrival advantage while reducing its
`63.59/953.42` RMS force/moment or `1335.33` mean effort. Falsify it if capture
is lost, the early redirect disappears, arrival exceeds `45.727` without a
clear load benefit, or the coherent posterior wake becomes disorganized. The
new candidate is evaluated only after this worker exits.

bookshelf_consulted: true
source_domain: biological burst redirects and robotic-fish state-feedback CPG turning
source_mechanism: release a bounded phase-conditioned turning asymmetry after observed route response develops
transferable_invariant: preserve the rhythmic traveling carrier, apply extra turn authority only while persistent body-frame route error remains large, and return continuously toward symmetric propulsion as measured targetward response reduces that error
nontransferable_details: published gains, dimensional burst durations, clocked CPG phase, species-specific C-start kinematics, robot duty ratios, exact vortex phases, and source-task routes
policy_translation: multiply the evaluated joint-state half-cycle asymmetry by a bounded function of slip-corrected body-frame bearing error while leaving the carrier, raw-bearing reserve scheduler, joint split, and envelope unchanged
falsification: reject if capture or coherent propulsion is lost, the initial redirect weakens enough to exceed the role-separated parent's arrival without load relief, or force, moment, and effort all fail to improve on the ungated half-cycle policy
