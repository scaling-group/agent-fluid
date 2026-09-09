# Multi-wake candidate diagnosis and hypothesis

## Evidence read before the policy edit

- The four sampled shared-prewarm sheets are byte-identical. They show the
  fish held high and downstream/right while the four staggered cylinder
  streets grow into an interacting target corridor. This is a common initial
  condition and does not rank candidates.
- Three sampled released sheets and their metrics are also byte-identical
  realizations of the current `20.25 deg`, `0.67`-period, `0.25`-lead anchor.
  The fish is self-propelled through a wake-assisted route: it makes a broad
  down/up release loop and several right-side heading reversals, enters the
  central wake, then approaches nearly horizontally and captures at `244.547`.
  Mean/final distance are `6.452/0.750L`, maximum lateral target offset is
  `4.293L`, and head travel is `(-10.916,-4.187)L`. Mean head velocity x
  `-0.04443` is more upstream than mean local-flow x `-0.03649`, leaving a
  positive `0.00793` controller-relative upstream margin; the motion is not
  passive advection.
- The otherwise matched `20 deg` sample also captures, but later at `266.255`
  with mean distance `7.218L` and only `0.00254` relative-upstream margin.
  Conversely, the anchor's maximum anterior acceleration is already
  `31.055 rad/time^2` against its `31.2` guard and the `31.416` episode cap.
  Together with the assigned parent's `19 deg` horizon miss, this brackets the
  drive shell tightly: neither less nor more anterior amplitude is supported.
- The inherited `0.20` and `0.30` constant bearing-rate leads both lengthened
  the route, capturing at `258.621/270.446` with mean distance
  `8.041/8.499L` and RMS force `18.629/18.958`, versus `6.452L/18.263` for
  `0.25`. The new component-separation result also failed its prediction:
  adding a bounded `0.05` heading-rate lead retained capture but delayed it to
  `259.160`, reduced relative-upstream margin to `0.00359`, and raised
  relative crossflow from `0.13437` to `0.13610`. Its modest force/moment
  reductions (`18.202/357.284` versus `18.263/362.214`) do not offset the
  later, longer route.
- The inherited convergence/divergence switch is the most informative hard
  failure. Its released sheet shows that the fish still turns toward the
  target and enters the interacting wake, but it follows a larger jagged loop,
  advances only `8.038L` upstream, and remains `3.632L` from the target at the
  horizon. It is not a collision, domain exit, saturation, or instability:
  anterior acceleration remains the anchor's `31.055`, while mean upstream
  velocity falls to `-0.02667` in much weaker mean local flow (`-0.01393`).
  The lower `0.13084` relative-crossflow RMS and `17.349` RMS force therefore
  demonstrate that reducing load or crossflow alone is not useful if corridor
  acquisition and self-propelled upstream transport are lost.

## Candidate hypothesis

Restore and preserve the demonstrated oscillator, `0.65/0.80` posterior
lag/damping, `10 deg` steering limit, `0.30` bearing scale, `0.25` constant
bearing-rate lead, and all actuation guards. Add one small body-frame
relative-crossflow term to the existing steering error. The term uses
`relative_flow_velocity_body_U[2]`, the locally observed fluid velocity minus
fish velocity, and is smoothly bounded to `1 deg` with a `0.15` velocity
scale. At the anchor's `0.13437` RMS relative crossflow it contributes about
`0.73 deg` typically and can never dominate the `10 deg` bearing steering.
The sign asks the posterior bend to crab against positive lateral relative
flow while retaining the proven target-bearing response.

This is a bounded corridor-retention test on a distinct normalized signal,
not another bearing gain, lead, closing-speed, heading-rate, or drive-shell
perturbation. The visual hypothesis is that rejecting local lateral advection
will reduce the broad right-side reversal sequence without erasing the
anchor's controller-relative upstream motion or late central-wake entry. The
next fixed-prewarm CFD evaluation must retain capture and improve arrival or
mean distance from `244.547/6.452L`, with no material growth beyond the
anchor's `4.293L` lateral excursion, `0.13437` relative-crossflow RMS,
`18.263/362.214` force/moment loads, or acceleration maximum. Falsify the
mechanism on later/lost capture, reduced relative-upstream margin, noisy
tailbeat-scale steering, increased loads, or a larger detour. If falsified,
restore the plain anchor and do not infer that lower aggregate crossflow is
beneficial without simultaneous route and transport improvement.
