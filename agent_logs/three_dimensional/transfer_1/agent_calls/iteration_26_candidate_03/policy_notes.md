# Candidate diagnosis and policy hypothesis

## Evidence read before the edit

- All four sampled rollouts and the inherited step-25 rollouts report direct
  uniform initialization, `U_infinity=(0,0,0)`, and zero cylinders. Their
  translation and wakes are self-propelled rather than prewarm or ambient-flow
  artifacts.
- I inspected both rows of the combined keyframe sheets for the strongest
  sampled finite rollout, `solver_6b0e320e2f55`, and the assigned-parent
  course-demodulation failure, `solver_5f2cc33a132b`. The capture maintains an
  alternating top-down vortex street and compact oblique Lambda2 structures
  through arrival at `18.601T`. The failure maintains the same qualitative
  traveling wake through its lower pass and lower-domain exit. It is a stable
  control-topology miss, not wake collapse or numerical instability.
- Three sampled exact-byte speed-reserve rollouts capture at
  `0.7466--0.7494L` and `18.320--18.601T`, with closest-pass speed
  `0.827--0.862L/T`. However, inherited logs now add two exact-byte baseline
  lower exits at `1.7276L` and `1.5478L`. Thus the baseline is a useful carrier
  and actuator allocation, but its capture is not repeat-robust.
- The assigned parent's two-joint course demodulation is a concrete negative
  result: it retained both wake views and reduced speed-limit residence to
  about `8.1%/8.6%`, yet missed below at `1.3787L` and exited. A distinct
  anterior-speed-only course compensation also reproduced the baseline failure
  at `1.5445L`. Do not tune either projection coefficient or stack another
  course observer onto them.
- The sampled capture envelope remains coherent despite approximately
  `68.2--68.7%/70.6--71.0%` action clamping, `10.4--10.6%/11.3--11.6%`
  speed-limit residence, maximum planar force `0.0309--0.0319`, and maximum yaw
  moment `0.0160--0.0167`. Recent failures have comparable or lower loads and
  speed residence, so neither scalar cadence nor clamp-fraction relief explains
  the semantic branch.
- Body-frame geometry separates the branches after the existing intercept gate
  begins. Between `2.75L` and `1.5L`, all four sampled captures have maximum
  target angle `0.468--0.618 rad` and spend `0%` of rows above `0.65 rad`.
  The baseline, anterior-only compensation, and assigned-parent demodulation
  failures spend respectively `82%`, `82%`, and `74%` of that band above
  `0.65 rad`, while their mean projected miss grows to `1.24--1.44L`. The
  existing additive steering is already requested at nearly full sign there,
  so more route gain would mostly add clipping rather than change how the turn
  is realized.
- An earlier posterior wave-shape pulse is informative but not robust by
  itself: the sampled policy captured at `0.7480L`, while an inherited exact
  evaluation missed at `1.2589L`. Its result supports posterior wave-shape as a
  compatible actuator primitive, not an unconditional replay or scalar gain
  tune.

## One candidate hypothesis

Preserve the exact speed-reserve carrier, course servo, response release,
intercept geometry, cadence, and actuator handling. Add one inner-approach
recovery primitive: a small posterior target-bias pulse synchronized by
normalized anterior joint speed, but activate it only in the evidenced
`2.75L--1.5L` branch-separation band when absolute body-frame target angle
exceeds the empirically clean capture envelope. The pulse follows the existing
route turn sign and disappears continuously when the target bearing recovers
or the fish enters the already established inner corridor. This is a
response-gated wave-shape redirect, not a new route, mean curvature, course
demodulator, or scalar-only gain change.

Expected test: recorded-trace replay makes the redirect identically zero for
all four sampled captures because their target angle remains below `0.62 rad`
until the new inner fade is complete. A lower branch receives extra posterior
steering authority at anterior neutral crossings without suppressing the
traveling bend. It should recover capture or at least improve the failure
termination class while retaining the active top-down and oblique wakes.

Falsification: reject the mechanism after any exact capture-like trajectory is
perturbed into an upper miss, after another lower exit without a smaller and
converging target bearing, if the traveling wake weakens, or if clipping,
speed-limit residence, planar force, or yaw moment leaves the sampled capture
envelope. Do not answer failure by tuning only the bearing thresholds or pulse
gain; first test whether the large-bearing branch remains separable.

## Non-CFD implementation cross-check

Replaying the new distance, bearing, and joint-phase gates over the recorded
states makes their product exactly zero on every row of all four sampled
captures (`0/3331`, `0/3309`, `0/3382`, and `0/3367`). It is potentially
active on `827/5785` baseline-failure rows, `824/5822` anterior-compensation
failure rows, and `602/5934` assigned-parent demodulation-failure rows. This is
only a recorded-trace selectivity check; it does not claim the unevaluated
closed-loop CFD result.

bookshelf_consulted: true
source_domain: biological C-start redirection and sensor-modulated robotic-fish CPG steering
source_mechanism: large observed heading error recruits bounded curvature or wave-shape authority, then releases continuously into the propulsive rhythm as heading response appears
transferable_invariant: preserve the traveling carrier and add posterior steering authority only when normalized body-frame geometry shows that ordinary route feedback has entered a persistent large-error branch
nontransferable_details: species-specific C-start kinematics, published CPG gains, dimensional cadence, exact vortex or oscillator phase, world coordinates, and task-specific routes
policy_translation: in the body-frame branch-separation distance band, use excess absolute target angle to gate a bounded posterior target bias synchronized by normalized anterior joint speed and signed by the existing route command
falsification: reject if exact repeats lose capture, the branch merely flips above the target, target bearing fails to converge, either wake weakens, or actuator and load metrics exceed the repeat-backed capture envelope
