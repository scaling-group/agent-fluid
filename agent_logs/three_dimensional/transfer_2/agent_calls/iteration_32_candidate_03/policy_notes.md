# Evidence-selected v41 candidate after the nominal-replication stall

## Visual diagnosis before candidate selection

- All four current solver examples are byte-identical v41 evaluations: their
  policies, `4480`-row trajectories, and combined keyframe sheets match.  Each
  uses direct uniform still-water initialization (`U_infinity=[0,0,0]`), no
  cylinders or prewarm, and captures at `24.640015T` and `0.748356L`, with
  mean distance `2.347937L`, score `-0.448328283`, and 284 inertial
  moving-window shifts.  These are deterministic nominal replications, not
  four mechanisms or evidence about reflected poses, perturbed releases, or
  external wakes.
- I inspected the combined sheet from release through capture in both views.
  The top-down row begins wake-free, then shows sustained self-propelled
  diagonal progress, a coherent alternating mid-plane vortex street, and a
  compact transverse hook through the target disk.  The oblique row retains
  paired, compact three-dimensional Lambda2 structures through the hook.  With
  zero background flow, the motion is not passive advection; there is no
  visible wake breakup, out-of-plane escape, instability, or collision-like
  terminal event.  The sampled diagnostics agree: neither joint occupies a
  hard stop, peak absolute body-frame planar force/yaw-moment coefficients are
  in the low `0.02303/0.03169/0.01559` class, and the terminal head crossing
  has a `0.001644L` margin.
- No termination failure exists among the current visual samples, so there is
  no distinct failure sheet to compare.  The informative inherited controls
  are completed regressions on the same terminal hook.  V42 transfers
  safety-filtered posterior effort to the anterior phase anchor; it crosses
  one row earlier but worsens final/mean distance to
  `0.749001/2.348455L`, raises raw acceleration-envelope exposure from
  `73.594%` to `74.124%`, and worsens score to `-0.448986`.  V43 makes the
  opposite coupling choice, vetoing the anterior terminal share when the
  posterior safety layers reject its mate.  It first diverges only at
  `22.044T/2.052L`, then captures later at `24.656513T`, consumes crossing
  margin to `0.000397L`, worsens mean distance/score to
  `2.348909L/-0.449516`, and supplies no new load or command class.
- Four consecutive inherited workers selected v41 unchanged, and their
  post-worker evaluations again produced the exact v41 rollout.  That semantic
  stall triggers the structured bookshelf consultation, but does not itself
  justify manufacturing a disturbance residual or another terminal scalar.

## Candidate hypothesis

Keep exactly one candidate: the current v41 terminal phase-allocation policy,
byte-identical in dynamics and parameter schema to all four sampled rollouts.
Preserve its observed-state anterior phase anchor, lagged posterior traveling
bend, normalized body-frame projected-miss corridor, bounded coupled
half-cycle steering, posterior stopping-stroke reserve, and posterior rate
coast.  Do not adopt v42's inverse headroom transfer or v43's coupled
anti-windup veto: the completed controls show that posterior stroke/rate
safety is a joint-local allocation decision on this established route.

This is completed-evidence selection, not scalar-only tuning and not a claim
about the unevaluated child.  Post-exit CFD should reproduce capture, the
coherent route and three-dimensional wake, zero hard-stop occupancy, and the
low-load class.  Reject the selection if nominal replication fails.  Test
reflection, release-pose perturbation, or actual external disturbance before
treating the phase allocation as generally robust; fixed-pose repetition does
not establish those properties.

bookshelf_consulted: true
source_domain: sensor-modulated coupled-oscillator robotic-fish control and asymmetric fish turning
source_mechanism: embed bounded sensory steering in an observed anterior-to-posterior traveling bend while retaining a stable phase anchor and posterior lag
transferable_invariant: infer beat phase from joint state and spend an existing normalized body-frame target residual on the compatible half-cycle without treating independently constrained joints as interchangeable instantaneous authority
nontransferable_details: published gains, dimensional cadence, prescribed duty ratios, species or robot kinematics, full-body waveforms, exact vortex phases, Strouhal targets, capture geometry, and task-specific routes
policy_translation: retain v41's mirror-equivariant projected-miss residual, lagged-wave phase gate, coupled joint shares, anterior phase anchor, and independent posterior safety filters; add no unsupported scalar, residual, route, or disturbance term
falsification: reject if nominal replication loses capture, far-route locality, coherent wake, zero hard-stop occupancy, low-load class, or the measured advantage over the v42 and v43 coupling controls; reject on held-out poses if phase selection removes necessary correction

## Evaluation boundary

Formal CFD is deferred to the post-worker evaluator.  The candidate's new
outcome is not evidence available to this worker.

## Pre-evaluation validation

- The single materializable solver candidate has LF SHA-256
  `9e6a29b253671527cc436021e572b18ba5bf6994d71936eadf98ca674753fadd`,
  matching all four current v41 samples.  No sibling candidate was created.
- The configured check-runner was invoked, but its pinned `gpt-5.4-mini`
  model is unsupported on this account.  Its three declared no-CFD commands
  were therefore run directly and separately.  After removing the duplicate
  assigned-parent marker from the rendered workspace README, reusable-guidance
  semantics, the Julia public policy contract, and the solver editable-boundary
  audit pass; the contract returns finite accelerations
  `(-14.3858335, 0.0005062)`.
- The deterministic schema audit resolves all `87` direct `params.FIELD`
  references among the `89` fields returned by `target_policy_params()`.
  Formal CFD remains reserved for the post-worker evaluator.
