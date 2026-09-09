# Candidate diagnosis: stress-gated helpful-moment relief

## Evidence read before the policy edit

- All four sampled evaluations report `uniform_direct` initialization,
  `U_infinity=(0,0,0)`, no prewarm snapshot, finite dynamics, and capture.
  Thus this sample has no failed termination to contrast; the informative
  contrast is the fastest/lowest-distance-integral capture against the
  slower or higher-load actuator ablations.
- In every combined keyframe sheet, the top-down row shows a body-attached,
  alternating red/blue vortex chain from release through capture. The oblique
  Lambda2 row confirms a compact three-dimensional alternating wake behind
  the moving body rather than a stationary structure advecting the fish.
  The route curves smoothly toward the target, with no visible wake collapse,
  wasteful lateral excursion, collision precursor, or boundary approach.
- `solver_0288c0d51d57`, the prefilled helpful-moment relief policy, captures
  at `18.6560T`, has mean distance `2.02115L`, action-limit occupancy
  `40.74%/75.74%`, and force/moment RMS about `0.01328/0.00691` after using
  vector force magnitude. The identical actuator-consistent baseline hash in
  `solver_8c5ed84c4bcd` and `solver_e6174a15bb9d` captures at `18.6725T` and
  `18.7385T`, with occupancy `42.15%/76.11%` and `40.53%/75.58%` and
  force/moment RMS about `0.01350/0.00703` and `0.01327/0.00691`.
  Consequently the `0.0165T` timing edge over the faster repeat is below the
  `0.0660T` same-policy spread and cannot establish a robust gain effect.
- The more invasive phase-demodulated moment residual in
  `solver_e85ca9b86253` lowers posterior occupancy to `74.14%` and
  force/moment RMS to about `0.01309/0.00682`, but captures later at
  `18.7165T`. Its top-down and oblique wakes remain coherent, so that tradeoff
  is an allocator/route effect, not propulsion failure. The inherited parent
  logs add captures at scores `-0.13364` and `-0.16256`; taken with the sample,
  they support preserving semantic capture rather than chasing small raw-score
  differences with broader raw-moment feedback.

## Policy hypothesis

Preserve the evaluated normalized body-frame bearing plus LOS-rate route,
anterior C-bend, traveling-wave carrier, posterior mean curvature, and
persistent same-side phase recruitment exactly. Restrict the prefilled
helpful-moment amplitude relief to intervals where predicted posterior demand
is near the acceleration envelope *and* the previous feasible action remains
on the same side. This uses the already evaluated `phase_activation` as an
actuator-stress gate. Below stress, the candidate is exactly the prefilled
route controller; under persistent stress, aligned physical yaw response may
relieve only redundant half-cycle amplitude, never the carrier, mean route
correction, or coefficient-norm-preserving phase path.

Expected test: retain capture and an arrival inside the inherited
`18.656--18.7385T` replication band while not exceeding the prefilled
`40.74%/75.74%` occupancy or `0.01328/0.00691` force/moment RMS. Falsify the
mechanism if capture is lost, arrival leaves that band, either load bound is
exceeded, the alternating wake weakens, or relief fails to act during clipped
same-side posterior demand. A later worker should then revert the stress gate
or test a genuinely beat-history allocator, not scalar-tune raw moment gains.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG and residual CPG/path-following control
source_mechanism: sensor feedback modulates a bounded residual steering channel while the rhythmic locomotion scaffold remains intact
transferable_invariant: preserve a productive traveling wave and recruit only the smallest observed-response correction needed after route and actuator-state feedback agree that redundant authority exists
nontransferable_details: published oscillator gains, species-specific kinematics, exact vortex phase, dimensional frequency, and task-specific routes
policy_translation: normalized body-frame LOS feedback retains route control; joint state, predicted feasible posterior acceleration, previous feasible action, and reflection-equivariant yaw-moment alignment gate relief of only the half-cycle amplitude residual
falsification: reject if capture or wake coherence is lost, arrival leaves the sampled replication band, load or limit occupancy exceeds the prefilled bounds, or the gate does not concentrate relief in persistent near-limit posterior demand
