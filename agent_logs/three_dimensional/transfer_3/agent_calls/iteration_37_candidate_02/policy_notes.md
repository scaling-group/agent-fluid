# Low-speed oscillator-energy bootstrap candidate

## Evidence and visual diagnosis before editing

- All four sampled rollouts satisfy the frozen Phase-2 contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite moving-window dynamics, and `capture`
  termination. Three evaluate the identical `v40` law; the prefilled `v41`
  source adds a terminal course/yaw selector but produces the exact same
  trajectory. Every sample captures at `19.684490 T`, scores
  `-0.261384287`, has mean/final distance `2.151092787 L`/`0.748302400 L`,
  follows a `12.951133 L` center path, and triggers `243` window shifts.
- I inspected the full combined keyframe sheet, including the release-to-
  capture top-down vorticity row and oblique body/Lambda2 row. The release is
  quiescent, so the motion is self-propelled rather than advection. A compact
  target-directed path and coherent alternating posterior wake develop, while
  the oblique row remains finite and localized; there is no collision,
  boundary-exit, volume-filling instability, or visible wake collapse.
- The four sampled sheets are byte-identical, so this sample set contains no
  distinct failure view. I therefore compared the best finite sample with the
  nearest inherited active regression, `v42`: its separate sheet is visually
  indistinguishable at keyframe resolution, but its late course/yaw allocation
  worsens score/mean/final distance to `-0.261390567`, `2.151097816 L`, and
  `0.748308659 L`. The inherited phase-lag loop and startup-curvature late turn
  are used only as logged scalar/topology evidence because their image sheets
  are not present in this workspace.
- The current trace isolates a different shortcoming before the mature wake.
  Range falls from `12.3277 L` to only `12.0 L` by `3.806 T`; mean center speed
  in successive first-second bins is about `0.063`, `0.138`, and `0.225 U` as
  the anterior/posterior angle envelopes grow from about
  `[-0.208,0.220]/[-0.164,0.321] rad` toward their established roughly
  `0.49/0.50 rad` excursions. After response builds, mean speed rises from
  `0.560 U` over `12-10 L` to `0.881 U` over `6-4 L`, with the coherent
  traveling-bend wake intact. The release transient is therefore an oscillator
  energy-build problem, not evidence for more startup curvature or a changed
  posterior lag.
- Terminal and route-changing alternatives are closed by completed evidence:
  the sampled `v41` selector is structurally dormant beneath the existing
  `0.82` allocation floor, forcing the sign-corrected selector active in `v42`
  regresses, startup mean curvature delays capture to `23.375013 T`, and outer
  lag shortening creates a `31.012702 L` loop with capture only at
  `46.145020 T`. The candidate must leave those loci unchanged.

## Policy hypothesis

Preserve the evaluated `v40` traveling-wave, steering, saturation-allocation,
and terminal-posture law, and remove the dormant `v41` selector. Add one new
mechanism inside the anterior state-feedback oscillator: while the target is
outside the protected `4 L` terminal band and measured body-frame translation
is still low, smoothly increase the Van der Pol energy-injection coefficient.
The boost decays to exactly zero once translation response is established and
the ordinary oscillator then governs. Posterior lag, posterior target,
frequency, target curvature, residual steering, command limit, and every
terminal command remain unchanged as functions of the same state.

This is a response-gated oscillator bootstrap, not a scalar retune of the
permanent gait. Same-state replay must show finite command changes during the
far low-speed release, exact zero below `4 L` and at established speed, no new
parameter-schema gap, and no command above the existing software limit. CFD
falsification is an unchanged or later `12 L` crossing, slower/lost capture,
a changed compact route, persistent extra clipping after speed builds,
material load growth, joint-stop dwell, instability, or degradation of the
alternating top-down or localized oblique wake.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and classical state-feedback oscillators
source_mechanism: modulate rhythmic energy input from sensed locomotor response while retaining the established inter-joint traveling-wave relation
transferable_invariant: bootstrap an under-developed rhythm only while normalized translational response is low, then withdraw the extra energy continuously without changing phase lag, route steering, or the mature gait
nontransferable_details: published oscillator gains, dimensional speed thresholds, robot geometry, species kinematics, Strouhal targets, exact beat or vortex phases, and task-specific routes
policy_translation: use body-frame speed magnitude and target-relative outer-distance support to add a bounded transient coefficient to the anterior Van der Pol energy term; keep the two-joint posterior follower, target feedback, and terminal law unchanged
falsification: reject if the branch is dormant, survives inside 4 L or after established speed, fails to advance startup progress, changes the compact approach, increases sustained clipping or loads, loses capture, or degrades either wake view

## Deterministic pre-CFD validation

- Replaying all `3579` stored parent states against sampled `v40` and this
  candidate changes `1163` far/low-speed commands, from the first stored state
  through about `6.397 T`, `10.887 L`, and `0.620 U`. No replayed command
  changes at or above the declared `0.62 U` response cutoff or at/below `4 L`.
  The largest same-state change is `2.9284 rad/T^2`, and every output remains
  within the existing `30.5433 rad/T^2` software limit.
- Over the affected parent states, `|action|>30 rad/T^2` counts change only
  from `414/607` to `411/610` anterior/posterior samples, while mean command
  vector norm changes from `36.7541` to `36.7373 rad/T^2`. The state-feedback
  energy term both injects below and dissipates above its amplitude envelope;
  the candidate is not an indiscriminate command multiplier. These equal-state
  checks establish activity and isolation, not hydrodynamic improvement.
- The prescribed checker was invoked, but its pinned `gpt-5.4-mini` model is
  unavailable for this account and failed before running a check. Running its
  three manifest commands directly gives PASS for the material guidance/notes
  update, finite two-joint Julia contract, and solver edit boundary. A separate
  schema audit resolves all `92` direct parameter references against the `93`
  returned fields; only the version field is intentionally unreferenced. No
  formal CFD rollout was run.
