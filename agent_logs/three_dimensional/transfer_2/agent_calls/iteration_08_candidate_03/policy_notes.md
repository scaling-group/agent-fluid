# Steering-priority sector-recapture candidate

## Evidence diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen contract: direct uniform
  still-water initialization with `U_infinity=[0,0,0]`, no cylinders, no
  prewarm, finite dynamics, and moving-window transport. Their motion and
  wakes are self-generated rather than imposed advection.
- Both rows of the combined keyframe sheets were inspected for the strongest
  finite sample (`solver_a81796f958a5`) and the informative basic-recapture
  failure (`solver_0e39f9f53067`). The top-down views show sustained
  translation and an alternating wake; the oblique Lambda2 views show compact
  three-dimensional shed structures through the approach and late turn.
  Propulsion loss, passive advection, wake breakup, or numerical instability
  is therefore not the missing mechanism.
- The assigned persistent-route plus recapture parent
  (`solver_016c2732900a`) does not realize the previously hypothesized
  complementarity. Relative to basic recapture, it changes minimum distance
  only from `3.031L` to `2.996L`, and both complete the same broad upper loop
  before a left-domain exit near `49.4T` at about `7.52L` final distance.
  The pivot-and-release variant (`solver_b99a83cfb22d`) reduces reconstructed
  raw acceleration-envelope exposure from `92.77%` to `82.97%`, but still has
  a `3.024L` minimum and the same termination topology. Posterior carrier
  unloading is consequently useful for command burden but is not, by itself,
  tighter recapture.
- The sector-intercept plus recapture-pivot sibling
  (`solver_a81796f958a5`) is the strongest reusable base. It reaches
  `2.579L` at `25.102T`, improves reconstructed mean distance to `6.284L`,
  and keeps raw acceleration-envelope exposure at `82.76%` with no angle-limit
  contact. Yet it still turns in a broad arc, exits left at `45.331T`, and
  finishes `7.435L` away. Its force and moment maxima are comparable to the
  other finite samples (`|Fx|<=0.0143`, `|Fy|<=0.0276`,
  `|Mz|<=0.0149`), so the remaining opportunity is how the bounded actuator
  command is allocated during large observed route error, not another global
  cadence or load reduction.
- In the inherited implementations, the oscillator, posterior target-wave,
  mean-curvature acceleration, and route steering are summed before the
  environment clips them. The carrier peaks at `74.0/113.0 rad/T^2` for the
  two joints against the `31.416 rad/T^2` envelope. Even after posterior wave
  unloading, same-sign carrier can therefore consume the finite command in
  the sector where curvature needs authority. Repeating another recapture
  gate, release threshold, or curvature gain would not isolate that mechanism.

## Policy hypothesis

Use the evaluated sector-intercept/recapture-pivot controller as the base and
add one component-level steering-priority mechanism. Decompose each joint's
command into rhythmic carrier and bounded route/curvature steering. Only when
the normalized body-frame intercept or target-behind request is active, cap
the admitted carrier to the acceleration headroom left after steering; blend
continuously back to the original sum as those observed gates release. This
does not raise the actuator envelope, does not add a clock or stored mode, and
is exactly neutral away from the demonstrated correction sectors.

The expected effect is an earlier, tighter useful course bend while preserving
the `2.579L`-class approach and coherent traveling wake outside the gate.
Falsify it if the pre-gate action changes, closest approach worsens, the
carrier fails to recover on gate release, the same broad upper loop remains,
or formal evaluation shows worse saturation, rate contact, force, or moment.

bookshelf_consulted: true
source_domain: biological burst turning and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: large observed-error curvature is temporarily prioritized over cruise and released into the propulsive rhythm after the response sector clears
transferable_invariant: separate rhythmic propulsion from bounded steering authority, prioritize the latter only under large observed route error, and restore the traveling wave continuously on geometric release
nontransferable_details: species-specific C-start shapes, published gains and dimensional timing, motor models, exact vortex phases, world-frame routes, and task-specific turning radii
policy_translation: use normalized body-frame intercept and target-behind requests as a mirror-equivariant allocation gate; decompose the two joint accelerations and admit carrier only into the headroom left by bounded steering without changing the physical actuator limit
falsification: reject if target-ahead actions change, the deep approach or wake coherence is lost, steering remains masked in the active sector, the carrier does not recover, or the non-capturing upper-loop topology persists

## Pre-evaluation checks

- A reconstructed recorded-state replay over all `8,242` states of the
  strongest sampled sector/pivot rollout compares this candidate with that
  exact policy. All `4,502` states with zero intercept/recapture allocation
  gate are bit-for-bit unchanged. Of `3,740` active states, `3,140` receive a
  material command change; maximum gate weight is `0.7645` and maximum action
  delta is `23.5593 rad/T^2`. The intervention is therefore selective but not
  algebraically inert where tested.
- On that fixed trace, reconstructed raw acceleration-envelope exposure falls
  from `82.94%` to `81.62%`. This is a counterfactual command check only: the
  new closed-loop path, force, moment, joint-rate exposure, and capture outcome
  remain unknown until EvE runs the formal CFD evaluation.
- The allocation operator is finite and exactly antisymmetric on a
  deterministic grid of mirrored carrier, steering, and gate inputs. All `74`
  direct `params.FIELD` names resolve among the `76` fields returned by
  `target_policy_params()`, and the lightweight Julia public-contract check
  returns two finite accelerations.
- The reusable-guidance semantic check and solver editable-boundary audit pass.
  Formal CFD was not run in this workspace.
- The required `.codex/agents/check-runner.toml` agent was invoked, but its
  pinned `gpt-5.4-mini` model is unavailable for this account and failed before
  running a command. Its three prescribed commands were therefore rerun
  directly and separately against the final files; the guidance, lightweight
  Julia contract, and editable-boundary checks all pass.
