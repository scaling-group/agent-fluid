# Evidence-selected v41 candidate after the replicated nominal stall

## Visual diagnosis before candidate selection

- All four current solver examples are exact v41 replications: their policy
  (`9e6a29b...`), 4480-row trajectory (`8870795a...`), top-down sheet
  (`28d36f07...`), and oblique sheet (`a5839ed1...`) hashes match.  Each uses
  direct uniform still-water initialization (`U_infinity=[0,0,0]`) without
  cylinders or prewarm and captures at `24.640015T` and `0.748356L`, with
  mean distance `2.347937L`, score `-0.448328283`, and 284 moving-window
  shifts.  Seven completed logs inherited from the assigned parent contain the
  same policy and trajectory bytes, so the available evidence is eleven
  deterministic nominal repetitions, not eleven controller tests.
- I inspected the top-down and oblique sheets from release through capture.
  The top-down sequence begins wake-free, develops a coherent alternating
  mid-plane vortex street during self-propelled diagonal progress, and ends in
  a compact transverse hook through the target disk.  The oblique Lambda2
  sequence retains compact paired three-dimensional structures through that
  hook.  With zero background velocity the motion is not passive advection;
  neither view shows wake breakup, out-of-plane escape, collision, or
  numerical instability.
- The trace supports the visual diagnosis: neither joint occupies the
  `45 deg` position stop and peak absolute planar body-frame force/yaw-moment
  coefficients remain in the low `0.02303/0.03169/0.01559` class.  The
  terminal state is nevertheless a narrow dynamic crossing, with only
  `0.001644L` radial margin, `1.887 rad/T` yaw rate, `13.839%` any-joint
  exact-rate exposure, and `73.594%` raw acceleration-envelope exposure.
- No current sampled solver supplies a distinct failure view.  The informative
  failure contrast is inherited trace-level evidence.  V42 transfers rejected
  posterior steering to anterior headroom and crosses one tick earlier, but
  worsens final/mean distance to `0.749001/2.348455L`, raises raw acceleration
  exposure to `74.124%`, and lowers score to `-0.448986`.  V43 makes the
  opposite cross-joint coupling choice and captures later at `24.656513T`,
  reduces crossing margin to `0.000397L`, and worsens mean distance/score to
  `2.348909L/-0.449516` without a better load or command class.  Older broad
  rate barriers and posterior reference-velocity feedforward reduce selected
  saturation counts but change the useful route and lose capture.

## Candidate hypothesis

Keep exactly one materializable candidate: the existing v41 terminal
phase-allocation controller, byte-identical in dynamics and parameter schema to
the four current samples.  Preserve the observed-state anterior phase anchor,
lagged posterior traveling bend, normalized body-frame projected-miss corridor,
bounded phase-compatible terminal residual, posterior stopping-stroke reserve,
and posterior rate coast.  Do not adopt another cross-joint transfer, terminal
scalar, approach-drive scalar, or uncalibrated force/moment/crossflow residual:
the completed evidence either directly regresses those nearby mechanisms or
contains no divergent disturbance from which their sign and scale can be
identified.

This is an evidence-backed negative selection, not a same-worker CFD claim.
Post-exit evaluation should reproduce nominal capture, coherent two-view wake,
zero posterior hard-stop occupancy, and the low-load class.  Reject the
selection if nominal capture does not repeat.  A later active mechanism should
first be tested on a reflected pose, perturbed release, or genuine external
disturbance and must remain dormant on the established far route; exact
fixed-pose repetition cannot establish generalization.

bookshelf_consulted: true
source_domain: elongated-body traveling-wave propulsion, asymmetric fish turning, and sensor-modulated coupled-oscillator robotic-fish control
source_mechanism: preserve an anterior-to-posterior traveling bend and allocate bounded sensory steering only for an evidenced error and compatible observed half-cycle
transferable_invariant: infer propulsion phase from joint state, retain the anterior phase anchor and posterior lag, and require a normalized body-frame error with evidenced sign and scale before adding a correction
nontransferable_details: published gains, dimensional cadence, species or robot kinematics, prescribed duty ratios, full-body waveforms, exact vortex phases, Strouhal targets, fixed capture geometry, and task-specific routes
policy_translation: retain v41's mirror-equivariant projected-miss residual, lagged-wave phase gate, anterior anchor, posterior stopping-stroke reserve, and posterior coast; add no unsupported scalar, cross-joint transfer, or disturbance residual
falsification: reject if nominal capture, far-route locality, coherent wake, zero posterior hard-stop occupancy, or the low-load class fails to repeat; reject a future residual if it activates without a distinct body-frame disturbance or removes necessary correction on a held-out route

## Evaluation boundary

Formal CFD is deferred to the post-worker evaluator.  The retained candidate is
not evidence for reflected poses, release perturbations, imposed inflow, or
external-wake robustness.

## Pre-evaluation validation

- The mandated check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unsupported on this account.  Its three declared no-CFD checks were then
  run directly and separately.  After removing the duplicated assigned-parent
  marker from the rendered workspace README, the reusable-guidance check,
  public Julia policy contract, and solver editable-boundary audit all pass.
- The public contract returns two finite accelerations
  `(-14.3858335, 0.0005062)`.  The deterministic schema audit resolves all 87
  direct `params.FIELD` references among the 89 fields returned by
  `target_policy_params()`.
- The one materializable solver candidate remains non-empty and has LF
  SHA-256 `9e6a29b253671527cc436021e572b18ba5bf6994d71936eadf98ca674753fadd`;
  no sibling candidate was created.  Formal CFD remains reserved for the
  post-worker evaluator.
