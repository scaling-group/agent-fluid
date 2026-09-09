# Multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before editing

- The prefilled response-coupled carrier is executable-identical to sampled
  `solver_a1b6333c00d2`. It captures at `18.66150T`, with scored mean distance
  `2.09362L`, but multiplying the target-lateral amplitude schedule by the
  existing correcting-yaw response gate falls inside the replicated carrier's
  variation and is not an evidenced mechanism improvement.
- All four current solver samples satisfy direct uniform still-water
  `U_infinity=(0,0,0)` initialization, no prewarm or cylinders, finite moving-
  window dynamics, and `termination=capture`. The two geometry-only policies
  differ only in comments and capture at `18.68350T`/`18.75500T`, with mean
  distance `2.09405L`/`2.09542L`; the response-coupled prefill is inside that
  band. The terminal range/velocity compound is weaker at `19.05201T` and
  `2.09874L`. Across the four, acceleration-limit contact remains about
  `60.65--60.94%`/`73.03--73.17%` and rate-limit contact about
  `10.91--11.20%`/`14.75--15.01%`, so none establishes demand relief.
- I inspected the combined sheets for the best sampled scalar result
  (`solver_8687829e1d01`) and the weaker terminal compound
  (`solver_072da2f3a45e`). Their top-down rows show self-propelled,
  target-directed alternating streets; their oblique rows retain compact
  caudal Lambda2 structures through capture. The terminal compound takes a
  larger vertical excursion near the target without a wake-coherence benefit.
- I also inspected the inherited onset-cadence failure
  (`solver_3fc40c59230c`) as the informative failure. Its top-down row bends
  down past the target and finishes nearly vertical while its oblique row
  continues to show compact alternating caudal structures. Metrics agree:
  the speed-triggered shared-frequency boost reaches only `3.17354L`, exits
  left at `29.08952T`, and ends `9.18680L` away. Wake persistence therefore
  does not rescue corrupted route topology.
- The assigned parent log's geometry-frequency relief preserves capture but
  regresses to `19.38750T` and mean distance `2.14184L`; its small reduction in
  acceleration contact is not useful relief. Another inherited completed
  result, response-gated posterior-wave relief, exits left after reaching only
  `3.42595L`. Together these results reject further cadence or posterior-wave
  allocation around this carrier for now. They support recovery to the
  simplest replicated controller: displacement-only half-cycle steering,
  common non-inverting curvature release, geometry-only amplitude scheduling,
  unchanged posterior lag, and final acceleration projection.

## Single-candidate policy hypothesis

Remove only the unsupported coupling between the target-lateral amplitude
schedule and the fast correcting-yaw response gate. Persistent normalized
body-frame target geometry will own the rhythmic envelope again, while the
existing one-sided response gate continues to release mean curvature without
ever changing route sign. No gain, phase relation, curvature allocation, or
actuator boundary changes.

This is a recovery/simplification candidate backed by two executable
replications, not a claim that a sub-repeat score difference is causal. The
formal run should retain capture, the target-directed top-down street, compact
oblique caudal structures, and the established `18.65--18.76T` /
`2.0934--2.0955L` behavior band. Falsify the candidate if it loses capture or
wake coherence, leaves that route band, or changes demand materially; in that
case the apparent geometry-only replication is not robust enough to serve as
the carrier for later architectural tests.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish gait modulation and wake-interaction control
source_mechanism: separate slow persistent route geometry from fast response or disturbance signals while preserving a coupled traveling bend
transferable_invariant: persistent body-frame target geometry may schedule the gait envelope, while fast yaw response should remain a bounded non-inverting release signal rather than acquire a second gait-allocation role
nontransferable_details: published gains, dimensional beat rates, robot morphology, clock phases, species kinematics, exact vortex phases, and task-specific routes
policy_translation: remove correcting-yaw response from the amplitude schedule; retain normalized target lateral fraction as its sole owner and leave the evidenced two-joint curvature gate and posterior phase relation unchanged
falsification: reject if the formal rollout loses capture or either coherent wake view, leaves the replicated arrival and mean-distance band, or materially worsens acceleration/rate contact or planar loads
