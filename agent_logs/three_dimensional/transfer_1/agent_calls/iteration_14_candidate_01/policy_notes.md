# Wake-policy candidate diagnosis

## Evidence read before editing

- All four sampled rollouts report direct uniform still-water initialization
  with `U_infinity=[0,0,0]`, no cylinders, and no prewarm. Their motion is
  self-propulsion rather than ambient advection. The combined sheets show an
  orderly alternating mid-plane street and compact oblique Lambda2 structures
  from release through capture, without visible 3D instability or terminal
  carrier collapse.
- Three samples use identical speed-reserve policy bytes (SHA-256
  `567de354...`) and all capture: `0.74664L` at `18.32049T`, `0.74796L` at
  `18.20499T`, and `0.74939L` at `18.60100T`. The separate LOS-guarded sample
  also captures at `0.74934L` and `18.60650T`. Thus capture is now a replicated
  property of the speed-reserve controller, not a single threshold crossing,
  while differences smaller than the repeat spread should not be attributed
  confidently to policy merit.
- The reserve mechanism did not establish actuator-efficiency improvement.
  Across its three repeats, action clamp fractions remain about
  `68.5--68.7%/70.7--71.0%`, both joints still reach `4.537856 rad/T`, and
  peak lateral-force and yaw-moment coefficients remain approximately
  `0.0274--0.0292` and `0.0157--0.0163`. Preserve it because of replicated
  semantic success and wake coherence, not because it solved saturation.
- The three capture sheets arrive on visibly different beat/heading states;
  terminal headings range from about `0.116` to `0.789 rad`, and reconstructed
  phase-compensated yaw remains oscillatory inside `2L` (roughly
  `0.38--0.49 rad/T` RMS). This makes terminal yaw response a more defensible
  new observation than another route-gain, cadence, or carrier-strength edit.
- The assigned parent's directional-reserve allocator preserved a coherent
  wake but changed the useful near-target path: it missed at `0.96323L`, then
  curved below the target and exited the domain at `34.287T`. Its full-trace
  clamp fractions fell to about `67.5%/67.0%`, showing that lower saturation
  did not compensate for redistributing steering by instantaneous carrier
  occupancy. A separately inherited terminal speed governor also lost the
  capture class (`1.38772L`, `left_domain`). Avoid both instantaneous steering
  reallocation and hard outward-command projection on this captured base.

## Candidate mechanism and falsification

Start from the evaluated speed-reserve policy byte-for-byte in its body-frame
course servo, projected-intercept guard, cadence, traveling-bend carrier,
two-joint steering shares, and sparse outward carrier relief. Add one compact
approach-hold mechanism: when the existing normalized response/intercept logic
is already releasing route steering, apply a small bounded brake proportional
to the phase-compensated yaw rate. Put this residual on the anterior joint
only, so posterior lag and thrust remain unchanged. Because the brake is gated
by the existing release, it cannot oppose an evidenced growing LOS miss or an
intercept-incompatible approach; outside the terminal release state the
captured parent is algebraically unchanged.

Expected test: retain capture and the alternating 3D wake while reducing the
spread of terminal yaw/approach state and avoiding the long post-pass turn.
Any scalar-score improvement smaller than the observed repeat spread is not
sufficient evidence by itself.

Falsification: reject the yaw brake if capture becomes a near miss or boundary
exit, if the terminal wake weakens, if far-field actions differ, if action or
speed-limit residence rises materially, or if force/moment peaks exceed the
replicated captures. Also reject it if the brake is active while the intercept
guard vetoes release; that would mean the implementation violates the intended
separation between route correction and approach hold.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish direction tracking and terminal approach hold over rhythmic locomotion
source_mechanism: retain a posterior-lagged propulsive rhythm while measured turn response adds bounded damping only after target-directed correction is established
transferable_invariant: terminal damping should be subordinate to target interception and preserve the traveling bend rather than replace or globally attenuate it
nontransferable_details: published gains, dimensional cadence, species or robot kinematics, prescribed body envelopes, exact beat or vortex phases, and task-specific routes
policy_translation: use normalized body-frame course/intercept geometry and phase-compensated yaw already present in the two-joint policy; gate a bounded anterior-only yaw brake by the existing steering-release signal while leaving posterior propulsion intact
falsification: reject if capture or wake coherence is lost, far-field closure changes, the brake acts during an intercept veto, saturation or loads rise, or terminal yaw dispersion is not improved across later repeats

## Non-CFD verification

- The candidate differs from the replicated speed-reserve policy only in its
  version, two owned yaw-brake parameters, comments, and the anterior residual.
  The residual is multiplied by the existing release, so it is algebraically
  zero whenever terminal, yaw-response, LOS, or projected-intercept logic
  vetoes that release.
- Recorded-trace counterfactual replay (an arithmetic check, not a coupled CFD
  prediction) found zero nonzero brake rows outside `4L` and zero intercept-veto
  bypasses in all three captured repeats. The brake exceeded `0.01 rad/T^2` on
  `288--454` rows, peaked at `2.2649 rad/T^2`, and projected head-action clamp
  fractions from `68.5--68.7%` to `65.0--66.6%`. Formal evaluation must decide
  whether that recovered command headroom survives the changed hydrodynamics.
- Julia is not installed on this worker's executable path. Deterministic source,
  schema, reflection, editable-boundary, and guidance checks are delegated to
  the required check runner; no formal CFD is run in this workspace.
