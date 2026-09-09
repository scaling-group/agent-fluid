# Candidate diagnosis and hypothesis

## Evidence read before the edit

- All four sampled evaluations report direct uniform still-water initialization
  (`U_infinity=[0,0,0]`), no cylinders, finite dynamics, and capture. The
  combined sheets for the executable-identical redistribution repeats
  `solver_649d7e789a5a` and `solver_d2a3f8408b10`, the dormant rearward-route
  variant `solver_bae498322681`, and the broadside-reserve policy
  `solver_de4c121e5685` show genuine self-propulsion: a coherent alternating
  top-down vortex street develops from release and the oblique row retains
  compact caudal Lambda2 structures through target crossing. No sampled sheet
  shows passive advection, wake collapse, collision, or numerical instability.
- The redistribution repeats give the strongest sampled distance integrals:
  capture at `18.8265--18.8815T` with mean distance
  `2.08855--2.08896L`. Their independent repeat agreement is useful, but the
  inherited optimizer records an executable-equivalent `0.81206L` near miss
  followed by a left exit, so this allocation is not yet robust.
- The geometry-scheduled broadside reserve captures sooner at `18.7055T`,
  limits sampled maximum absolute lateral target fraction to `0.6484` rather
  than `0.8873--0.9397`, and keeps acceleration/rate contact inside the same
  approximate `61%/73%` and `11%/15%` bands. Its mean distance is worse at
  `2.09386L`, so it establishes capture compatibility and redirect authority,
  not a scalar improvement.
- The dormant rearward-route multiplier captures at `18.9640T`, but its
  reconstructed forward target fraction remains positive (minimum `0.3541`),
  so the added term never activates and supplies no recovery evidence.
  Inherited score/guidance logs are more decisive: a full simultaneous
  composition of broadside reserve and redistribution retains an energetic
  two-view wake but reaches only `1.90495L` and exits left at `31.1905T`.
  Wake coherence therefore cannot justify stacking both gait modifiers.

## Visual diagnosis

The useful carrier already creates a productive traveling bend and turns toward
the target; the missing capability is not propulsion or basic turn sign. The
late route is sensitive when the target becomes broadside while redistribution
continues to reshape the oscillation envelope. The broadside-only policy
visibly preserves the same wake family and reduces the target-direction
excursion, while the inherited full composition demonstrates destructive
controller interaction despite an apparently healthy wake.

## One-candidate policy hypothesis

Use one smooth, normalized body-frame broadside handoff. Below the evidenced
broadside onset, preserve the sampled redistribution carrier exactly. As the
forward target becomes broadside, continuously fade redistribution out while
fading the already capture-compatible mean-curvature reserve in through the
same gate. At full handoff the policy reduces to the sampled broadside-reserve
architecture rather than their failed sum. Keep target-owned sign,
correcting-yaw release, displacement-only half-cycle steering, posterior lag,
and the final acceleration projection unchanged.

Falsify the mechanism if it loses capture, repeats the left-exit/near-miss
topology, disrupts either wake view, exceeds the sampled load/contact boundary,
or fails to retain either the redistribution mean-distance band or a distinct
reduction in late broadside excursion. A nominal capture inside ordinary
repeat spread without an altered late-route diagnostic is only non-interference.

bookshelf_consulted: true
source_domain: biological burst turning and sensor-modulated robotic-fish CPG control
source_mechanism: large observed direction error receives temporary bounded curvature authority before release back to the propulsive gait
transferable_invariant: allocate redirect authority continuously from current body-frame target misalignment and measured correcting response while preserving the traveling-wave carrier
nontransferable_details: species-specific C-start shape and timing, published CPG gains, dimensional frequencies, exact vortex phase, and any prescribed route
policy_translation: use normalized forward/lateral target fractions to fade half-cycle envelope redistribution out as a bounded broadside mean-curvature reserve fades in; retain two-joint displacement feedback and non-inverting yaw-response release
falsification: reject on lost capture, repeated left exit, wake incoherence, worse contact/load envelope, or no distinct late-route benefit beyond direct-uniform repeat variation
