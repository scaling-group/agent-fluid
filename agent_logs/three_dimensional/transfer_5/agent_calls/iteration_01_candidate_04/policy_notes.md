# Candidate wake-policy notes

## Prior evidence diagnosis

- The only sampled rollout is the transferred 2D champion
  `solver_24bf67867ea8` (`score=-11.170165`, `termination=left_domain`). It is
  direct uniform still-water initialization (`U_infinity=[0,0,0]`) with no
  prewarm artifact, so the visible motion is self-propelled rather than
  advection.
- Both visual rows show a strong, organized alternating wake and sustained
  translation. The top-down sheet progresses from `12.33L` initially to
  `8.4L` near `11T`, and the oblique Lambda2 row shows a bounded three-
  dimensional vortex chain rather than a numerical instability. Propulsion is
  therefore useful and should be preserved.
- The best finite part of the same rollout reaches `4.780L` near `17.85T`.
  The informative failure part then continues downward until the center is at
  `(12.187,0.798)L`, with final distance `9.709L` and bottom-boundary exit at
  `27.49T`. This agrees with the trajectory and stable (not unstable) score
  diagnostics.
- Target-relative geometry exposes the steering failure before exit. Bearing
  changes from about `-0.20` at `8.26T` to `+0.23` at `13.76T` and `+1.12` at
  closest approach, while heading continues increasing and body-frame lateral
  velocity remains about `-0.28U`. Thus the fish has crossed the target line
  and keeps yawing/slipping away despite a large opposite-side target error.
  The seed already applies posterior mean-curvature and half-cycle steering;
  another propulsion-frequency adjustment would not address this trajectory
  topology.
- The seed's recovery and centerline-rate-brake branches use
  `close_gate = 1 - clamp(distance_L / 2.1, 0, 1)`. Since the sampled rollout
  never enters `2.1L`, those branches are inactive even at its `4.78L` best
  point. The missing redirect must therefore operate in the middle-distance
  regime rather than being another terminal-capture schedule.
- The assigned parent guidance contains no prior 3D result-specific lesson,
  and there are no inherited `logs/optimize` files in this fresh lineage. The
  sampled failed seed is therefore the result evidence for this candidate.

## Policy hypothesis

Preserve the state-feedback traveling-wave drive, target geometry request,
posterior lag, and ordinary steering. Add one response-gated whole-body
redirect mechanism: when normalized body-frame bearing is materially large
and recent yaw still has the wrong sign, smoothly shift the anterior
oscillator equilibrium toward the requested bend and add compatible posterior
curvature. Release the redirect continuously when yaw responds toward the
target or bearing returns toward centerline. This adds a transient C-bend
authority channel that the posterior-only mean-curvature seed lacks, without
using time, coordinates, a route, or a wake phase.

Expected evidence: after the bearing sign change, mean yaw should reverse
before the `4.78L` closest-approach region, the target should return toward the
body centerline, and the coherent propulsive wake should persist. Reject the
mechanism if it produces persistent joint saturation or bang-bang action,
destroys downstream vortex coherence/thrust, causes an earlier boundary exit,
or leaves the same growing-bearing downward trajectory.

bookshelf_consulted: true
source_domain: biological C-start redirect and closed-loop robotic-fish direction tracking
source_mechanism: large observed heading error invokes bounded whole-body curvature and releases when the measured turning response points toward the target
transferable_invariant: separate a transient, response-gated redirect bend from the continuing propulsive rhythm
nontransferable_details: species-specific bend envelopes, published gains and frequencies, exact vortex phases, and source-task routes
policy_translation: use normalized body-frame bearing and recent yaw sign to gate bounded anterior-equilibrium and posterior-curvature offsets within the existing two-joint state-feedback oscillator
falsification: reject if targetward yaw does not begin earlier, if the same bearing-growth and bottom exit remain, or if redirecting collapses propulsion or drives persistent saturation/load spikes
