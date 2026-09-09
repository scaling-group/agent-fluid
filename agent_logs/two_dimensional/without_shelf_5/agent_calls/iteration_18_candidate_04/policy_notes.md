# Multi-wake target-policy candidate notes

## Evidence-first visual diagnosis

- The four current shared-prewarm sheets are byte-identical. They show the
  fish held at the upper-right release pose while the four staggered cylinder
  streets develop, merge, and pass through the target region. This is the
  certified common initial condition and does not distinguish policies.
- The assigned `1750 deg/time^2` posterior-cap parent and all three sampled
  `1700 deg/time^2` policies preserve the same safe control topology: the fish
  turns left and down under a dense alternating propulsive trail, crosses into
  the merged wake late in the traverse, and aims through the target ring with
  no collision, exit, or instability. The fish is actively swimming rather
  than merely advected. At `1700`, mean body velocity
  `(-0.3164,-0.1322)` differs materially from mean local flow
  `(-0.1782,-0.1839)`, particularly in useful leftward progress.
- The three `1700` candidate files and released keyframe sheets are
  byte-identical and their physical metrics exactly replicate: arrival
  `34.331`, mean distance `1.714L`, command energy/power `45153/3390`,
  relative-crossflow RMS `0.2312`, force/moment RMS `54.48/766.14`, posterior
  excursion `0.509` rad, and an active `29.671 rad/time^2` posterior ceiling.
  Against the assigned `1750` parent at `35.750/1.741L`, `48243/3614`,
  `0.2257`, `47.39/694.77`, and `0.500` rad, the tighter cap reproducibly
  advances the same route and lowers effort, but increases wake loading.
- Inherited exact `1800`-envelope results extend the same directional sequence:
  they reached at `38.049` with mean distance `1.802L`, energy/power
  `52895/3965`, crossflow `0.2249`, force/moment `42.01/653.13`, and posterior
  excursion `0.521` rad. Thus `1800 -> 1750 -> 1700` improves navigation and
  effort monotonically while crossflow and loads rise; posterior excursion is
  not monotone, so the cap is not an unloading mechanism.
- No current sampled rollout is a semantic failure. The inherited `27`-degree
  amplitude probe is the most informative failed control hypothesis with a
  sheet: it visibly falls behind on the same route and regresses to arrival
  `38.214`, mean distance `1.812L`, and energy/power `53078/3978` despite lower
  `40.03/630.70` force/moment RMS. This rules out mixing weaker global
  propulsion into the cap test. Earlier inherited damping, lag, allocation,
  and gain continuations were non-monotonic, while mixed auxiliary feedback
  became unstable at `2.807`; those axes and the observation set stay fixed.

## Single-candidate hypothesis

Continue only the replicated posterior acceleration-bound axis by one equal
`50 deg/time^2` step, from `1700` to `1650 deg/time^2`. Preserve the
`0.55`-period, 28-degree oscillator, lag `0.75`, damping `0.65`, bounded
body-frame bearing gain `1.7`, 12-degree steering limit, fraction-`0.35`
allocation, and existing observation set. The three exact `1700` replicas
satisfy the inherited requirement to establish repeatability before any cap
continuation; this candidate tests whether the observed navigation/effort
direction persists for one more isolated step, not whether tighter bounds are
generally better.

The later CFD rollout supports `1650` only if it preserves the visible safe,
self-propelled turn-then-diagonal capture and improves arrival below `34.331`,
mean distance below `1.714L`, or energy/power below `45153/3390` without a
material regression in the other navigation/effort measures. Loss of capture,
route change, collision, exit, instability, posterior excursion above the
`0.521`-rad unbounded anchor, or disproportionate growth beyond crossflow
`0.240` and force/moment RMS `65/850` rejects the continuation. A positive
result remains limited to the certified wake phase and start pose until a
held-out wake phase or geometry test is available. No current-worker CFD
outcome is assumed here.
