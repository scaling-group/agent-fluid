# Wake-policy candidate notes

## Evidence diagnosis before editing

- All four sampled rollouts satisfy the frozen direct-uniform still-water
  contract: `U_infinity=(0,0,0)`, no cylinders or prewarm, finite moving-window
  transport, and `termination=capture`. The geometry-scheduled prefill captures
  at `18.68350T` with mean distance `2.09405L`; the two executable-equivalent
  envelope-redistribution runs capture at `18.82649--18.88149T` with mean
  distance `2.08855--2.08896L`; the redistributed rearward-multiplier run
  captures at `18.96399T` with mean distance `2.09072L`. The small score and
  integral spread is not evidence for changing the target-ahead propulsive
  carrier.
- I inspected both rows of every current combined keyframe sheet. Each
  top-down row develops a coherent alternating street along the approach, and
  each oblique row retains compact caudal Lambda2 structures through first
  crossing. The fish are self-propelled, turn toward the target, and show no
  visible wake collapse or instability before capture; this agrees with the
  finite `18.68--18.96T` horizons and monotonically successful distance
  progress.
- The informative inherited failure is also a valid direct-uniform rollout.
  Its top-down row keeps an energetic alternating street while the route bends
  away after closest approach; its oblique row retains compact caudal
  structures during the same departure. Metrics agree: it misses at
  `0.85155L`, becomes rearward immediately afterward, and exits left at
  `34.02851T` and `10.33926L`. Thus wake production survives while recovery
  authority fails.
- Reconstructing body-frame geometry from the trajectories sharpens the
  mechanism boundary. In all four current captures the forward direction
  cosine remains positive (minimum `0.342--0.853`); in the sampled
  rearward-multiplier capture it remains `0.354--1.000`, so that multiplier is
  exactly inactive and establishes target-ahead compatibility, not post-miss
  recovery. In the inherited additive-reserve failure, closest approach still
  has forward fraction `0.408` and lateral fraction `0.913`; the target becomes
  rearward at `19.42050T`, after the miss. The additive reserve then fails to
  recover despite coherent propulsion. Prefer the inherited bounded
  multiplicative hypothesis, which preserves lateral geometry as the only
  turn sign and vanishes continuously at directly astern.

## Policy hypothesis

Produce one clean-carrier recovery candidate. Preserve the prefilled
oscillator, posterior lag, common geometry-scheduled amplitude relief,
displacement-only half-cycle steering, one-sided response release, and final
acceleration projection. Add only a normalized rearward body-longitudinal
multiplier to the existing lateral route argument. It is algebraically
inactive while the target is ahead, cannot invent a turn sign, and can at most
double the pre-`tanh` route magnitude after an overshoot. This isolates the
recovery primitive from the non-repeatable envelope redistribution and from
the failed additive reserve.

Falsify the candidate if it changes any target-ahead action, introduces a sign
discontinuity near directly astern, destroys either coherent wake row, loses
the clean carrier's capture topology, or repeats a post-miss decaying-turn
`left_domain` exit. A nominal capture with no rearward samples establishes only
compatibility and must not be reported later as proof of recovery.

```text
bookshelf_consulted: true
source_domain: closed-loop robotic-fish direction tracking and burst redirect
source_mechanism: qualify bounded mean-curvature authority with observed route geometry while preserving the posterior-lagged propulsive rhythm
transferable_invariant: body-frame route geometry may strengthen an existing target-signed mean turn without replacing beat phase or propulsion
nontransferable_details: published gains, clocked CPG phase, species-specific kinematics, actuator hardware, exact vortex phase, and task-specific routes
policy_translation: multiply normalized body-lateral target error by a bounded factor from only the normalized rearward body-longitudinal component before the existing tanh; retain the two-joint traveling bend and response release
falsification: reject if target-ahead actions differ, astern sign chatter appears, wake coherence or capture is lost, or an activated post-miss rollout repeats the decaying-turn left exit
```

## Evaluation boundary

No CFD is run in this worker. The formal rollout occurs only after exit, so the
candidate below remains a hypothesis; completed sampled and inherited results
are the only evidence cited here.

## Non-CFD validation

- A deterministic Julia comparison over target, joint, and yaw states confirms
  exact action equality with the prefilled carrier whenever the target is
  ahead, a material action difference for a rearward off-axis target,
  reflection symmetry, finite outputs, and final commands within the owned
  `1800 deg/T^2` acceleration envelope.
- Every direct `params.FIELD` reference is present in the object returned by
  `target_policy_params()`. The lightweight public-contract check and solver
  edit-boundary check pass. No prohibited clock, step, random, file-I/O,
  mutable-global, obstacle-coordinate, or memorized-route input is present.
