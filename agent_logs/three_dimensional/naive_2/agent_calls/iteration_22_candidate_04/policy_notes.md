# Head-centered collision-course candidate

## Evidence and visual diagnosis before editing

- All four sampled episodes satisfy the frozen contract: direct uniform
  initialization, `U_infinity=(0,0,0)`, no cylinders, and no prewarm. I
  inspected both rows of the combined sheets for the best finite capture and
  the assigned prefill failure. The sampled predicted-miss controllers are
  self-propelled along a nearly direct route behind a compact alternating
  top-down wake and localized oblique Lambda2 structures; three sampled
  executions capture at `15.983--16.016T` and `0.7472--0.7500L`. The prefill
  remains propulsive but broad carrier relief lets steering dominate: the
  body curls into a large high-load loop, reaches only `2.703L`, and exits
  left with final distance `7.056L`.
- The assigned parent's inherited logs delimit nominal capture from robust
  capture. Related predicted-miss mechanisms missed at `1.2164L`, `0.9952L`,
  `1.0117L`, and `1.0251L`, then exited left. The latest fitted carrier-sway
  subtraction did not improve the preceding result (`1.0251L` versus
  `1.0117L`) or the termination class. The recovery pulse and response-release
  variants likewise supplied new actuator logic without surviving the same
  near-pass topology. This rejects another same-case velocity residual fit or
  pulse/gain refinement as the next mechanism.
- Saved trajectories show why a different observation is available. The
  existing closest-approach predictor uses body-center translational velocity,
  while success is a planar *head* crossing. At the first `3L` crossing, the
  direct head-target inertial line-of-sight rate is about `-0.006--0.038`
  rad/T in the three captures but `-0.125--0.224` rad/T in the inherited
  failures, even though all retain strong closure. The policy observation
  exposes the normalized head-target vector and its one-step body-frame rate;
  adding measured heading rate cancels frame rotation and reconstructs this
  head-centered collision-course signal without coordinates, a clock, or a
  fitted carrier model.

## Single policy hypothesis

Start from the sampled response-released predicted-miss controller, preserve
its full traveling-bend carrier and broad body-frame navigation, and remove
the failed fitted carrier-sway residual. Add one terminal mechanism: while the
head is closing inside a smooth `4L` neighborhood, add a headroom-limited
steering residual that opposes inertial head-target line-of-sight rotation. A
constant line of sight under positive closure is a collision course, so this
channel should correct the accumulating low-side pass before the `0.75L`
boundary while becoming quiet on an established intercept. It acts through
the existing mean-bend, posterior mid-stroke, and half-cycle handoff; it does
not brake or retune the propulsive carrier.

An offline observation audit, not a CFD claim, confirms that the proposed
signal distinguishes the sampled routes before terminal saturation. Its
headroom-limited steering residual is zero beyond `5L`; within the first
`3--4L` handoff its mean absolute request contribution is `0.073--0.080` for
the three captures versus `0.111--0.149` for the four inherited near misses.
Falsify the candidate if it loses capture, retains a roughly `1L` lower/left
pass, changes the direct compact-wake route materially, increases joint/load
occupancy beyond the sampled class, or fails a reflected/perturbed case because
the sign or head-rate cancellation is not invariant.

bookshelf_consulted: true
source_domain: sensor-feedback robotic-fish direction tracking and terminal interception
source_mechanism: preserve the rhythmic propulsive carrier while a target-response signal recruits bounded terminal steering and releases it on an established intercept
transferable_invariant: positive closure with nearly constant inertial line of sight defines a collision course independently of beat phase and world route
nontransferable_details: published CPG gains, species kinematics, robot linkage geometry, dimensional rates, exact vortex phase, target coordinates, and prescribed paths
policy_translation: combine normalized `target_body_L`, `target_body_rate_L`, and `heading_rate` into a bounded head-centered inertial line-of-sight rate, oppose that rate only under smooth distance and closure gates, and add it within the available headroom of the existing two-joint state-feedback steering channels without changing the traveling carrier
falsification: reject if capture margin and termination do not improve together, or if direct trajectory, wake coherence, joint reserve, planar loads, or reflection behavior degrade

The new candidate's CFD evaluation occurs only after this worker exits and is
not claimed as evidence here.
