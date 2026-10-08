# Coupled traveling-wave acceleration-envelope candidate

## Evidence diagnosis before the policy edit

- All four sampled solvers satisfy the frozen contract: direct uniform
  initialization in still water with `U_infinity=(0,0,0)`, no cylinders or
  prewarm, active moving-window transport, finite dynamics, and capture. The
  policies are behaviorally identical (three are byte-identical and the fourth
  changes only comments/version text) and reproduce score `-0.5283387731`,
  capture at `25.1185226 T`, and mean/final distance
  `2.429293780/0.746410191 L`.
- I inspected the complete combined sheets for the strongest sampled baseline
  (`solver_b79884a946b7`) and the informative weaker body-alignment release
  inherited from `optimizer_06a0dc4e972b`, including the top-down mid-plane
  vorticity row and oblique body/Lambda2 row from release through capture. Both
  show self-propulsion along the same compact target-directed arc, a coherent
  alternating three-dimensional posterior wake through the outer approach,
  and a smooth C-bend handoff into capture with no collision, boundary-exit
  precursor, terminal flailing, or instability. Their visual equivalence is
  consistent with a terminal allocation regression rather than wake loss.
- The assigned parent and inherited completed variants provide a consistent
  negative terminal result. Direction-aware release, shared yaw-response
  curvature, body-alignment-confirmed release, productive-crossflow relief,
  and zero-sum anterior curvature redistribution all retain capture but score
  between `-0.528581` and `-0.530398`, versus `-0.528339` for the coordinated
  parent. Their terminal-hold distance integrals increase because they cross
  no deeper than `0.746666--0.748574 L`; even the variants with slightly lower
  observed distance integrals lose that advantage at the crossing. This
  rejects another terminal curvature, joint-role, course, or carrier-release
  gate in this candidate.
- A distinct active defect remains outside `4 L`. The parent independently
  clips `51.6%` of anterior and `40.7%` of posterior commands above
  `30 rad/T^2`; for `39.5%` of outer samples exactly one joint is clipped
  (`25.2%` anterior-only and `14.3%` posterior-only). Thus the nominal
  state-feedback traveling carrier is repeatedly projected component by
  component, changing its two-joint acceleration direction and relative wave
  allocation even though the visible wake stays coherent. Inside `4 L`, no
  command exceeds `30 rad/T^2`, so the validated terminal mechanism does not
  need a new allocator.

## Policy hypothesis

Preserve every target-geometry, closure-preview, terminal-equilibrium, and
response-release calculation. Replace only the final independent two-joint
acceleration clipping with a homothetic projection: when the raw command pair
exceeds the declared per-joint envelope, multiply both commands by the same
bounded factor so the pair fits while its direction and sign pattern remain
unchanged. Below the envelope the mapping is exactly the parent policy. This
is an actuator-allocation mechanism, not a new carrier gain or a copied gait.

Expected evidence is an equally coherent but less clipping-distorted traveling
wave, preserved correct-sign outer target motion, and capture with improved
distance integral or crossing depth. Reject it if the compact path or wake is
lost, capture is delayed or lost, propulsion falls materially, independent
clipping simply reappears downstream, or force/moment and joint-stop behavior
worsen. Because the gate is the observed raw command norm, it is active on the
sampled trajectory and requires no clock, route, target identity, or world
coordinate.

bookshelf_consulted: true
source_domain: state-feedback robotic-fish CPG control and Lighthill-style traveling-wave propulsion under limited actuation
source_mechanism: retain coordinated inter-joint waveform structure when a bounded rhythmic command meets actuator limits
transferable_invariant: a proven traveling carrier depends on the relative direction and lag of the two-joint command, so constraint handling should preserve that coordination instead of clipping one component independently
nontransferable_details: published CPG gains, oscillator phase, dimensional frequency, species-specific amplitude envelopes, full-body kinematics, exact vortex phases, and task-specific routes
policy_translation: project the final normalized body-frame two-joint acceleration pair into the existing declared envelope with one common state-dependent scale, while leaving all target-relative feedback and terminal allocation unchanged below the limit
falsification: reject if outer progress, compact capture, wake coherence, or crossing depth regresses, or if joint stops and force/moment spikes increase despite removal of componentwise clipping distortion

The new CFD evaluation occurs only after this worker exits and is not claimed
as evidence here.

## Non-CFD implementation audit

- The required guidance-delta check and solver boundary check pass. The
  lightweight Julia contract returns two finite commands, and the deterministic
  schema scan resolves all `68` direct `params.FIELD` references in the
  returned `69`-field parameter object.
- Synthetic comparison with the sampled parent is command-exact for an
  unsaturated outer state and for a fully active `0.8 L` terminal state. In an
  anterior-only-clipped outer state, the parent command
  `(-30.5433, 3.5937)` becomes `(-30.5433, 1.70235) rad/T^2`: the limiting
  component and its sign are preserved while the other component receives the
  same raw-pair scale. This establishes bounded activation, below-envelope
  noninterference, and exact recovery of the evaluated terminal parent only;
  it does not establish a coupled-flow improvement.
