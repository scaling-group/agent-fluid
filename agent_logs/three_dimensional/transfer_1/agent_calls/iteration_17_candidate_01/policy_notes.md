# Wake-policy candidate diagnosis

## Evidence read before editing

- All four sampled solver rollouts and the informative inherited failure use
  direct uniform initialization with `U_infinity=[0,0,0]`, no cylinders, and
  no prewarm. Translation in both visual rows is therefore self-propulsion,
  not advection or inherited flow.
- I inspected the combined top-down vorticity and oblique Lambda2 sheets from
  release to termination for the highest-scoring sampled capture
  (`solver_6b0e320e2f55`) and the latest inherited half-cycle failure
  (`solver_eabef54fa5c2`). The capture develops a coherent alternating wake by
  about `4T` and retains a traveling bend plus compact three-dimensional wake
  structures through its `0.7494L` crossing at `18.6010T`; no collision, wake
  collapse, coasting, or numerical instability precedes capture.
- The failed half-cycle allocator also remains self-propelled and continues
  laying down an organized alternating wake after the pass. It reaches only
  `1.6860L` at `18.2600T`, with speed about `0.8405L/T`, then bends below the
  target and exits the lower boundary at `31.4875T` with final distance
  `10.3091L`. Its failure is terminal steering allocation, not inadequate
  thrust. This falsifies the inherited claim that moving steering effort from
  carrier-aligned to opposing half-cycles would preserve the three-repeat
  capture topology.
- Three exact-byte sampled evaluations of the prefilled
  `dogfish3d_intercept_guarded_speed_reserve_v1` captured at
  `0.7466--0.7494L` and `18.2050--18.6010T`, with coherent wakes despite
  substantial actuator clipping. Two exact projected-miss replays and the
  half-cycle allocator instead exited below while preserving propulsion.
  Consequently the repeat-supported carrier, achieved-course route error,
  intercept geometry, and sparse outward-carrier reserve are retained; neither
  terminal error replacement nor carrier-phase reallocation is stacked here.
- The three baseline captures show large beat-scale heading-rate excursions
  near the target, but the existing joint-velocity compensation reduces them
  to a slower yaw-response estimate. The remaining unsupported capability is
  active yaw braking after projected intercept geometry says the fish is
  already approaching inside the capture corridor: the current release logic
  can remove steering, but it cannot apply a small counter-yaw residual.

## One candidate hypothesis

Preserve the evaluated speed-reserve controller outside the existing
`2.75L--2.0L` intercept transition and preserve its carrier everywhere. Inside
that transition, only when projected miss and target/velocity alignment both
indicate an approaching capture corridor, add a bounded residual with the sign
that opposes phase-compensated yaw. The residual is subordinate to the existing
steering limit and does not replace achieved-course error, suppress carrier
acceleration, schedule cadence, or encode a route.

Expected test: retain far-field closure and the coherent top-down and oblique
wake while reducing terminal yaw excursions enough to reproduce capture with
no greater action/speed saturation or force/moment envelope. A faster or less
variable crossing would be secondary evidence; this worker's unevaluated edit
is a hypothesis, not a claimed improvement.

Falsification: reject the yaw brake if it changes outputs outside the existing
intercept corridor, weakens the traveling wake, delays route correction when
projected miss is outside the corridor, raises loads or saturation, or turns a
repeatable baseline capture into the evidenced below-target `left_domain`
topology. If rejected, later workers should revert to the exact speed-reserve
baseline and seek an observation that distinguishes the divergent terminal
approaches before changing carrier or steering allocation again.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and terminal capture control
source_mechanism: preserve rhythmic propulsion while sensor-derived approach geometry gates a bounded yaw or slip damping residual
transferable_invariant: after broad route acquisition, damp excess measured yaw only when normalized interception geometry already predicts an approaching capture, without suppressing the propulsive carrier
nontransferable_details: published gains, dimensional cadence, species or robot kinematics, exact beat and vortex phases, duty ratios, and task-specific routes
policy_translation: retain the two-joint achieved-course and speed-reserve baseline; inside its existing intercept gate multiply projected-corridor and approach-alignment gates, then add a bounded residual opposing joint-compensated body yaw
falsification: reject if far-field output changes, capture is lost, wake coherence weakens, loads or saturation rise, or the residual prevents correction when predicted miss remains outside the corridor

## Non-CFD verification

- The final candidate SHA-256 is
  `3bc7e932cb0a4d1fc59822ac9c1d16f71c70199c0a5f0f9e36344465bef7c9bd`.
- The mandated lightweight Julia contract passes using the installed Julia
  `1.12.6` binary: the parameter object has no forbidden `L` field and the
  policy returns two finite accelerations. The deterministic schema audit and
  solver editable-boundary check also pass.
- A direct Julia comparison with the three-repeat baseline returns exactly
  identical actions for a state outside the intercept gate. An aligned
  terminal state activates the new residual, and its reflected state returns
  exactly sign-mirrored joint accelerations, confirming that the edit preserves
  lateral reflection equivariance. These are static checks, not CFD evidence.
- The required material-guidance check passes. No CFD rollout was run in this
  worker; capture and wake effects remain the next evaluation's falsification
  test.
