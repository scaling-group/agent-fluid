# Phase-selective posterior commitment candidate

## Visual diagnosis before editing

- I inspected the combined release-to-capture keyframe sheets for a current
  `v44` sample and the inherited `v41` comparator in both required views.  All
  evidence is direct-uniform still water with `U_infinity=(0,0,0)`, no
  cylinders, and no prewarm snapshot.  The top-down rows show self-propelled
  diagonal progress, a coherent alternating vortex street, and a compact
  transverse hook through the target disk.  The oblique Lambda2 rows retain
  compact three-dimensional structures through the hook, without passive
  advection, wake breakup, out-of-plane escape, or instability.
- No sampled rollout has a failed termination or distinct failure sheet, so I
  do not invent a visual failure comparison.  The strongest finite evidence is
  four byte-identical current `v44` captures at `24.557514T`, `0.747654L`, and
  score `-0.447653764`; replicated `v41` is the weaker visual comparator at
  `24.640015T`, `0.748356L`, and `-0.448328283`.  The inherited `v42` headroom
  transfer and `v43` coupled anti-windup captures are the informative numerical
  regressions: both consumed crossing margin without improving the load class.
- Trace metrics resolve what the visually indistinguishable sheets cannot.
  Relative to `v41`, `v44` first changes only the anterior command inside the
  `2.10L` approach neighborhood, advances capture by `0.0825T`, increases
  crossing margin from `0.001644L` to `0.002346L`, lowers terminal yaw rate
  from `1.887` to `1.564 rad/T`, and reduces final projected miss from
  `0.631928L` to `0.612134L`.  It preserves zero posterior hard-stop occupancy,
  the low peak planar force/yaw-moment class, and the coherent wake.  Four
  current samples and three available inherited optimizer records now repeat
  the exact `v44` outcome, establishing fixed-case determinism but no further
  semantic evidence.
- At capture the measured velocity course remains inside the `0.75L` target
  disk but is nearly transverse, while the current policy preserves posterior
  additive route steering across both lagged-wave half-cycles.  The evidence
  supports testing phase allocation of that residual, not more thrust, another
  course/corridor gain, broad dual-joint rate braking, or cross-joint
  redistribution.

## Policy hypothesis

Preserve the evaluated `v44` carrier, anterior collision-course hold,
route-scale mean curvature, phase-selective corrective residual, posterior
stopping reserve, and posterior rate coast.  Add one mirror-equivariant,
phase-selective posterior commitment gate.  Only inside the already-safe,
positively closing collision-course corridor, infer the requested geometric
turn side and posterior wave half-cycle from normalized body-frame target
geometry and observed joint state.  Smoothly withdraw a bounded share of
posterior additive route steering on the opposed half-cycle while retaining
the route-aligned half-cycle.  Leave posterior carrier and mean curvature, the
anterior oscillator, and all safety filters unchanged.

This is an actuator-allocation mechanism rather than a scalar-only gain edit.
It should act on the nominal terminal trace while remaining exactly dormant on
the far route and preserving the route-aligned posterior half-cycle.  Falsify
it if post-exit CFD loses capture or crossing margin, changes
commands outside `2.10L`, increases projected miss after commitment, delays
arrival without a distance/load benefit, or regresses wake coherence,
hard-stop occupancy, loads, or rate exposure.  Held-out reflection or release
perturbation is still required before claiming generality.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish oscillator modulation, asymmetric flapping, and terminal approach hold
source_mechanism: preserve the traveling-wave carrier while asymmetric flapping allocates steering to the half-cycle aligned with a sensory route request
transferable_invariant: separate propulsion from steering and use bounded joint-state phase plus normalized body-frame geometry to preserve the useful steering half-cycle while releasing the opposed half-cycle during an already-valid intercept
nontransferable_details: published gains, dimensional cadence, duty ratios, robot or species kinematics, full-body waveforms, exact vortex phases, capture geometry, and task-specific routes
policy_translation: inside the existing collision-course gate, taper only posterior additive route steering on the lagged-wave half-cycle opposed to the geometric turn request; preserve the aligned half-cycle, carrier, mean curvature, corrective residual, anterior phase anchor, and safety filters
falsification: reject if capture or margin is lost, the far route changes, projected miss grows, or coherent-wake, load, hard-stop, or rate classes regress; separately require reflected or perturbed evidence for generalization

## Evaluation boundary

Formal CFD is deferred to the post-worker evaluator.  All numerical outcomes
above are assigned or inherited completed evidence, not a same-worker result.

## Recorded-state audit after editing

- A first geometry-versus-course conflict formulation was rejected before
  handoff because it changed zero commands on all `4465` recorded parent
  states.  This is a concrete trace-level negative: two normalized corrections
  can be mirror-consistent yet supply no test when their conflict does not
  overlap the safe-corridor gate.
- The retained phase-selective mechanism changes only the posterior command on
  `168` recorded parent states, first at `22.280499T/1.837224L`.  It changes no
  command at or beyond `2.10L`, leaves the anterior command byte-equivalent on
  every fixed state, reaches a maximum gate of `0.3058`, and bounds the maximum
  posterior acceleration difference to `2.3783 rad/T^2`, below the owned
  `31.416 rad/T^2` acceleration envelope.
- Reflecting target lateral geometry, velocity, bearing/rate, yaw rate, joint
  state, prior action, and moment leaves the new scalar gate identical to
  floating-point precision on every recorded state.  This verifies structural
  reflection symmetry and nominal locality, not closed-loop hydrodynamic
  improvement.

## Pre-evaluation validation

- The required check-runner was invoked, but its pinned `gpt-5.4-mini` model is
  unsupported on this account, matching the inherited infrastructure failure.
  Its three declared no-CFD checks were then run directly and separately.  The
  reusable-guidance check initially exposed the rendered README's duplicated
  assigned-parent marker; after removing only the duplicate marker, guidance
  semantics, the Julia public policy contract, and the solver editable-boundary
  audit all pass.
- The public contract returns finite accelerations
  `(-14.3858335, 0.0005062)`.  The deterministic schema audit resolves all `89`
  direct `params.FIELD` references among the `91` fields returned by
  `target_policy_params()`.  The sole editable candidate has SHA-256
  `45420472bc513549e19f2eb3c8bac5001acbf7d6348dbbd7cb7b93afa0783867`;
  no sibling candidate or formal CFD rollout was created.
