# Multi-Wake Candidate Diagnosis and Hypothesis

## Evidence diagnosis

- The shared prewarm sheet shows the fish held at the upper-right release pose
  while four developed vortex streets overlap through the second-row target.
  This is common initial-condition evidence, not a policy effect. Every released
  sample remains to the right of the cylinder corridor, so the present decision
  concerns far-field propulsion, course control, and stability; it cannot claim
  wake entry or capture behavior.
- The target-blind seed visibly produces an upstream body wave before being
  swept downward out of the domain. Its head displacement is
  `(-3.55,-13.30)L`, mean y velocity (`-0.263`) nearly matches local-flow y
  (`-0.241`), and both joint-rate and acceleration caps are touched. Its
  transient `8.61L` minimum range is therefore not controlled navigation.
- Terminal joint-state protection makes the positive-bearing angle-only gait
  finite, but does not by itself fix course. The assigned `16 deg`, gain-`0.75`
  parent moves upstream `-2.45L` yet visibly curls upward and exits after
  `47.35` time with head y `+1.73L`; its RMS force/moment remain elevated at
  `350/5007`.
- The strongest sampled finite controller uses the `0.75`-period, `22 deg`
  angle-only gait, `12 deg` gain-`0.60` bearing steering, `0.04` opposing
  recent-turn-rate damping, and `34 deg`/`200 deg/time` joint guards. Its sheet
  shows a clean self-propelled upstream leg followed by a broad upper U-turn.
  Metrics corroborate both: head x is `-4.08L`, mean velocity x is `-0.0673`
  versus local-flow x `-0.0457`, minimum range is `6.71L`, and it remains finite
  for `65.47` time with RMS force/moment `66.5/958`; head y nevertheless ends at
  `+1.80L` and range rebounds to `9.73L` at the upper exit.
- Two inherited one-parameter continuations sharpen the course-gain boundary.
  Reducing bearing gain to `0.45` while retaining damping `0.04` cuts upstream
  displacement to `-0.73L`, never gets closer than `9.90L`, and still ends at
  head y `+1.79L`, so proportional-gain reduction does not correct the upper
  loop. Raising uniform turn damping to `0.06` instead reaches a better `5.41L`
  minimum but then crosses to a lower/downstream exit: head displacement ends
  `(+2.62,-7.92)L`, final range is `14.73L`, and progress is `-0.185`. The
  identical `0.04` and `0.06` architectures therefore bracket the useful
  lateral correction without supporting either endpoint as a route controller.
- The newest sampled distance-gated `0.04` to `0.06` damping policy regresses
  to a `8.59L` minimum, `-2.48L` head x, and `+1.77L` head y before exiting at
  `53.97` time. Its smooth gate begins changing the controller before the
  nominal `8L` threshold, and the rollout never reaches that threshold. This is
  concrete negative evidence against another range-gated damping schedule in
  the same transition band. Inherited full-orbit radial regulators also remain
  finite but flow-following, so changing the propulsion architecture would
  confound the direct `0.04`/`0.06` course bracket.

## One candidate hypothesis

Use the strongest finite controller exactly, changing only uniform opposing
recent-turn-rate damping from `0.04` to `0.05`. This is the midpoint of the
directly sampled course bracket: `0.04` preserves active upstream propulsion
but turns too far upward, while `0.06` supplies useful target-directed descent
and closer approach before overcorrecting downward and downstream. A uniform
gain avoids the early sensitivity demonstrated by the unsuccessful distance
gate. Keep bearing gain `0.60`, the `12 deg` limit, the complete angle-only
gait, posterior lag, joint guards, and smooth `1600 deg/time^2` action bound
unchanged.

All active constants remain owned by `target_policy_params`; the controller
uses only body-frame bearing, recent turn rate, and joint state. It encodes no
coordinates, target identity, route, clock, prescribed inflow, remote wake
probe, or omitted research shelf. The next CFD rollout supports the hypothesis
only if it retains negative head and relative-flow x, changes net y from the
`0.04` policy's upward drift toward a moderate descent, improves on its `6.71L`
minimum, and avoids both endpoint U-turns without hard-cap or load growth. It is
falsified if the midpoint still exits upward, crosses into the `0.06` lower
exit, loses self-propulsion, or merely moves the same broad loop. No outcome for
this unevaluated candidate is claimed here.
