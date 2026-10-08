# Multi-wake target-policy candidate notes

## Visual and metric diagnosis

- The shared prewarm sheet shows the common held fish near the upper-right
  boundary while four mature, interacting vortex streets occupy the route to
  the target behind the second cylinder row. It is common initial-condition
  evidence, not a controller advantage.
- All four released sheets show the same failure topology. The fish first
  generates its own upstream motion and travels leftward above the useful wake
  corridor, then curls sharply upward and exits without turning down toward
  the target. This is self-propulsion rather than passive advection: in the
  strongest finite sample, mean head velocity x is `-0.130` while mean local
  flow x is `-0.091`.
- The `turn_rate_damping=0.70`, `turn_rate_scale=0.35` sample is the finite
  anchor: it reaches `5.33L`, makes `0.380` progress, and displaces the head
  `-6.93L` upstream. The prefilled `0.80/0.35` controller retains the visible
  upper loop but regresses to `5.66L`, `0.351`, and `-6.35L`; raising damping
  to `1.05` also regresses to `5.64L`, `0.369`, and `-6.67L`. Moving the scale
  down to `0.25` is worse still (`6.41L`, `0.291`, `-5.30L`). Thus neither
  more maximum rate damping nor earlier rate sensitivity fixes the lateral
  exit.
- The diagnostics agree with the visible loss of control: every sampled
  variant reaches both `260 deg/time` rate caps and both `1650 deg/time^2`
  candidate command caps. The best sample also reaches `44.1 deg` posterior
  angle and RMS force/moment `325/3331`. More damping can lower posterior peak
  angle slightly, but the `1.05` result shows that this alone does not improve
  the route or load.
- Inherited parent logs provide the orthogonal static-bias boundary. Reducing
  the otherwise identical positive posterior bias from `10 deg` to `8 deg`
  preserved the upward exit but collapsed head travel to `-2.19L`, closest
  approach to `8.22L`, and progress to `0.095`. Target-bearing-rate and added
  lateral-rate channels were also negative, so they are not revived here.

## Single candidate hypothesis

Restore the complete best sampled direct-heading-rate controller
(`turn_rate_damping=0.70`, `turn_rate_scale=0.35`) and vary only its positive
posterior steering ceiling from `10 deg` to `11 deg`. The sampled decrease to
`8 deg` establishes that the static positive bearing authority is still doing
useful work, while the four current samples show that direct-rate tuning is
exhausted. A small upward probe should preserve the anchor's propulsion and
ask for the missing downward turn earlier, without changing the oscillator,
posterior lag, damping, fade, or acceleration ceiling.

This is a falsifiable proposal, not a same-worker CFD claim. It should retain
upstream head travel near `-6.93L` while reducing the roughly `+1.80L` head-y
drift, bending toward the target before the last two keyframes, and improving
on the anchor's `5.33L` closest approach or `55.38` release survival. It is
falsified if the stronger bias merely increases posterior saturation or loads
and repeats the upper exit. In that case later workers should restore the
`10 deg`, `0.70/0.35` anchor and test phase-aware posterior steering allocation
rather than continue rate-gain/scale tuning or add bearing-rate feedback.
