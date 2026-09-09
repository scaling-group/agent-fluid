# Candidate diagnosis and hypothesis

## Evidence diagnosis before editing

- All four sampled rollouts satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no prewarm, finite moving-window transport, and
  `termination=capture`. In the best-scoring assigned parent
  (`solver_649d7e789a5a`), the top-down row develops a coherent alternating
  body-attached street and bends it toward the target; the oblique row keeps
  compact paired Lambda2 structures concentrated near the caudal region through
  first crossing. The worst-scoring current capture (`solver_a1b6333c00d2`)
  has the same useful self-propelled wake and route class, so its small score
  difference is not a wake-topology failure.
- The inherited `solver_8ca2f5d49339` sheet is the informative failure. It is
  also a valid direct-uniform rollout and keeps energetic alternating
  top-down and compact caudal 3D structures, but its posterior-specific
  redirect relief turns the route below and past the target after a
  `3.4260L` closest approach, then exits left at `27.506T` and `7.2511L`.
  Wake coherence therefore establishes propulsion, not correct allocation.
  Preserve the common anterior/posterior carrier, target-signed curvature
  shares, displacement-only beat phase, response release, posterior lag, and
  final projection.
- The assigned parent's common half-cycle envelope redistribution is the only
  new current mechanism and is capture-class. Relative to three baseline or
  response-coupled captures at `18.6505--18.6835T` and mean distance
  `2.09340--2.09405L`, it improves mean distance to `2.08855L`, reaches the
  `10L`, `8L`, `6L`, `4L`, and `2L` thresholds about `0.027--0.068T` earlier,
  and slightly lowers peak planar force/moment. It does not relieve demand:
  anterior/posterior acceleration contact remains `60.85%/73.27%` and rate
  contact `11.07%/14.93%`, within the comparison band.
- The parent's loss is localized to approach. At `2L` it is still `0.044T`
  ahead, but at `1L` it is `0.011--0.050T` behind the three comparisons and
  finally captures at `18.8265T`. Its head path moves from `y=10.121L` at
  `2L` to `y=9.316L` at capture, below the target's `y=9.5L`; normalized
  body-lateral target fraction grows to `0.887` at crossing, versus
  `-0.229` to `-0.054` in the comparisons. Thus the far/middle redistribution
  provides useful progress, but carrying it unchanged through the final two
  body lengths compounds beat-scale steering during capture.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and biological redirect-to-cruise transitions
source_mechanism: continuous sensor-conditioned release from redirect modulation into an unmodified cruise or approach rhythm
transferable_invariant: preserve a useful traveling-wave carrier while smoothly releasing an added rhythmic steering modulation as normalized task geometry enters a distinct approach regime
nontransferable_details: published gains, clock phase, species-specific kinematics, fixed routes, exact vortex phase, dimensional switching distances, and task-specific target coordinates
policy_translation: use normalized head-to-target distance only to smoothstep the sampled half-cycle relief redistribution from full far-field authority to zero near-field authority; leave mean geometry relief, both curvature shares, displacement phase, response release, posterior lag, and projection unchanged
falsification: reject if capture or either coherent wake view is lost, progress through the `2--10L` bands regresses to or behind the baseline band, arrival does not recover beyond parent variability, the final lateral-target swing persists, or demand and load histories materially worsen

## Single-candidate policy hypothesis

Add one bounded approach-release mechanism to the assigned parent. Keep its
full half-cycle relief redistribution for `distance_L >= 3`, smoothly reduce
only that added redistribution over `1 < distance_L < 3`, and return exactly
to the sampled geometry-scheduled carrier at `distance_L <= 1`. Both endpoints
and the smoothstep width are parameter-owned, normalized in body lengths, and
contain no time, world coordinate, target identity, or memorized route.

This isolates the evidenced tradeoff: preserve the parent's earlier
far/middle progress and lower distance integral while preventing its extra
half-cycle envelope allocation from persisting through the final approach.
The candidate is not a scalar-only gain retune and does not add velocity,
force, flow, or yaw authority. Formal CFD occurs after this worker exits.
Accept the mechanism only if it retains capture and both wake rows, preserves
the parent's progress lead above `2L`, and improves the `18.8265T` arrival
without worsening the established demand/load boundary.

## Implementation and non-CFD validation

The candidate adds exactly two parameter-owned normalized boundaries and one
smoothstep gate. The gate is `1` at and above `3L`, `0.5` at `2L`, and `0` at
and below `1L`; it multiplies only `half_cycle_relief_redistribution`. The
assigned parent's carrier is therefore recovered exactly near the target and
preserved exactly far away.

The configured guidance-provenance check, explicit-Julia policy contract, and
solver boundary check all pass. The contract call returns two finite joint
accelerations for the synthetic multi-wake observation, and the schema guard
confirms every direct `params.FIELD` reference is declared. No CFD was run;
the candidate's physical outcome remains a hypothesis for the next evaluator.
