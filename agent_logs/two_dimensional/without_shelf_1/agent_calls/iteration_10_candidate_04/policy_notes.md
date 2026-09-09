# Multi-Wake Candidate Diagnosis

## Evidence read before the policy edit

The common prewarm sheet shows the held fish above and downstream of four
developed, interacting vortex streets.  It is the same initial condition for
all candidates.  In the released sheets, every sampled controller
self-propels upstream rather than passively following the local flow, but all
eventually bend into the same sharp upper-domain curl and exit without entering
the useful second-row target neighborhood.

- The strongest sampled static probe uses the preserved `0.90`-period gait,
  `11 deg` posterior bias, `25 deg` bearing scale, and direct heading-rate
  setting `0.70/0.35`.  It travels `-7.89L` in head x and reaches `4.87L`,
  improving on the `10 deg` anchor's `-6.93L` and `5.33L`.  Its mean velocity
  x is `-0.141`, versus mean local flow x `-0.099`, so the upstream motion has
  a real self-propelled component.  However, head y drift is effectively
  unchanged (`+1.792L` versus `+1.797L`), both joint rates and commands hit
  their caps, posterior angle reaches `44.7 deg`, and RMS force/moment rise
  from `325/3331` to `406/4113`.  The visual path gets farther left before the
  same terminal curl; the added static bias acts more like propulsion than a
  lateral correction.
- Increasing only direct heading-rate damping to `0.80`, or shrinking bearing
  scale from `25` to `20 deg`, regresses progress to `0.351` and `0.310` and
  closest approach to `5.66L` and `5.77L`.  Both retain about `+1.8L` head-y
  drift and the terminal curl, so neither is a useful desaturation axis.
- The inherited `0.35` gait-phase steering relief also retains that curl while
  cutting head-x travel to `-4.59L`, progress to `0.250`, and closest approach
  to `6.88L`.  Its modest load reduction to `302/3197` does not compensate for
  losing the upstream mechanism.  This rules out weakening posterior bias on
  reinforcing oscillator phases throughout the far-field swim.

## Single candidate hypothesis

Use the strongest `11 deg`, `25 deg`, `0.70/0.35` sampled controller as the
far-field anchor.  Add one smooth, normalized distance gate that preserves its
full posterior bias at and beyond `6L`, then reduces only the mean steering
bias toward a `0.70` floor over the next `1.5L` of approach.  This differs from
the failed gait-phase relief because it cannot weaken the established upstream
mechanism before the fish reaches the best samples' approach region.  The
oscillator, traveling-wave lag, direct heading-rate feedback, and actuator
ceiling remain unchanged.

The falsifiable expectation is that the rollout initially follows the
`11 deg` sample, then releases enough posterior mean bend below `6L` to reduce
angle/rate saturation and prevent the sharp turn that erases the `4.87L`
closest approach.  Evidence would falsify the mechanism if it fails to enter
the gate, loses upstream progress before entry, or retains the same y drift,
curl, and saturation after entry.  In that case later workers should treat
static posterior bias as propulsion allocation rather than successful steering
and should not deepen distance relief without a signal that changes lateral
motion.
