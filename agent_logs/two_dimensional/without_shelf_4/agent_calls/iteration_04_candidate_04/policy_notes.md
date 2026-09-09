# Multi-wake candidate diagnosis

## Evidence boundary and visual diagnosis

- This diagnosis uses only the task contract, assigned-parent guidance, sampled
  solver results, inherited optimizer notes, and the supplied rollout sheets
  and diagnostics. It does not use the omitted research shelf, neighboring
  configurations, repository history, coordinates, or archival VTK fields.
- The shared prewarm sheet establishes the common initial condition: the fish
  is held above and downstream of the target while four staggered cylinder
  streets develop and merge through the target corridor. The released sheets
  therefore compare policies under the same visible wake state.
- The prefilled `20 deg`, `0.67` policy is the only sampled success. Its sheet
  shows active upstream swimming, entry into the developed wake corridor, and
  eventual capture, but the traced path also contains broad early heading
  reversals before the final direct approach. Metrics confirm useful rather
  than passive motion: it reaches `0.749L` after `266.255` released time, moves
  the head `(-11.031,-4.702)L`, and has mean body x velocity `-0.04144` versus
  mean local flow `-0.03889`. The successful gait remains below the envelope:
  maximum joint angles are about `20.0/25.0 deg`, rates `188/141 deg/time`, and
  accelerations `1757/1326 deg/time^2`; the policy's `30.8 rad/time^2` guard is
  not contacted. RMS lateral force/moment remain finite at `18.26/353.21`.
- The assigned parent's `21 deg`, `0.69` branch is the closest informative
  failure. Its sheet retains upstream motion but shows repeated zigzags, never
  enters the target circle, and finishes farther away than its `3.246L`
  minimum. It survives the horizon with `(-8.121,-3.574)L` displacement, but
  raises relative crossflow, lateral force, and moment to
  `0.1398/19.15/363.27`. Because that branch also widened the bearing scale
  from `0.30` to `0.38`, its failure does not isolate gait from steering; it
  does rule out carrying that combined extrapolation forward.
- The `19 deg`, `0.67` sample supplies the lower propulsion boundary: it ends
  at its `5.812L` minimum after `(-5.846,-4.282)L` displacement, whereas the
  otherwise matching `20 deg` policy captures. Conversely, changing the
  `19 deg` policy's posterior lag/damping from `0.65/0.80` to `0.78/0.72`
  removes nearly all upstream displacement (`+0.058L`) despite similar effort.
  Preserve the successful anterior amplitude, period, posterior phasing, and
  negative bounded steering sign rather than reopening those coupled axes.

## Policy hypothesis

Keep the complete sampled-success controller and change only the clipped
bearing-rate lookahead from `0.25` to `0.35`. Both the successful path and the
assigned-parent failure visibly spend range on broad turn reversals, and both
use the same short lookahead. With the existing `0.30 rad/time` rate clip, this
change can shift predicted bearing by at most another `0.03 rad`; it leaves the
`10 deg` far-off-axis steering bound unchanged while asking the posterior bend
to unwind slightly earlier near alignment. It introduces no new observation:
the policy continues to use joint state plus normalized body-frame target
bearing and its supplied window rate.

The later CFD evaluation should preserve target capture, the successful
policy's upstream displacement, and its cap-free joint envelope while reducing
heading reversals enough to arrive before `266.255` and lower the `7.218L`
mean distance. The hypothesis is falsified if capture is lost or delayed, if
final/minimum distance rebounds, if lateral target offset grows beyond its
initial `4.293L`, or if joint/force/moment loads materially exceed the sampled
success. In that case later workers should restore `0.25` rather than combine
more lookahead with amplitude, period, or posterior-lag changes.
