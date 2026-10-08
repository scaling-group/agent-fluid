# Candidate diagnosis and hypothesis

The assigned parent (`solver_d1fa01b2365d`) is a stable capture, not a
propulsion or termination failure.  Its direct-uniform still-water top-down
sheet shows self-propelled S-route translation and an attached alternating
vorticity street from release through the `22.154001T` capture.  The oblique
row independently shows discrete three-dimensional Lambda2 structures through
the approach.  Distance falls from `12.327720L` to `11.299767/8.628953/
6.148319/3.974854/1.859209/0.819874L` at `4/8/12/16/20/22T`, with peak
normalized force/moment `0.030897/0.015839`; there is no visual wake collapse,
passive advection, boundary event, or instability to repair.

The no-new-preview sample (`solver_fb6f1126a48d`) retains the same complete
two-view wake and captures at `22.159500T` with `2.105808L` mean distance and
score `-0.211168`.  Previewing the posterior half-cycle envelope in the
assigned parent narrowly but consistently improves all three task measures to
`22.154001T`, `2.105583L`, and `-0.210952`, while preserving the force/moment
peaks.  In contrast, moving preview only to the anterior redirect gate
(`solver_e02a46416407`) delays capture to `22.285997T` and raises mean distance
to `2.106929L`; its oblique row is blank and cannot provide a separate 3D-wake
claim.  Hydrodynamic-response release (`solver_9617a3ec2e52`) crosses earlier
at `22.093502T` but worsens score to `-0.211397` and leaves only a
`0.000578L` threshold margin.  The reusable signal is therefore predictive
allocation among independently bounded posterior paths, not scalar steering
gain, anterior-gate broadening, or general load-responsive unloading.

Policy hypothesis: retain the parent's carrier, course preview, half-cycle
preview, reactive rudder, terminal relief, and every authority ceiling.
Within the already normalized `8.0--5.5L` proximity envelope, add at most half
a cycle of de-yawed target-line preview only to the convex posterior recovery
allocator.  The early launch remains exactly unchanged; near the target, a
developing target-line error should select the already successful velocity-
quadrature recovery target slightly earlier without stacking posterior angle
amplitude or changing the fixed recovery budget.  Falsify the candidate if it
does not beat the parent boundaries `22.154001T`, `2.105583L`, and
`-0.210952`, or if the complete wake, preterminal route, action/saturation, or
`0.030897/0.015839` force/moment envelope worsens.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and phase-lag or wave-shape turning control
source_mechanism: use sensor feedback to modulate a low-dimensional rhythmic parameter instead of replacing the propulsive rhythm with a raw high-frequency command
transferable_invariant: allocate a bounded existing posterior phase relationship from measured target geometry while preserving the traveling carrier
nontransferable_details: published gains, clock-driven oscillator phases, robot-specific joint envelopes, species kinematics, exact vortex phases, and task-specific routes
policy_translation: use bounded de-yawed body-frame target-line preview and normalized proximity to blend the existing whole-carrier and velocity-quadrature recovery targets without increasing their shared budget
falsification: reject if capture is not earlier with lower mean distance and higher score, or if route, coherent two-view wake, effort, saturation, force, or moment leaves the assigned-parent envelope
