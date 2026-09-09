# Multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before editing

- All four sampled solver examples satisfy the frozen experiment contract:
  direct uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite moving-window transport, and capture. Three are
  executable-identical half-cycle envelope-redistribution policies. They
  capture at `18.6505--18.8815T`, reach `0.74630--0.74928L`, and have score
  mean-distance values `2.08855--2.09222L`. The distinct broadside-reserve
  sample captures at `18.7055T` with mean distance `2.09386L`.
- I inspected every sampled combined sheet and compared the best-score
  redistribution capture with the distinct reserve capture. Their top-down
  rows form alternating target-bending streets from quiescent water, and their
  oblique rows retain compact alternating caudal Lambda2 structures through
  first crossing. Translation is self-propulsion rather than advection;
  neither sampled architecture visibly loses its productive traveling bend.
- The newly completed inherited phase-separated ablation is the informative
  failure. Removing displacement-phase scaling from both mean-curvature shares
  while retaining envelope redistribution preserves an energetic two-view
  wake, but the top-down body and street turn below and away after the near
  approach. It misses capture at `0.95507L`, exits left at `34.2815T`, finishes
  at `10.15052L`, and has score mean distance `8.98475L`. Its lower rate contact
  (`8.62%/9.43%`) is not relief because the route is lost; acceleration contact
  remains `64.88%/68.47%`. The visual/metric agreement shows that beat-phase
  curvature modulation is route-relevant, not a redundant ornament.
- Two sibling step-27 controls sharpen the boundary. The executable rollback
  retains full phase steering and captures at `18.6890T` with mean distance
  `2.09418L`. A smooth route-authority gate confined to
  `|lateral_fraction| < 0.05` also captures at `18.6670T`, with coherent wake
  rows, mean distance `2.09620L`, and the usual demand/load class. It proves
  that locally reducing authority is capture-compatible, but does not prove a
  performance benefit from suppressing the whole route request.
- The actionable distinction is therefore between persistent mean curvature
  and its beat-side amplification. The current capture traces contain
  `46--47` lateral-target sign crossings and spend `9.3--9.6%` of rows inside
  `|lateral_fraction| < 0.05`. Outside that small-error sector, the failed full
  ablation requires retaining displacement-phase curvature. Inside it, the
  completed route-gate capture supports a narrower test that leaves the base
  target-owned route intact and attenuates only phase-dependent amplification.

## Bookshelf transfer

```text
bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and asymmetric-flapping turning
source_mechanism: persistent target geometry supplies mean bend while observed beat side modulates additional turning authority only when direction error is substantive
transferable_invariant: qualify beat-side curvature asymmetry by normalized body-frame direction error without removing the posterior-lagged traveling wave or the persistent target-signed mean bend
nontransferable_details: published gains and deadbands, robot geometry, species-specific kinematics, dimensional cadence, prescribed oscillator phase, exact vortex phase, and task-specific routes
policy_translation: retain the inherited body-lateral route request, correcting-yaw release, two-joint bias ratio, posterior lag, and common-envelope redistribution; apply a smooth zero-to-one body-lateral gate only to half-cycle curvature scaling inside the evidenced 0.05 alignment sector
falsification: reject if capture or either coherent wake row is lost, the same broadside-to-left-exit topology returns, mean distance leaves the sampled capture band without a distinct benefit, or actuator contact and planar loads worsen beyond the established class
```

## Single-candidate policy hypothesis

Add exactly one alignment-qualified phase-steering mechanism to the prefilled
redistribution carrier. A cubic smoothstep of absolute normalized body-lateral
target direction is zero at exact alignment and reaches one at `0.05`. It gates
only `half_cycle_steering_fraction * phase_alignment`; the base target-signed
mean curvature remains active, and the existing envelope redistribution still
uses full observed displacement phase. At larger target error the executable
controller is exactly the prefilled capture carrier.

This is a normalized body-frame state-feedback allocation change, not
scalar-only carrier tuning. It adds no time, step count, world coordinate,
target identity, route memory, velocity residual, flow term, terminal schedule,
broadside reserve, posterior-only allocation, or rate barrier. Formal CFD runs
only after this worker exits. Credit the mechanism only if a later evaluation
retains capture and both wake views and shows a useful route, distance-integral,
or robustness change beyond repeat variation.
