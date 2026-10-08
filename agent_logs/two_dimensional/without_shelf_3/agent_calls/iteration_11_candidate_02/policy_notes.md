# Multi-wake candidate diagnosis and hypothesis

## Evidence read before the policy edit

- The shared prewarm sheet shows the fish held at the common upper-right pose
  while four developed, overlapping vortex streets convect around the target.
  It is common initial-condition evidence, not a policy effect. Every released
  sheet remains outside the target-centered second-row corridor, so this
  candidate addresses far-field course retention rather than wake capture.
- The strongest finite anchor is the guarded angle-only oscillator with
  bearing gain `0.60`, a `12 deg` steering ceiling, anterior allocation `0.35`,
  and fixed opposing recent-turn gain `0.04`. Its sheet shows a sustained,
  nearly horizontal upstream leg followed by a nose-up pitch and upper U-turn.
  The metrics confirm self-propulsion during the useful leg: mean x velocity
  `-0.0673` exceeds the local upstream-flow magnitude `-0.0457`, head travel is
  `(-4.08,+1.80)L`, minimum range is `6.71L`, progress is `0.217`, and finite
  RMS force/moment are `66.5/958`.
- The sampled higher-authority controller pitches upward sooner and shows
  tighter body curvature. It moves only `-2.45L` upstream, never gets closer
  than `10.35L`, and raises RMS force/moment to `350/5007`. The evaluated
  `10/14 deg` ceilings, range-gated damping increase, always-active lateral
  velocity subtraction, and nearby uniform damping changes all likewise begin
  the same loop earlier or shorten the upstream leg. The anchor's target-forward
  steering law, allocation, and `0.04` damping therefore must remain unchanged
  during the demonstrated approach.
- The inherited step-10 outcomes reject two proposed terminal discriminants.
  Scaling the whole steering command down to a `0.35` floor whenever the short
  history window reports opening range still makes the upper turn early: head-x
  travel falls to `-2.27L`, minimum range worsens to `7.99L`, progress falls to
  `0.099`, and RMS force/moment rise to `117/1568`. Opening speed alone is not
  a sufficiently selective terminal gate. Moving mean steering bias from the
  anterior oscillator to the posterior joint is worse: fractions `0.30` and
  `0.25` move only `+0.07L` and `+0.46L` in x, with negative progress, despite
  finite lower loads. Static joint margin therefore does not imply safe
  curvature reallocation; the anchor's `0.35/0.65` split is part of its
  propulsion mechanism.
- In the anchor and every finite descendant, the released sheets show the fish
  pitching until its nose points away from the target just before the upper
  boundary exit. The observation contract exposes signed body-frame target
  geometry, but `state.bearing` is computed with the absolute longitudinal
  separation and therefore does not distinguish a target in front from one
  behind. Signed forward target position is the remaining evidence-backed gate
  that can be exactly inactive on the useful initial leg and active only after
  the visible course has rotated past the target direction.

## One candidate hypothesis

Keep the anchor's oscillator, guards, `0.60` bearing gain, `12 deg` ceiling,
`0.35` anterior allocation, and `0.04` recent-turn damping exactly while the
target is forward. Compute a smooth rearward gate from the normalized signed
body-frame target x component. Only when the target moves behind the fish,
increase opposing recent-turn damping by at most `0.02`, over a `0.5L`
front/back transition. Unlike range-only gating, the new term cannot activate
during the anchor's target-forward upstream leg; unlike changing the steering
ceiling or allocation, it does not alter static target authority or the
progress-producing traveling bend. Its intended effect is to arrest the
observed nose-up angular continuation after the target becomes rearward, so the
unchanged bearing term can recover a target-facing course before domain exit.

This is one isolated structural test, not a claim of same-worker CFD
improvement. It is supported only if the early rollout retains approximately
`-4.08L` upstream travel and the `6.71L` approach, then delays or removes the
upper return without raising joint/load extrema materially. It is falsified if
the gate perturbs the target-forward leg, repeats an upper or lower full return,
worsens closest range, or raises cap contact or loads. The gate uses normalized
body-frame target geometry only and contains no coordinate, clock, route,
prescribed inflow, remote probe, target-station flow, or omitted-shelf input.
