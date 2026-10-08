# Multi-Wake Candidate Diagnosis and Hypothesis

## Visual and quantitative diagnosis

- The shared prewarm sheet shows the fish held at the common upper-right
  release pose while four developed cylinder streets overlap around the
  target. Every sampled release stays to the right of that useful wake
  corridor, so this candidate concerns far-field course retention rather than
  wake capture. The held flow is common initial-condition evidence, not a
  controller effect.
- The uniform-`0.04` guarded controller remains the strongest finite anchor.
  Its released sheet shows a sustained, nearly horizontal upstream leg before
  a clockwise turn toward the upper boundary closes into a broad return. Its
  head moves `(-4.08,+1.80)L`, its mean x velocity exceeds the local upstream
  flow in magnitude (`-0.0673` versus `-0.0457`), and it reaches `6.71L`
  range with RMS force/moment `66.5/958`. The propulsion is active and finite,
  but the turn prevents wake entry and capture.
- Increasing the coefficient on the anchor's subtracted heading-rate term is
  consistently harmful before wake entry. The current range-gated increase
  toward `0.06` repeats the upper turn after only `-2.48L` head-x travel and an
  `8.59L` minimum. Inherited uniform `0.0425` and `0.045` rollouts preserve the
  same topology while upstream displacement falls to `-1.93L` and `-0.15L`
  and minimum range worsens to `8.42L` and `9.59L`; loads do not fall. At
  uniform `0.05`, the course crosses into a long lower return with
  `(+0.33,-13.31)L` displacement and mean y velocity nearly equal to local
  flow. This closes the prior interpolation hypothesis rather than leaving a
  useful coefficient between `0.04` and `0.05`.
- Static steering changes do not repair the loop. Raising the ceiling alone
  from `12` to `14 deg` shortens upstream travel to `-2.46L`; inherited logs
  report that lowering it to `10 deg` gives only `-1.43L`. A large-bearing
  proportional rolloff gives only `-0.50L`, a `10.20L` minimum, and the same
  upper exit. The guarded high-gain sample also exits upward with much larger
  RMS force/moment `350/5007`. Preserve the anchor's gait, guards, `0.60`
  bearing gain, and `12 deg` ceiling.
- The task geometry and sheet expose a sign-level explanation for the failed
  derivative sweep. The initial target produces a positive body-frame bearing,
  while the positive proportional request is followed by negative heading
  rotation in the visible upper turn. During that turn, the current expression
  subtracts a negative `turn_rate_recent`, increasing the positive request.
  Its so-called damping term therefore reinforces the observed rotation; the
  earlier loop under larger coefficients is the expected measured consequence.

## One candidate hypothesis

Restore the strongest finite controller and change only the sign of its
policy-owned heading-rate feedback:
`steering_gain * bearing + turn_rate_damping_gain * turn_rate_recent`, with
gain magnitude `0.04`. Keep the `0.75`-period angle-only oscillator, posterior
lag, `0.60` bearing gain, `12 deg` steering ceiling, local joint guards, and
smooth `1600 deg/time^2` demand bound unchanged. The sign reversal makes a
negative heading rate reduce the positive steering request that visibly
created it, while the zero-rate release command and propulsion architecture
remain those of the anchor. It uses only normalized target-relative geometry,
heading rate, and joint state; it adds no coordinates, clock, route, prescribed
inflow, remote probes, target-station flow, or omitted research shelf.

The next CFD rollout supports the hypothesis only if it preserves meaningful
negative head-x travel and finite loads while delaying or arresting the upper
turn. Strong support would retain or improve the anchor's `6.71L` minimum and
enter the target-side wake corridor without either boundary return. It is
falsified if upstream propulsion collapses, the upper turn is unchanged, a
lower return appears, hard joint/action caps are touched, or force/moment loads
rise materially. No outcome is claimed for this unevaluated candidate.
