# Candidate wake-policy notes

## Evidence and visual diagnosis before editing

- All four sampled evaluations are the required direct-uniform still-water
  experiment (`U_infinity=(0,0,0)`, no cylinders, no prewarm). In both visual
  rows they form a body-connected alternating vorticity street and coherent
  three-dimensional Lambda2 structures through cruise. Their progress is
  therefore self-propelled; the common failure is control-induced turning,
  not advection or wake loss at release.
- `solver_4b6f0dc046cd` is the strongest geometric approach. Full-circle target
  feedback and misalignment-gated drive relief reached `2.319L` at `18.032T`,
  but the sheet then curls upward as both joints pin on the requested side.
  The trajectory confirms `4.152T` with both joints beyond `40 deg`, posterior
  angle-limit occupancy for `6.231T`, and an upper exit at `27.227T`.
- The assigned parent mechanism in `solver_815b9ef451f0` used signed two-joint
  mean bend to release carrier relief. That was a real actuator-health
  improvement: simultaneous `>40 deg` dwell fell to zero and peak planar
  force/moment fell from `0.688/0.289` to `0.488/0.220`. It did not improve the
  task topology: closest approach regressed to `2.664L`, distance then grew to
  `7.699L`, and the fish again exited the upper boundary at `26.287T`.
- The reason is visible and explicit in joint history. From about `19T` to
  `23T`, the anterior joint recovers to roughly `-4..+7 deg`, making mean bend
  look released, while the posterior joint remains at `-45 deg`; its total
  angle-limit occupancy is still `4.856T`. Because the inherited release
  restored only the symmetric carrier and left posterior-emphasized steering
  active, it redistributed two-joint pinning into one-joint tail pinning.
  The current prefill's target-plane hold is also not a solution: it reaches
  only `2.703L` and has `5.351T` of simultaneous `>40 deg` dwell.

## Single candidate hypothesis

Retain the sampled full-circle, phase-compensated traveling-bend controller,
but replace mean-bend carrier-only release with a posterior-bend burst release.
During near, misaligned approach, requested-side posterior bend is the direct
reserve signal because that joint owns the larger steering share and remained
pinned after the mean signal cleared. As it approaches a reserve below the
hard limit, one smooth reflection-equivariant gate both restores the symmetric
carrier and fades the half-cycle steering term. Outside the near/misaligned
burst, the gate is one and the evidenced cruise controller is unchanged.

This is falsified if the posterior joint again dwells near `45 deg`, if the
same post-approach upper curl remains, or if the change loses the parent's
coherent cruise wake. Physical support requires a return arc or better
termination class while retaining at least the assigned parent's `2.664L`
approach; beating `2.319L` or capture is stronger support. Increased rate/action
saturation or force/moment peaks also falsify the actuator-health rationale.

bookshelf_consulted: true
source_domain: biological C-start or burst redirect and sensor-modulated robotic-fish CPG steering
source_mechanism: recruit bounded curvature for large observed target error, then release it from observed maneuver state back into a posteriorly lagged propulsive beat
transferable_invariant: strong curvature is temporary; sufficient requested-side bend must reduce steering authority and restore the traveling carrier
nontransferable_details: species C-start shape, published gains or duration, robot duty ratio, exact vortex phase, dimensional speed, and any task-specific route
policy_translation: in normalized body-frame near/misaligned pursuit, use turn-request times posterior joint angle as a smooth reflection-invariant reserve that fades half-cycle steering and carrier relief; preserve far-field feedback and the two-joint contract
falsification: reject if tail-limit dwell or the upper-exit topology persists, closest approach exceeds 2.664L, cruise wake coherence is lost, or rate, action, force, or moment saturation worsens

## Dry validation only

The prescribed guidance-materiality, lightweight Julia contract, parameter
schema, and editable-boundary checks pass; no CFD was run. A `30,375`-state
grid over joint angles/rates, fore/aft and lateral target geometry, slip, and
yaw response produced finite commands strictly inside the smooth
`30 rad/T^2` envelope and exact left/right reflection (maximum error `0.0`).
For a full turn request, posterior bend reserve is `0.9999999` at neutral bend
and `0.0180` at `40 deg`. These checks establish contract safety, symmetry,
boundedness, and gate semantics only; later CFD must decide every physical
falsifier above.
