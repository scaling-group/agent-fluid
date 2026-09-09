# Wake-policy candidate diagnosis

## Evidence read before editing

All four sampled evaluations report `uniform_direct`, zero background velocity,
no cylinders, and capture. The combined sheets were inspected from release to
capture in both the top-down mid-plane vorticity row and oblique body/Lambda2
row. The fastest sampled carrier governor (`solver_4ba229efefc5`) is visibly
self-propelled: a coherent alternating wake develops from quiescence, follows
the moving fish rather than advecting it, and remains organized through the
broad target-directed arc. Its wake is not visibly destabilized before capture.
The slowest sample (`solver_a860be11e4d6`) retains the same coherent wake and
capture topology; its difference is a later, more curved terminal alignment,
not a flow failure or initialization artifact.

The scalar and trajectory diagnostics sharpen that comparison. The summed
nonnegative-work common governor (`solver_4ba229efefc5`) captures at `17.688T`
with distance integral `1.96419L`, but has the widest sampled head path
(`12.330L`), peak planar force/yaw-moment coefficients `0.03198/0.01651`, and
anterior/posterior residence above 99% joint rate of `12.13/2.02%`. The
joint-wise guard (`solver_a860be11e4d6`) captures at `18.111T`, takes a
`12.281L` path, reduces peak load to `0.02716/0.01414` and 99%-rate residence
to `8.17/0.43%`, but raises sub-`2L` mean absolute yaw to `0.373 rad/T`. The
dominant-joint common guard (`solver_5fc33d6eb58b`) gives the shortest path
(`12.170L`) and lower terminal lateral speed, yet arrives `0.302T` later than
the fastest sample. Thus neither independent clipping nor another scalar rate
threshold is supported. The useful unresolved tradeoff is fast progress versus
route/load/rate headroom while preserving one common traveling-wave scale and
untouched target-conditioned steering.

The inherited step-25/26 worker notes make that formulation boundary explicit:
the intended control invariant was one coupled carrier scale with the steering
residual restored unchanged, while earlier arbitrary or whole-command rate
suppression had regressed. They also require evaluation beyond a scalar score,
including path, rate residence, outward impulse, load, joint margin, and both
wake views. The present proposal keeps that inherited boundary and changes the
observation that requests allocation rather than retuning its rate threshold.

## Candidate hypothesis

Retain the fastest sampled summed-positive-work carrier/steering separation,
capture scaffold, gait, and parameters. Add one controller mechanism: while a
joint is already near the normalized rate envelope, give an unfulfilled
body-frame course redirect priority over rhythmic carrier work. Compute that
priority from the existing bounded velocity-course error and measured signed
yaw response; merge it with the positive carrier-work request before applying
the single common carrier scale. Large course error with little correct-sign
yaw response therefore withdraws carrier acceleration but leaves the steering
residual intact; as the observed turn develops, the carrier is continuously
released. No clock, stage counter, coordinates, new terminal gate, or raw-flow
residual is introduced.

bookshelf_consulted: true
source_domain: biological C-start/burst redirects and sensor-modulated robotic-fish CPG path following
source_mechanism: prioritize bounded curvature during a large direction error, then release into posterior traveling-wave propulsion when the observed heading response appears
transferable_invariant: propulsive rhythm and redirect authority should be allocated by normalized error plus measured response, with the rhythmic two-joint phase relationship preserved
nontransferable_details: species-specific C-start shapes, published CPG gains and frequencies, exact tail-beat phases, and task-specific routes
policy_translation: use body-frame target/velocity course error and signed recent yaw response to augment only the near-rate common carrier guard; preserve the existing target-conditioned two-joint steering residual and posterior lag
falsification: reject if CFD loses capture or coherent wake, fails to beat the `17.688--18.111T` sampled timing class, retains the `12.13%` anterior near-rate residence and `0.03198/0.01651` load peaks without a shorter path, or regresses toward the joint-wise guard's `0.373 rad/T` terminal yaw

This is a prospective hypothesis. The current worker cannot claim its CFD
outcome; evaluation after exit must decide whether redirect-priority carrier
allocation improves the tradeoff.
