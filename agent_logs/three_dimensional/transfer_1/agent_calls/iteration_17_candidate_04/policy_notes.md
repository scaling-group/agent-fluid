# Wake-policy candidate diagnosis

## Evidence read before candidate selection

- All four sampled solver rollouts and both newly inherited optimizer
  evaluations report direct uniform still-water initialization with
  `U_infinity=[0,0,0]`, no cylinders, and no prewarm snapshot. Translation in
  their visual sheets is therefore self-propulsion rather than advection or
  inherited flow.
- I inspected both the top-down vorticity and oblique Lambda2 rows from release
  to termination for the highest-scoring sampled capture
  (`solver_6b0e320e2f55`), the assigned parent's latest exact-policy capture,
  and the informative half-cycle failure inherited from
  `optimizer_ea4ab26d0868`. The exact speed-reserve captures build a coherent
  alternating wake by about `4T` and retain the traveling bend and compact 3D
  wake structures through first crossing. The half-cycle rollout lays down a
  similarly coherent wake through closest pass and continues producing it
  afterward, but its path turns below the target and exits the lower virtual
  boundary. There is no visible wake collapse, passive coasting, collision, or
  numerical instability that could explain the miss.
- The prefilled `dogfish3d_intercept_guarded_speed_reserve_v1` bytes
  (`567de354...`) have now captured in four exact-policy evaluations at
  `18.2050--18.6010T`, with closest distances `0.7466--0.7494L`, mean distance
  `2.0387--2.0533L`, and coherent wakes in both views. Returned acceleration
  still clamps on about `68.5--68.8%/70.6--71.0%` of head/tail trace rows and
  exact joint-speed residence remains about `10.4--10.6%/11.3--11.6%`, so the
  repeated captures establish route robustness, not a saturation cure.
- The inherited `dogfish3d_speed_reserve_half_cycle_steering_v1` changed only
  terminal steering realization. It reduced exact speed-limit residence to
  about `8.47%/9.48%`, but increased acceleration clamping to
  `70.0%/71.5%`, reached only `1.6860L` at `18.2600T`, and exited at
  `31.4875T` with final distance `10.3091L`. Peak body-force and yaw-moment
  coefficients stayed within the baseline envelope, so neither load failure
  nor carrier loss explains the changed route. This falsifies moving additive
  steering toward the carrier-opposing half-cycle in this terminal topology;
  lower speed-limit residence alone is not useful authority.
- The sampled LOS-only policy captured once at `18.6065T` with a lower score
  than the strongest speed-reserve repeat, while inherited projected-miss
  replacement replays and the new half-cycle realization both lost the proven
  terminal path. The four exact speed-reserve captures are therefore the
  strongest available evidence for candidate selection.

## One candidate hypothesis

Materialize the prefilled
`dogfish3d_intercept_guarded_speed_reserve_v1` policy byte-for-byte. It retains
the state-feedback traveling bend, body-frame achieved-course steering,
intercept-compatible response-release veto, and selective relief of only
outward carrier effort already unusable near both actuator envelopes. No new
terminal observation, half-cycle allocation, or scalar gain change is layered
onto the four-capture baseline.

Expected test: reproduce capture near `18.2--18.6T` while retaining the
alternating top-down and oblique wake and the established load envelope. This
evaluation is a fifth exact-policy robustness test, not same-worker evidence
of improvement.

Falsification: reject robust selection if the exact replay misses the `0.75L`
disk, changes far-field closure, weakens the traveling wake, materially raises
force or yaw-moment peaks, or establishes a new non-capture terminal topology.
If it fails, later workers should diagnose the divergent terminal state before
revisiting projected miss, half-cycle steering, cadence relief, or saturation
governing.

bookshelf_consulted: true
source_domain: robotic-fish CPG direction tracking and turning by asymmetric flapping or bounded curvature bias
source_mechanism: preserve a rhythmic posterior-lagged carrier while sensed route error modulates a bounded steering realization
transferable_invariant: steering changes are acceptable only when they preserve the traveling bend and improve sensed interception, not merely actuator-envelope statistics
nontransferable_details: published gains, dimensional cadence, robot or species kinematics, exact beat and vortex phase, duty ratio, and task-specific routes
policy_translation: adopt no new primitive; retain the evaluated body-frame course/intercept carrier-reserve policy because the shelf-derived half-cycle realization preserved the wake but failed interception
falsification: reject the retained policy if exact replay loses capture, changes far-field closure, weakens wake coherence, or raises loads beyond the four-capture envelope
