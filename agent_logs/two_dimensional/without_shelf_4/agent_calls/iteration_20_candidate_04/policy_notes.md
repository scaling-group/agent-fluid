# Multi-wake candidate diagnosis and hypothesis

## Evidence read before the policy edit

- The four sampled shared-prewarm sheets are byte-identical. They show the
  fish held at the common upper-right release pose while the staggered
  four-cylinder streets develop into a broad overlapping wake around the
  target. This fixes the initial wake phase and geometry but does not rank
  controllers.
- All four current solver samples have byte-identical released sheets and
  reproduce the symmetric `0.015 L/time` rolling-closing-speed policy exactly;
  their candidate differences are comments only. The fish actively propels
  through a broad far-field turn, repeated lateral reversals, and several wake
  bands before a nearly horizontal target entry at `210.370`. Mean upstream
  velocity is `0.05223`, versus `0.03551` mean local-flow magnitude in x, so
  the `0.01672` controller-relative upstream transport and `11.040L` upstream
  head displacement are not passive advection. Capture has score/mean distance
  `-3.528/5.519L`, but the visible loops coincide with a `4.293L` maximum
  lateral target offset and `18.426/363.057` RMS lateral force/moment. Maximum
  anterior acceleration is already `31.055 rad/time^2` under the `31.2` policy
  guard, so more gait amplitude is neither supported nor needed.
- The inherited receding-soft sign split (`0.015` while closing, `0.020` while
  receding) remained finite and captured `3.899` earlier, but worsened mean
  distance/score to `5.943L/-3.956` and reduced controller-relative upstream
  transport to `0.01215`; its lower effort and load did not preserve route
  quality. The complementary closing-soft split (`0.020` while closing,
  `0.015` while receding) is the informative semantic failure. Its sheet shows
  repeated right-side loops without central-wake acquisition, followed by a
  turn toward the upper boundary and domain exit at `214.528`. Diagnostics
  confirm `11.062L` mean, `12.542L` final, and `7.316L` minimum distance,
  negative progress, `6.011L` maximum lateral target offset, and only
  `0.00619` controller-relative upstream transport. Anterior joint extrema are
  unchanged, isolating selector timing rather than propulsion or guard contact.
- Together, the two sign splits falsify treating the symmetric transition as
  separable closing and recovery halves, even though both formulas are bounded
  and continuous at zero. The older `75%` progress / `25%` drift-magnitude
  selector also missed the horizon after wide reversals and a lower-corridor
  excursion. This candidate therefore restores symmetric `0.015` progress
  scheduling, keeps rolling closing speed as its sole schedule input, and does
  not mix or split selectors.

## Single candidate hypothesis

Preserve the replicated `20.25 deg`, `0.67`-period gait, posterior lag and
damping, `10 deg` steering bound, `0.30` bearing scale, `0.25` bearing-rate
lead, `0.07--0.08` progress-selected lateral lookahead, `0.10` lateral-velocity
clamp, symmetric `0.015 L/time` transition, and `31.2` acceleration guard.
Change only the activation scale of the existing sign-gated target-away
lateral-velocity correction: multiply its current
`bearing_scale * lateral_velocity_limit` normalization by `0.75`. This makes
the bounded `tanh` weight engage somewhat earlier when bearing and lateral
velocity show motion away from the target, while leaving targetward lateral
motion, the successful progress selector, maximum correction, propulsion, and
all actuator limits unchanged. It adds no coordinate, route, clock, prescribed
inflow, remote wake probe, station-flow signal, or new observation.

The visual hypothesis is that earlier engagement of the already-present
body-frame retention correction will reduce the anchor's far-field reversals
without changing its central-wake acquisition. Count it as an improvement only
if it still captures and improves mean distance below `5.519L` and/or arrival
before `210.370`, preferably with maximum lateral offset below `4.293L`, while
keeping controller-relative upstream transport near `0.01672`, anterior guard
margin, effort, force, and moment. Falsify it on later or lost capture, a
different poor-integral wake-band route, larger excursion, lower upstream
margin, increased load, or switching. The inference is local to this gait and
certified wake phase, and no same-worker CFD result is claimed.
