# Half-cycle terminal-curvature candidate

## Visual and quantitative diagnosis before editing

- All four sampled rollouts satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm snapshot, stable dynamics,
  and capture. In the combined sheets, the top-down rows show self-propelled
  broad target-directed arcs and strong alternating vortex trains; the oblique
  Lambda2 rows show coherent paired three-dimensional shedding through
  capture. The assigned parent, fastest sample, and slowest sample have no
  visible carrier breakup, and their terminal differences are below keyframe
  resolution. There is no current failure sheet. The available failure boundary
  is inherited: replacing this carrier with opposite-sign static posture caused
  weak-wake upper exits, including one rollout with `78.0%` posterior
  angle-limit exposure.
- The strongest sampled finite result is the v24 phase-demodulated course brake
  (`solver_8ce1bc88a53c`): capture at `23.8315T` and scoring mean distance
  `2.434073L`. It gains closing speed at the cost of terminal motion: peak yaw
  is `3.208 rad/T`; inside `3L`, mean absolute yaw, target-transverse speed,
  lateral-force coefficient, and yaw-moment coefficient are respectively
  `1.684 rad/T`, `0.239U`, `0.01179`, and `0.00640`.
- The assigned-parent v25 direction-consensus gate (`solver_3b3fa6c1a86f`)
  still captures, but arrives later at `23.8590T` with a slightly worse scoring
  mean distance of `2.434115L`. Its peak yaw falls only to `3.176 rad/T`, while
  the same inside-`3L` measures remain `1.683 rad/T`, `0.238U`, `0.01177`, and
  `0.00638`. Thus hard suppression when course and yaw signs disagree gives no
  material route/load benefit and sacrifices some of v24's progress.
- The slower approach allocator (`solver_8c3d920cc8a5`, `23.9250T`,
  `2.435081L`) and carrier-rejected course controller
  (`solver_f5439f78a42a`, `23.9360T`, `2.434807L`) show the opposite side of the
  trade: inside `3L`, mean absolute yaw falls to `1.585/1.582 rad/T` and
  target-transverse speed to `0.227/0.216U`, but mean closing speed falls to
  `0.667U` from v24's `0.683U`. All four have zero sampled angle-limit exposure
  but essentially identical anterior/posterior velocity-cap exposure near
  `19.8%/9.4%`, so another posture-range or projection-gain edit is not the
  evidenced missing capability.
- Inherited logs establish that the traveling-wave carrier, same-sign C-bend,
  response release, and smooth acceleration projection are the reliable
  layers. Recent terminal residuals changed sub-keyframe dynamics without a new
  semantic outcome. The remaining testable question is how terminal correction
  is coupled to the beat, not whether the carrier needs replacement or a scalar
  gain increase.

## Policy hypothesis

Use the evaluated v24 controller as the sole base and retain its continuous
normalized body-frame course/yaw brake signal. Replace only its phase-independent
terminal mean-curvature application with a state-derived half-cycle application:
the normalized posterior tangent velocity identifies the current stroke, and
terminal curvature is reinforced smoothly only while that stroke is moving in
the requested correction direction. This transfers steering authority from a
static offset to beat-compatible asymmetry without a clock, mutable phase,
global route, target identity, or scalar-only gain probe.

The candidate should keep v24's capture, closing progress, alternating wake,
C-bend polarity, response release, and physical projection while reducing the
route-scale yaw/cross-track/load cost of continuous terminal curvature. Falsify
it if capture is lost, arrival exceeds `23.9T` or scoring mean distance exceeds
`2.435L` without a material yaw/load improvement, the alternating wake weakens,
or joint-speed/command exposure grows. The new CFD result is unavailable to
this worker and is not claimed as evidence.

## Bookshelf transfer

```text
bookshelf_consulted: true
source_domain: robotic-fish CPG half-cycle amplitude and duty-ratio turning
source_mechanism: generate mean turning by state-synchronized asymmetric strokes while retaining a propulsive rhythmic carrier
transferable_invariant: couple a bounded route-scale turn residual only to the observed half-cycle already moving toward the requested bend instead of imposing phase-independent curvature
nontransferable_details: published gains, dimensional cadence, robot linkage kinematics, species-specific envelopes, exact oscillator or vortex phase, and prescribed routes
policy_translation: normalized body-frame target, velocity, and yaw observations retain the v24 brake request; normalized two-joint posterior tangent velocity supplies the beat-side gate for the existing two-joint curvature targets
falsification: reject if capture or coherent alternating-wake topology is lost, or if arrival, mean distance, terminal yaw/course, loads, joint-speed exposure, or command exposure do not jointly improve over the v24 and v25 evidence
```
