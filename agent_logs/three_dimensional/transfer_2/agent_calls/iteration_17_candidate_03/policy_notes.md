# Anterior midstroke-coast candidate

## Evidence diagnosis before the policy edit

- The assigned-parent rollout and all three sampled comparators satisfy the
  frozen experiment contract: direct uniform still-water initialization with
  `U_infinity=[0,0,0]`, no cylinders or prewarm, finite dynamics, and inertial
  moving-window transport. The three comparators are byte-identical instances
  of the course-preview controller, so they replicate one mechanism rather
  than provide three independent architectures. Each captures at `24.5795T`,
  minimum/final distance `0.746968L`, and mean distance `2.36044L`.
- Both rows of the combined assigned-parent and comparator keyframe sheets and
  the inherited dual-joint-barrier failure sheet were inspected. The parent
  top-down row starts wake-free, develops an organized alternating mid-plane
  vortex street along a self-propelled diagonal approach, redirects toward the
  target, and crosses the capture circle. Its oblique row retains compact
  three-dimensional Lambda2 structures through capture. The failed barrier
  initially follows the same wake-coherent route but passes outside the circle,
  curls away, and exits at `36.7510T`; its continuing organized wake rules out
  passive advection, wake breakup, or numerical instability as the failure.
- The parent's role-separated posterior coast guard is positive but bounded
  evidence. Relative to the inherited full-authority stroke-reserve result, it
  reduces any-joint exact-rate occupancy from `15.163%` to `13.101%` and
  posterior exact-rate samples from `260` to `174`. It preserves capture at
  `25.0635T` and `0.749973L`, zero sampled posterior hard-stop occupancy, and
  the low peak-load class (`|C_x|/|C_y|/|C_m| =
  0.0244/0.0337/0.0162`). Its mean distance `2.35222L` and score `-0.452083`
  also improve on the replicated course-preview sample, although the crossing
  margin is only `0.0000275L` inside the capture boundary and must be treated
  as fragile.
- The parent leaves `423/4557` anterior samples at the exact `260 deg/T` rate
  limit; all `423` still request velocity-increasing acceleration. Of these,
  `297` occur while the anterior joint moves toward the body centerline and
  `126` while it moves toward a bend extremum. Posterior exposure is largely a
  far-carrier effect (`167/174` exact-rate rows above `6.5L`), whereas anterior
  exposure spans the route. A blanket route or terminal gate is therefore not
  supported.
- Two inherited dual-joint active barriers are concrete negatives. They reduce
  total exact-rate occupancy to `0.236%` and `0%` but miss at `0.9332L` and
  `0.8484L`, then exit with final distance `6.9418L` and `7.2108L`. Both retain
  zero tail hard-stop occupancy and coherent low-load wakes. Their common
  inward braking and disturbance of both actuator roles improve the constraint
  statistic while destroying the successful crossing; do not repeat that
  architecture.

## Policy hypothesis

Preserve the assigned parent's course preview, steering allocation, posterior
stroke reserve, posterior non-braking coast, cadence, and traveling-wave
targets. Add one role- and phase-selective feasibility mechanism after anterior
steering allocation: only when the anterior joint is moving back toward the
body centerline, taper a velocity-increasing final head command toward coast
over the owned `250--260 deg/T` soft band. Pass outward bend-building motion,
sub-band motion, and every command already reducing speed through exactly.
At the rate boundary the permitted same-direction acceleration reaches zero;
the mechanism never injects active braking.

This tests the remaining phase-anchor loophole left by the failed dual-joint
barriers and the successful posterior ablation. Expected evidence is capture
with the parent's route and coherent three-dimensional wake, zero posterior
hard-stop occupancy, the inherited low-load class, and total exact-rate
occupancy below `13.101%` through reduced anterior centerward exposure.
Falsify it if capture or the narrow crossing margin is lost, the far diagonal
route changes materially, tail hard-stop contact returns, peak loads leave the
parent's class, or anterior/total exact-rate occupancy does not improve. A
better rate statistic without capture is explicitly a negative result.

bookshelf_consulted: true
source_domain: coupled-oscillator robotic-fish control and Lighthill elongated-body anterior/posterior swimming roles
source_mechanism: joint-state phase can modulate rhythmic drive while anterior motion sustains and steers a phase-lagged posterior traveling wave
transferable_invariant: remove only constraint-conflicted velocity-increasing work in the evidenced midstroke phase while preserving bend-building motion and posterior wave lag
nontransferable_details: published gains, dimensional cadence, species-specific kinematics, full-body envelopes, exact vortex phases, Strouhal targets, and task-specific routes
policy_translation: use normalized anterior joint rate plus the reflection-invariant sign of joint angle times joint rate to coast only centerward same-sign commands near the owned rate boundary
falsification: reject if capture, route and wake coherence, zero posterior hard-stop occupancy, or the low-load class is lost, or if total exact-rate occupancy does not fall below 13.101 percent

## Pre-evaluation validation

- Every direct `params.FIELD` reference resolves to a field returned by
  `target_policy_params()`, the prescribed public-contract state returns two
  finite accelerations, and the solver editable-boundary audit passes.
- `8,405` direct guard probes spanning joint angle, both rate signs, and both
  command signs are finite and mirror-equivariant to numerical tolerance. The
  guard passes sub-band motion, outward bend-building motion, and commands
  already reducing rate exactly; a centerward velocity-increasing command
  reaches coast rather than active braking at either signed rate limit.
- A `46,656`-state grid spanning target geometry, range, bearing and trend,
  closing behavior, body-frame velocity, both joint positions, and sub-band
  rates is byte-identical to the evaluated parent. A separate `4,860`-state
  active-band grid returns finite actions. Whole-policy mirror symmetry was not
  asserted because the inherited controller deliberately has unequal positive
  and negative steering gains; the new guard itself preserves sign symmetry.
- Fixed-state application to the assigned-parent trace would modify `371/4557`
  anterior commands, including all `297` exact-rate rows in the centerward
  phase. Changes begin at `2.6015T`; `162` occur above `6.5L` and `104` below
  `3.5L`, so only formal CFD can establish whether the narrow capture margin
  survives. This is a command audit, not a trajectory claim.
- A `20T` joint-only closed-loop envelope probe under fixed far geometry
  reduces anterior exact-rate hits from `146` to `14`, leaves posterior hits
  unchanged at `58`, keeps peak bends at `24.82/25.04 deg`, and ends within
  `7.9e-5 rad` in angle and `5.4e-4 rad/T` in rate of the parent. This rejects
  gross local phase drift but does not substitute for hydrodynamic evaluation.
- The configured check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unsupported on this account. Its three declared no-CFD commands were run
  directly and separately: the reusable-guidance semantic check, exact Julia
  public-contract check, and solver editable-boundary audit all pass. No formal
  CFD was run.
