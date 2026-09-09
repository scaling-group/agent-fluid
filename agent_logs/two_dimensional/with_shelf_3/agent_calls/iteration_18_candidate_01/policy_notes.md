# Wake-policy candidate notes

## Evidence diagnosis before the edit

- All four sampled solver directories are exact repeats: policy, prewarm sheet,
  released sheet, score, and diagnostics have identical hashes or values. They
  provide fixed-snapshot reproducibility, not four independent wake tests.
- The shared prewarm sheet shows the held fish above and downstream of four
  developed, interacting cylinder streets. The released sheet shows active
  self-propulsion on a compact diagonal path into that developed-wake region;
  the fish turns toward the target, retains a posterior traveling bend, and
  reaches the `0.75L` circle without a visible detour, collision, domain exit,
  or terminal overshoot. No sampled failure keyframe exists in this workspace,
  so inherited failed-rollout text is used only as nonvisual counterevidence.
- Metrics agree with the pictures: every sample reaches the target in
  `31.5645` release time with mean/final distance `1.60525/0.745668L` and
  displacement `(-10.9169,-4.2166)L`. The fish crosses substantial wake motion
  (`0.24105` RMS relative crossflow) while remaining finite, but both joints
  still touch the `4.53786 rad/time` velocity and `31.4159 rad/time^2`
  acceleration caps; force/moment RMS remain `66.32/887.63`.
- Inherited logs make the new semantic result legible. The earlier normalized
  target-window supervisor repeated at `32.340`, `1.63773L`, and
  `65.12/888.56`; a composed controller layer regressed to `32.4555`,
  `1.64548L`, and `67.83/914.09`. The sampled signed-moment policy improves
  arrival and distance integral materially, but not aggregate load, so its
  assistance cue should be preserved and any next layer must be conjunctive,
  local to the posterior reference, and small.

## Policy hypothesis

The current controller withdraws only the optional `8%` posterior half-cycle
residual, leaving a unit-gain posterior traveling wave even when that wave is
being clipped. Add one phase-preserving reference governor: during coherent
body-frame target closure, and only when target-signed yaw moment coincides
with velocity/acceleration pressure that reinforces the posterior wave, reduce
the base posterior-wave reference by at most `3%`. Keep the anterior oscillator,
distributed mean curvature, lag, and optional-residual logic unchanged. This
should reduce saturation distortion and hydrodynamic load without erasing the
direct propulsive topology; it may also recover useful actuator authority.

bookshelf_consulted: true
source_domain: wake-interaction studies and sensor-modulated robotic-fish rhythmic control
source_mechanism: sensed hydrodynamic assistance can reduce required rhythmic actuation while closed-loop modulation preserves the locomotor wave
transferable_invariant: yield only the already-reinforcing propulsive component when environmental assistance and task-directed response agree, while preserving wave phase and steering authority
nontransferable_details: species kinematics, published CPG gains, single-cylinder Karman phase, dimensional frequencies, exact vortex timing, and source-task routes
policy_translation: use normalized target-window efficiency, body-frame `moment_z_L2`, and posterior speed/acceleration ratios relative to the policy gait; conjunctively and smoothly attenuate only the lagged posterior-wave magnitude at its existing target
falsification: reject if target capture or the compact diagonal topology is lost, arrival/mean distance worsen without a meaningful saturation or load reduction, force/moment rise, or held-out wakes expose switching or propulsion loss

