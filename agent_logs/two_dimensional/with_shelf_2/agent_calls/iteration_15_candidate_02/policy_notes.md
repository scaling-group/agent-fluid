# Multi-wake policy candidate notes

## Evidence diagnosis before the edit

- The shared prewarm sheets are byte-identical and show the same held fish at
  the upper-right release while four developed, interacting vortex streets
  occupy the target corridor. They establish a common initial condition, not a
  candidate-specific wake phase or route.
- All four sampled released episodes reach the target; there is no sampled
  failure sheet. Their useful topology is a zero-centered traveling bend with
  self-propelled diagonal motion down and upstream, followed by one broad turn
  through the merged wakes into capture. Mean body velocity x near `-0.2415`
  exceeds mean local-flow x magnitude near `-0.177`, and head displacement is
  about `-10.96L`, so the transit is not passive advection. The three strongest
  sheets and policy files are byte-identical; the fourth sheet has the same
  visible topology and differs only in the terminal response scheduler.
- Without the terminal time-to-go cap, the strongest prior allocator reaches
  at `45.2595` with mean/final distance `1.71529/0.74937L`, score `0.165009`,
  command-energy mean `1030.54`, and force/moment RMS `438.82/4341.50`. The
  matched cap reaches at `45.2210` with `1.71458/0.74854L`, score `0.165860`,
  energy mean `1030.39`, and load RMS `439.16/4344.77`. This is a small positive
  terminal result with essentially unchanged effort and slightly higher load,
  not evidence of robustness or a reason for another scalar scheduler edit.
- The diagnosed candidates still reach about `0.70/0.68` rad joint angle and
  the `4.538` rad/time rate cap, while the inherited over-propulsive boundary
  passed below capture and collided at `58.93` with a `1.872L` closest approach
  and `537/4995` load RMS. The candidate therefore preserves the oscillator,
  posterior lag, closure-earned residual, positive-only yaw/rate allocator,
  and soft acceleration limiting.

## Policy hypothesis

Add one bounded route-response mechanism without changing propulsion: separate
observed body yaw from inertial target line-of-sight drift. For body-frame
bearing, `bearing_window_rate + heading_rate` is the observed inertial
line-of-sight rate. Forecast that drift over the same state-estimated horizon
and within the same angular bound already used for heading response, then add
it to the existing predicted bearing. This retains the established release of
steering when body yaw is already correcting, but does not assume the target
line of sight is stationary while the fish translates diagonally through the
wake. Windowed bearing rate already has successful sign evidence in the
course-consistency allocator, so this tests a new placement of an evidenced
signal rather than an uncalibrated signed force or moment residual.

Expected evidence is preserved first-crossing capture and diagonal topology,
with a lower mean-distance integral or a materially lower load at matched
arrival. Reject the mechanism if it loses capture, recreates the inherited
below-target collision, worsens mean distance or arrival beyond deterministic
replay variation without a load benefit, or amplifies steering/load switching.
Success on the fixed prewarm snapshot would still require changed-wake tests
before being called robust.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish direction tracking and wake-interaction control
source_mechanism: preserve the rhythmic gait while sensor feedback corrects route response instead of encoding a fixed turn or wake phase
transferable_invariant: decompose observed relative bearing motion into body yaw and target line-of-sight drift, then apply a bounded drift correction only in the slow body-frame route channel
nontransferable_details: published gains, robot linkage geometry, species-specific gait envelopes, exact vortex phases, cylinder coordinates, target coordinates, capture radius, and task-specific routes
policy_translation: form windowed inertial line-of-sight rate as `bearing_window_rate + heading_rate`, bound its forecast with the existing terminal-aware response horizon and angular limit, and add it to predicted bearing before the unchanged yaw-gated two-joint half-cycle steering law
falsification: reject if capture or diagonal topology is lost, mean distance or arrival regresses without a material load reduction, or rate-limit contact and hydrodynamic loads increase without a shorter useful route
