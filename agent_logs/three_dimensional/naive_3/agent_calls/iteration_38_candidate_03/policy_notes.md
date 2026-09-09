# Candidate diagnosis and hypothesis

The assigned parent is `solver_fbea116ed491`, the prefilled posterior
turn-response modulation of the phase-balanced carrier.  It is finite to the
`100T` horizon but misses at `2.439L`, with `3.861/3.310L` mean/final distance.
The inherited parent log also records a much closer `1.444L` result for
`solver_6cc2def4d35e`, so the lineage has previously reached the terminal
region even though none of the four current samples captures.

All four sampled evaluations satisfy direct uniform still-water initialization
with `U_infinity=(0,0,0)` and no prewarm.  In both rows of the combined visual
sheets, the fish self-propels and sheds a coherent alternating 3D wake, then
executes a broad repeated loop around the target rather than an inward terminal
intercept.  This is not passive advection or a wake-collapse failure.  At the
sampled minima, speed remains about `0.677--0.681U`, course error is
`1.698--1.704 rad`, course dot is slightly receding (`-0.127-- -0.133`), and
yaw is only `-0.253-- -0.269 rad/T`.  Thus yaw nearly follows the rotating
target ray while the course remains tangential.  The assigned parent and the
sampled posterior-energy variant reach their minima with a quiet common C-bend;
inside `2.5L` their mean absolute anterior velocity is only about
`0.003--0.005 rad/T`.  The sampled joint-state unbend is the closest current
failure (`2.215L`) but still retains the same broad loop, while fixed-sign wave
restart reaches only `2.369L`.  Together with inherited guidance, this rejects
another posterior residual, independent posterior energy injection, static
bend shift, fixed-sign restart, or scalar drive/curvature retuning.

Policy hypothesis: restore the evidenced symmetric, anterior phase-balanced
energy carrier without either sampled posterior add-on.  Add one new actuator
role only in the terminal course hold: compute the body yaw-rate deficit from
the normalized target ray, translational course, distance, and measured yaw;
apply a bounded requested-sign acceleration at the anterior joint, and release
it continuously when measured yaw catches the course-closing request.  Unlike
the failed constant restart, this term has an observed response release and
acts while the moving carrier is active.  It should increase inward curvature
near the inherited `1.175--1.444L` terminal approaches without changing the
first pass or prescribing a route.  Falsify it if the first return changes,
the same quiet bend persists, yaw/load limits worsen, the orbit broadens, or
closest approach, residence inside `1.25L`, and final distance fail to improve.

bookshelf_consulted: true
source_domain: biological fast-start turning and closed-loop robotic-fish CPG modulation
source_mechanism: response-released C-start curvature burst superposed on a propulsive rhythm
transferable_invariant: strong redirection should be bounded by observed error and released by observed turning response while the traveling wave remains available
nontransferable_details: species kinematics, published gains, dimensional burst timing, exact body-wave phase, and task-specific routes
policy_translation: terminal body-frame target-ray/course error defines a desired yaw rate; measured yaw deficit adds bounded requested-sign anterior acceleration and releases it as the response appears, with no clock or hidden stage
falsification: reject if cruise changes, active terminal motion collapses, the loop or wake broadens, loads rise materially, or minimum distance and near-target residence do not improve

## Non-CFD controller checks

The deterministic parameter-schema audit finds `52` fields and `52` direct
references, with no missing or unused active field.  The lightweight policy
contract and lateral reflection test pass with finite actions.  On a
reconstructed assigned-parent minimum at `2.439L`, the candidate changes the
anterior action by only `-0.063 rad/T^2` and leaves the posterior action equal
to numerical precision, supporting first-return locality.  On a representative
`1.241L` inherited course-hold near miss, the response-released anterior delta
is `-3.059 rad/T^2`; the resulting anterior action remains `-11.342 rad/T^2`,
well inside the policy's `28 rad/T^2` command clamp, while the posterior delta
is only `0.012 rad/T^2`.  These frozen-state checks establish boundedness,
actuator separation, and sign symmetry only; they do not predict the pending
coupled CFD result.
