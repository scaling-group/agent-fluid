# Adverse-yaw-work dissipative residual candidate

## Evidence diagnosis recorded before the policy edit

- The assigned parent guidance, all four sampled solver summaries/traces, and
  the available inherited optimizer notes/evaluations were read first. Every
  rollout used direct uniform still water (`U_infinity=(0,0,0)`), no cylinders
  or prewarm snapshot, remained numerically stable, and terminated by capture.
- The combined sheets for the strongest sampled progress case (v24,
  `solver_8ce1bc88a53c`) and the weakest sampled case (v23,
  `solver_e08e4373a646`) were inspected in both rows. Top-down vorticity shows
  a broad target-directed arc behind a coherent alternating wake from release
  through capture. Oblique Lambda2 shows compact paired three-dimensional
  shedding attached to the moving fish. The fish is self-propelled rather than
  advected; neither case shows carrier collapse, wasteful large-amplitude
  lateral translation visible at keyframe scale, boundary contact, or a
  terminal topology change. The inherited v27 sheet is visually coincident,
  so its regression is a sub-keyframe feedback/load effect.
- V24 remains the progress baseline: capture at `23.8315T`, scoring mean
  distance `2.434073L`, and observed distance integral `1.865152L`. Inside
  `3L`, its mean absolute yaw, target-transverse speed, lateral-force
  coefficient, and yaw-moment coefficient are `1.6839 rad/T`, `0.23935U`,
  `0.011795`, and `0.006402`. The slower v23 terminal drive-relief branch is
  cleaner (`1.5563 rad/T`, `0.22499U`, `0.011057`, `0.005963`) but gives up
  closing speed and arrives at `23.8810T`; this is evidence to preserve v24's
  carrier and course brake rather than apply blanket terminal relief.
- The assigned parent's inherited v27 moment-urgency result falsifies raw
  moment as a multiplier on route curvature. It crossed sooner at `23.8095T`
  and slightly improved the observed pre-capture distance integral to
  `1.864818L`, but worsened scoring mean/final distance to
  `2.435682L`/`0.749258L`. Its inside-`3L` yaw, cross-track speed, lateral
  force, and moment all rose to `1.6964 rad/T`, `0.24447U`, `0.011832`, and
  `0.006440`; peak yaw rose to `3.221 rad/T`. The separately inherited v28
  posterior-lag damper also regressed mean/final distance to
  `2.435327L`/`0.748560L` without meaningful load cleanup. Moment must not
  amplify route steering, and posterior lag is not the next actuator channel.
- Across the sampled terminal traces, normalized yaw moment agrees in sign
  with finite-difference yaw acceleration for `97.2-97.7%` of samples and has
  correlation `0.935-0.940`. It is therefore usable as a hydrodynamic response
  observation, but only under a dissipativity condition that the failed v27
  multiplier lacked.

## Single policy hypothesis

Restore evaluated v24 as the sole base, preserving its traveling-wave carrier,
same-sign C-bend redirect, response release, carrier-rejected target-course
brake, and smooth component projection. Add one small response mechanism:
form signed route-relative yaw-rate error and normalized moment; moment may
activate a same-sign C-bend residual only when their product is positive, i.e.
when the measured hydrodynamic moment is accelerating the yaw error. The
residual direction is always opposite that error. Restoring moment or small
yaw error produces exactly zero residual, while the independent v24 course
loop remains active on both beat halves.

This should retain v24's route and closing speed while rejecting only adverse
terminal yaw work, avoiding both the half-cycle controller's blanket authority
loss and v27's moment-driven route amplification. Falsify the mechanism if
capture or alternating-wake coherence is lost; if arrival exceeds `23.9T` or
mean/final distance exceeds `2.435L`/`0.748L` without material cleanup; or if
inside-`3L` yaw, target-transverse speed, force/moment, joint-speed exposure,
or high-command exposure fails to improve jointly against v24. The current
candidate has no CFD result yet and none is claimed here.

## Bookshelf transfer

```text
bookshelf_consulted: true
source_domain: wake-interaction rejection and sensor-modulated robotic-fish direction control
source_mechanism: separate slow target-route steering from a small bounded fast load-rejection residual while preserving the propulsive rhythm
transferable_invariant: let target geometry own the route and permit hydrodynamic feedback to remove yaw-error energy only when the sensed load is actively increasing that error
nontransferable_details: published gains, dimensional cadence, full-body envelopes, robot linkage kinematics, species-specific tail motion, exact vortex phase, and prescribed routes
policy_translation: retain the normalized body-frame v24 course loop; inside the terminal gate, multiply bounded normalized moment by signed carrier-rejected route-relative yaw error, and add a two-joint C-bend only for positive adverse yaw work with direction fixed opposite the error
falsification: reject if capture/progress or coherent alternating-wake topology regresses, or if terminal yaw, cross-track motion, loads, joint-speed exposure, and command exposure do not improve together
```

## Non-CFD contract checks

- The material-guidance check, direct parameter-schema guard, and solver
  boundary check pass. Exactly one active `candidate_target_policy.jl` exists
  and is non-empty.
- The configured `julia` executable is absent, so the prescribed lightweight
  contract probe was run through the workspace `julia-vanda` wrapper and
  returned a finite, bounded two-joint action.
- A static grid spanning terminal/far distances, target offsets, body
  velocities, yaw, both joint angles and velocities, and signed moment kept all
  commands inside `31.416 rad/T^2`. The new residual was identically zero for
  restoring moment, always opposed route-relative yaw error when active, and
  reproduced v24 to numerical precision outside `3L`. A non-finite moment also
  produced finite commands. No CFD rollout was run.
