# Candidate wake-policy notes

## Evidence and visual diagnosis before editing

- All four sampled rollouts satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no cylinders, and no prewarm. In every combined sheet,
  the top-down row develops a body-connected alternating vorticity street and
  the oblique row retains coherent three-dimensional Lambda2 structures during
  leftward translation. The fish are self-propelled and numerically stable;
  their shared high route and upper-boundary exit are directional-control
  failures rather than advection or wake collapse.
- The current prefill `solver_1fbf1e40b119` reaches `2.703L` at `17.434T`,
  with its head still high at `(9.086,12.202)L`, then curls upward. Its tail
  spends `8.663T` beyond `40 deg`, both joints do so for `5.344T`, and the
  route exits at `24.518T`. Target-plane carrier hold therefore neither
  captures nor preserves joint reserve.
- The assigned-parent evidence `solver_815b9ef451f0` makes the tightest
  sampled approach (`2.664L` at `18.004T`) and has the lowest sampled peak
  planar force/moment (`0.488/0.220`), but signed mean-bend release still
  leaves the posterior joint beyond `40 deg` for `6.349T` and repeats the high
  left exit. The inherited log's posterior-bend release
  `solver_6acb145d7f64` is a concrete negative result: it cuts tail dwell to
  `0.930T` and simultaneous dwell to `0.017T`, yet worsens closest approach to
  `3.312L` and raises peak planar force/moment to `0.890/0.414`. Another
  instantaneous joint-threshold release would optimize an occupancy proxy,
  not the route.
- The highest scalar sample `solver_ec81137f627b` follows the straightest
  path but reaches only `4.650L`, holds the tail beyond `40 deg` for `5.079T`,
  and exits high at `20.034T`; its joint-angle target-phase correction is not
  a semantic terminal improvement. Across all four trajectories at about
  `14T`, the signed target-to-velocity course mismatch remains a consistent
  `-0.98..-1.18 rad` even though their body headings and joint phases differ.
  This persistent response error is obscured by raw body-relative bearing,
  lateral slip, and beat-correlated yaw terms.

## Single candidate hypothesis

Preserve the evidenced joint-state oscillator, posterior traveling-bend lag,
and bounded shared-joint half-cycle steering. Replace the inherited
bearing/slip/yaw steering construction and failed near-target carrier relief
with one course-response mechanism: compute the signed angular mismatch
between normalized body-frame target and translational-velocity vectors. Both
vectors rotate with the body, so their mismatch rejects instantaneous body-yaw
and joint-phase motion without fitted phase coefficients. Since course is
undefined near rest, blend continuously from full-circle body-frame pursuit as
speed rises. Use the resulting response error for both turn sign and redirect
authority while keeping the symmetric carrier fully active.

Support requires retaining at least the assigned parent's `2.664L` approach
with a visibly lower, target-directed course or producing capture/a better
termination class. The mechanism is falsified if the same upper-exit topology
persists, closest approach exceeds `2.664L`, the alternating wake or leftward
translation degrades, posterior pinning remains, or peak planar force/moment
exceed `0.488/0.220` without a semantic route improvement. The exact
antiparallel target/course case has no cross-product side; it must fall back to
the reflection-equivariant pursuit side rather than embed a fixed turn.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and residual CPG path following
source_mechanism: measured motion-to-goal error modulates a bounded steering channel over a preserved rhythmic carrier
transferable_invariant: directional feedback should act on target-versus-translation course mismatch while leaving the propulsive traveling bend available
nontransferable_details: published gains, robot linkage and oscillator timing, species kinematics, dimensional speeds, exact vortex phases, and task-specific routes
policy_translation: form a reflection-equivariant signed course residual from normalized body-frame target and velocity, blend to full-circle pursuit only where speed cannot define course, and drive bounded two-joint half-cycle steering without carrier relief
falsification: reject if closest approach exceeds 2.664L, the high upper exit persists, coherent propulsion degrades, tail-limit dwell remains, or load peaks worsen without a better trajectory class

## Dry validation only

The prescribed policy contract and parameter schema, guidance materiality,
and editable-boundary checks pass without CFD. A deterministic `40,500`-state
grid over joint angles/rates, target geometry, and body-frame velocity produced
finite commands strictly inside the smooth `30 rad/T^2` envelope and exact
left/right reflection (maximum error `0.0`). Zero-speed, zero-target, and both
antiparallel-course orientations are finite. These checks establish only
contract safety, boundedness, symmetry, and edge-case semantics; the later
formal CFD evaluation alone decides the physical falsifiers above.
