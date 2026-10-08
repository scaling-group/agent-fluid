# Load-response release for course-consensus forward bend

## Visual and quantitative diagnosis before editing

- I read the workspace and guidance contracts, the four sampled scores,
  observations, metrics, diagnostics, trajectories, and policies, and the
  assigned parent's inherited optimization notes. All four sampled episodes
  are finite captures from direct uniform still water with
  `U_infinity=(0,0,0)`, no prewarm, and no cylinders; their initial distance is
  `12.3277L` and their arrival times span only `17.9960T`--`18.0290T`.
- I inspected the combined keyframe sheets from release through capture for
  the sampled v20 scalar leader, the course-consensus forward-allocation
  candidate, and the target-normal-power selector failure. In both the
  top-down mid-plane vorticity row and the oblique Lambda2 row, the fish
  self-propels from rest and retains a coherent alternating wake with compact
  three-dimensional posterior structures. There is no passive advection,
  boundary interaction, wake breakup, or out-of-plane instability. The
  remaining difference is terminal steering/allocation, not propulsion or
  gross wake topology.
- The sampled v20 parent remains the scalar leader at `18.0070T`, mean
  distance `1.950358L`, and score `-0.064028`, but finishes with course
  alignment `0.1092`, absolute yaw `0.9840 rad/T`, head cross-track `0.7317L`,
  and `75.83%` near posterior acceleration-ceiling residence. The sampled
  course-consensus forward allocation is a semantic improvement: it finishes
  at `0.1951` alignment and `0.2761 rad/T` yaw, narrows cross-track to
  `0.7245L`, and lowers near posterior acceleration-ceiling residence to
  `72.29%`. Its costs are a `0.0220T` later capture, a `0.000425L` larger mean
  distance, score `-0.064510`, and small anterior pressure migration (near
  acceleration-ceiling residence `70.28%` versus `69.21%`). Relative to the
  inherited v16 terminal envelope, it is essentially score-neutral while
  retaining the better final alignment/yaw class of conserved forward bend.
- The sampled target-normal-power candidate bounds how load feedback may be
  used. Selecting the posterior-wave envelope with positive target-normal
  power shortened path to `13.1921L` and capture to `17.9960T`, but final
  alignment fell to `0.0975` and absolute yaw rose to `1.2697 rad/T`; the
  coherent two-view wake survived. Thus target-normal power is not supported
  as a replacement for the established yaw-qualified posterior envelope.
  Inherited analysis nevertheless established that its sign is meaningful:
  velocity-normal times force-normal correlates `0.965`--`0.972` with the
  short-horizon change in cross-course kinetic energy. The untested use worth
  isolating is response-based release of the forward mean-bend allocation,
  while leaving the posterior propulsive envelope unchanged.

## Single policy hypothesis

Use the sampled course-consensus policy as the base. Preserve its
state-feedback carrier, posterior lag and emphasis, phase-consistent work
reserve, odd target-to-curvature map, route controller, v16 terminal posterior
envelope, half-cycle steering, reversal-preserving rate governor, and conserved
forward mean-bend allocation. Add one load-response release to only the
allocation authority. Project normalized body-frame velocity and measured
hydrodynamic force onto the normal of the instantaneous target line. When
their product is negative, the measured load is already removing cross-course
kinetic energy; smoothly return the shifted mean tangent to the posterior
joint. When the load is neutral or worsening cross-course motion, retain the
course-consensus forward shift.

This is a response selector on where an existing bend acts, not a force-based
route command or a posterior-wave envelope. The total signed mean tangent is
still conserved, the gate is exactly irrelevant outside the established
`2.10L` approach allocation, and lateral reflection negates both target-normal
projections while preserving their product and the release magnitude. The
expected result is identical far/middle action and the same coherent two-view
wake, retained capture, v24-class terminal alignment/yaw, and less arrival,
distance-integral, and anterior-pressure cost. Falsify if the v24 terminal
benefit disappears, capture or score regresses materially, posterior pressure
rises, pressure merely migrates between joints, reflection changes the gate,
or either wake row deteriorates.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish direction control and response-released fish turning
source_mechanism: preserve the posterior propulsive rhythm, apply a bounded forward steering allocation while directional response is deficient, and release it when sensed load is already correcting cross-course motion
transferable_invariant: use normalized body-frame response feedback to release a transient steering allocation without changing the total requested bend or the lagged posterior wave
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, full-body kinematics, exact vortex phases, world coordinates, target location, capture radius, and task-specific routes
policy_translation: form target-normal velocity and force from normalized body-frame observations, smooth-gate their negative product, and use that gate only to return the course-consensus mean-bend share posteriorly while retaining the established posterior-wave envelope
falsification: reject if transit changes, total mean tangent is not conserved, capture or distance integral worsens materially, v24-class terminal alignment and yaw are lost, load residence migrates without benefit, lateral reflection fails, or either coherent wake view deteriorates

## Lightweight validation after editing

- The required dedicated check runner was invoked, but its pinned
  `gpt-5.4-mini` model is unsupported on this account. Running the immutable
  checks directly gives `PASS` for the guidance materiality check and `PASS`
  for the solver boundary; `candidate_target_policy.jl` is the only solver
  edit. Julia is not installed or discoverable, so the executable
  include/action smoke probe cannot run. No CFD was run.
- Deterministic static checks find one definition of each public policy
  function, resolve every direct `params.FIELD` reference among the fields
  returned by `target_policy_params`, confirm balanced delimiters and a
  nonempty candidate, and find no elapsed time, step count, randomness, file
  I/O, cylinder coordinate, target coordinate, or memorized route input.
- Offline replay of the new load-response release on the sampled v24 trace
  leaves its combined allocation authority exactly zero for all `2,881`
  samples at or beyond `2.10L`. Within the `397` approach samples, corrective
  load activates release on `53.40%`, with mean release `0.2823` and mean
  retained response authority `0.7177`. Focused algebraic probes give zero
  numerical error for both lateral-reflection invariance of normal power and
  conservation of anterior plus posterior mean tangent. These are
  selectivity, symmetry, and contract checks, not evidence for the pending CFD
  outcome.
