# Evidence-selected v41 candidate after the nominal-replication stall

## Visual diagnosis before candidate selection

- All four current solver examples are byte-identical v41 evaluations: their
  policies, `4480`-row trajectories, and combined keyframe sheets match.  Each
  uses direct uniform still-water initialization (`U_infinity=[0,0,0]`), no
  cylinders or prewarm, and captures at `24.640015T` and `0.748356L` with mean
  distance `2.347937L`, score `-0.448328283`, and 284 moving-window shifts.
  These are deterministic nominal replications, not four mechanisms or
  evidence about reflected poses, perturbed releases, or external wakes.
- I inspected the combined sheet and both view-specific sheets from release
  through capture.  The top-down row begins wake-free, then shows sustained
  self-propelled diagonal progress, a coherent alternating mid-plane vortex
  street, and a compact transverse hook into the target disk.  The oblique row
  retains compact three-dimensional Lambda2 structures through that hook.
  With zero background flow, the motion is not passive advection; there is no
  visible wake breakup, out-of-plane escape, instability, or collision-like
  terminal event.  The inherited trace audit agrees: neither joint occupies a
  hard stop and peak absolute body-frame planar force/yaw-moment coefficients
  remain in the low `0.02303/0.03169/0.01559` class.
- No failed termination exists among the current examples, so a current
  failure sheet cannot be compared.  The informative inherited completed
  regressions are mechanism controls instead: posterior-only phase allocation
  captures later at `24.673016T` with `0.748776L` final distance and
  `-0.448772903` score; anterior headroom redistribution crosses at
  `0.749001L`, raises raw acceleration-envelope exposure, and worsens mean
  distance; coupled anti-windup captures at `24.656513T` and `0.749603L` with
  score `-0.449516228`.  All preserve the same coherent route/load class, so
  neither reallocating nor vetoing the coupled terminal share creates a useful
  controller mechanism.  Older dual-joint rate barriers and posterior
  reference-velocity feedforward are stronger termination negatives: they
  lower saturation statistics but change the far route and lose capture.
- Three consecutive inherited completed workers then selected v41 unchanged,
  and their post-worker evaluations again produced the exact v41 rollout.
  This triggers the structured bookshelf consultation, but it adds no new
  semantic or robustness evidence by itself.

## Candidate hypothesis

Keep exactly one candidate: the current v41 terminal phase-allocation policy,
byte-identical in dynamics and parameter schema to the four sampled rollouts.
Preserve the observed-state anterior phase anchor, lagged posterior traveling
bend, normalized body-frame projected-miss corridor, bounded coupled
half-cycle steering, posterior stopping-stroke reserve, and posterior rate
coast.  Do not manufacture a new flow/yaw residual, terminal hold, phase-lag
allocator, or scalar tune: the visible nominal wake is already coherent and
low-load, no sampled disturbance establishes a feedback sign or scale, and
the completed nearby terminal mechanisms regress capture margin without a
new trajectory or constraint class.

This is a concrete evidence-selection result, not a same-worker CFD claim.
Post-exit evaluation should reproduce capture, the coherent route, zero hard
stops, and the low-load class.  Reject the retained candidate on nominal
non-replication.  Robustness remains untested until a reflected, perturbed-pose,
or actually disturbed rollout supplies a divergent body-frame signal; a later
mechanism should be null on the established route and rejected if it changes
that route before its triggering evidence appears.

bookshelf_consulted: true
source_domain: terminal approach control, asymmetric fish turning, and sensor-modulated coupled-oscillator robotic-fish control
source_mechanism: preserve a stable traveling bend and add only observed-state approach damping or phase allocation justified by a measured terminal error
transferable_invariant: keep the anterior phase anchor and posterior lag, infer beat phase from joint state, and require any bounded terminal correction to be localized by normalized body-frame evidence rather than elapsed phase or a presumed disturbance
nontransferable_details: published gains, dimensional cadence, prescribed duty ratios, species or robot kinematics, full-body envelopes, exact vortex phases, Strouhal targets, fixed capture geometry, and task-specific routes
policy_translation: retain v41's mirror-equivariant projected-miss residual and compatible lagged-wave half-cycle gate unchanged because current evidence supplies no calibrated wake residual or approach-hold error that survives the inherited negative controls
falsification: reject on nominal loss of capture, coherent wake, zero hard-stop occupancy, or low-load class; on held-out poses or wakes reject the retained phase allocation if it removes necessary correction, and reject any future residual that activates before a divergent normalized body-frame signal

## Pre-evaluation boundary

- The single materializable solver candidate remains LF SHA-256
  `9e6a29b253671527cc436021e572b18ba5bf6994d71936eadf98ca674753fadd`,
  matching all four current samples.  No sibling candidate was created.
- Formal CFD is reserved for the post-worker evaluator.  Static contract,
  schema, and editable-boundary checks are recorded after they run.
- The mandated check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unsupported on this account.  Its three declared no-CFD checks were run
  directly and separately.  Reusable-guidance semantics passes after removing
  the duplicate assigned-parent marker from the rendered workspace README;
  the Julia public contract returns finite accelerations
  `(-14.3858335, 0.0005062)`; and the solver editable-boundary audit passes.
- The deterministic schema audit resolves all `87` direct `params.FIELD`
  references among the `89` fields returned by `target_policy_params()`.
