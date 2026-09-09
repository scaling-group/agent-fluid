# Multi-wake candidate diagnosis and hypothesis

## Evidence read before the policy edit

- The shared prewarm sheets are byte-identical and show the fish held high and
  downstream/right of the target while the four staggered cylinder streets
  develop and overlap through the target corridor. They establish one common
  wake initial condition and do not rank policies.
- The inherited `19 deg`, `0.67`-period horizon miss is the informative failure
  boundary. Its released sheet shows a broad turn followed by repeated lateral
  corrections on the right of the cylinder field; it never acquires the dense
  central reverse-flow corridor. It survives all `300` release units and ends
  at its `5.812L` minimum after moving the head `(-5.846,-4.282)L`. Mean x
  velocity `-0.01942` against local-flow x `-0.00682`, together with maxima of
  about `19/24.3 deg`, `178/134 deg/time`, and `1670/1260 deg/time^2`, shows
  finite self-propulsion without cap contact, but not enough corridor access.
- The assigned-parent `20 deg` controller repairs that longitudinal failure.
  Two current samples reproduce its released sheet and all physical metrics
  exactly: capture at `266.255`, mean distance `7.218L`, head displacement
  `(-11.031,-4.702)L`, and maximum acceleration `30.672 rad/time^2`. The fish
  turns broadly after release, aligns leftward in the interacting wake, and
  approaches the target from the right without collision, exit, instability,
  or late rebound. Its mean velocity `(-0.04144,-0.01765)` nearly matches mean
  local flow `(-0.03889,-0.02029)`, so the controller is selecting and holding
  a wake-assisted corridor rather than sustaining large speed through water.
- The current `20.25 deg` sample changes only the anterior shell and its
  mechanically necessary guard. Its released sheet preserves the successful
  topology and reaches the target at `244.547`, `21.708` earlier than the
  `20 deg` baseline. Mean distance improves from `7.218L` to `6.452L`, while
  total command energy falls from `177752.5` to `170142.5` because the episode
  is shorter. Maximum anterior acceleration is `31.055 rad/time^2`, below its
  `31.2` guard and the `31.416` hard limit. RMS force is unchanged at `18.263`;
  RMS moment rises modestly from `353.21` to `362.21`. The closer match between
  mean velocity x `-0.04443` and local-flow x `-0.03649` still supports
  wake-assisted corridor acquisition rather than a new high-relative-speed
  mechanism.
- Sharpening only the successful baseline's bearing scale from `0.30` to
  `0.28` is negative local evidence. It crosses slightly earlier at `262.895`,
  but its sheet spends more of the route far to the right before entering the
  lower central street. Mean distance worsens to `8.112L`, score falls to
  `-6.086`, and RMS force rises to `18.583`, despite unchanged propulsion
  acceleration. Therefore earlier final crossing alone does not justify the
  sharper response; preserve the `0.30` scale when using the improved shell.
- Inherited optimizer logs also rule out compensating with posterior phasing:
  a `0.78/0.72` lag/damping variant looped near release with essentially no
  upstream travel, and a coupled `21 deg`, `0.69`-period, `0.38`-bearing-scale
  variant rebounded from `3.246L` to a `3.610L` miss. At the retained `0.67`
  period, `20.5 deg` would put nominal anterior acceleration above the episode
  hard envelope, so the evaluated `20.25 deg` result is the supported local
  endpoint rather than evidence for further amplitude extrapolation.

## Candidate hypothesis

Promote the evaluated `20.25 deg`, `0.67`-period controller as the single
candidate, preserving the successful `0.30` bearing scale, `0.25` bounded
bearing-rate lookahead, `0.65/0.80` posterior lag/damping, and `10 deg`
posterior steering limit. Keep its policy-owned `31.2 rad/time^2` guard, which
the sampled rollout did not touch and which remains below the hard episode
limit. This uses only joint state and body-frame target bearing/rate; it adds no
coordinates, route, clock, prescribed inflow, remote wake probe, or target
station signal.

Under the certified fixed prewarm, the next evaluation should reproduce the
sampled central-corridor capture near `244.55`, keep mean distance below the
`20 deg` baseline's `7.218L`, and avoid policy-guard contact, rebound, or a
material lateral-load increase. Falsify transfer beyond this wake phase if
capture is lost or later than the replicated baseline, mean distance regresses,
the guard becomes active, or force/moment growth accompanies visible wasteful
turning. In that case later workers should restore the replicated `20 deg`,
`0.30`-scale anchor and test corridor-retention feedback, not sharpen bearing
gain, increase posterior lag, or raise amplitude again at this period.
