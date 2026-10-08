# Multi-wake candidate diagnosis and hypothesis

## Evidence read before the policy edit

- The sampled shared-prewarm sheet shows the fish held high and downstream of
  the four cylinders while their staggered vortex streets develop through the
  target corridor. It is the certified common initial condition, not a reason
  to rank candidates.
- The best finite released sheet is the bounded body-frame lateral counter-
  drift controller. It remains self-propelled, crosses the alternating wake
  bands, enters the interacting central wake without collision or instability,
  and reaches the target nearly horizontally at `224.488`. Its mean/final
  distance is `6.311/0.749L`, versus `6.452/0.750L` and `244.547` for the plain
  `0.25` bearing-rate anchor. Diagnostics support the visible route gain:
  controller-relative upstream transport rises from `0.00793` to `0.01602`,
  RMS lateral force falls from `18.263` to `17.943`, and RMS crossflow is
  essentially unchanged (`0.13437` to `0.13427`). The unchanged `4.293L`
  maximum lateral offset means the improvement is reversal timing, not removal
  of the initial excursion.
- The assigned-parent global heading-rate correction is less useful despite a
  small moment reduction: it captures at `259.160`, has `6.502L` mean distance,
  raises RMS crossflow to `0.13610`, and leaves only `0.00359` controller-
  relative upstream transport. The inherited sign-asymmetric bearing-rate
  failure is the hard boundary: its keyframes show repeated jagged reversals
  and failed corridor retention, and its diagnostics end at the horizon with
  minimum/final/mean distance `3.290/3.632/8.447L` and only `-0.02667` mean
  upstream velocity. Lower RMS force in that miss does not make it a viable
  route.
- The best controller's `31.055 rad/time^2` anterior maximum still lies just
  below the `31.2` local guard, so propulsion amplitude has no supported upward
  margin. Its `0.08` counter-drift lookahead raises mean command effort only
  from `695.75` to `701.39` while earlier capture lowers total command energy
  from `170142` to `157454`; this supports a small timing refinement, not a new
  gait or a direct body-rotation term.

## Single candidate hypothesis

Preserve the demonstrated `20.25 deg`, `0.67`-period oscillator, posterior
lag/damping, `10 deg` steering bound, `0.30` bearing scale, `0.25` bearing-rate
lookahead, velocity clamp, and acceleration guard from the best sampled
controller. Increase only the counter-drift lookahead from `0.08` to `0.10`.
The correction remains inactive during stationary or targetward lateral
translation and bounded by `0.010 rad` before the steering nonlinearity. This
is a modest local extension of the one newly positive observation mechanism,
not an assumption that steering or propulsion gains improve monotonically.

The expected effect is slightly earlier rejection of target-away translation
during the broad release loop while preserving productive wake-band crossings
and the aligned final approach. Improvement requires target capture with mean
distance below `6.311L` and no material regression from `224.488` arrival,
`0.01602` controller-relative upstream transport, `0.13427` RMS crossflow,
`17.943` RMS force, `361.014` RMS moment, or the observed actuation guard.
Falsify the extension on later/lost capture, unchanged maximum excursion paired
with worse mean distance, load or effort growth, reduced upstream transport,
or visible extra switching. A later worker should then restore the evidenced
`0.08` value and treat it as the local anchor rather than intensifying the
instantaneous counter-drift term again without time-resolved evidence.
