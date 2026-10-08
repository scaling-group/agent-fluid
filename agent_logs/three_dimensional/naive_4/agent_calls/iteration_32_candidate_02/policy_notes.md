# Candidate diagnosis: reactive-load phase lead

## Evidence read before the edit

- All four sampled evaluations used direct uniform still-water initialization
  (`U_infinity=[0,0,0]`), had no cylinders, remained finite, and captured in
  2867 steps at `15.768509T` with 232 moving-window shifts. Three distinct
  policy hashes produced byte-identical trajectories and combined wake sheets
  at score `-0.041674176`, final distance `0.745720L`, and distance integral
  `1.924067L`. The raw-net-line-of-sight contrast changed only the terminal
  crossing (`0.745725L`, `1.924071L`, `-0.041679331`) and did not change the
  termination step or visual topology.
- In both the best sampled sheet and the slight terminal regression, the
  top-down row develops a strong alternating reverse-street-like wake by
  `4T`, keeps organized lateral pairs through `8T` and `12T`, and turns the
  body smoothly toward the target. The oblique Lambda2 row confirms compact
  three-dimensional structures shed on alternating sides rather than passive
  advection or a planar rendering artifact. There is no collision, exit, or
  wake collapse before capture. The direct-uniform `t=0` panels contain no
  prewarm wake.
- Cross-checking the best trace shows bounded joint excursions
  (`26.28/34.73 deg`) and a coherent path, but substantial command limiting
  (`48.83%/23.58%` exact acceleration-limit residence) and peaks of
  `|Fy|=0.03329` and `|Mz|=0.01895`. Thus a new broad curvature or amplitude
  increase is poorly supported; a response-local allocation inside the
  existing posterior envelope is the safer distinct test.
- Relative to the inherited speed-gated posterior emphasis
  (`15.977511T`, distance integral `1.928581L`, score `-0.045506`), the sampled
  axial-force allocation advanced capture by `0.209002T`, reduced the distance
  integral by `0.004514L`, and improved score by `0.003832`, despite a slightly
  less central final crossing. This supports measured response selection over
  unconditional low-speed emphasis.
- On the best trace, the reflection-even quantity
  `max(-Fy * posterior_wave_rate/(omega*amplitude), 0)` has a low-speed 90th
  percentile of `0.002924`. It is weakly related to simultaneous positive
  axial force but correlates about `0.70` with positive axial force roughly
  `0.08T` later. With a `0.003` full-response scale, its smooth gate adds
  eligibility on 193 of the 669 low-speed samples, rather than restoring the
  unconditional speed gate.

## Policy hypothesis

Preserve the complete captured carrier, steering, approach, terminal-slip,
and direct axial-response branches. Add one posterior reactive-load phase-lead
selector: when measured body-frame lateral force opposes the instantaneous
velocity of the lagged posterior wave target, let that response open the same
already bounded boosted endpoint slightly before axial thrust appears. Use the
maximum of this selector and the proven axial-force selector; never add their
authorities. The existing minimum-magnitude endpoint guard remains, so the new
branch cannot command more than the evaluated boosted controller.

This is falsified if CFD delays the `8/6/4/2L` milestones, loses capture or
wake coherence, increases posterior limiting or force/moment peaks without a
route benefit, or remains trajectory-equivalent. A useful result should retain
the termination class while advancing early/middle distance progress or
reducing the distance integral; command-effort reduction alone is insufficient.

bookshelf_consulted: true
source_domain: Lighthill elongated-body reactive swimming theory
source_mechanism: posterior lateral kinematics create a phase-related reactive load that can contribute to axial thrust
transferable_invariant: reinforce a traveling posterior bend only when normalized measured lateral reaction supports its current wave direction
nontransferable_details: published gains, dimensional frequencies, species envelopes, exact tail-tip kinematics, vortex phase, and task route
policy_translation: form a reflection-even gate from body-frame lateral force times the normalized state-derived posterior-target velocity, then use it only to select between the existing bounded base and boosted joint-2 accelerations
falsification: reject if the new selector loses capture or coherent two-view shedding, delays distance milestones, raises limiting or load peaks without route benefit, or produces no feasible-action difference
