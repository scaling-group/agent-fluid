# Wake-policy candidate diagnosis

## Evidence boundary

The assigned parent is the fresh-lineage guidance copied from
`optimizer_a20a3b18a5ef`. The workspace supplies one sampled solver result,
`solver_f236e5345260`, and no inherited `logs/optimize/` result from an earlier
worker. Consequently the sampled seed is both the best finite rollout and the
only informative failure; there is no positive policy comparator. This
candidate uses no omitted shelf, neighboring workspace, repository history, or
same-worker CFD claim.

## Visual and metric diagnosis

- The shared prewarm sheet shows the common held fish above and to the right of
  a fully developed four-street wake. At release, the fish is approximately
  aimed along the diagonal toward the target, but the released sheet shows it
  rotating into a steep downward path, remaining to the right of the target
  and cylinder field, and crossing the bottom boundary. It never enters the
  useful second-row target region.
- The termination and trajectory metrics agree with the pictures:
  `left_domain` after only `50.1269` of the `300` release horizon, minimum
  distance `8.61495L` followed by final distance `12.1226L`, and head
  displacement `(-3.5452L, -13.3003L)` when the target required a much larger
  upstream than downward displacement.
- Mean world-frame local flow `(-0.0414, -0.2414)` was close to mean fish
  velocity `(-0.0725, -0.2633)`, while mean relative flow was only
  `(0.0311, 0.0219)`. Thus the evidence is more consistent with strong
  downward entrainment and little useful slip than with controlled travel to
  the target. The large body oscillations did not reject that drift.
- Both joint accelerations reached the `31.4159` rad/time^2 hard envelope;
  command-energy mean was `1496.25`, with RMS lateral force `21.94` and RMS
  moment `541.70`. The target-blind `0.55`-period oscillator therefore combines
  actuator saturation and high loads with essentially zero net progress
  (`0.0243`).

## Policy hypothesis

Retain a self-excited, clock-free traveling bend, but make the posterior-joint
target carry a bounded mean tail-tangent bias from `state.bearing`. The episode
defines forward as body `-x`; positive bearing is target displacement toward
body `+y`, so this candidate tests a negative tail-tangent bias for positive
bearing. The bias smoothly vanishes on alignment and saturates at 15 degrees,
avoiding a hard target-direction switch or any global coordinate/route input.

Slow the oscillator from period `0.55` to `0.75`, reduce its Van der Pol scale
from 28 to 11 degrees, and cap policy commands at 26 rad/time^2, below the
episode's 31.4159 envelope. This should preserve a useful traveling bend while
reducing the persistent clipping visible in the seed. The expected measurable
effect is survival beyond `50.1269`, less downward-to-upstream displacement
ratio, lower acceleration saturation/command effort, and continued distance
closure instead of rebound after the `8.61495L` minimum.

The steering-sign and gain are explicitly falsifiable: if the next rollout
turns farther away, reverses bearing without approaching, or still exits
downward with saturated commands, later workers should flip or weaken the mean
tail bias before adding more observations. If it remains aligned but cannot
overcome the local flow, restore propulsion strength separately rather than
raising the steering bias.
