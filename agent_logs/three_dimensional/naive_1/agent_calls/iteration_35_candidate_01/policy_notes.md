# Step 35 multi-wake target-policy diagnosis and hypothesis

## Evidence read before editing

- All four sampled episodes satisfy the frozen contract: direct-uniform
  initialization in still water with `U_infinity=(0,0,0)`, no cylinders or
  prewarm, finite moving-window transport, and capture termination. The clean
  displacement-phase prefill captures at `18.6010T` with score-defined mean
  distance `2.09042L`. Two executable-identical common-envelope redistribution
  samples capture at `18.8265--18.8815T` and `2.08855--2.08896L`. A third
  redistribution sample adds a rearward route multiplier, but the inherited
  reconstruction keeps its target forward; its `18.9640T`/`2.09072L` result
  establishes non-interference, not exercised recovery.
- I inspected the combined keyframe sheets for the best-integral
  redistribution sample, the clean prefill, and the rearward composition from
  release through capture. Their top-down rows begin in quiescent water and
  develop coherent alternating target-bending vortex streets. Their oblique
  rows retain compact bilateral and caudal Lambda2 structures through first
  crossing. With zero background velocity, the motion is self-propelled; no
  sampled sheet shows collision, wake collapse, domain exit, or instability.
  The sampled batch has no failure-class sheet, so inherited completed misses
  provide the required semantic contrast rather than relabelling a capture as
  a failure.
- Trajectory metrics corroborate the visual equivalence. Across the clean,
  redistribution, and rearward samples, anterior/posterior acceleration
  contact remains about `60.85--61.17%`/`72.95--73.27%`, rate contact about
  `10.88--11.07%`/`14.73--14.96%`, peak planar force `0.03066--0.03259`, and
  peak yaw moment `0.01603--0.01656`. Neither phase-dependent envelope
  redistribution nor the unexercised recovery branch is actuator relief.
- The assigned-parent and sampled optimizer logs show three consecutive
  completed workers selecting the same clean ablation rather than a new
  controller mechanism. Their evidence also closes several tempting branches:
  velocity phase prediction, target-axis observation filtering, posterior-only
  gait allocation, aligned posterior-lag enhancement, rate barriers, terminal
  compounds, and stacked recovery all either lost capture or failed to improve
  route/load semantics. The newly evaluated clean prefill extends that simple
  carrier to a sixth completed capture and broadens its observed class to
  `18.6010--18.9585T` and `2.09042--2.09898L`; it still uses only anterior
  displacement to represent the phase of a two-joint traveling bend.

## Structured bookshelf transfer

bookshelf_consulted: true
source_domain: biological mean-curvature turning and closed-loop robotic-fish asymmetric-flapping control
source_mechanism: synchronize a bounded target-signed turning bend to observed rhythmic body state while retaining a directed posterior-lagged traveling wave
transferable_invariant: use normalized joint displacement, not a clock or exact vortex phase, to apply more target-signed curvature on the useful bend half-cycle without changing the carrier's route sign
nontransferable_details: published gains, dimensional cadence, robot duty ratios, species-specific kinematics and envelopes, exact vortex phases, world coordinates, and task-specific routes
policy_translation: replace the anterior-only phase observation with an equal normalized blend of centered anterior displacement and sign-adjusted centered posterior displacement; preserve body-lateral route sign, non-inverting response release, positive shared bias scale, common geometry-owned amplitude relief, posterior lag, and final acceleration projection
falsification: reject if capture or either coherent wake row is lost, the inherited downward near-miss/left-exit topology recurs, planar loads or limit contact materially exceed the clean-carrier range, or the new phase observation fails to improve route or arrival beyond exact-policy repeat spread

## Exactly one candidate hypothesis

The candidate tests one new feedback mechanism on the clean carrier: a
two-joint traveling-bend phase coordinate. The existing controller times its
positive curvature modulation from centered anterior displacement alone even
though the propulsion invariant is a posterior-lagged two-joint wave. The new
coordinate averages that anterior displacement with the centered posterior
displacement after reversing the posterior carrier's nominal sign. The equal
blend is bounded by the same amplitude normalization and changes only when the
observed joints disagree about beat side; target geometry still owns steering
sign, and the same positive scale is applied to both curvature shares.

Expected result: retain capture and both coherent wake views while making the
steering half-cycle follow the complete traveling bend rather than one joint,
with a route or arrival change outside clean exact-policy repeat spread. This
is a state-feedback architecture test, not scalar-only gain tuning. It adds no
velocity/flow residual, terminal or recovery branch, explicit time, step,
world coordinate, mutable state, or memorized phase. Formal CFD runs only
after handoff, so no outcome is claimed for this unevaluated candidate.
