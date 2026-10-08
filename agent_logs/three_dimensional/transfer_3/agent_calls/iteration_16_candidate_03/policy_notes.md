# Force-vetoed intercept-corridor terminal release

## Evidence and visual diagnosis before the policy edit

- All four sampled evaluations satisfy the frozen Phase-2 contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite moving-window dynamics, and capture from
  `12.32772 L` at `25.1185226 T` after `4,567` solver steps and `268` window
  shifts.
- The assigned v28 parent is reproduced bit-for-bit by two sampled solvers at
  score `-0.5281032175`, mean distance `2.4291077322 L`, and final distance
  `0.7461626530 L`. The adverse-force veto independently improves those
  measures to `-0.5280861775`, `2.4290942804 L`, and `0.7461447120 L`; the
  intercept-corridor support improves them further to `-0.5280772274`,
  `2.4290872138 L`, and `0.7461352944 L`. Both variants retain the exact
  capture time and are command- and trajectory-identical to v28 through all
  `4,341` recorded states at or beyond `1.6 L`.
- I inspected the complete combined top-down vorticity and oblique
  body/Lambda2 sheets for the strongest intercept sample, the force-veto
  sample, and the weaker v28 finite baseline. In every top-down row the fish
  self-propels along the same compact, gradually turning target-directed arc
  while shedding a coherent alternating wake; lateral oscillation remains a
  productive traveling bend rather than stationary flailing. In every
  oblique row the posterior vortex packets stay finite and organized, with no
  out-of-plane breakup, passive advection, collision, boundary-exit precursor,
  or numerical instability. The carrier subsides into the same quiet held
  bend immediately before capture, so the sheets support terminal
  noninterference but cannot visually rank the small response differences.
- Telemetry supports both semantic gates without licensing more authority.
  Over the `226` states inside `1.6 L`, the intercept policy reduces projected
  cross-track miss from `0.68497 L` at band entry to `0.22778 L` at capture
  and finishes at speed `0.65402 L/T`. The force-veto policy acts on the same
  `20` target-opposing lateral-force states identified in the parent replay,
  improves the terminal force-norm maximum from `0.0022374` to `0.0021817`,
  and slightly improves final course mismatch from `0.310311` to
  `0.310286 rad`, though its command maxima rise slightly. Neither result
  justifies a
  gain increase, mean-curvature unloading, beat-side selection, or joint-role
  split.

## Policy hypothesis

Use the evaluated intercept-corridor policy as the single candidate base and
compose only the evaluated adverse-force veto onto its optional `3.5%` paired
carrier release. A small predicted cross-track miss may earn the release only
while measured normalized lateral force does not oppose the target side.
Positive closure, late proximity, helpful relative crossflow, and settled
two-joint response remain independent prerequisites. The force signal cannot
request a turn or change the validated crossflow release, shared mean bend,
carrier phase, posterior lag, outer steering, or command limits.

This is one small compatible composition of two separately positive response
mechanisms, not a claim that their effects add. On the stored intercept
trajectory the force veto should be active on `20/226` states inside `1.6 L`,
reach full veto on four, and remain exactly inactive outside that terminal
band. Reject the composition if replay shows a dormant or unbounded gate, any
outer command change, added release authority, delayed or lost capture, worse
mean/final distance or projected miss, a late loop, renewed carrier
oscillation, joint stops, saturation, load growth, instability, or wake
degradation.

bookshelf_consulted: true
source_domain: wake-interaction control and sensor-modulated robotic-fish rhythmic control
source_mechanism: separate slow target-direction control from a bounded fast hydrodynamic response while preserving the established traveling-wave scaffold and helpful lateral motion
transferable_invariant: optional terminal carrier release may be earned by an observed intercept and continuously withheld by target-opposing lateral force without adding steering authority
nontransferable_details: published gains, dimensional force thresholds and cadence, species-specific bend envelopes, duty ratios, clock or vortex phase, cylinder geometry, capture radius, and task-specific routes
policy_translation: form intercept support from normalized body-frame target and velocity vectors, multiply only that optional paired release by a smooth veto from normalized body-frame lateral force and target side, and preserve the inherited mean bend and all outer commands
falsification: reject if either gate is inactive on stored terminal states, the composition affects the outer path or helpful-force states, authority increases, capture is delayed or lost, distance or miss worsens, or oscillation, saturation, joint stops, load spikes, instability, or wake loss returns

## Non-CFD implementation audit

- The lightweight Julia contract returns two finite commands with the frozen
  `L=64` observation adapter.
- Replaying the composed and evaluated intercept-policy algebra on all `4,567`
  stored intercept trajectory states makes the force gate active on `20/226`
  states below `1.6 L`, including four full vetoes. Nine of those states also
  have nonzero intercept-release support and therefore change commands; the
  other eleven correctly remain command-invariant rather than gaining another
  response path.
- The maximum replayed per-joint command changes are
  `0.00424/0.01006 rad/T^2`, terminal mean absolute changes are
  `0.000038/0.000089 rad/T^2`, and the final-state difference is zero. The
  maximum command difference over all `4,341` states at or beyond `1.6 L` is
  exactly zero. These checks establish finite output, active bounded gating,
  and outer noninterference only; they do not establish coupled-flow benefit.

The composed candidate's coupled-flow evaluation occurs only after this worker
exits and is not claimed as evidence here.
