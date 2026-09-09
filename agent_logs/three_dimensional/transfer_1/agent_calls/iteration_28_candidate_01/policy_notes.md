# Candidate diagnosis and policy hypothesis

## Evidence read before editing

- All four sampled evaluations and the inherited optimizer failures use direct
  uniform still-water initialization with `U_infinity=(0,0,0)`, no cylinders,
  and no prewarm. The observed translation and wakes are released-swimmer
  behavior rather than ambient advection or stored-flow initialization.
- I inspected both rows of the combined sheets for the best-scoring sampled
  capture (`solver_6b0e320e2f55`) and the informative inherited target-bearing
  recovery failure (`solver_75af5e6ee82e`). The sampled capture lays down a
  persistent alternating top-down vortex street and compact bilateral oblique
  Lambda2 structures through contact. The failure retains the same active
  traveling wake after closest pass, but turns onto the lower branch and exits
  at `1.8004L` minimum and `10.1819L` final distance. This is terminal path
  geometry, not passive advection, carrier collapse, or instability.
- The four current samples all capture at `0.7480--0.7494L` after
  `18.20--18.75T`, but they do not support equal conclusions. Two are the same
  exact-byte speed-reserve baseline, whose inherited record includes lower
  exits; the posterior pulse already has an inherited failed replay; and the
  unsafe-terminal anterior-transfer mechanism has only its first completed
  outcome. Its `0.7492L` capture at `18.7495T` is therefore a mechanism
  demonstration requiring an exact repeat, not evidence of robust success.
- The anterior-transfer capture preserves terminal speed (`0.833L/T`), action
  clamp fractions (`68.8%/70.8%`), exact speed-limit residence
  (`10.7%/11.6%`), maximum force coefficient (`0.0310`), and maximum yaw-moment
  coefficient (`0.0159`) within the two sampled baseline-capture envelope. Its
  two visual rows also retain the baseline's coherent active wake. Thus the
  new spatial allocation did not buy contact by suppressing propulsion or
  leaving the evaluated actuator/load regime.
- Inherited logs already falsify phase-sway course compensation (`1.5445L`),
  target-bearing recovery (`1.8004L`), full-band interception release,
  posterior pulse robustness, and unchanged baseline robustness. Stacking any
  of those onto the single positive allocation result would prevent a clean
  test of whether spatial steering/propulsion role separation survives
  rollout variability.

## Exactly one candidate hypothesis

Submit an exact-policy repeat of
`dogfish3d_unsafe_intercept_anterior_transfer_v1`. Relative to the prefilled
speed-reserve baseline, this is one bounded spatial allocation mechanism:
inside the existing terminal band, while raw body-frame target/velocity
projection is not capture-compatible, transfer a fixed share of additive
steering from the posterior propulsive joint to the anterior joint while
keeping their total steering share constant. Smoothly return to the evaluated
allocation as the projected intercept becomes compatible. Preserve the
carrier, cadence, posterior lag, route observation, interception guard,
steering magnitude, and conditional outward-carrier reserve exactly.

This is deliberately an exact repeat rather than a scalar adjustment or a
new stacked residual. Expected test: retain the organized two-view wake,
far-field closure, and capture-speed/load envelope while establishing whether
the first spatial-allocation capture repeats. Falsify the mechanism if this
same policy misses, weakens either wake view, changes the miss side, or moves
clipping, speed-limit residence, force, or moment outside the sampled
speed-reserve envelope. A second capture would support further repeats; it
would not by itself prove robustness or justify increasing the transfer.

bookshelf_consulted: true
source_domain: classical elongated-body propulsion and robotic-fish turning
source_mechanism: use anterior bending for target redirection while preserving a posteriorly lagged traveling wave for reactive thrust
transferable_invariant: separate spatial steering and propulsion roles without suppressing the rhythmic traveling bend, and release redirection from observed target-relative response
nontransferable_details: published gains, dimensional cadence, species or robot kinematics, explicit oscillator or vortex phase, task coordinates, and memorized routes
policy_translation: use normalized body-frame projected-miss and approach gates to transfer only unsafe-terminal additive steering from the posterior joint to the anterior joint while preserving total steering authority and the joint-state carrier
falsification: reject if the exact repeat loses capture, changes the miss side, weakens either wake view, alters far-field closure, or leaves the evaluated actuator and load envelope
