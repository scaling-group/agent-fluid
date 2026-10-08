# Partitioned posterior-turn release replication candidate

## Completed evidence and visual diagnosis before editing

- All four sampled rollouts terminate in finite `capture` after direct uniform
  still-water initialization with `U_infinity=(0,0,0)`, no cylinders, and no
  prewarm.  Two byte-identical evaluations reproduce the assigned v47
  contraction-release parent at `17.53399 T`, score `-0.0640479`, and
  observed/total distance integrals `1.333721/1.949721 L`.
- The completed v48 partitioned-release sample captures at `17.47899 T` and
  lowers observed distance integral to `1.331907 L`, improving arrival by
  `0.05500 T` and the integrated released route by `0.001814 L`.  It also
  lowers any-joint acceleration-limit residence from `42.75%` to `40.15%`
  and maximum speed from `0.97314` to `0.96017 L/T`, while preserving the
  sampled `0.032252/0.016092` peak normalized planar-force/yaw-moment scale.
  Its worse score (`-0.0658087`) and total integral (`1.950776 L`) come from a
  shallower last discrete capture sample (`0.749953 L` versus `0.746974 L`)
  being held through the unobserved horizon, not from slower arrival or a
  worse observed route.
- The partitioned route is meaningfully different rather than uniformly more
  aggressive: relative to v47 it is `0.025/0.023 L` closer at `6/8 T`,
  `0.010/0.025 L` farther at `10/12 T`, nearly tied at `14 T`, and
  `0.033 L` closer at `16 T`.  The approach-distance arbitration sample stays
  byte-equivalent to v47 through `14 T`, then captures at `17.52849 T` with
  observed/total integrals `1.333644/1.950718 L`; it does not recover the
  partitioned sample's arrival, route integral, or actuator-residence gain.
- I inspected the combined sheets from release to capture.  The readable v47
  duplicate and v48 partitioned sample both show active self-propulsion on a
  smooth target-signed arc: compact startup vorticity becomes an organized
  alternating posterior street in the top-down row, and paired compact
  Lambda2 structures remain attached to the caudal wake in the oblique row.
  There is no reversal, collision, boundary exit, wake collapse, or visible
  out-of-plane instability.  The prefill v47 sheet has black oblique panels;
  that is a render/evidence failure, and its byte-identical readable duplicate
  is used for the 3D comparison instead.
- Assigned-parent guidance and inherited step 27-32 notes rule out reopening
  carrier amplitude/cadence, route-wide approach authority, axial release of
  the whole launch envelope, and indiscriminate phase-common-mode rejection.
  They establish the phase-even posterior residual and contraction release as
  useful while showing that individually positive mechanisms should be
  arbitrated rather than multiplied.  The current completed sample supplies
  the missing closed-loop evidence for partitioning two response modes across
  normalized target error instead of scheduling them by route distance.

## One-candidate policy hypothesis

Materialize the completed v48 partitioned-release policy as the sole candidate.
Preserve v47's normalized body-frame target sensing, selective crossflow pose
confidence, state-feedback carrier, posterior lag, redirect, launch governor,
cadence, half-cycle steering, carrier-first spillover, and componentwise
actuator projection.  Change only release of its supplementary posterior
turn-shape residual: retain bearing-contraction release inside the established
de-gaited centerline window, use correct-sign de-gaited yaw response outside
that window, and take the stronger bounded release rather than multiplying the
two confidences.  The carrier and base route steering remain active, and the
retained posterior target stays odd under reflection.

This is a reproducibility candidate backed by completed CFD, not a new scalar
gain trial.  Expect capture near or before `17.479 T`, observed distance
integral no worse than `1.331907 L`, the organized two-view wake, and no
material increase over the completed `0.9602 L/T`, `40.15%`, `0.032252`, and
`0.016092` maximum speed, acceleration-residence, force, and moment envelope.
Falsify the mechanism if these semantic gains do not reproduce, if capture or
target-signed curvature is lost, if the centerline/out-of-band partition
switches discontinuously or becomes beat-sensitive, or if another pose or wake
loses coherent propulsion.  Formal CFD runs only after this worker exits.

```text
bookshelf_consulted: true
source_domain: biological C-start response release and sensor-modulated robotic-fish phase-lag or wave-shape steering
source_mechanism: preserve a traveling propulsive rhythm while supplementary posterior curvature yields after an observed geometric or correct-sign yaw response
transferable_invariant: separate response modes by normalized target-error geometry so extra wave-shape steering releases on the response that is informative in each regime while carrier and base steering remain active
nontransferable_details: published gains, dimensional cadence, species or robot curvature envelopes, full-body kinematics, open-loop oscillator phase, exact vortex phases, and task-specific routes
policy_translation: partition the existing posterior residual's bounded release between de-gaited bearing contraction inside a normalized centerline window and sign-coherent de-gaited yaw outside it; use body-frame target request and joint-state carrier observations only, with unchanged two-joint projection
falsification: reject if arrival or observed route integral fails to reproduce, capture or mirrored target-signed behavior is lost, actuator residence or normalized loads grow materially, release becomes discontinuous, or readable two-view evidence loses the coherent alternating wake
```

## Evidence boundary

All completed outcomes and visual claims above come from the assigned parent,
sampled solver results, inherited optimizer logs, and inherited durable
guidance.  No same-worker CFD result is claimed for this candidate.

## No-CFD implementation audit

- The sole materialized candidate is
  `dogfish_target_control_v48_partitioned_posterior_turn_release`, SHA-256
  `a8db482ba605bad79a2478468ac0c657b9c6c8a3990735cd0ab9445af9e4023a`,
  byte-identical to the completed partitioned-release sample.  Relative to the
  assigned v47 parent, it changes only arbitration of the existing posterior
  turn-shape residual; anterior action, carrier, and final projections remain
  unchanged.
- All `68` distinct direct `params.FIELD` references resolve among the `70`
  fields returned by `target_policy_params()`.  Structural tests confirm that
  the centerline contraction and out-of-band yaw release components remain
  identical under sign-reflected body-frame inputs.
- The configured check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable to this ChatGPT account.  Its three exact non-CFD commands
  were run locally and separately: the material-guidance check, lightweight
  Julia policy contract, and solver editable-boundary check all pass.  No
  formal CFD was run.
