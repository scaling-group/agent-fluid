# Established-speed course-guidance candidate

## Visual and quantitative diagnosis before editing

- All four sampled rollouts satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm snapshot, stable dynamics,
  and capture. In both rows of the combined sheets, the fish is self-propelled
  along the same broad target-directed arc: top-down vorticity shows a strong
  alternating train, while the oblique Lambda2 view shows coherent paired
  three-dimensional structures through capture. The differences among v24,
  v25, the yaw-directed v26, and the half-cycle v26 are below keyframe
  resolution, so the carrier and same-sign C-bend should be preserved.
- V25 has the highest sampled scalar score (`-0.5357785`), but the v24
  phase-demodulated course brake is the progress baseline: v24 captures at
  `23.8315T` with scoring mean distance `2.434073L`, versus `23.8590T` and
  `2.434115L` for v25. Yaw-selected direction and half-cycle terminal gating
  are later (`23.8535T` and `23.9085T`) without a jointly better terminal
  trajectory. The inherited moment-lead result is slightly earlier at
  `23.8260T` but regresses scoring mean distance to `2.435488L` and increases
  inside-`3L` target-transverse speed from `0.2393U` to `0.2425U`; pressure-
  gated residual allocation likewise regresses mean distance to `2.435590L`.
  These completed results reject another terminal cue/gate as the useful next
  architectural test.
- The informative semantic failure boundary remains inherited: opposite-sign
  static-posture replacement destroyed the alternating carrier and exited the
  upper boundary, including one rollout with `78.0%` posterior angle-limit
  exposure. The successful carrier-preserving C-bend instead captures. No
  current or inherited result supports replacing the carrier or reversing its
  bend convention.
- V24 still carries a persistent route-scale course residual before its
  terminal branch activates. From `6L` to `9L`, mean closing speed is
  `0.5905U` while mean absolute target-transverse speed is `0.1848U`; after
  removing the sampled anterior-joint carrier component, mean cross-track
  speed is `-0.1645U` and the corresponding mean absolute course angle is
  `0.2682 rad`. From `3L` to `6L`, the demodulated course angle remains
  `0.1787 rad`. Its corrective sign agrees with the body-frame bearing request
  in `100%` and `89%` of those respective samples. This is evidence for a
  bounded middle-route course residual, rather than more terminal braking.

## Policy hypothesis

Use evaluated v24 as the sole base, preserving its state-feedback traveling
wave, posterior lag, same-sign C-bend, response release, terminal course brake,
and smooth component-wise acceleration projection. Add one observation-driven
direction-tracking mechanism to the main guidance request: form target-relative
cross-track and closing speeds in the body frame, subtract the evidenced
anterior-joint carrier component, map the remaining course angle to a bounded
turn residual, and admit it only as translation speed becomes established.
The speed gate prevents an undefined velocity direction at release; joint-state
demodulation prevents ordinary beat sway from masquerading as route error. A
normalized distance gate is fully released across `6L` to `3L`, leaving v24's
evaluated terminal control law unchanged inside `3L`.

The candidate should preserve capture and both coherent wake views while
reducing the persistent `6L`-to-`3L` course error enough to lower arrival time
or distance integral. Falsify it if capture or wake coherence is lost, if mean
distance exceeds `2.435L` without a material course/load benefit, or if yaw,
joint-speed exposure, high-command exposure, lateral force, or moment worsens.
The candidate CFD result is unavailable in this worker and is not claimed.

## Bookshelf transfer

```text
bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and residual control over rhythmic locomotion
source_mechanism: retain a stable propulsive oscillator while a bounded sensor-derived direction residual corrects persistent route error
transferable_invariant: separate beat-synchronous carrier motion from slower target-relative course error before modulating steering authority
nontransferable_details: published gains, dimensional cadence, robot linkage kinematics, species-specific envelopes, exact oscillator or vortex phase, and prescribed source-task routes
policy_translation: preserve the two-joint state-feedback carrier; use normalized body-frame target and velocity plus anterior joint velocity to form a speed-gated, carrier-rejected course-angle residual in the existing target guidance
falsification: reject if capture or alternating-wake coherence is lost, or if arrival, distance integral, middle-route course error, yaw/load, joint-speed exposure, and command exposure do not jointly improve
```

## Non-CFD validation

- The required material-guidance check and solver boundary check pass.
- The configured Julia policy assertions pass through the workspace's
  `julia-vanda` wrapper because the literal `julia` executable is unavailable.
- Static schema comparison confirms that every direct `params.FIELD` reference
  is returned by `target_policy_params()`.
- Nominal, nonfinite, and extreme-finite state probes return two finite commands
  within the owned acceleration envelope. At zero translation or inside `3L`,
  the candidate's command exactly matches evaluated v24 and its added course
  residual is zero.
- No CFD rollout was run in this worker.
