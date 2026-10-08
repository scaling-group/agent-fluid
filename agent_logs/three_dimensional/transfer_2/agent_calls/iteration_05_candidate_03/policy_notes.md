# Multi-wake target-policy candidate notes

## Evidence diagnosis before the edit

- All four sampled evaluations satisfy the frozen evidence contract: direct
  uniform still-water initialization (`U_infinity=[0,0,0]`), no cylinders,
  no prewarm, finite dynamics, and moving-window transport.  Their translation
  and wakes are therefore self-generated rather than imposed advection.
- Both the top-down vorticity and oblique Lambda2 rows of all four combined
  keyframe sheets were inspected.  The common `0.55T`, `28 deg` carrier in
  `solver_e1a03f18d808`, `solver_045019f39c2a`, and
  `solver_e3aa71fd7b95` sustains a coherent alternating wake and compact 3D
  structures.  The globally slower, soft-limited `solver_a1d9e06dfe8a`
  instead has a shorter, weaker clean wake, turns upward early, reaches only
  `8.752L`, and exits the upper boundary at `14.911T`; global cadence and
  acceleration reduction are not supported fixes.
- The assigned phase-selective parent is a real mechanism and semantic
  improvement, not merely a scalar fluctuation.  Relative to the curvature-
  release child, it improves minimum distance from `4.141L` at `20.669T` to
  `3.033L` at `23.238T`, reduces raw acceleration-envelope exposure from
  `98.09%` to `93.63%` and joint-rate-limit exposure from `19.41%` to
  `12.68%`, and changes the late lower-boundary sweep into a longer westward
  trajectory that exits the left boundary at `40.331T`.  Its top-down wake
  remains coherent and the oblique row retains compact alternating vortices;
  propulsion loss or flow advection is not the remaining failure.
- At the phase-selective closest approach the head is `(10.478,6.852)L`, the
  target is almost purely lateral in the body frame at approximately
  `(0.672,2.957)L`, speed remains `0.64U`, and local flow is only about
  `0.02U`.  The target crosses behind the fish's body-normal plane near this
  epoch, but the fish never reacquires it: by `24T` the target is behind and
  remains behind while distance grows to `9.314L`.  This is a route-scale
  target-passage/recapture deficit, not evidence for a wake-rejection term.
- Completed inherited failures bound the intervention.  A negative static
  tail tangent, even initially below `0.5 deg`, produced an immediate upper
  exit when applied from release; another always-on mean bend is therefore
  unsafe.  Conversely, the new parent shows that joint-state half-cycle
  allocation is useful but cannot by itself turn back toward a target that
  has passed behind.  The missing branch should be dormant during the proven
  early approach and keyed to the sign of normalized body-frame forward target
  position rather than elapsed time, fixed coordinates, or another gain-only
  edit.

## Policy hypothesis

Retain the evaluated phase-selective carrier, wrong-polarity curvature release,
and all early steering.  Add one target-passage recapture primitive inside the
posterior target: when the normalized forward target component becomes
materially negative and lateral error remains nonzero, add a bounded mean tail
tangent with mirror-symmetric sign opposite the lateral target component.
Release it continuously when body rotation brings the target forward again or
when lateral error closes.  This is a geometry-gated burst rather than a held
route bias, so it is exactly dormant on every state with the target ahead and
cannot recreate the inherited release-pose upper turn there.

Expected evidence is bit-for-bit preservation of the assigned parent's action
through the target-passage gate, followed by a visible late hairpin or target
reacquisition instead of the `10L` westward runout.  Falsify the mechanism if
it changes early approach states, destroys the alternating wake, causes an
upper or lower exit before reacquisition, increases clipping or joint-limit
exposure materially, or retains the left-boundary exit without a meaningfully
closer pass or useful turn-back trajectory.

bookshelf_consulted: true
source_domain: biological C-start redirect and sensor-modulated robotic-fish CPG turning
source_mechanism: apply a strong bounded curvature response only under large observed route error and release it when the target response is recovered
transferable_invariant: separate the propulsive carrier from a transient geometry-gated recapture maneuver whose authority disappears when the target returns forward
nontransferable_details: species-specific C-start shape, published gains, motor timing, dimensional cadence, clock-driven phase, exact vortex phase, and task-specific routes
policy_translation: use normalized body-frame forward target sign to arm a bounded posterior mean tangent, use lateral target sign for mirror-equivariant direction, and release continuously on forward reacquisition or lateral closure within the two-joint state-feedback contract
falsification: reject the transfer if it perturbs target-ahead states, loses the coherent carrier or deep approach, creates a premature boundary exit, worsens limit exposure materially, or fails to turn back after target passage

## Pre-evaluation checks

- Recorded-state replay over all `7,333` states of the assigned parent is
  exactly unchanged whenever the target is ahead.  The recapture gate first
  activates at `21.670T`, after the established approach, and is active on
  `43.76%` of the completed parent trace.  It requests about `-4.06 deg` mean
  posterior tangent at `23T`, `-4.36 deg` at `24T`, and approaches its bounded
  `-7 deg` value only as the target moves farther behind.  The anterior action
  is unchanged everywhere.
- On the same fixed recorded states, reconstructed exposure to at least one raw
  acceleration command above `1800 deg/T^2` changes from `93.66%` to `92.34%`,
  with the same `112.973 rad/T^2` peak.  This establishes branch selectivity
  and no algebraic increase in the inherited clipping burden; it cannot predict
  the new closed-loop path.
- All `62` direct `params.FIELD` references resolve in the `64` fields returned
  by `target_policy_params()`.  A deterministic `472,392`-pair grid over
  mirrored body-frame target position, joint state, lateral velocity, bearing
  rate, yaw rate, closing speed, and moment remains finite.  The new gate is
  reflection invariant, its request and mean tangent are antisymmetric, and it
  is identically zero for every target-ahead grid state.
- The required check-runner was invoked, but its pinned model is unavailable
  for this account.  Its three prescribed no-CFD commands were therefore run
  directly and separately: the reusable-guidance semantic check, lightweight
  Julia public-contract check, and solver editable-boundary audit all pass.
  Formal CFD remains deferred to EvE after this worker exits.
