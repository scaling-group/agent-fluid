# Candidate wake-policy notes

## Evidence and visual diagnosis before editing

- All four sampled rollouts report direct uniform still water with
  `U_infinity=(0,0,0)`, no cylinders, and no prewarm. Their combined sheets
  show body-connected alternating top-down wakes and three-dimensional
  Lambda2 structures, so the trajectories are self-propelled controller
  responses rather than advection or numerical-instability failures.
- The phase-compensated controller without approach scheduling
  `solver_77835bec7423` is the useful scaffold: it escaped the inherited early
  upper-boundary topology, traveled for `27.429T`, and reached `3.174L` before
  passing the target corridor and exiting left. Its coherent compact wake and
  roughly `0.800L/T` mean speed show that the remaining problem was approach
  steering, not propulsion.
- The assigned parent `solver_4b6f0dc046cd` added full-circle target geometry
  and misalignment-gated carrier relief. The top-down row shows a visibly
  tighter downward approach, and the metrics confirm a better `2.319L`
  minimum at `18.032T`, compared with `2.703L`, `3.174L`, and `3.600L` for the
  other samples. Thus full-circle phase-separated steering and conditional
  approach relief are retained.
- The parent did not complete the intended burst release. After closest
  approach, distance grew while the full turn request and relieved carrier
  persisted; both joint angles then stayed at approximately `-45 deg` from
  about `18.7T` through `22T`, both joint rates reached `260 deg/T`, and the
  traveling bend visibly collapsed into a strongly curved body before the
  fish exited the upper boundary at `27.227T`. The strong sample without
  relief retained `34.8/35.1 deg` maximum joint angles but missed farther away.
  This isolates the defect as steering dominance after the requested bend has
  already formed, not insufficient scalar turn authority.
- The inherited logs also rule out broad rate braking: it removed near-limit
  occupancy but reduced mean speed to `0.279L/T`, regressed closest approach
  to `11.643L`, and repeated the early upper exit. The next release therefore
  acts only on the approach carrier trade and uses joint state, leaving the
  far-field carrier, steering request, and action envelope unchanged.

## Single candidate hypothesis

Preserve the parent's target-vector pursuit angle, phase-compensated yaw
residual, shared half-cycle steering, and distance/misalignment approach gate.
Add one joint-state burst-release gate to the approach carrier relief. Signed
mean bend measures how much curvature has already accumulated on the requested
turn side; once it enters a bounded reserve band below the `45 deg` hard limit,
the relief fades and the symmetric traveling-bend carrier returns. The signed
steering channel remains active, so this is not general braking or a turn-off:
it should restore the reverse half-cycle before both joints pin while retaining
the parent's tighter approach.

The candidate is falsified if it does not beat the parent's `2.319L` minimum
or create a clear return arc, if both joints again dwell at the same angle
limit after closest approach, if it loses the coherent pre-approach wake and
translation, or if a better trajectory requires more rate/action saturation.
Capture or a better termination class is semantic support; score alone is not.

bookshelf_consulted: true
source_domain: biological C-start or burst redirect and sensor-modulated robotic-fish CPG steering
source_mechanism: a large observed target error recruits bounded curvature, then observed bend state releases the maneuver back into a posteriorly lagged propulsive beat
transferable_invariant: strong target-directed curvature should be temporary and should restore the traveling-bend carrier once sufficient signed body bend has accumulated
nontransferable_details: species C-start shape, published curvature and gains, maneuver duration, clock phase, robot duty ratio, exact vortex phase, dimensional speed, and any task-specific route
policy_translation: multiply only the normalized distance/misalignment carrier-relief gate by a smooth reflection-invariant reserve computed from turn request times two-joint mean bend; keep full-circle feedback and signed half-cycle steering unchanged
falsification: reject if the parent minimum is not improved, the target-return topology does not appear, same-side angle-limit dwell persists, or pre-approach propulsion, wake coherence, rates, actions, or loads worsen

## Dry validation only

The mandated guidance, lightweight Julia contract, and editable-boundary
checks pass; no CFD was run. A `24,300`-state grid spanning joint state,
target side and fore/aft position, distance, lateral velocity, and yaw response
produced finite commands strictly inside the smooth `30 rad/T^2` envelope and
exact left/right reflection (maximum error `0.0`). At the parent's `2.319L`
closest distance and maximum bearing, the carrier scale is `0.353` at neutral
signed mean bend, `0.676` at the `32 deg` release center, and `0.988` at
`40 deg`; at `12L` it is `0.999996`. These establish boundedness, symmetry,
far-field preservation, and release semantics only. The later CFD evaluation
must decide every physical falsifier above.
