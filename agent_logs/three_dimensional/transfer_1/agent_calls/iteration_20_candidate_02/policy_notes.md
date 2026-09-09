# Wake-policy candidate diagnosis

## Evidence read before policy edit

- All four sampled rollouts use direct uniform still-water initialization at
  `U_infinity=(0,0,0)`, without cylinders or prewarm. Their translation and
  wakes are therefore released-swimmer behavior rather than ambient advection.
- I inspected both the top-down vorticity and oblique Lambda2 rows for the
  strongest baseline capture, the sampled posterior-wave capture, and the
  inherited ungated half-cycle failure. The three exact speed-reserve baseline
  runs and the posterior-wave run sustain a coherent alternating wake through
  capture at `0.7466--0.7494L`. The inherited half-cycle run also remains
  self-propelled and numerically stable, but turns downward well before the
  target, reaches only `3.7595L`, and exits the lower boundary. This separates
  useful terminal wave shaping from wake collapse, advection, or a generic
  propulsion deficit.
- The sampled `dogfish3d_speed_reserve_posterior_wave_shape_v1` rollout
  captures at `0.7492L` and `18.4690T`, with final speed `0.8575L/T`, action
  clamp fractions `68.40%/70.88%`, speed-limit residence `10.51%/11.32%`,
  peak lateral-force coefficient `0.0286`, and peak yaw-moment coefficient
  `0.0161`. Every value lies within or essentially on the three-repeat parent
  envelope: capture at `18.2050--18.6010T`, clamp `68.48--68.66% /
  70.64--70.97%`, speed residence `10.41--10.63% / 11.27--11.56%`, peak
  lateral force `0.0274--0.0292`, and peak yaw moment `0.0157--0.0163`.
- The posterior term is exactly absent outside the existing `2.75L` intercept
  gate. At gate entry its trajectory remains within the observed spread of
  the successful baseline paths, unlike the inherited ungated half-cycle
  candidate. Thus the one sampled capture supports a compatible controller
  mechanism but does not yet establish superiority or repeatability over the
  `3/3` parent baseline.
- Inherited logs also report coherent-wake lower exits at `1.6860L` for gated
  carrier-signed half-cycle allocation and `1.4601L` for terminal yaw damping.
  Those failures reject stacking either residual onto the new mechanism. The
  clean next experiment is an exact-byte posterior-wave repeat rather than a
  scalar gain change or another terminal observation.

## One candidate hypothesis

Materialize the sampled `dogfish3d_speed_reserve_posterior_wave_shape_v1`
policy exactly. It retains the repeat-supported achieved-course/intercept
servo, active traveling bend, and sparse outward-carrier reserve. Inside the
existing intercept gate only, normalized anterior joint speed supplies a
clock-free phase cue for a small signed posterior target-bias acceleration.
This tests posterior wave-shape steering as one mechanism without changing the
far-field controller, tuning a scalar after one run, or confounding the repeat
with another residual.

Expected test: a second exact-policy capture with the same coherent two-view
wake and parent-scale saturation/load envelope would promote posterior wave
shaping from a one-run compatible success to a repeat-supported candidate.
Improved capture reliability or terminal geometry—not a marginal scalar-score
difference—is the intended signal.

Falsification: reject the mechanism as a baseline replacement if the exact
repeat loses capture, develops the inherited below-target exit, weakens the
alternating wake, or exceeds the parent saturation, lateral-force, or
yaw-moment envelope. If it repeats capture but provides no reliable arrival,
load, or actuator benefit across later repeats, retain the simpler baseline
rather than tune or stack this pulse.

bookshelf_consulted: true
source_domain: fish and robotic-fish turning by posterior phase-lag or wave-shape modulation
source_mechanism: embed a bounded target-directed curvature change in the posterior traveling wave while retaining the propulsive carrier
transferable_invariant: a small state-synchronous posterior wave-shape change can realize steering without suppressing the active traveling bend
nontransferable_details: published gains, dimensional cadence, species or robot kinematics, oscillator clocks, exact vortex phases, prescribed routes, and task coordinates
policy_translation: use normalized anterior-joint speed as a clock-free phase cue and the existing normalized body-frame turn and intercept feedback to add a bounded posterior bias that is exactly zero outside the terminal gate
falsification: reject if exact-policy repetition loses capture, changes far-field closure, weakens the alternating wake, or raises saturation, lateral force, or yaw moment beyond the repeat-supported speed-reserve envelope

## Non-CFD verification

- The materialized candidate SHA-256 is
  `393aac051dfa5d938ff7d56c3f86df355a494b578710d007bc9954ab3bfc265a`,
  exactly matching the sampled posterior-wave policy; this is a clean
  exact-policy repeat rather than an undocumented parameter change.
- The mandated Julia `1.12.6` contract assertion passes in an isolated
  rootless container: `target_policy_params()` has no forbidden `L` field and
  `target_policy` returns two finite accelerations for the full adapter state.
- The guidance semantic-change and solver editable-boundary checks pass. No
  CFD rollout was run in this workspace.
