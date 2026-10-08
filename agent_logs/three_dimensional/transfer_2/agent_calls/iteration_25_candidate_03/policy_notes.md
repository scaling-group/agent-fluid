# Terminal collision-course half-cycle candidate

## Visual diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen direct-uniform still-water
  contract (`U_infinity=[0,0,0]`, no cylinders or prewarm, L64 moving
  window), and all capture.  Three byte-identical v40 trajectories capture at
  `24.662014T`, minimum/final distance `0.748606L`, mean scored distance
  `2.348173L`, and score `-0.448570730`; the distinct v39 trajectory captures
  at `24.678516T`, `0.748602L`, `2.348208L`, and `-0.448571249`.  The v40
  result is therefore replicated, but its advantage over v39 is only a
  nonsemantic `0.000000519` score and three integration rows.
- Both rows of the v40 and v39 combined keyframe sheets were inspected from
  release to capture.  Their top-down rows show wake-free release followed by
  self-propelled diagonal progress, a coherent alternating mid-plane vortex
  street, and the same compact transverse hook into the capture disk.  Their
  oblique rows show compact three-dimensional Lambda2 structures persisting
  through capture without out-of-plane escape or instability.  The two wake
  and route classes are visibly indistinguishable, consistent with v40 first
  separating only inside `1.8461L`.
- The metrics agree with the images.  Relative to v39, v40 preserves zero
  sampled posterior hard-stop occupancy, essentially the same rate class, and
  the same low peak body-force/yaw-moment class (`0.0229/0.0318/0.0157`
  versus `0.0233/0.0320/0.0156`).  Its final projected perpendicular miss
  remains safely inside the `0.75L` disk but grows slightly from `0.63638` to
  `0.63771L`, and final course angle worsens from `58.221` to `58.415 deg`.
  Thus collision-corridor release is a reproducible noninterference result,
  not evidence for another corridor or course gain.
- No failed-rollout keyframe is present in the sampled set.  The informative
  inherited failure remains the audited reference-velocity follower: despite
  a coherent three-dimensional wake, its widespread synthesized follower
  acceleration separated the far route by `8T`, missed at `0.993183L`, and
  exited left at `37.1470T` and `6.9973L`.  Together with the failed symmetric
  velocity barriers, this rules out another broad phase correction or
  anterior rate intervention.

## Policy hypothesis

Preserve v40's evaluated carrier, course-preview intercept, predicted-miss
release, posterior braking reserve, and posterior coast.  Add one bounded
asymmetric-flapping mechanism only inside the existing terminal miss support:
use the sign of v40's already-bounded coupled collision-course residual and
the observed lagged-tail wave side to identify the posterior carrier
half-cycle opposing the requested correction, then attenuate only that
half-cycle.  Do not synthesize acceleration, alter the anterior phase anchor,
weaken the complementary posterior half-cycle, or change any command when the
collision-course residual is zero.

This tests whether terminal steering can be obtained by reallocating existing
posterior wave authority rather than adding more mean curvature or coupled
turn magnitude.  Expected evidence is exact far-route noninterference, a
material but terminal-local output difference, retained capture and coherent
wake, no posterior hard stop, and no regression in arrival, crossing margin,
rate, raw-command, force, or moment class.  Reject the mechanism if it changes
commands outside the v40 residual support, produces the inherited broad-loop
or pass-and-turn topology, suppresses both half-cycles, loses capture, or
increases actuator/load exposure.  The new CFD outcome occurs only after this
worker exits and is not claimed here.

bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping and sensor-modulated coupled oscillators
source_mechanism: preserve a stable anterior-led traveling bend while bounded sensory steering reallocates posterior authority by weakening only the half-cycle opposed to the requested turn
transferable_invariant: use normalized body-frame collision-course error and observed joint phase to remove only counterproductive follower effort while retaining the phase anchor and complementary propulsive stroke
nontransferable_details: published gains, dimensional cadence, duty ratios, species or robot kinematics, full-body waveforms, prescribed paths, exact vortex phases, Strouhal targets, and task-specific routes
policy_translation: within v40's existing near-range predicted-miss support, compare the signed coupled course residual with the lagged-tail wave side and smoothly attenuate only the opposing posterior carrier half-cycle
falsification: reject if the edit changes the established far route, affects states with zero collision-course residual, loses capture or the coherent wake, suppresses both posterior half-cycles, or regresses hard-stop, rate, raw-command, force, or moment class

## Pre-evaluation validation

- A pure-function audit reconstructed all `4484` completed v40 sampled states
  and returned finite v41 commands.  The new mechanism changes `162` same-state
  outputs, first at `22.2860T` and `1.83289L`; it changes no state where the
  bounded raw collision-course residual is zero.  Maximum same-state command
  difference is `1.31573 rad/T^2`, well below the owned
  `31.41593 rad/T^2` acceleration envelope.  This is a locality/materiality
  audit, not a coupled hydrodynamic result.
- On that fixed trace, relief is active on only one of the two posterior wave
  sides, with maximum attenuation `0.23210` despite the owned `0.40` cap; the
  complementary half-cycle and all commands before `1.83289L` remain exact.
  Under reflected observations, the raw course request and lagged-tail wave
  side reverse sign while their opposing-half-cycle relief is unchanged, so
  the added gate itself has the required odd/odd-to-even reflection structure.
- The public-contract probe returns exactly two finite accelerations
  (`-14.3858335`, `0.0005062`).  All `89` direct `params.FIELD` references
  resolve among the `91` fields returned by `target_policy_params()`; only the
  descriptive version and inherited `control_period` fields are unused by the
  policy calculation.
- The configured check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unsupported on this account.  Its three declared deterministic no-CFD
  checks were then run directly and separately: reusable-guidance semantics,
  the Julia public contract, and solver editable-boundary compliance all pass.
  Candidate LF SHA-256 is
  `6971a37835914663c2cd90d1e1d69f371e9dec581bb23322b0cd42d0023b04d3`.
  No formal CFD was run.
