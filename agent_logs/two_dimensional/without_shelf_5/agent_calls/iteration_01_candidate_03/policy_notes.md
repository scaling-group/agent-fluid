# Multi-wake candidate diagnosis

## Evidence read before the policy edit

- The shared prewarm sheet shows the common held fish above and downstream of
  four established, interacting vortex streets. The target lies in the merged
  corridor behind the second cylinder row, so this is initial-condition
  evidence rather than credit for the seed policy.
- The released sheet shows active self-propulsion rather than passive advection:
  the fish sheds a dense oscillatory trail and moves `-3.545L` in world x.
  However, it rapidly rotates nose-down, moves `-13.300L` in world y, never
  enters the target/wake corridor, and crosses the lower boundary after only
  `50.127` of the `300` release horizon. The trajectory first reaches
  `8.615L` from the target but finishes `12.123L` away, leaving only `0.0243`
  net progress.
- The aggregate diagnostics agree with the visual failure: mean local vertical
  flow is `-0.241`, RMS relative crossflow is `0.175`, RMS moment is `541.7`,
  and command-energy mean is `1496.25`. Thus the visible turn is not a useful
  wake capture; it is a high-load lateral escape that reverses early distance
  improvement.
- The sampled policy is exactly the target-blind seed oscillator. The assigned
  parent contains only initial strategy, and there are no inherited optimizer
  notes in `logs/optimize/`. Only this failed sampled rollout was supplied, so
  there is no positive finite candidate with which to claim a proven steering
  mechanism.

## Candidate policy hypothesis

Preserve the seed's autonomous joint-state oscillator and posterior phase lag,
because the rollout at least produced upstream x displacement. Add current
body-frame target bearing as the smallest missing feedback capability. A
bounded smooth steering angle will shift the first-joint oscillator center and
the total posterior tangent center while leaving the alternating gait intact.
This should build corrective curvature when the target moves off the headward
axis, relax that curvature as alignment returns, and avoid any global
coordinate, elapsed-time, cylinder identity, or remote-flow dependence.

The formal rollout should falsify this hypothesis if target bearing does not
decrease before the prior nose-down excursion, if the fish exits even earlier
on either lateral boundary, or if joint/acceleration saturation becomes
persistent. If bearing is repaired but distance closing remains weak, a later
worker should tune propulsion strength separately instead of adding more
steering observations. If bearing grows with the commanded curvature, later
workers should test the opposite curvature sign rather than increasing gain.
