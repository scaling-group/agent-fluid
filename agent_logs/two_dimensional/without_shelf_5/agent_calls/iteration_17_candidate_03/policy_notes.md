# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before editing

- The sampled shared-prewarm sheets are the same common initial condition: the
  fish is held at the upper-right release pose while four staggered cylinder
  streets develop, merge, and pass through the target region. They do not
  distinguish the policies.
- Three sampled policies are exact replicas of the assigned `0.55`-period,
  28-degree, lag-`0.75`, damping-`0.65`, gain-`1.7`, fraction-`0.35` anchor.
  Their released sheets and metrics repeat exactly. The fish turns left and
  down under a dense alternating propulsive trail, crosses into the merged wake
  only late in the traverse, and reaches without collision, exit, or
  instability at `38.049`. Mean fish velocity `(-0.2853,-0.1198)` versus mean
  local flow `(-0.1687,-0.1692)` confirms active leftward swimming rather than
  passive advection. Mean distance is `1.802L`, energy/power is `52895/3965`,
  relative-crossflow RMS is `0.2249`, force/moment RMS is `42.01/653.13`, joint
  peaks are `0.496/0.521` rad, and both joints touch the episode rate and
  acceleration envelopes.
- The strongest sampled finite result changes only the posterior command path
  by imposing a candidate-owned `1700 deg/time^2` ceiling below the contacted
  `1800 deg/time^2` episode envelope. Its five-frame sheet preserves the same
  self-propelled turn-then-diagonal topology and target entry, but it is visibly
  farther along at matched middle and late stages. Diagnostics agree: arrival
  improves to `34.331`, mean distance to `1.714L`, mean velocity to
  `(-0.3164,-0.1322)`, energy/power to `45153/3390`, and the posterior peak to
  `0.509` rad. This is not clean unloading: relative crossflow rises to
  `0.2312` and force/moment RMS jumps to `54.48/766.14`, beyond both the anchor
  and the inherited damping probes. The result is a large navigation/effort
  gain coupled to a load penalty, not evidence that acceleration relief is
  monotonically beneficial.
- No current sample is a semantic failure. The inherited damping-`0.625`
  rollout is the most informative failed control hypothesis with a keyframe
  sheet. It follows the same route and arrives earlier than the anchor at
  `37.339`, but visibly leaves a more disturbed lateral trail; crossflow and
  force/moment rise to `0.2461/47.26/710.38`, posterior excursion to `0.565`
  rad, and mean distance/score regress to `1.803L/0.07187`. Higher damping
  (`0.675` and `0.70`) instead weakens traverse while leaving saturation
  active. Together these inherited logs argue against another damping step or
  combining this probe with lag, allocation, bearing-gain, amplitude, or new
  observation changes.
- The compact observation JSON embeds the wake diagnostics used above; no
  standalone local `wake_diagnostics.json` is present. No omitted shelf,
  neighboring configuration, artifact outside this Phase 2 workspace, or
  repository history was consulted.

## Candidate hypothesis

Preserve the assigned anchor's oscillator, posterior phase target, damping,
bounded body-frame bearing law, steering allocation, and observation set. Add
one candidate-owned `1750 deg/time^2` symmetric ceiling to the raw posterior
acceleration only. This is the midpoint between the anchor's contacted
`1800 deg/time^2` episode envelope and the sampled `1700 deg/time^2` tradeoff.
It is an isolated bracket test of whether modest posterior command shaping can
retain a useful part of the `1700` result's faster active traverse and lower
effort while avoiding its disproportionate lateral load increase; it is not a
linear interpolation claim.

The later CFD rollout supports the candidate only if it preserves the visible
turn-then-diagonal capture and improves arrival below `38.049`, mean distance
below `1.802L`, or energy/power below `52895/3965` without material regression
in the other navigation/effort measures. Force/moment must move materially
toward the `42.01/653.13` anchor rather than reach or exceed the sampled
`54.48/766.14` ceiling result, and posterior excursion must remain below the
anchor's `0.521` rad. Loss of capture, a changed route, collision, exit,
instability, navigation no better than the anchor, or loads no better than the
`1700` result rejects the bracket. Any positive result remains specific to the
certified wake phase and start pose and does not establish robustness or
justify another fine cap interpolation without held-out evidence.
