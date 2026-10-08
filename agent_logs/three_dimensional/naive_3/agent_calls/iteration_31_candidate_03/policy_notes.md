# Candidate diagnosis and hypothesis

## Evidence read before editing

- The assigned parent `solver_493935b907b9` captures at `16.96515T`, with
  score `-0.20446593`, mean distance `2.08904L`, peak self-propelled speed
  `1.39186U`, peak local flow `0.03234U`, peak force/yaw moment
  `0.03609/0.01817`, posterior angle magnitude `0.56251 rad`, and joint-speed
  peaks `4.51922/4.52389 rad/T` below the `260 deg/T` stops.
- The repeated bidirectional allocation baseline `solver_260633cea095` and
  `solver_9c72bd94b27c` is deterministic: both capture at `16.98841T`, score
  `-0.20476427`, and mean distance `2.08931L`. This is the informative weaker
  control comparison, rather than a termination failure, because every
  currently sampled rollout captures.
- The strongest finite sample `solver_db2418f56ce7` replaces the parent's
  joint-angle counter-yaw selector with target-signed measured adverse-yaw
  compatibility. It captures at `16.93205T`, improves score to `-0.20004481`
  and mean distance to `2.08513L`, and keeps joint-speed peaks below the stops.
  The tradeoff is posterior angle magnitude `0.59921 rad` and peak force/yaw
  moment `0.03693/0.01835`, both slightly above the assigned parent.
- All inspected diagnostics confirm direct uniform still-water initialization,
  `U_infinity=(0,0,0)`, no cylinders, and moving-window transport. Local flow
  stays below `0.033U` while fish speed reaches about `1.39U`, so the approach
  is self-propelled rather than passive advection.

## Visual diagnosis

The combined sheets for the strongest sample and the repeated baseline were
read from release through capture in both rows. Their top-down mid-plane views
show the same persistent alternating red/blue street and a gently corrected
target-directed route, without a held-joint coast or a late hook. Their oblique
Lambda2 views show compact alternating three-dimensional structures following
the body through the moving window up to the capture sphere. The signed-load
variant does not visibly lose the traveling bend, but its slightly larger
posterior excursion and load peak make indiscriminate extra transfer a poor
next test.

## Policy hypothesis

Start from the evidenced signed adverse-yaw sample. Preserve its oscillator,
posterior lag, acceleration reserve, soft envelope, high-onset speed guard,
base bidirectional transfer, and kinetic posterior angle projection. Separate
the adverse-yaw increment from the base posterior-to-anterior transfer and
give only that increment a plateau-plus-C1 receiver-speed gate: full authority
while the anterior receiver is well below its speed limit, then continuous
withdrawal before the existing receiver ceiling. This translates measured
phase-separated headroom into the residual channel without strengthening the
carrier or altering the already useful base transfer. The current traces put
the anterior receiver below about `0.48` of its speed limit at posterior-donor
events, so a `0.75--0.90` normalized gate should retain the evidenced residual
while remaining inactive as a safety relaxation near a held-out speed event.

Expected result: preserve capture and both wake views, retain zero exact speed
occupancy, and improve or match `16.93205T` / `2.08513L` without exceeding the
sampled `0.5993 rad`, `0.0370` force, or `0.0184` yaw-moment envelope. Falsify
the hypothesis if the residual restores a speed contact, broadens posterior
angle/load beyond those bounds, changes the alternating wake, loses capture,
or cannot distinguish itself from the signed-load parent.

bookshelf_consulted: true
source_domain: coupled-oscillator robotic-fish control and reactive two-joint swimming
source_mechanism: sensor-modulated residual work applied without replacing the traveling posterior wave
transferable_invariant: preserve rhythmic phase and allocate only unavailable work to an actuator with normalized instantaneous headroom
nontransferable_details: published CPG gains, species kinematics, dimensional beat settings, exact vortex phase, and task-specific routes
policy_translation: isolate the target-signed adverse-yaw increment and withdraw it smoothly only as anterior receiver speed approaches its normalized ceiling
falsification: reject if capture or coherent shedding is lost, a joint speed stop returns, or posterior angle and load exceed the sampled signed-load envelope
