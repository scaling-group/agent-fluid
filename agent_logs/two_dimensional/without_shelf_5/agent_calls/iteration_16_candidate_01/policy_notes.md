# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before editing

- The four sampled shared-prewarm sheets are byte-identical common-initial-
  condition evidence. They show the fish held at the upper-right release pose
  while the four asymmetric staggered-cylinder streets develop, merge through
  the target region, and extend toward the release point. They do not
  distinguish controller quality.
- All four sampled solver policies and released sheets are exact
  `tail_lag_gain=0.75`, `tail_damping=0.65` replicas. The fish promptly turns
  left and down, produces a dense alternating tail trail, enters the developed
  wake corridor, and crosses the target ring without collision, domain exit,
  or instability. Mean fish velocity `(-0.2853,-0.1198)` versus mean local
  flow `(-0.1687,-0.1692)` confirms that the useful leftward traverse is
  self-propelled rather than passive advection. Each repeat reaches at
  `38.049`, with score `0.073801`, mean distance `1.802L`, command
  energy/power `52895/3965`, relative-crossflow RMS `0.2249`, force/moment RMS
  `42.01/653.13`, and anterior/posterior peaks `0.496/0.521` rad. Both joints
  touch the rate and acceleration caps.
- No sampled rollout is a semantic failure. The inherited
  `tail_damping=0.70` rollout is the most informative policy-hypothesis
  failure: its sheet preserves safe active turning and eventual capture, but
  it visibly falls behind the anchor during the middle approach. Its metrics
  agree, regressing to `46.910` arrival, `2.067L` mean distance,
  `66607/5051` energy/power, and score `-0.185818`. Its lower
  `33.13/581.31` force/moment loads therefore come from a much slower traverse,
  not a useful unloading mechanism, while crossflow remains `0.2274` and both
  joints still reach the same hard rate and acceleration caps.
- The inherited symmetric damping bracket makes the response strongly
  asymmetric. Raising damping from `0.65` to `0.675` preserves capture and
  lowers force/moment to `40.10/637.97`, but slows arrival to `41.591`, raises
  mean distance to `1.901L` and effort to `58328/4400`, and increases rather
  than arrests the joint peaks to `0.508/0.551` rad. Lowering damping to
  `0.625` keeps the visible turn-then-diagonal route and improves arrival to
  `37.339` and energy/power to `52247/3947`, with stronger mean leftward speed
  `-0.2908`; however, its score is slightly lower at `0.071866`, mean distance
  is essentially flat at `1.803L`, and crossflow, force/moment, and joint peaks
  worsen to `0.2461`, `47.26/710.38`, and `0.516/0.565` rad. Thus lower
  damping exposes a real speed/effort benefit but `0.625` is not an improved
  incumbent because the load and excursion cost survives the scalar score.
- The assigned parent and other inherited logs already close another small
  phase-lag, steering-gain, or anterior-allocation continuation, and an older
  mixed observation-feedback candidate became unstable. No omitted shelf,
  neighboring configuration, repository history, external coordinates, or
  unscaled new observation is used here. The compact JSON embeds the wake
  diagnostics; there is no standalone local `wake_diagnostics.json`.

## Candidate hypothesis

Preserve the replicated `0.55`-period, 28-degree oscillator,
`tail_lag_gain=0.75`, gain-`1.7` bounded body-frame bearing law, 12-degree
steering bound, fraction-`0.35` allocation, and existing observation set.
Change only `tail_damping` from `0.65` to `0.6375`, halfway toward the
faster-but-loadier `0.625` result. This isolated bracket test asks whether a
smaller damping reduction retains useful posterior traveling-bend response
and active traverse while avoiding enough of the `0.625` crossflow/load
penalty to improve the replicated score anchor. It is not a claim that the
damping response or score is monotone or safely interpolated.

The later CFD rollout supports the candidate only if it reaches the target on
the same visible self-propelled turn-then-diagonal route and exceeds score
`0.073801`, or provides a strict navigation/effort Pareto gain over the anchor
without approaching the `0.625` load envelope. Concretely, an arrival below
`38.049` should accompany mean distance no worse than `1.802L`, effort below
`52895/3965`, and crossflow and force/moment materially below
`0.2461/47.26/710.38`. Loss of capture, collision, exit, instability, score no
better than the anchor, unchanged hard-cap contact with higher effort, or
loads at the `0.625` boundary falsifies the compromise. Any positive result
remains specific to this certified wake phase and start pose until held-out
wake phase or geometry evidence tests it.
