# Multi-Wake Candidate Diagnosis and Hypothesis

## Evidence diagnosis

- The assigned parent preserves the seed result: a target-blind `0.55`-period,
  `28 deg` oscillator briefly reached `8.61L` range but then followed the
  downward branch of the local flow, touched both joint velocity and
  acceleration caps, and exited after `50.13` released time. The inherited
  worker notes correctly treat its early leftward motion as propulsion evidence
  only, not as a steering success.
- The common prewarm sheet shows four developed, overlapping vortex streets
  between the held upper-right fish and the second-row target. This is the same
  initial condition for every sampled controller. None of the released sheets
  shows useful wake entry or capture, so this candidate is a far-field course
  and stability test rather than a claimed wake-exploitation law.
- The positive, bearing-only curvature candidate is the strongest sampled
  trajectory mechanism. It visibly turns from the release pose into sustained
  leftward travel and moves its head `-3.59L` upstream with only `0.15L` net
  lateral displacement. Its range improves from about `12.42L` to a `9.01L`
  minimum and it reports `0.259` progress over `33.06` released time. However,
  the final sheet shows the body folding into a severe oscillatory turn just
  before `unstable_dynamics`; both acceleration commands reach
  `31.416 rad/time^2`, joint one reaches the `4.538 rad/time` velocity cap, and
  RMS force/moment rise to `20024`/`314391`. Its better scalar score therefore
  does not survive the stability and load evidence.
- Reversing the bearing-curvature sign while adding turn-rate and moment terms
  produced the cleanest joint/load diagnostics (`21.84` maximum acceleration,
  `3.03` maximum joint speed, and RMS force/moment `21.1`/`430`), but the visible
  fish rotates into an almost vertical attitude, moves `+2.74L` downstream and
  `-2.32L` laterally, never improves on its initial distance, and exits after
  `15.86` time with `-0.170` progress. Thus its radial phase-energy regulator
  is worth isolating, while its steering sign and compound rate/load feedback
  are not.
- A second rate-augmented candidate fails even earlier: bearing-window-rate
  feedback centered entirely on joint one, whose angle reaches `0.7814 rad`
  (essentially the `45 deg` hard limit), followed by instability at `1.66`
  time, RMS relative crossflow `3.86`, RMS force `59346`, and RMS moment
  `608198`. The current evidence does not support another derivative or moment
  feedback combination before the bearing-only sign is stabilized.

## Candidate hypothesis

Use the positive bounded bearing curvature from the only upstream-progressing
sample, but reduce its limit to `10 deg` and distribute it `35/65` over the
anterior/posterior joints. Around that moving equilibrium, use the finite
sample's radial phase-energy oscillator instead of the cap-hitting
position-only Van der Pol amplitude term. A `0.82` period and `21 deg`
amplitude retain a state-encoded traveling wave with nominal anterior harmonic
speed and acceleration near `161 deg/time` and `1237 deg/time^2`, below the
`260/1800` envelope. Apply a smooth `1350 deg/time^2` policy-owned acceleration
bound to both raw joint commands so a large wake-driven state error cannot
delegate regulation to the evaluator's hard clip.

Do not add bearing-rate, turn-rate, moment, coordinates, a route, a clock, or
unavailable flow probes in this candidate. The next CFD evaluation supports
the hypothesis only if the fish keeps negative x displacement, avoids the
sampled folded-body load event, remains in-domain beyond `33.06` time, and
improves range without hard cap contact. It is falsified if positive curvature
again produces near-zero/downstream progress, if the reduced `10 deg` command
cannot correct lateral bearing, or if soft limiting merely delays instability
while force/moment and joint excursions still grow. The new candidate has not
yet been evaluated, so no improvement is claimed here.
