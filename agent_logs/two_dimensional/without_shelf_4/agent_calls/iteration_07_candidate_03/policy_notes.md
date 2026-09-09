# Multi-wake candidate diagnosis and hypothesis

## Evidence read before the policy edit

- The four shared-prewarm sheets are byte-identical. They show the fish held
  high and downstream/right while the four staggered cylinder streets develop
  and overlap through the target corridor. This is common initial-condition
  evidence and cannot rank policies.
- All four current released sheets are byte-identical, and their physical
  metric values agree apart from wall-clock runtime, for the evaluated
  `20.25 deg`, `0.67`-period controller. The fish is
  actively oscillating rather than passively advected: it makes a broad turn
  on the right, reverses heading through several visible zig-zags, enters the
  interacting wake, and approaches the target from the right without
  collision, domain exit, breakup, or final rebound. It reaches `0.7498L` at
  `244.547`, with mean distance `6.452L`, head displacement
  `(-10.916,-4.187)L`, and maximum lateral target offset `4.293L`.
- The flow/load cross-check supports wake-assisted self-propulsion but also
  identifies lateral route waste. Mean body velocity x `-0.04443` is more
  upstream than mean local-flow x `-0.03649`, so the gait contributes about
  `-0.00793` relative x velocity rather than merely drifting. At the same time,
  RMS relative crossflow is `0.1344`, RMS lateral force is `18.263`, and RMS
  moment is `362.21`; the wide visible turns therefore agree with finite
  lateral and rotational loading. The anterior maximum `31.055 rad/time^2`
  stays below the policy's `31.2` guard but leaves no supported amplitude
  headroom.
- No sampled failure sheet is present in this rendered workspace. The most
  informative failure boundary is therefore inherited textual and diagnostic
  evidence, not a newly claimed visual comparison: the matched `19 deg`
  controller survived the full horizon but stopped at its `5.812L` minimum,
  while the coupled `21 deg`, `0.69` variant rebounded from `3.246L` to a
  `3.610L` miss. The inherited `0.28`-versus-`0.30` bearing-scale comparison is
  the decisive steering negative: sharpening the scale crossed only `3.36`
  units earlier but worsened mean distance from `7.218L` to `8.112L` and
  raised RMS lateral force from `18.262` to `18.583`.
- Assigned-parent guidance consequently rules out more amplitude, sharper
  steady bearing gain, and coupled posterior-phasing changes. The current four
  physically identical replications strengthen the positive boundary for the `20.25 deg`
  shell, while their shared `4.293L` lateral excursion leaves bounded steering
  phase lead as a separable corridor-retention axis.

## Candidate hypothesis

Keep the complete evaluated propulsion and steady-steering bundle: `20.25 deg`
amplitude, `0.67` period, `0.65/0.80` posterior lag/damping, `10 deg` steering
limit, `0.30` bearing scale, and the inactive `31.2 rad/time^2` guard. Change
only `bearing_rate_lead` from `0.25` to `0.35`. Because the observed rate is
already clamped at `0.30 rad/time`, this adds at most `0.03 rad` (`1.72 deg`)
to the predicted bearing. When bearing is already moving toward zero, the
additional lead reduces the posterior mean bend sooner; when bearing is
diverging, it strengthens correction. Zero-rate and steady-bearing behavior
remain identical to the evaluated controller.

This candidate uses only the existing body-frame bearing and its bounded
history-window rate. It adds no coordinates, route, elapsed-time switch,
prescribed inflow, remote wake probe, target-station signal, or morphology
change. The next CFD evaluation should preserve capture while reducing the
broad zig-zag, maximum lateral target offset, mean distance, and preferably
RMS moment without contacting the acceleration guard. Falsify the phase-lead
hypothesis if capture is lost or later than `244.547`, mean distance is not
below `6.452L`, the `4.293L` lateral offset does not contract, or force/moment
load grows. On falsification, restore the evaluated `0.25` lead; do not
compensate with amplitude above `20.25 deg` or bearing scale below `0.30`.
