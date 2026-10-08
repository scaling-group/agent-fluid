# Multi-wake target-policy candidate notes

## Visual and metric diagnosis

- The shared prewarm sheet is common initial-condition evidence: the fish is
  held near the upper-right boundary while the four interacting cylinder wakes
  develop across the route to the second-row target. It does not distinguish
  the sampled controllers.
- Every released sheet shows active upstream swimming rather than passive
  advection. In the strongest finite sample, mean head velocity is about
  `-0.136 L/time` while mean local flow x is `-0.099`; the fish travels
  `-7.89L` upstream. None of the samples enters the useful target wake. They
  travel left above it and then curl sharply upward into a domain exit.
- The new `11 deg` static posterior-bias sample is the best approach by score,
  closest distance, and progress: relative to the otherwise identical
  `10 deg`, damping/scale `0.70/0.35` anchor, upstream head travel changes from
  `-6.93L` to `-7.89L`, closest distance from `5.33L` to `4.87L`, and progress
  from `0.380` to `0.424`. This is useful evidence that the positive posterior
  steering sign still contributes to target approach.
- The same comparison falsifies further static-bias increases as the lateral
  repair. Head-y exit displacement is effectively unchanged (`+1.797L` versus
  `+1.792L`), the keyframes retain the same final upward curl, posterior peak
  angle rises from `0.770` to `0.781 rad`, and RMS force/moment rise from
  `325/3331` to `406/4113`. Both samples hit both joint-rate and candidate
  acceleration caps. The `20 deg` bearing-sensitivity sample and the
  damping/scale variants `0.80/0.35`, `1.05/0.35`, and `0.70/0.25` also keep
  the upward exit while losing progress, so neither stronger geometric
  sensitivity nor more direct-rate tuning is supported.
- Inherited optimizer notes set complementary boundaries: an `8 deg` static
  bias collapsed progress to `0.095`; target-bearing-rate and lateral-rate
  feedback regressed approach; anterior steering caused an early curled
  instability; and globally weakening the gait reduced loads while moving
  downstream. The next test must therefore preserve the complete propulsion
  oscillator, the positive posterior mean steering, and the best direct
  body-rate setting.

## Single candidate hypothesis

Restore the `10 deg`, damping/scale `0.70/0.35` finite anchor and add one
posterior-only, gait-phase allocation. The normalized nominal posterior
traveling-wave component is computed from joint state as
`-phi_dot[1] / (omega * oscillator_amplitude)`. When that component has the
same sign as the bounded bearing command, multiplying the steering bias by
`1 - 0.35 * alignment` selectively relieves the phase in which static steering
reinforces the posterior excursion. Opposing phases retain the full `10 deg`
request. The allocation is bounded, needs no clock or coordinates, leaves the
anterior oscillator unchanged, and uses only the state already responsible for
the sampled gait.

The evaluation supports this mechanism if it retains upstream self-propulsion
near the `10 deg` anchor while reducing posterior peak angle, RMS load, or the
late upward curl and improves on its `5.33L` closest approach or `55.38`
release survival. It is falsified if the selective relief behaves like a
globally weaker bias—substantially losing upstream progress—or if it repeats
the upper exit without reducing posterior saturation/load. Later workers
should then restore the static `10 deg` anchor and test a different
posterior-servo saturation mechanism, not another bias increase, bearing-rate
channel, anterior steering term, or direct-rate sweep.
