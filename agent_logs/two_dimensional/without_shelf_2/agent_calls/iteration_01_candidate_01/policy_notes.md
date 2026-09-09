# Multi-wake candidate diagnosis

## Evidence coverage

- The assigned parent guidance is the fresh-lineage baseline and contains no
  evaluated control mechanism beyond the requirement to use bounded,
  normalized body-frame feedback. No inherited optimizer narrative is
  available in this workspace. The inherited evaluation log only establishes
  that the seed contract, rollout, visual rendering, and failure-penalty checks
  completed; its environment warnings do not add control evidence.
- There is one sampled solver, so it is both the best finite sample and the
  most informative failure; there is no successful or near-miss comparator.
  Its `-14.294201` score ends in `left_domain` after only `50.1269` released
  time units. It reaches a minimum distance of `8.61495L` but finishes
  `12.1226L` away, for only `0.02425` progress.
- The common prewarm sheet shows the held fish starting well downstream and
  above the target while four developed, interacting vortex streets occupy
  the target corridor. The released sheet shows the fish initially aligned
  approximately toward the target, then yawing into a steep near-vertical
  descent on the right side of the domain. It never enters the second-row
  wake/target neighborhood, and the last frames show the same downward track
  immediately before the lower/left-domain termination rather than a
  collision or numerical breakup.
- The motion is predominantly advection, not productive swimming: mean world
  velocity `(-0.0725,-0.2633)` is close to mean local flow
  `(-0.0414,-0.2414)`, while head displacement is `(-3.545,-13.300)L`.
  The target-blind `0.55`-period oscillator beats at `32.83` times the
  estimated shedding frequency, reaches both acceleration caps (`31.416`
  rad/time^2), and incurs mean command energy `1496.25`, yet supplies almost
  no target progress. RMS crossflow `0.1747`, force-y `21.94`, and moment-z
  `541.70` agree with the visible uncontrolled yaw and lateral escape.

## Candidate hypothesis

Retain a self-starting, state-phase oscillator, but slow it enough that the
nominal joint motion does not require the evaluator's acceleration cap. Move
the oscillator's center with a bounded bias from `state.bearing` and its
windowed rate, and give both joints the same mean-curvature sign while keeping
the posterior joint's opposing, lagged oscillation. This adds target-relative
yaw correction without global coordinates, elapsed time, prescribed inflow,
or remote wake probes. A smooth output acceleration bound limits command and
load spikes.

The next evaluation should show the fish keeping the target bearing bounded,
avoiding the early steep downward turn, and developing material velocity
relative to the local flow while distance falls. The hypothesis is falsified
if bearing grows under the chosen curvature sign, the fish again leaves a
lateral boundary before entering the target wake region, target progress does
not exceed the seed's `0.02425`, or reduced frequency merely lowers useful
relative propulsion. Because only one failed sample exists, this proposal
does not claim that the selected period or steering gains are already
empirically optimal.
