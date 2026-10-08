# Multi-Wake Candidate Diagnosis and Hypothesis

## Evidence diagnosis

- The assigned parent guidance says that the target-blind seed's early upstream
  motion is genuine propulsion but not course control, and that positive
  body-frame bearing curvature is only a conditional direction signal. The
  inherited optimizer notes likewise separate the positive-bearing rollout's
  useful upstream leg from its terminal folded-body instability; they do not
  claim that radial phase regulation or derivative feedback has succeeded.
- The common prewarm sheet shows the held fish at the upper-right release pose
  while four overlapping vortex streets develop across the target corridor.
  This is identical initial-condition evidence for all candidates, not a
  controller effect.
- The target-blind seed is the strongest finite sampled rollout by score among
  the non-unstable examples. Its released sheet shows active leftward motion
  followed by an increasingly vertical descent and lower-boundary exit, never
  useful wake entry. Its head moves `(-3.55,-13.30)L`; the `8.61L` minimum
  range rebounds to `12.12L`, and mean velocity y (`-0.263`) nearly equals
  local-flow y (`-0.241`). Both joint speeds and accelerations reach their hard
  caps, so this is a cap-demanding gait that is largely advected laterally.
- The positive-bearing, angle-only oscillator is the sole sampled controller
  with meaningful target progress. Visually it changes the initial diagonal
  pose into sustained nearly horizontal upstream travel, keeping net lateral
  displacement to `+0.15L`; then the body folds sharply in the final frame
  before `unstable_dynamics`. Metrics agree: head x is `-3.59L`, progress is
  `0.259`, and minimum range is `9.01L`, while both acceleration caps and the
  joint-one speed cap are reached and RMS force/moment jump to
  `20024/314391`. The useful upstream segment is therefore active propulsion,
  not advection, but the `16 deg` bearing bias and unguarded high-energy joint
  state are not finite control.
- Two newly sampled positive-bearing policies used radial phase-energy
  regulation with slower/lower gaits. Their released sheets show little useful
  body wave or turn toward the target; both remain to the right of the wake
  corridor and exit downstream. Their head displacements are
  `(+2.24,-2.79)L` and `(+2.27,-4.79)L`, progress is `-0.126/-0.122`, and mean
  x velocity is within `0.0032/0.0017` of mean local-flow x. They are finite and
  low-load (`19.5--21.5` RMS force, about `377--379` RMS moment), but they do
  not preserve the upstream propulsion seen in both angle-only oscillators.
  Because period, amplitude, limits, and one derivative term also changed,
  this is not a pure regulator ablation; it is nevertheless direct negative
  evidence against continuously replacing the useful angle-only drive with
  the sampled radial regulator in the next candidate.
- The inherited bearing-window-rate candidate is an additional negative
  boundary: joint one reaches `0.781rad` and it fails unstable after `1.66`
  time with RMS force/moment `59346/608198`. The current candidate should not
  add bearing, turn-rate, moment, or load derivatives before a finite
  bearing-only loop exists.

## One candidate hypothesis

Retain the `0.75`-period positive-bearing rollout's demonstrated angle-only
state oscillator and posterior traveling lag, but make the smallest
evidence-directed changes needed to combine propulsion, diagonal course, and
finite joint demand. Slow the period slightly to `0.80` while retaining a
`22 deg` amplitude: its nominal anterior speed and acceleration are about
`173 deg/time` and `1357 deg/time^2`, below the `260/1800` envelope. Reduce the
bearing limit from `16` to `12 deg` and gain from `0.75` to `0.60`. The visual
expectation is that this preserves upstream motion but no longer removes all
of the useful downward component toward a target that starts below the fish.

Do not use the sampled radial drive, which acted over the entire nominal phase
orbit in the two downstream exits. Instead, add policy-owned joint-angle and
joint-speed guards that are exactly inactive below `34 deg` and
`200 deg/time`, then smoothly bound final acceleration below
`1600 deg/time^2`. These guards should leave the nominal angle-only gait nearly
unchanged and intervene only on the sampled route to rate-cap contact and body
folding. All thresholds and gains are owned by `target_policy_params`; the law
uses only normalized body-frame bearing and joint state, with no coordinates,
route, clock, prescribed inflow, or unavailable wake probes.

The next CFD evaluation supports this candidate only if head x remains
negative relative to the release pose, head y becomes moderately negative
without a near-vertical exit, and the fish remains finite beyond `33.06` time
without hard rate/acceleration contact or a terminal force/moment spike. It is
falsified if it drifts downstream like the radial-regulation samples, if the
reduced steering restores the seed's lower-boundary plunge, or if localized
guards merely delay the same folded-body instability. No new-rollout result is
claimed in this worker.
