# Multi-wake target-policy candidate notes

## Evidence diagnosis before the policy edit

The assigned parent in `solver/` is the common target-blind seed. Its released
sheet shows a hard curling descent below the useful wake corridor; it exits the
lower domain after `50.127` time units, displaces `(-3.545, -13.300)L`, and
never comes closer than `8.615L`. Both joints reach the rate and acceleration
caps. This establishes that the seed carrier can move upstream but lacks route
control, not that more scalar propulsion is needed.

The sampled step-1 results identify a much stronger baseline. The policy that
keeps the seed carrier unchanged and adds an `8 deg` bounded body-frame
bearing-to-mean-curvature bias is the only success: it reaches the `0.75L`
target boundary after `93.032` release time, attains `0.940` progress, and has
mean distance `4.033L`. Its keyframes show a sustained target-directed traverse
from the upper-right release point into the interacting wake and then the
target, so this is controlled self-propulsion rather than favorable advection.
The useful topology is costly, however: a pronounced mid/late curl and strong
self-wake are visible, both joint rates and accelerations reach their hard
caps, RMS lateral force/moment rise to `95.50/1146.61`, and mean command energy
is `972.51`.

The failures bound what should change. Reducing the carrier everywhere to a
`0.90` period and `14 deg` envelope yields mostly downstream/rightward motion
and a domain exit after `17.457`, with progress `-0.145`; a `12 deg` static
turn bias on the fast carrier settles near the bias instead of developing the
successful oscillation, exits after `16.791`, and has progress `-0.147`. The
inherited heading-rate-damped, slow/narrow carrier becomes unstable after
`14.508`, with RMS force/moment `22067.65/382309.44`. These are evidence
against a global carrier reduction, a larger static bias, or uncalibrated yaw
feedback. They do not negate a near-target schedule that leaves the proven
far/middle controller exactly intact.

## Policy hypothesis

Start from the sampled successful policy, including its carrier, posterior lag,
and bounded mean-curvature steering. Add one mechanism: a smooth approach
envelope driven only by normalized `state.distance_L`. Far from the target the
carrier amplitude is exactly the successful `28 deg`; over the last few body
lengths it continuously falls toward a parameter-owned fraction while the
carrier frequency, route bias, and posterior lag remain unchanged. This tests
whether terminal drive relief can preserve first-crossing success while
reducing the cap-dominated curl and load/effort spike. It is falsified if the
far/mid trajectory changes, capture is delayed or lost, propulsion decays
before the wake corridor, or joint/load caps remain unchanged near approach.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and terminal target capture
source_mechanism: continuous range-conditioned relief of the propulsive oscillation envelope during final approach
transferable_invariant: once target-directed propulsion works, remaining normalized distance can smoothly reduce excess rhythmic drive without changing the far-field route mechanism
nontransferable_details: published CPG gains, dimensional ranges and frequencies, robot or species kinematics, exact vortex phases, cylinder coordinates, and task-specific routes
policy_translation: preserve the successful body-frame bearing bias and joint-state carrier; use a bounded smooth function of `state.distance_L` to reduce only the oscillator amplitude near the target
falsification: reject if success is lost or delayed, the far/middle route changes, the fish coasts before entering the useful wake, or saturation and load remain cap-dominated

## Pre-evaluation verification

A no-CFD Julia comparison evaluated the candidate and the sampled successful
formula over a grid of bearings and joint states. Their two accelerations are
exactly equal for every tested `distance_L >= 2.5`. The smooth envelope scale
is `1.000` at and above `2.5L`, `0.974` at `2.0L`, `0.912` at `1.5L`, and
`0.804` at the `0.75L` capture boundary. This establishes formula-level
localization and continuity only; whether the schedule preserves capture or
reduces CFD load remains deliberately unevaluated for the next rollout.
