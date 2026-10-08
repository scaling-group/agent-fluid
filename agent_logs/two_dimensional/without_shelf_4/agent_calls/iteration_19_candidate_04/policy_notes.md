# Multi-wake candidate diagnosis and hypothesis

## Evidence read before the policy edit

- The current shared-prewarm sheet shows the fish held at the common
  upper-right release pose while four staggered cylinder streets develop into
  the target corridor. The current samples share this initial condition, so it
  establishes wake layout and phase but does not rank policies.
- All four current sampled rollouts reproduce the symmetric `0.015 L/time`
  pure closing-speed selector: they have byte-identical released keyframe
  sheets and identical physical metrics apart from evaluation wall time. The
  fish is visibly self-propelled rather than merely advected: it remains
  actively oscillatory through a broad initial descent and several wake-band
  reversals, then enters the target nearly horizontally. Diagnostics agree:
  mean upstream head speed is `0.05223`, exceeding the `0.03551` magnitude of
  mean local-flow x, for positive controller-relative upstream transport of
  `0.01672`. It captures without collision, exit, or instability at `210.370`,
  with mean distance `5.519L`, score `-3.528`, and upstream displacement
  `11.040L`.
- Propulsion remains bounded but nearly consumes the policy guard: maximum
  anterior acceleration is `31.055 rad/time^2` against `31.2`, while maximum
  anterior angle/velocity are `0.3531 rad` and `3.3161 rad/time`. Maximum
  lateral target offset is `4.293L`, RMS relative crossflow is `0.13289`, RMS
  lateral force/moment are `18.426/363.057`, and command energy is `147846`.
  This supports preserving the gait and acceleration guard; the visible route
  reversals are a steering-timing opportunity, not evidence for more drive.
- There is no failure among the current samples. The assigned parent's
  inherited notes retain the informative `75%` progress / `25%` drift-blend
  failure: unchanged propulsion but wide reversals and a deep lower-corridor
  excursion led to a horizon miss at `3.689L` final and `7.507L` mean
  distance. Therefore this candidate keeps rolling closing speed as the sole
  selector and does not compose another schedule signal.
- A later inherited optimizer log provides the controlled sign-split result.
  Relative to the current symmetric `0.015` anchor, keeping `0.015` while
  closing but using `0.020` while receding captured earlier at `206.470` and
  reduced command energy from `147846` to `142752`, RMS moment from `363.057`
  to `356.178`, and RMS force slightly from `18.426` to `18.368`. Those gains
  did not preserve route quality: mean distance worsened to `5.943L`, score to
  `-3.956`, and controller-relative upstream transport to `0.01215`; relative
  crossflow also rose slightly to `0.13331`. Its sheet shows a distinct,
  flatter middle approach with fewer sharp reversals, but the distance and
  transport diagnostics show that this visually calmer path is not the better
  target route. Unchanged `4.293L` maximum lateral offset and `31.055`
  anterior-acceleration maximum isolate selector timing rather than added
  propulsion, saturation, or excursion.

## Single candidate hypothesis

Preserve the reproduced `20.25 deg`, `0.67`-period propulsion, posterior lag
and damping, `10 deg` steering bound, `0.30` bearing scale, `0.25`
bearing-rate lead, sign-gated target-away lateral correction, `0.07--0.08`
lookahead envelope, `0.10` lateral-velocity clamp, and `31.2` acceleration
guard. Keep rolling closing speed as the only selector, but test the
complementary sign split: retain the route-leading `0.015 L/time` transition
while receding and use `0.020 L/time` only while closing. The selector remains
continuous at zero and bounded within evaluated scales, and it introduces no
coordinate, route, clock, prescribed inflow, remote wake probe, or
target-station signal.

This candidate isolates the half of the transition not isolated by the
inherited split. The evidence says receding-side sharpness is necessary for
the anchor's distance integral and upstream margin; gentler closing-side
selection may reduce load or wasteful correction after progress resumes
without surrendering recovery. Count it as an improvement only if it retains
capture, mean distance at or below `5.519L`, upstream margin near or above
`0.01672`, and lowers load/effort without later arrival, larger excursion,
switching, or guard contact. Falsify it if softening the closing side worsens
mean distance beyond the symmetric anchor, delays capture, reduces upstream
margin, or restores wide route reversals; that would establish symmetric
`0.015` as the local sign-independent anchor. Scope is limited to this gait
and certified fixed-prewarm phase until later evaluation and a held-out phase
test it. No same-worker CFD outcome is claimed.
