# Multi-wake candidate diagnosis and hypothesis

## Evidence boundary and visual diagnosis

- The common prewarm sheet shows the fish held above and downstream of the
  target while four mature, interacting cylinder streets fill the corridor.
  The sampled prewarm images are pixel-identical, so this is shared
  initial-condition evidence rather than evidence for a policy difference.
- All four current solver examples are the same finite control outcome:
  their released sheets are pixel-identical and their metrics agree through
  the reported precision despite source-level naming and comment differences.
  The fish makes a broad initial turn with several large path reversals, then
  travels diagonally left into the central wake and reaches the `0.75L`
  target radius at released time `266.255`. It does not collide, leave the
  domain, or become unstable. Final distance is also the rollout minimum
  (`0.749L`), so the late approach remains productive rather than rebounding.
- Diagnostics support a wake-assisted, actively steered interpretation. Head
  displacement is `(-11.031,-4.702)L`; mean velocity
  `(-0.04144,-0.01765)` is close to mean local flow
  `(-0.03889,-0.02029)`, with only `(0.00254,-0.00264)` mean relative flow.
  The fish therefore exploits the local transport after steering into the
  useful region rather than demonstrating large speed through the water.
  Maximum lateral target offset is nevertheless `4.293L`, consistent with
  the visibly circuitous release transient. Joint maxima remain finite at
  about `20.0/25.0 deg`, `187.7/141.3 deg/time`, and
  `1757.3/1325.9 deg/time^2`; the `30.8 rad/time^2` policy guard and episode
  hard caps are not reached.
- No sampled failure keyframe exists in this workspace. The failure boundary
  is therefore taken only from inherited optimizer logs, not an invented
  visual comparison: an otherwise matched `19 deg` shell survived the horizon
  but ended `5.812L` away after only `-5.846L` head-x travel; coupled changes
  to `21 deg`, period `0.69`, and softened bearing scale `0.38` produced a
  late rebound from `3.246L` minimum to `3.610L` final distance; and increased
  posterior lag/reduced damping (`0.78/0.72`) erased upstream travel. These
  results support preserving the demonstrated `20 deg`, `0.67`, `0.65/0.80`
  bundle rather than adding drive, lag, or softer proportional steering.

## Candidate hypothesis

Preserve the replicated propulsion shell, posterior steering sign and limit,
lag, damping, bearing scale, and acceleration guard. Increase only the bounded
bearing-rate lookahead from `0.25` to `0.35`. With the existing `0.30`
bearing-rate clamp, the predictive contribution remains at most `0.105 rad`
instead of `0.075 rad`, while the steady-bearing command is unchanged. The
falsifiable expectation is earlier unwinding of the broad release turn and
less lateral path reversal, reducing mean distance and capture time while
retaining negative head-x travel, central-wake entry, monotone late distance,
and no guard or hard-cap contact. The hypothesis is rejected if capture is
later or lost, if late distance increases after approach, or if force/moment
loads or cap contact rise; later workers should then restore `0.25` and test a
smaller anticipatory change rather than perturbing the proven propulsion and
posterior-phasing bundle.
