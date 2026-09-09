# Step 40 wake-policy diagnosis

## Evidence read before the edit

- All four sampled solver evaluations satisfy the released experiment
  contract: direct uniform still water at `U_infinity=(0,0,0)`, no cylinders,
  and no prewarm. All capture at `0.74846--0.74986L` after
  `18.2875--18.6560T`; three are exact speed-reserve-baseline runs and the
  fourth is the unsupported-bearing qualifier.
- The best sampled capture, assigned-parent capture, inherited partial-guard
  capture, and both exact LOS-policy outcomes were inspected in their combined
  top-down and oblique sheets. The captures visibly self-propel from release,
  lay down an alternating mid-plane street, and retain bilateral Lambda2
  structures through target crossing. The LOS failure keeps the same active
  traveling wake after its closest pass, turns below the target, and exits the
  lower boundary. This is terminal path geometry, not passive advection,
  carrier collapse, collision, or numerical instability.
- The inherited fixed LOS-rate residual now has mixed exact-byte evidence.
  After its original `0.74605L` capture, one exact replay captured at
  `0.74957L` and `18.8980T`, but a sibling replay passed at `1.59620L` and
  exited at `10.33579L`. The failed replay still approached its minimum at
  about `0.829L/T`, retained its wake, and did not exceed the sampled peak-load
  envelope. Its head/tail action clipping was about `70.25%/71.79%`. This
  makes the mechanism `2/3`, rejects promotion or scalar tuning, and leaves no
  propulsion deficit for a stronger residual to repair.
- The bounded partial outer steering-retention policy has one direct-uniform
  capture at `0.74852L` and `18.29849T`. Its visual wake remains organized;
  head/tail action clipping (`68.80%/70.81%`), speed-limit residence
  (`10.64%/11.33%`), and peak body-force/moment coefficients
  (`0.01495/0.02783/0.01620`) stay within the sampled speed-reserve envelope.
  Unlike the fixed LOS residual, it changes only how much correct-sign
  response may release existing steering when projected pass geometry is
  incompatible, and it has not yet received an exact-policy repeat.

## Candidate hypothesis

Install exactly the evaluated `dogfish3d_partial_outer_intercept_guard_v1`
bytes without tuning or stacking another terminal cue. Preserve raw achieved
course, the response-conditioned inner intercept guard, additive joint shares,
the posterior-lagged traveling bend, and sparse outward-only carrier reserve.
Between `4.0L` and the existing `2.75L` inner-guard boundary, projected-miss
and approach geometry may retain only a bounded fraction of steering that
correct-sign yaw response would otherwise release; the carrier and route
request are unchanged.

This is a reliability test of one state-feedback authority mechanism. Support
requires another capture with both organized wake views and actuator/load
metrics inside the established envelope. Falsify it if the exact repeat misses
or exits, changes far-field closure, weakens the traveling wake, materially
increases clipping, speed residence, force, or moment, or merely reproduces
the fixed-LOS lower branch. No same-worker CFD outcome is claimed.

bookshelf_consulted: true
source_domain: sensor-feedback robotic-fish direction tracking over an independently sustained rhythmic carrier
source_mechanism: continuously modulated steering authority from observed trajectory compatibility and turn response
transferable_invariant: route correction should remain closed-loop and bounded while the propulsive traveling wave stays independently active
nontransferable_details: published gains, dimensional cadence, clocked CPG phase, robot morphology, species-specific kinematics, exact vortex phase, and task-specific routes
policy_translation: use normalized body-frame target/velocity projection and approach alignment to retain a bounded part of two-joint steering before the existing inner guard, without changing the carrier
falsification: reject if exact replay loses capture, keeps the coherent-wake lower-exit topology, weakens either wake, or moves actuator and load metrics outside the repeat-backed envelope

## Non-CFD validation

- The installed candidate is byte-identical to the evaluated partial-retention
  policy (SHA-256
  `1059127f77ddbeac9f8a832d1f922d0d0820a08707327c8fa1799c7ab7467d3f`).
- The required semantic-guidance and parameter-schema check passes after the
  redundant duplicate parent listing in the rendered workspace README was
  removed; the guidance change is material and the transient notes exist.
- Julia 1.12.6 loads the candidate and returns the finite two-joint action
  `(-15.078363043496848, -1.6932057383289447)` for the prescribed contract
  probe. The solver editable-boundary check also passes. No CFD was run.
