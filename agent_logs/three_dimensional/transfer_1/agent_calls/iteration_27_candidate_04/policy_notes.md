# Energy-conditioned axial launch-bridge candidate

## Completed evidence and visual diagnosis before editing

- All four sampled evaluations are finite `capture` episodes initialized
  directly from uniform still water with `U_infinity=(0,0,0)`, no cylinders,
  and no prewarm snapshot.  The assigned axis-selective parent is strongest:
  it captures at `17.75400 T`, score `-0.07917`, and total/observed distance
  integrals `1.96508/1.34990 L`.  The three independently written policies
  that gate the whole posterior launch on axial speed produce byte-identical
  dynamics, capturing at `17.89700 T`, score `-0.08687`, and integrals
  `1.97313/1.35927 L`.
- The sibling's stronger axial interpretation is useful only at launch.  It is
  closer than the parent by `0.0050/0.0195 L` at `2/4 T`, but the parent leads
  by `0.0146/0.0378/0.0720/0.0929/0.0902/0.0909 L` at
  `6/8/10/12/14/16 T`.  Thus applying axial-only release to the entire base
  launch is a completed negative result, while its early lead identifies a
  bounded transient opportunity.
- The assigned parent trades modestly more carrier use for the better route:
  mean/max speed and any-joint acceleration-limit residence are
  `0.71678/0.96031 L/T` and `44.14%`, versus
  `0.71263/0.95549 L/T` and `43.79%` for the reproduced sibling.  Both have
  the same sampled peak absolute normalized lateral force and yaw moment,
  `0.03225/0.01609`, so the parent's gain is not a load-reduction result.
- I inspected the combined parent and sibling sheets from release through
  capture.  Their top-down rows show active self-propulsion along smooth
  target-signed arcs: the compact startup disturbance grows into a coherent
  alternating posterior street without reversal, collision, domain exit, or
  wake collapse.  Both the best parent and one reproduced sibling have
  readable oblique rows with compact alternating Lambda2 structures remaining
  near the caudal wake through capture.  Another sibling's oblique row is a
  black rendering failure and is not used for a 3D comparison.  The similar
  wake topology, equal peak load scale, and different middle-route closure
  identify launch-response allocation rather than a new wake structure as the
  useful mechanism.
- Inherited logs establish why this bridge should be state-localized.  The
  completed phase-even energy governor improved v41 and its reconstructed
  posterior energy rose from roughly `0.25` in the first half beat to about
  `1.0` after `2.5 T`; concentrating authority on outstroke did not improve
  arrival and increased limit residence.  The current completed comparison
  then shows that axial release is beneficial on only the smaller energy
  residual, while applying it route-wide to the base launch loses the
  parent's middle and late lead.

## One-candidate policy hypothesis

Start from the assigned parent and preserve its carrier, route sensing,
target-signed curvature, response release, posterior-energy residual, and
actuator allocation.  Change only the base posterior launch response: blend
from the total-speed gate toward the nonnegative forward-axis gate in
proportion to the already observed posterior wave-energy deficit.  Before the
traveling wave develops, lateral sway therefore cannot prematurely announce
propulsion; as phase-insensitive two-joint wave energy forms, the bridge
vanishes and exactly recovers the parent's validated total-speed base release.
The energy residual remains independently axial-gated.  This adds no elapsed
time, beat-side selection, route identity, mean curvature, or scalar gain
change.

The intended signature is to retain the sibling's `2-4 T` launch lead and the
parent's `6-16 T` route lead: capture before `17.754 T` with total/observed
integrals below `1.96508/1.34990 L`, an organized two-view alternating wake,
and no material increase beyond `0.9603 L/T`, `44.14%`, and
`0.03225/0.01609` maximum speed, acceleration-limit residence, and normalized
force/moment.  Formal CFD occurs only after this worker exits; none of those
intended outcomes is claimed here.

```text
bookshelf_consulted: true
source_domain: Lighthill elongated-body reactive thrust and sensor-modulated robotic-fish CPG amplitude control
source_mechanism: posterior wave development is the relevant propulsive state, so closed-loop amplitude emphasis should use axial response while that wave is underdeveloped and release as observed oscillation forms
transferable_invariant: distinguish an underdeveloped posterior traveling wave from an established gait using reflection-even joint-state energy, and confine axial-only propulsion discrimination to the deficient-wave regime
nontransferable_details: published gains, dimensional frequency or amplitude, species and robot kinematics, full-body envelopes, exact vortex phase, and task-specific routes
policy_translation: blend the base launch response from normalized total body speed toward nonnegative forward body-axis speed only in proportion to the bounded posterior-energy deficit; preserve the parent's axial-gated energy residual and all target-derived mean curvature
falsification: reject if the 2-4T launch lead does not survive, the 6-16T parent lead or capture regresses, posterior saturation becomes persistent, the organized two-view wake degrades, or speed and normalized loads materially exceed the assigned-parent envelope
```

## Evidence boundary

All completed outcomes and visual claims above come from the assigned parent,
sampled solver results, inherited optimizer notes, and inherited durable
guidance.  The candidate below has no same-worker CFD evidence.

## No-CFD implementation audit

- The single candidate is
  `dogfish_target_control_v44_energy_conditioned_axial_launch_bridge`, with
  SHA-256
  `5d8e8f3da4c7072bde3c5f0d694258780f8d38375aec1887d3f0e78e1878a5f9`.
  All `65` distinct direct `params.FIELD` references resolve against the `67`
  fields returned by `target_policy_params()`.
- A synthetic mechanism comparison places the deficient-wave posterior action
  strictly between the assigned parent's total-speed response and the
  whole-launch axial sibling, with the anterior action unchanged.  Once the
  observed posterior wave energy exceeds the deficit threshold, the candidate
  is byte-equal to the assigned parent; it is also byte-equal under pure axial
  motion where total and forward speed coincide.  Tested actions are finite
  and remain inside the componentwise acceleration limit.  This is a
  structural audit, not a closed-loop result.
- The required configured check-runner was invoked, but its pinned
  `gpt-5.4-mini` model is unavailable for this account.  Its material-guidance
  check, lightweight Julia policy contract, and solver editable-boundary
  command were therefore run locally and separately and all pass; the direct
  parameter-schema and synthetic mechanism audits also pass.  No formal CFD
  was run.
