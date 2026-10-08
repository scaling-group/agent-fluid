# Closure-qualified low-energy posterior reserve

## Visual and quantitative diagnosis before the policy edit

- All four sampled evaluations satisfy the frozen Phase-2 contract: direct
  uniform still-water initialization with `U_infinity=(0,0,0)`, no prewarm or
  cylinders, stable dynamics, and capture termination. Three are exact
  `dogfish_3d_error_qualified_los_guidance_v7` reruns, so their identical
  `-0.08139542` score is determinism evidence rather than three mechanisms.
- I inspected the release-to-capture top-down vorticity and oblique Lambda2
  rows for that baseline and the strongest sampled finite candidate, the
  low-energy posterior reserve. Both fish self-propel from rest, establish a
  coherent alternating mid-plane street, retain compact three-dimensional
  posterior structures through capture, and show no passive advection,
  collision, wake breakup, or out-of-plane instability. No termination
  failure is available, so the deterministic baseline is the informative
  visual control. The reserve does not create a meaningfully new wake
  topology; its trajectory and terminal state decide whether it transfers.
- The reserve validates the propulsion part of its hypothesis. It improves
  mean score-distance from `1.967391L` to `1.960279L`, score from
  `-0.08139542` to `-0.07395193`, is `0.0440L` closer by `3T`, and reaches
  `4L` about `0.055T` earlier. Reconstructing the normalized anterior
  angle-rate energy with the policy's dynamic cadence shows that reserve
  authority is concentrated in carrier establishment: the mean energy gate
  falls from `0.852` over the first `0.5T` to about `0.002` after `3T`.
- That short transient is not route-neutral. Relative to the deterministic
  baseline, the reserve lengthens center path from `12.8468L` to `13.0672L`,
  reaches the `2.1L` approach boundary `0.033T` later, and delays capture from
  `17.7265T` to `17.9740T`. Final course alignment falls from `0.601` to
  `0.132`, final yaw magnitude rises from `0.901` to `2.146 rad/T`, and
  posterior acceleration-ceiling residence rises from about `64.78%` to
  `65.91%`. RMS planar force and moment remain in the same load class, but the
  early reserve leaves a persistent course-state displacement after its own
  gate has become negligible. The inherited progress-qualified terminal-drive child
  also worsened score, so adding more approach propulsion is contradicted.

## One policy hypothesis

Preserve the sampled error-qualified route controller, odd curvature map,
anterior phase-plane oscillator, posterior lag/emphasis, cadence and approach
handoff, half-cycle steering, and reversal-preserving rate governor. Retain
the score-positive posterior reserve, but require two independent observed
deficits: low normalized anterior carrier energy and absent or weak target
closure. Normalize the existing bounded closing-deficit signal so zero or
negative closure retains full recovery authority, while increasingly useful
positive closure continuously releases the extra posterior target. This is a
feedback-allocation mechanism, not a clocked startup schedule or scalar-only
gain change; it can react after a genuine loss of carrier energy only when
that loss also impairs target progress.

Expected evidence is most of the reserve's early distance benefit with a
smaller body-course perturbation, baseline-like `2.1L` handoff, capture timing,
terminal alignment, and two-view wake. Falsify it if early closure no longer
improves, if the conjunction remains materially active after useful closure
is established, if capture/path/alignment regress, or if joint-limit, force,
moment, or wake-coherence evidence worsens.

bookshelf_consulted: true
source_domain: Lighthill-style posterior reactive propulsion and sensor-modulated robotic-fish state-feedback oscillators
source_mechanism: restore a posteriorly emphasized traveling bend only while measured locomotor state and task progress both indicate a propulsion deficit
transferable_invariant: recovery authority should require an observed carrier deficit and release continuously once the resulting body-frame translation is useful, while route steering remains a separate feedback path
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, exact vortex phases, target coordinates, elapsed startup schedules, and task-specific routes
policy_translation: multiply the anterior phase-plane energy gate by a bounded normalized target-closing-deficit gate before scaling the lagged posterior wave target; retain the established odd two-joint steering and all far/near route logic
falsification: reject if the early distance gain disappears, if reserve authority persists despite positive closure, or if capture timing, route directness, terminal alignment, load class, reflection symmetry, or either visual wake view regresses
