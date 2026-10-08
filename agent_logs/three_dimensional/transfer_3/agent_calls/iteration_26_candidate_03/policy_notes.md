# Wake-policy diagnosis and candidate hypothesis

## Evidence read before editing

- All four sampled rollouts report direct uniform still-water initialization,
  `U_infinity=[0,0,0]`, no cylinders, no prewarm snapshot, finite dynamics,
  and capture. The duplicated `solver_ea692bd78513` and
  `solver_5839f2f95c6e` policy, score, trajectory, and combined sheet are
  byte-identical where expected.
- The prefilled saturation-separated target-residual allocator captures at
  `21.735992 T`, score `-0.30126617`, mean distance `2.19485723 L`, and final
  distance `0.74940461 L`. Its top-down row shows coherent alternating
  shedding through the outer approach, followed by a broad lower-side curve
  and a nearly wake-free held-bend glide at capture. The oblique row confirms
  finite three-dimensional Lambda2 structures rather than passive advection.
  Only `21/8` anterior/posterior actions exceed `30 rad/T^2` below `4 L`, and
  the final action is nearly zero, but it reaches `2 L` only at `19.497494 T`.
- The posterior-response-conditioned allocator captures sooner at
  `20.096998 T` with score `-0.29756859` and mean distance `2.18831161 L`.
  Its coherent wake remains active through the upper-side terminal approach;
  below-`4 L` action-above-`30` incidence rises to `387/486`, with lateral
  force/yaw-moment maxima about `0.02566/0.01348`.
- The strongest response-exclusive allocator assigns poor posterior tracking
  to direction-preserving common limiting and settled tracking to the existing
  target-residual allocator. It retains the compact upper-side, self-propelled
  path and alternating top-down/finite oblique wake, crosses `4 L` at
  `15.664007 T`, and captures at `19.612991 T`; score improves to
  `-0.28294122` and mean distance to `2.17243510 L`. This is a semantic and
  scalar improvement over both sampled component allocators, although it
  remains actively undulatory at capture (`508/589` below-`4 L` actions above
  `30`, final action `5.36/30.54 rad/T^2`, and late lateral-force/yaw-moment
  maxima `0.02692/0.01519`). The new policy therefore preserves its outer
  allocation and does not claim that quiet terminal behavior is always better.
- Replaying the strongest trajectory through its state-feedback algebra shows
  the lag-and-direction response gate active on 2,499 outer states. The
  posterior raw command sets the saturation scale on 1,658 of them, but the
  anterior command sets it on 841. In the latter states, extra common scaling
  attenuates the smaller posterior command even though posterior lag error is
  precisely the signal requesting added traveling-bend support.

## Policy hypothesis

Use the strongest response-exclusive allocator as the parent behavior and add
one smooth posterior-authority selector. When posterior lag error and clipping
rotation request the extra three-point common-scale contribution, permit that
contribution only as the posterior command becomes the dominant command. When
the anterior command dominates, transfer the complementary share to the
already bounded drive-first target-residual allocator. This preserves the
validated base/direction coupling and exact below-`4 L` algebra while avoiding
attenuation of a lagging posterior correction merely because the anterior
joint currently sets the envelope.

The candidate is falsified if the selector is dormant on the sampled overload
regime; if capture is later than `19.612991 T`, lost, or follows the slower
held-bend topology; if mean/final distance regresses from `2.17243510 L` and
`0.74866050 L`; or if it increases joint-stop dwell, global force/moment loads,
instability, or visibly degrades either wake view. Because formal CFD occurs
after this worker exits, these are hypotheses, not claimed outcomes.

bookshelf_consulted: true
source_domain: classical elongated-body swimming and two-joint robotic-fish control
source_mechanism: directed traveling bend with posterior lag and posterior propulsive emphasis
transferable_invariant: preserve lagged posterior corrective authority while the anterior joint sustains and steers the wave
nontransferable_details: published gains, species-specific envelopes, dimensional cadence, full-body kinematics, exact vortex phase, and task-specific routes
policy_translation: use normalized posterior lag error plus the two normalized raw-command magnitudes to gate only the extra outer response-coupling share; retain target-relative body-frame guidance and the existing two-joint feedback oscillator
falsification: reject on dormancy, later or lost capture, worse distance integral, changed terminal contract, joint-stop dwell, material load growth, instability, or loss of coherent top-down and oblique wake structure

## Static validation after editing

- Same-state replay against the strongest sampled allocator changes 874
  commands, with a maximum component difference of `2.361065 rad/T^2`; the
  posterior-response partition is active on 2,144 states and fully active on
  1,821, so the mechanism is not dormant in inherited evidence.
- On all 719 replayed states at or below `4 L`, the new and sampled winning
  policies produce exactly identical commands. This checks algebraic scope,
  not future trajectory-level noninterference.
- The guidance materiality check, lightweight Julia policy contract, direct
  parameter-schema audit, and editable-boundary check pass. No CFD rollout was
  run in this worker.
