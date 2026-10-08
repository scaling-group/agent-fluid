# Wake-policy candidate diagnosis

## Evidence read before editing

- The shared prewarm sheet shows the fish held at the common upper-right
  release pose while the four staggered cylinder streets develop through and
  beyond the target corridor. It is common initial-condition evidence, not a
  policy difference.
- The two replicated `0.07` lateral-lookahead samples capture with score
  `-4.290729`, elapsed time `245.449`, and mean distance `6.30464L`. Their
  released sheets show a broad initial turn followed by repeated upper/lower
  wake-band crossings and a visibly jagged late approach. Mean upstream fish
  speed exceeds mean local upstream flow (`0.04426` versus `0.03141`), so the
  fish is self-propelled rather than merely advected. Mean controller-relative
  upstream transport is `0.01284`; RMS lateral force/moment are
  `18.399/363.454`.
- The two replicated `0.08` prefill samples follow a shorter-looking corridor
  transit and capture earlier at `224.488`, with mean controller-relative
  upstream transport `0.01602` and lower RMS force/moment
  `17.943/361.014`. They nevertheless score slightly worse (`-4.310836`) and
  have slightly worse mean distance (`6.31061L`) and higher mean command/power
  proxies (`701.390/47.662` versus `691.179/46.964`).
- Both settings remain finite, reach the target, have the same `4.293L`
  maximum lateral target offset and `31.055` maximum anterior acceleration,
  and avoid collision and domain exit. Thus the observed difference is a
  steering-timing route bifurcation, not a propulsion, envelope, or safety
  change. No sampled rollout is a failure; the assigned parent supplies the
  adverse boundary: `0.10` delayed capture to `263.346`, worsened mean distance
  to `6.974L`, and increased load, while inherited bearing-divergence gating
  missed the target.

## Candidate hypothesis

Adopt the exactly replicated `0.07` target-away lateral-velocity lookahead and
leave gait, clamp, bearing/rate steering, and acceleration guard unchanged.
For the fixed scoring contract, this is the strongest directly demonstrated
candidate: both independent samples improve score by `0.020107` and mean
distance by `0.00597L` over the assigned `0.08` parent while retaining safe
capture and reducing mean command and power proxies. The hypothesis is that
the deterministic certified prewarm will reproduce that score-oriented gain;
the later arrival and higher lateral load are explicit costs, so `0.08` remains
the preferred anchor if the objective changes to arrival time, upstream margin,
or load. Falsify adoption if the new rollout does not capture, scores at or
below `-4.310836`, contacts the acceleration guard, exceeds the sampled
`4.293L` excursion materially, or raises force/moment beyond the replicated
`0.07` envelope.
