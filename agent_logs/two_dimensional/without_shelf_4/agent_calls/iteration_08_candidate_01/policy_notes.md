# Multi-wake candidate diagnosis and hypothesis

## Evidence read before the policy edit

- The sampled shared-prewarm sheets are byte-identical and show the fish held
  high and downstream/right of the target while the four staggered cylinder
  streets develop and overlap through the target corridor. They establish a
  common initial condition and cannot rank policies.
- All four current sampled rollout sheets are also byte-identical. The proven
  `20.25 deg`, `0.67`-period, `0.25`-lookahead controller is actively
  target-directed rather than passively advected: after broad alternating
  right-side turns it aligns upstream through the interacting central wake and
  captures from the right at `244.547`, with mean distance `6.452L` and head
  travel `(-10.916,-4.187)L`. Its mean head velocity x is `-0.04443` versus
  mean local-flow x `-0.03649`, so the wake assists the route but does not
  account for all upstream transport. The finite `18.263/362.214` RMS lateral
  force/moment and `31.055 rad/time^2` anterior maximum agree with the visible
  absence of collision, exit, breakup, or cap contact.
- The assigned-parent evidence bounds propulsion. At this same period and
  posterior bundle, `19 deg` self-propelled upstream but missed the corridor at
  the horizon (`5.812L` final), `20 deg` captured at `266.255`, and the isolated
  `20.25 deg` shell reached the current anchor. The inherited `14 deg`,
  `0.80`-period rollout was instead advected downstream and exited. Because
  `20.25 deg` is already close to the `31.416 rad/time^2` hard limit, the
  remaining visible inefficiency is steering/corridor acquisition, not a
  supported request for more amplitude.
- The new inherited `0.30` bearing-rate-lookahead rollout is the most
  informative mechanism failure. With propulsion, static bearing response,
  posterior lag/damping, and limits unchanged, its keyframes show longer
  high/right corrections before late central-wake entry. It still captures,
  but only at `270.446`; mean distance worsens to `8.499L`, mean upstream
  velocity falls to `-0.04032` despite a more favorable `-0.04086` mean local
  flow, and RMS lateral force rises to `18.958`. Lower mean command energy and
  RMS moment do not compensate for the delayed route. More rate anticipation
  therefore unloads useful target turning too early or gives the window-rate
  term too much influence in this wake.
- A distinct inherited closing-speed test also regressed. Weakening bearing
  response from scale `0.30` toward `0.32` during positive closing delayed
  capture to `256.663`, raised mean distance to `7.394L`, and increased RMS
  relative crossflow/force to `0.1373/18.426`, despite lower effort and moment.
  Together with the assigned-parent static `0.28` negative result, this rules
  out either stronger or weaker bearing-scale changes as the next clean axis.

## Candidate hypothesis

Preserve the complete demonstrated `20.25 deg`, `0.67`-period propulsion
shell, `0.65/0.80` posterior lag/damping, `10 deg` steering limit, `0.30`
static bearing scale, `0.30 rad/time` rate bound, and `31.2 rad/time^2` guard.
Change only bearing-rate lookahead from `0.25` to `0.20`. This is the symmetric
local contrast to the falsified `0.30` test: it keeps target bearing in control
slightly longer during a developing turn and reduces sensitivity to
window-rate fluctuations, without changing the initial large-error steering
limit or introducing an unscaled observation.

Under the certified fixed prewarm, the next CFD evaluation should retain
active upstream travel and central-wake capture while shortening the broad
alternating approach, reducing mean distance below `6.452L`, or reaching
before `244.547` without increased force/moment load. Falsify the direction if
capture is lost or later, mean distance rises, corridor entry is delayed, the
route rebounds, or lateral load grows. In that case restore the demonstrated
`0.25` lookahead and stop treating bearing-rate anticipation as a locally
monotone route-straightening knob; test a separately scaled retention signal
instead of changing amplitude or static bearing response.
