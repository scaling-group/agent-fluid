# Phase-selective collision-course commitment candidate

## Evidence and visual diagnosis before editing

- All four sampled solvers are byte-identical `v44` policies, trajectories,
  and combined keyframe sheets.  Each directly initializes uniform still
  water with `U_infinity=(0,0,0)`, no cylinders, and no prewarm, then captures
  at `24.557514T` and `0.747654L`; mean distance is `2.347238L`, score is
  `-0.447654`, and the moving window shifts 283 times.  This establishes
  deterministic nominal repeatability, not four mechanisms or held-out
  robustness.
- I inspected the combined sheet from release through capture in both views.
  The top-down row shows self-propelled diagonal progress, an orderly
  alternating vortex street, and a compact terminal hook through the target
  disk.  The oblique Lambda2 row retains compact paired three-dimensional
  structures through the hook.  Neither view shows passive advection, wake
  collapse, an out-of-plane escape, collision, or instability.
- The trace agrees with the images: posterior hard-stop occupancy is zero,
  exact-rate exposure is `8.959/4.658/13.617%` for anterior/posterior/any
  joint, raw acceleration-envelope exposure is `73.393%`, and peak absolute
  body-frame planar force/yaw-moment coefficients are
  `0.02292/0.02893/0.01559`.  The terminal crossing margin is `0.002346L`,
  projected constant-velocity miss is `0.61213L`, and yaw rate remains
  `1.564 rad/T`; capture is coherent but still a dynamic transverse hook.
- No sampled termination failure or distinct failure sheet exists, so a visual
  success/failure comparison cannot be manufactured.  The useful failure
  controls are inherited numeric results: v42 transfers rejected posterior
  effort to the anterior phase anchor and v43 vetoes anterior effort when its
  posterior mate is filtered; both retain capture but worsen distance, score,
  or crossing margin without improving the load class.  The assigned parent
  does not yet contain the sampled v44 outcome; its v41 baseline captured at
  `24.640015T/0.748356L`, mean distance `2.347937L`, score `-0.448328`, final
  projected miss `0.63193L`, and yaw rate `1.887 rad/T`.

## Policy hypothesis

Preserve v44's observed-state anterior oscillator, posterior lagged traveling
bend, target-route feedback, terminal phase allocation, collision-course
commitment, posterior stopping reserve, and posterior rate coast.  Add one
bounded actuator-allocation refinement without a fixed side or world frame
inside the existing commitment gate: infer anterior half-cycle energy
direction from the product of normalized additive route acceleration and
normalized measured anterior joint rate, and withdraw additional route
steering only when that product is positive.  Rate-opposing anterior steering,
the oscillator acceleration, all posterior commands, and every command outside
the safe terminal corridor are unchanged.

This tests a phase-selective approach hold rather than another terminal gain:
after measured velocity already defines a capture-compatible intercept,
additive steering should stop pumping the anterior half-cycle while useful
joint braking remains available.  Falsify it if CFD loses capture, reduces the
`0.002346L` crossing margin, changes action outside the established `2.10L`
approach neighborhood, increases terminal projected miss or yaw, or regresses
the coherent-wake, zero-hard-stop, load, raw-command, or exact-rate classes.
Do not infer reflected-pose robustness from the nominal rollout.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish oscillators, asymmetric half-cycle turning, and terminal approach hold
source_mechanism: separate the propulsive phase anchor from bounded sensory steering and reduce only steering that injects joint motion after a valid velocity intercept forms
transferable_invariant: preserve the traveling-wave oscillator while normalized body-frame collision geometry and observed joint-state phase decide whether additive anterior steering should continue doing positive work
nontransferable_details: published gains, dimensional cadence, prescribed duty ratios, robot or species kinematics, exact vortex phase, capture geometry, and task-specific routes
policy_translation: within v44's collision-course gate, smoothly taper additional anterior route steering only when its normalized acceleration-rate product is positive; retain rate-opposing steering and all oscillator and posterior authority
falsification: reject if capture or crossing margin is lost, commands change outside the terminal neighborhood, terminal miss or yaw grows, or wake, load, hard-stop, rate, or raw-command classes regress

## Recorded-state audit

This is a no-CFD action audit on the sampled v44 states, not evidence about the
new closed-loop trajectory.  The mechanism changes only the anterior command
on `226/4465` recorded states, first at `22.264T/1.851L`; no state at or beyond
`2.10L` changes, the posterior command remains exactly identical, maximum
additional anterior-command withdrawal is `1.193 rad/T^2`, and the composite
phase gate remains at or below `0.311`.  Every audited action is finite.  The
normalized acceleration-rate classification contains no explicit lateral sign,
but the inherited controller is not globally reflection-exact, so this audit
does not claim exact whole-policy reflection equivariance.

## Evaluation boundary

All numerical outcomes above are completed sampled-solver or inherited-parent
evidence.  The new candidate's CFD evaluation occurs only after this worker
exits and is not claimed here.

## Pre-evaluation validation

- The configured check runner was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable on this account, matching the inherited infrastructure
  limitation.  Its three prescribed no-CFD checks were then run directly and
  separately.  The reusable-guidance semantic check, finite two-acceleration
  Julia contract, and solver editable-boundary audit all pass; the contract
  returns `(-14.3858335, 0.0005062)`.
- The deterministic schema audit resolves all `87` direct `params.FIELD`
  references among the `89` fields returned by `target_policy_params()`.
  The sole editable candidate is v45 and has SHA-256
  `c17963426bf2af5be07cdbc610ebcbbffa976f3a29f0ea376a67a1597fdd696d`.
  No formal CFD was run.
