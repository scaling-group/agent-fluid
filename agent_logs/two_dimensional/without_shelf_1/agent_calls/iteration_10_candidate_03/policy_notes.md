# Multi-wake target-policy candidate notes

## Visual and metric diagnosis

- The shared prewarm sheet is the common certified initial condition: the held
  fish is near the upper-right boundary and the four interacting cylinder
  wakes are developed around the second-row target. It is not evidence for
  any candidate-specific advantage.
- The strongest sampled finite rollout (`11 deg` posterior bias, `25 deg`
  bearing scale, direct heading-rate setting `0.70/0.35`) is self-propelled
  upstream rather than advected: its mean head velocity is about
  `-0.1413 L/time` versus mean local flow `-0.0995`, and head travel is
  `-7.89L`. Its released sheet nevertheless remains above the useful target
  wake, follows a broad upper loop, curls sharply upward in the last two
  frames, and exits the domain. The `4.87L` closest approach, `0.424`
  progress, `+1.20L` center-y exit, and `406/4113` RMS force/moment agree with
  useful propulsion but wasteful turning rather than target capture.
- The assigned parent changed only bearing scale from the `10 deg`, `25 deg`
  anchor to `20 deg`. Its sheet turns upward earlier and retains the same upper
  exit while progress falls from `0.380` to `0.310`, closest approach worsens
  from `5.33L` to `5.77L`, and head travel falls from `-6.93L` to `-5.62L`.
  Increasing small-bearing sensitivity is therefore falsified for this gait.
- The newer inherited phase-headroom candidate visibly curls upward after
  only a short upstream traverse. Its `42 deg` posterior target clamp reduces
  peak posterior angle from the anchor's `0.770 rad` to `0.683 rad`, posterior
  peak rate from `4.538` to `4.423 rad/time`, command-energy mean from `854`
  to `768`, and RMS loads from `325/3331` to `215/2535`; however, progress
  collapses to `0.102`, closest approach worsens to `8.37L`, and head travel
  falls to `-2.31L`. The lower load is evidence that clipping the propulsive
  posterior target removed the useful traveling bend, not evidence of a
  steering repair. Two other inherited oscillator-phase steering-relief
  variants agree: progress falls to `0.250` and `0.035` with closest approach
  `6.88L` and `8.94L`, while the same approximately `+1.20L` center-y exit
  remains.
- All unallocated anchor-family samples reach the `260 deg/time` posterior
  rate cap and `1650 deg/time^2` posterior command cap. The failed allocation
  tests show that target or steering suppression over a broad oscillator phase
  destroys propulsion. A useful next probe must act on measured posterior
  servo saturation itself and leave the desired traveling-wave target intact.

## Single candidate hypothesis

Restore the complete `10 deg` bias, `25 deg` bearing scale, and `0.70/0.35`
direct-heading-rate anchor. Add only a posterior actual-rate soft brake: above
a parameter-owned `220 deg/time` threshold, subtract acceleration proportional
to the excess posterior rate with gain `10`. The brake is symmetric and
inactive through the lower `85%` of the measured hard-rate envelope. It does
not alter the anterior oscillator, posterior target, target-bearing feedback,
tail lag, nominal tail damping, final-distance fade, or either acceleration
ceiling.

This isolates a posterior servo-dynamics repair from the disproven
phase-allocation family. It is supported if posterior peak rate moves below
`260 deg/time` while upstream progress stays near or above `0.380`, and if the
fish approaches below the repeated upper loop, improves on `5.33L` closest
distance, or avoids the upper exit without higher loads. It is falsified if
the posterior rate and command caps persist, if progress falls materially, or
if the same `+1.20L` upper exit repeats without a closer approach. A negative
result should restore the unbraked anchor; later workers should then test a
single posterior servo stiffness/damping change, not another oscillator-phase
allocation, smaller bearing scale, or direct yaw-rate retune.
