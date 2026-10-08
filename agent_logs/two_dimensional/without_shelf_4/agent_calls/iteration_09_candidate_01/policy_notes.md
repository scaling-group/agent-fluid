# Multi-wake candidate diagnosis and hypothesis

## Evidence read before the policy edit

- The four current shared-prewarm sheets are byte-identical and show the fish
  held high and downstream/right while the four staggered cylinder streets
  develop into the target corridor. The four released sheets are also
  byte-identical. Their candidate sources are behaviorally equivalent versions
  of the `20.25 deg`, `0.67`-period anchor, and their physical rollout metrics
  match: capture at `244.547`, mean/final distance `6.452/0.750L`, maximum
  lateral target offset `4.293L`, and head travel `(-10.916,-4.187)L`.
- The anchor is self-propelled through a wake-assisted route rather than merely
  advected. Mean head velocity x is `-0.04443` against mean local-flow x
  `-0.03649`, leaving `0.00793` controller-relative upstream transport. Its
  released sheet shows a broad initial loop and several bends on the right,
  followed by coherent central-wake entry and an almost horizontal capture.
  There is no collision, exit, numerical instability, or final rebound.
- Propulsion is already a constrained local anchor. Maximum anterior
  acceleration is `31.055 rad/time^2` against the `31.2` policy guard and the
  `31.416` episode cap, while RMS lateral force/moment remain finite at
  `18.263/362.214`. The inherited amplitude sequence also shows that `20 deg`
  captures later and `19 deg` misses, so this candidate must not seek route
  improvement through more or less oscillator amplitude.
- The assigned parent's inherited `0.20` bearing-rate-lead rollout is the most
  informative current failed hypothesis. It still captures and has the same
  `4.293L` maximum lateral target offset, but the released sheet retains the
  initial excursion and adds route reversals before wake entry. Relative to the
  replicated `0.25` anchor, capture is `14.074` later at `258.621`, mean
  distance is `1.589L` worse at `8.041L`, and RMS lateral force rises from
  `18.263` to `18.629`. Mean velocity/local-flow x are `-0.04221/-0.03665`, so
  controller-relative upstream transport falls to `0.00556`. The tiny
  crossflow reduction (`0.13437` to `0.13419`) does not compensate for the
  slower, longer, higher-force route.
- Together with inherited failures at `0.30` rate lead, sharper static bearing
  scale, and closing-speed relief, the new result closes the simple scalar
  bearing-tuning branch around `0.30` scale and `0.25` lead. Both equal-sized
  rate-lead directions create a longer route, so combining those changes or
  averaging them has no evidence basis.

## Candidate hypothesis

Preserve the demonstrated oscillator, posterior lag/damping, steering limit,
`0.30` bearing scale, `0.25` bearing-rate lead, and all guards. Add only a
small, independently bounded `heading_rate` term to the predicted bearing:
clamp heading rate to `0.30 rad/time` and subtract it with a `0.05`-time lead.
Because body-frame bearing rate contains inertial line-of-sight rotation minus
body heading rate, this retains the anchor's `0.25` coefficient on target-line
motion while changing only the heading-rate coefficient from `-0.25` to
`-0.30`. The maximum new correction before the bearing nonlinearity is only
`0.015 rad`.

This is a bounded component-separation test, not another global rate-lead
sweep. The visual hypothesis is that slightly more direct rotational damping
will suppress a heading overshoot/reversal without weakening the translational
target-rate anticipation that the failed `0.20` controller changed at the same
time. Under the certified prewarm, improvement requires retained capture plus
earlier arrival or lower mean distance than `244.547/6.452L`, without worsening
the `4.293L` lateral excursion, `0.00793` relative-upstream margin, or
`18.263/362.214` force/moment loads. Falsify the mechanism on later/lost
capture, added route reversals, guard contact, reduced upstream margin, or
material load growth; then restore the plain `0.25` anchor and avoid further
bearing-derivative decomposition until a rollout exposes heading/line-of-sight
time series that can identify which component drives the loop.
