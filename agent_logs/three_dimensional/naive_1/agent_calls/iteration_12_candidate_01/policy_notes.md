# Wake-policy diagnosis and candidate hypothesis

## Evidence diagnosis

- All four sampled rollouts satisfy the experiment contract: direct uniform
  still-water initialization at `U_infinity=(0,0,0)`, no cylinders, finite
  moving-window motion, and `capture` termination.
- In both rows of every combined keyframe sheet, the fish is visibly
  self-propelled rather than advected: a target-directed alternating
  top-down street grows behind the tail, while compact paired oblique
  Lambda2 structures remain caudally concentrated. The street stays coherent
  through release, the broad redirect, and capture; no sampled composition
  shows wake breakup or a distinct failure topology immediately before
  termination.
- The four trajectories are much closer in physical behavior than their
  optional terminal additions suggest. All capture in `18.881--19.052T` with
  mean distance `2.0987--2.1154L`. In the matched lateral-velocity pair, the
  carrier without half-cycle redistribution captures at `19.019T` and mean
  distance `2.1154L`, while adding half-cycle steering reaches at `19.008T`
  and `2.0999L`. The half-cycle policy without velocity lead captures at
  `18.881T` and `2.1023L`, while the version with added `20%`
  approach-amplitude relief captures at `19.052T` and `2.0987L`. This supports
  the common half-cycle mechanism's route-integral benefit but does not
  attribute an improvement to velocity lead or range relief.
- Demand also fails to separate the compositions. Public acceleration is
  projected at `31.416 rad/T^2` in every sample and contacts that projection
  on roughly `60.7--61.5%` of anterior and `72.0--73.4%` of posterior rows;
  both joints still contact the rate envelope. Thus the sampled evidence
  supports preserving projection and the phase-compatible carrier, not
  stacking another terminal scalar schedule.
- The inherited step-11 logs add two `left_domain` outcomes with closest
  approaches of `2.927L` and `3.569L`, while the assigned parent's durable
  lesson already identifies added response qualification as non-improving.
  Those scalar-only failure records are useful as a warning against extra
  qualifiers, but lack sampled keyframes and policies, so they do not support
  a more specific causal claim.

## Policy hypothesis

Produce one clean ablation of the sampled half-cycle mechanism. Preserve the
projected Van der Pol traveling-bend carrier, posterior lag, target-owned
differential mean-curvature sign, and positive joint-state half-cycle scale.
Remove the terminal lateral-velocity residual and the yaw-response release
gate entirely, so normalized body-frame target geometry is the sole route
request and observed joint displacement is the sole within-beat modulation.
This tests whether the half-cycle mechanism itself accounts for the new route
band without confounding instantaneous motion qualifiers.

Expected result: retain a coherent target-directed top-down street, compact
caudal 3D structures, and capture within the sampled `18.881--19.052T` and
`2.0987--2.1154L` band. Falsify the ablation if it loses capture, returns to a
domain-exit topology, reverses the target-owned turn, breaks either wake view,
or materially worsens the route/demand band. Because the response gate can
release at most `35%` of curvature and does not own sign, a modest route shift
without semantic regression remains an interpretable isolation result; it is
not evidence of efficiency unless saturation or loads also improve.

bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping and mean-curvature turning
source_mechanism: infer beat side from oscillator state and bias the useful half-cycle while preserving a traveling posterior-lagged wave
transferable_invariant: persistent target geometry should own turn sign, while bounded observed beat phase redistributes steering without replacing the propulsive wave
nontransferable_details: published gains, dimensional beat frequencies, species-specific envelopes, clock-driven CPG phase, exact wake phase, and source-task routes
policy_translation: map `target_body_L[2] / distance_L` to bounded differential curvature and use centered anterior joint displacement to apply one positive half-cycle scale to both curvature shares
falsification: reject if capture is lost, the turn sign changes, either coherent wake view degrades, or route and demand leave the sampled capture band
