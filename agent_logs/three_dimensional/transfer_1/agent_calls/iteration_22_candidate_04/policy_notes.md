# Candidate diagnosis and policy hypothesis

## Evidence read before the edit

- All four sampled rollouts satisfy the frozen experiment contract: direct
  uniform still-water initialization with `U_infinity=(0,0,0)`, no cylinders,
  and no prewarm. All four capture. The two exact prefilled
  `dogfish3d_intercept_guarded_speed_reserve_v1` evaluations capture at
  `0.7466--0.7494L` after `18.3205--18.6010T`; inherited logs add another
  exact baseline capture at `0.7499L` after `18.6725T` and guidance records a
  fourth. This remains the repeat-supported controller.
- I inspected the combined top-down vorticity and oblique Lambda2 rows for the
  highest-scoring sampled baseline capture, a sampled posterior-wave capture,
  and the assigned parent's posterior-wave failure. The captures visibly
  self-propel through termination with a coherent alternating mid-plane wake
  and compact three-dimensional structures. The failure retains the same
  active wake through its `1.2589L` closest pass and lower-domain exit, so the
  failed mechanism changes terminal path geometry rather than propulsion or
  numerical stability.
- The exact intercept-gated posterior wave-shape policy has three sampled or
  inherited captures at `0.7480--0.7492L`, but the two latest inherited exact
  replays miss at `1.2589L` and `1.3584L` and exit below. Its aggregate `3/5`
  record is weaker than the baseline repeat record, and its successful scores
  and secondary metrics overlap the baseline. The posterior pulse is therefore
  falsified as a robust improvement; changing its scalar or stacking it with
  the failed yaw brake is not supported.
- Baseline traces remain fast and actively undulatory at capture
  (`0.83--0.91L/T`) while taking geometrically different crossings. Reconstructed
  projected miss spans near-central to nearly tangential approaches, yet the
  existing intercept guard already withholds yaw-response release when either
  projected miss or approach alignment is unsafe. The evidence supports
  preserving that guard and carrier, while testing whether geometry alone can
  provide a small, phase-independent release when a safe pass is already
  predicted.

## One candidate hypothesis

Retain the exact achieved-course/intercept speed-reserve baseline and add one
bounded capture-corridor hold mechanism: inside the existing intercept-distance
gate, only when projected miss is within the inner corridor and target/velocity
alignment is approaching, impose a small geometry-only floor on steering
release. The floor is combined with the existing yaw-response release by
`max`, so it never increases steering, never changes the carrier, and is zero
outside the normalized safe corridor. Unlike the failed yaw brake it does not
oppose measured body rotation; unlike projected-miss replacement it does not
change route error; unlike posterior wave shaping it does not introduce a
joint-phase perturbation.

Expected test: preserve far-field closure and both coherent wake views, retain
capture, and reduce unnecessary additive steering/clipping on already safe
terminal approaches without slowing arrival or weakening the traveling bend.
The mechanism is an improvement only if exact repeats preserve capture and
eventually show a consistent arrival, terminal-geometry, load, or actuator
benefit beyond baseline variation.

Falsification: reject the hold floor and restore the exact speed-reserve
baseline if capture is lost, the projected pass is redirected outside the
corridor, arrival or distance integral worsens, the wake weakens, or actuator
or force/moment metrics leave the baseline envelope. Do not respond to a miss
by widening the corridor or tuning only the release scalar.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish direction tracking and terminal capture control
source_mechanism: approach scheduling that preserves rhythmic propulsion while measured interception geometry relaxes excess steering
transferable_invariant: terminal authority may be reduced only after body-frame target and velocity geometry already predict a safe approaching pass, while the active traveling bend remains intact
nontransferable_details: published gains, dimensional cadence, species or robot kinematics, explicit oscillator phase, exact vortex phase, prescribed routes, and task coordinates
policy_translation: retain the normalized achieved-course controller and two-joint carrier; use the existing projected-corridor, approach-alignment, and intercept-distance gates to impose a small phase-independent steering-release floor
falsification: reject if capture reliability, arrival, wake coherence, loads, or actuator metrics worsen relative to the repeat-backed speed-reserve baseline
