# Wake-policy candidate notes

## Evidence diagnosis

The shared prewarm sheet shows the held fish above and downstream of four
developed, interacting vortex streets, with the target behind the second
cylinder row. The released sheets show that all four sampled policies remain
outside that useful wake/target region: they initially self-propel upstream,
then form a large upward J/U-turn and leave through the top boundary. This is
not passive advection. Mean local x-flow is near zero or upstream in every
sample, while the head moves upstream by `2.18--4.69L`; the visible motion and
the negative mean body x-velocity therefore agree that the gait supplies
propulsion.

The undamped positive posterior-only anchor survives `73.39` release units and
gets closest (`6.34L`), but its broad loop ends with posterior angle saturation
and both rate/acceleration limits. Bearing-window-rate damping with an `8 deg`
bias still makes the same loop, exits sooner (`53.53`), and worsens closest
approach to `7.90L`. The mixed weaker `22 deg` gait avoids posterior angle
saturation but reaches only `9.31L` and raises RMS force/moment to `388/5262`,
so it does not isolate a useful desaturation mechanism. The assigned parent's
direct heading-rate damping is the best sampled scalar/progress result:
upstream head displacement improves from `-2.73L` to `-4.69L`, progress from
`0.132` to `0.255`, and mean distance from `10.65L` to `9.48L`. However, its
sheet still ends in the same upper J-turn, its closest approach is worse
(`7.30L`), and the posterior angle plus both rates/commands still hit their
limits. RMS force/moment also rise from `196/2014` to `284/2797`.
The assigned parent's inherited score log adds a lower-load failure
(`146/1539`) with only `0.040` progress and an `8.37L` closest approach, so
lower loads without a changed exit topology are not evidence of navigation
improvement.

## Candidate hypothesis

Preserve the parent's `0.90`-period, `28 deg` anterior oscillator, posterior
lag/damping, `10 deg` positive bias, and command ceiling. The useful direct
turn-rate signal should be retained, but its additive `0.35` correction leaves
at least `65%` of a saturated bearing request and can reverse a small request.
Replace it with a `0.75` sign-preserving brake: normalize body heading rate,
remove steering only when its sign is already turning the body toward the
current bearing, never amplify steering while turning away, and never reverse
the bearing request. The expected result is to retain the parent's early
upstream displacement while reducing the terminal overshoot and posterior
saturation enough to continue diagonally toward the target. The hypothesis is
falsified if upstream displacement is lost before the turn, or if posterior
angle/rate saturation and the upper-boundary loop persist without a better
closest approach; a later worker should then restore the additive parent and
isolate posterior lag or static bias rather than add more rate feedback.
