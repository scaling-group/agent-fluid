# Posterior coast-rate candidate

## Evidence diagnosis before the policy edit

- The four sampled solver examples are byte-identical course-preview controls,
  so they provide replication of one mechanism rather than four independent
  trajectories. Each satisfies the frozen contract (direct uniform still
  water with `U_infinity=[0,0,0]`, no cylinders, and no prewarm) and captures
  at `24.5795T`, minimum/final distance `0.746968L`, and mean distance
  `2.36044L`.
- Both rows of the sampled combined keyframe sheet and the assigned-parent
  failure sheet were inspected. The captured top-down sequence starts from
  wake-free water, builds a coherent alternating mid-plane street along the
  diagonal approach, redirects before the target, and crosses the capture
  circle. Its oblique row retains compact three-dimensional Lambda2 structures
  through the redirect. The parent's failed rate-barrier rollout remains
  self-propelled and wake-coherent, but is already displaced on the long
  approach, passes below/outside the circle, then executes an organized turn
  away before the left-domain exit. This is a controller-trajectory failure,
  not passive advection, wake breakup, or numerical instability.
- The inherited v32 posterior braking reserve is the strongest semantic
  controller to preserve: it captures at `24.6290T` and `0.748702L`, eliminates
  sampled posterior hard-stop occupancy, and holds peak absolute planar
  force/yaw-moment coefficients to `0.0241/0.0303/0.0149`. Its remaining exact
  rate-limit occupancy is `9.357%` anterior plus `5.806%` posterior.
- Two independently written dual-joint barriers now give a concrete negative
  result. The full inward-braking form removes anterior exact-rate occupancy
  and leaves only `0.236%` posterior occupancy, but misses at `0.9332L` and
  exits at `37.2735T` with final distance `6.9418L`. The softer form eliminates
  sampled exact-rate occupancy on both joints, but misses at `0.8484L` and
  exits at `36.7510T` with final distance `7.2108L`. Both retain zero posterior
  hard-stop occupancy and low peak loads. Their common failure therefore
  falsifies broad dual-joint active braking as a safe constraint cure: the
  rate metric improves while the successful carrier phase and route do not.

## Policy hypothesis

Restore the evaluated v32 braking-reserve controller, including its course
preview, steering-priority allocation, posterior stroke reserve, cadence, and
traveling-wave targets. Add one narrower feasibility mechanism: only on the
posterior follower joint, taper the velocity-increasing final command toward
zero between `250` and `260 deg/T`. Commands below the band and commands already
reducing posterior speed pass through exactly; at the rate limit the guard
coasts rather than injecting inward acceleration. The anterior oscillator and
the upstream steering allocation remain unchanged.

This is a role-separated ablation of the failed barriers, not a gain retune.
Expected evidence is preserved capture, far-path and three-dimensional wake
topology, zero posterior hard-stop occupancy, and the v32 low-load class,
together with posterior exact-rate occupancy below `5.806%` and total
occupancy below `15.163%`. Falsify it if capture is lost, the narrow crossing
margin degrades, the coherent route changes materially, posterior hard-stop
contact returns, load peaks leave the v32 class, or posterior rate occupancy
does not fall. A lower rate statistic without capture is explicitly not an
improvement.

bookshelf_consulted: true
source_domain: Lighthill elongated-body swimming and sensor-modulated robotic-fish CPG control
source_mechanism: anterior motion sustains and steers a traveling body wave while a phase-lagged posterior follower supplies reactive thrust under proprioceptive modulation
transferable_invariant: preserve the anterior phase anchor and steering while modifying only redundant velocity-increasing posterior actuation at its finite rate boundary
nontransferable_details: published gains, dimensional cadence, species kinematics, full-body envelopes, exact vortex phase, Strouhal targets, and task-specific routes
policy_translation: retain evaluated v32 and apply a sign-symmetric non-braking rate cap only to the final posterior command using normalized observed tail rate and the owned rate and acceleration envelopes
falsification: reject if capture, coherent route and wake, zero posterior hard-stop occupancy, or the v32 low-load class is lost, or if posterior exact-rate occupancy does not fall below 5.806 percent

## Pre-evaluation validation

- All `84` direct `params.FIELD` references resolve among the `86` fields
  returned by `target_policy_params()`. The prescribed public-contract state
  returns two finite accelerations.
- The guard is sign-symmetric to numerical tolerance across `8,585` direct
  rate/command probes. It is exactly equal to v32 below `250 deg/T`, passes
  every velocity-reducing command unchanged, and returns zero rather than an
  inward brake for a velocity-increasing command at either signed rate limit.
- A `466,560`-state whole-policy grid spanning distance, target side, bearing
  and trend, closing behavior, body-frame velocity, both joint positions, and
  both joint rates returns finite actions. All `279,936` sub-band states are
  byte-identical to evaluated v32; only the posterior output can differ.
- Fixed-state application to the completed v32 trace changes `295/4478`
  posterior commands (`6.588%`), from `2.079T` to `13.701T`; `288` changes
  occur above `6.5L`. All `260` exact posterior-rate rows replace redundant
  velocity-increasing command by coast, while every anterior command remains
  structurally untouched. This is an offline command audit, not a trajectory
  result.
- A `20T` joint-only closed-loop envelope integration reduces posterior
  exact-rate samples from `240` to `117` while leaving anterior exposure at
  `176` samples, avoiding hard-stop contact, and ending within `3e-6 rad` and
  `3e-5 rad/T` of the v32 joint state. This rejects gross phase drift in the
  local actuator model; only the later CFD evaluation can establish capture,
  wake, and load consequences.
- The configured check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unsupported on this account. Its three declared no-CFD commands were run
  directly and separately: the reusable-guidance semantic check, exact Julia
  public-contract check, and solver editable-boundary audit all pass. No
  formal CFD was run.
