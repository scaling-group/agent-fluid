# Candidate diagnosis and policy hypothesis

## Evidence read before the policy edit

- All four sampled rollouts are valid direct-uniform still-water evaluations
  with `U_infinity=(0,0,0)`, no prewarm, no cylinders, and moving-window
  transport active. All capture from `12.32772L`. The assigned v22 parent
  captures at `25.11302T` with score `-0.53006032` and mean distance
  `2.430636L`.
- I inspected the combined top-down vorticity and oblique body/Lambda2 sheets
  for the assigned parent, the best sampled result, and the inherited
  `51.64503T` low-drive counterexample. The parent shows self-propulsion on one
  compact target-directed arc, an organized alternating posterior wake, and
  finite three-dimensional shed structures through terminal straightening.
  The counterexample retains an early wake but turns past the target into a
  broad loop before eventual capture (score `-1.19739`), so generic terminal
  drive relief is not supported. The best result's first two oblique panels
  are blank; I therefore use its trajectory/loads and later finite panels, not
  those missing panels, to compare terminal mechanisms. Its outer controller
  is unchanged from the fully rendered parent.
- Two different response-conditioned descendants materially and reproducibly
  improve v22 without changing the outer architecture. Phase-selective
  departure reallocation (`solver_6a46e49f8216`) captures at `25.11302T`,
  improves mean distance to `2.429298L`, and scores `-0.52837563`.
  Equilibrium-error carrier recovery (`solver_89a97c83567b`) captures at
  `25.11852T`, improves mean distance to `2.429294L`, and is marginally best at
  `-0.52833877`. Both finish with small commands and coherent later oblique
  structures. These results support response-conditioned allocation but do
  not support another range-preview gain change.
- The two mechanisms describe complementary response regimes. Positive
  `(q-q_target)*q_dot` detects a carrier half-cycle moving away from the
  requested bend while it is forming; normalized equilibrium error detects
  when that bend has settled enough to recover carrier. Their evaluated gains
  can be combined without copying source-domain kinematics or introducing a
  clock, route, or world-frame cue.

## Policy hypothesis

Start from the evaluated v22 closure-previewed controller and retain every
outer propulsion, target geometry, preview, and curvature parameter. Form one
response-partitioned terminal allocator:

1. Normalize maximum two-joint equilibrium error by carrier amplitude.
2. While that error is large, use the evaluated positive curvature-error
   growth pressure to advance reallocation only during the partial closure
   blend.
3. As the equilibrium settles, continuously turn that phase boost off and
   recover the evaluated bounded posterior-lag carrier fraction around the
   same target-relative mean bend.

This should inherit v6a's protection against the destructive transition
half-cycle and v89's useful settled propulsion, while the smooth tracking-error
partition prevents the two mechanisms from demanding conflicting allocation.
Expected evidence is an unchanged outer path/wake, capture near `25.11T`, mean
distance no worse than `2.42930L`, finite low-load terminal motion, and no
joint-stop dwell. Reject the combination if it changes commands before the
closure gate activates, delays or loses capture, raises terminal clipping or
loads, or recreates the broad low-drive loop.

bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping and biological C-start release into rhythmic propulsion
source_mechanism: use observed joint phase to suppress a turn-opposing half-cycle, then release strong curvature control into posterior-lag propulsion when the requested bend has formed
transferable_invariant: separate target-relative mean curvature from the traveling carrier and partition their allocation continuously by observed curvature-error direction and settling, not elapsed time
nontransferable_details: published gains, dimensional cadence, duty ratios, species-specific C-start envelopes, exact vortex phases, full-body waveforms, and task-specific routes
policy_translation: normalized two-joint tracking error selects between positive curvature-error-growth reallocation during the partial closure blend and bounded carrier recovery around the same body-frame target curvature after settling
falsification: reject if pre-terminal commands change, the outer wake or compact arc changes, capture is delayed or lost, terminal saturation or load spikes return, or the partition behaves like broad drive relief and produces a loop

The new CFD result is not available to this worker and is not claimed here.

