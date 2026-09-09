# Response-gated posterior counterturn candidate

## Visual and diagnostic evidence before the policy edit

- All four sampled episodes meet the frozen evidence contract: direct uniform
  `U_infinity=(0,0,0)` initialization, no cylinders or prewarm, finite moving-
  window transport, stable dynamics, and `capture` termination. They capture
  at `0.7472--0.7476L` in `19.635--19.817T`. There is no sampled semantic
  failure, so the controlled corridor replication at `19.817T` is the valid
  failure-side visual comparator rather than a fabricated failure diagnosis.
- Both rows of the combined sheets for the batch-best posterior-lag sample
  (`solver_17ed583a64e1`) and the informative corridor underperformer
  (`solver_2adc39f18b21`) were inspected from release to capture. Their top-
  down views show genuine self-propulsion from quiescent water, coherent
  alternating posterior vorticity, and a bounded late hook into the target;
  their oblique views show compact three-dimensional Lambda2 structures
  following the fish without wake collapse, collision, or instability. The
  posterior-lag path is visibly a little shorter, but both remain in the same
  coherent wake and capture class.
- The assigned parent's posterior turn-phase lag allocation is the strongest
  current sample: it captures at `19.635T`, mean distance `2.10246L`, and
  score `-0.21272`, versus `19.706T/2.10594L/-0.21598` for the plain LOS-led
  scaffold and `19.701--19.817T/2.10438--2.10672L/-0.21449-- -0.21655` for
  the unconfirmed corridor pair. It also shortens head path from `12.444L` to
  `12.222L`, lowers mean absolute course error below `4L` from `0.290` to
  `0.233 rad`, and lowers mean absolute lateral speed below `2L` from `0.141`
  to `0.109U`. These trajectory changes support preserving the mechanism even
  though its single-sample timing gain is smaller than the corridor repeat
  span.
- The benefit stays inside the established physical envelope: maximum planar
  force/yaw-moment coefficients are `0.02476/0.01312`, joint angles remain
  below `0.587 rad`, and zero angle-limit residence is reported. The cost is a
  small increase in mean absolute command from `18.20/17.02` to
  `18.55/17.44 rad/T^2`; both rates still touch their hard limit, and command
  residence above 90% of the smooth bound remains about `36.3%/33.9%`.
- The unresolved response is localized rather than a reason to replace the
  coherent carrier. Below `1L`, the parent has already crossed the target
  centerline: the bounded route request is negative while measured yaw stays
  positive, making a normalized wrong-sign-response gate active on every
  sampled terminal step. In that region its mean absolute course error and
  lateral speed are `0.272 rad/0.098U`, versus `0.184 rad/0.037U` for the
  plain scaffold, despite a lower mean absolute yaw rate (`0.339` versus
  `0.451 rad/T`). Inherited logs reject another intercept corridor, raw slip
  curvature, generic redirect lag compression, or previous-action feasibility
  gate; the remaining test is whether the newly supported phase allocation
  can be concentrated when measured yaw still opposes the current route turn.

## One-candidate hypothesis

Preserve the evaluated posterior-lag parent unchanged outside one bounded
response gate. Infer a counterturn demand from the reflection-invariant
product of the current body-frame route request and normalized recent yaw:
zero when yaw is aligned with the requested turn, positive when it is opposed.
Within the existing continuous approach weight, use that demand to strengthen
only the posterior useful/return-stroke lag allocation. Do not add mean
curvature, alter the anterior half-cycle, compress the base lag, read
crossflow, add a clock, or change the propulsion and terminal-relief scaffold.

Expected signature: keep the parent's earlier, shorter target approach and
coherent two-view wake while making the late sign reversal more prompt;
preserve capture and the approximately `0.025/0.013` load class; reduce the
sub-`1L` course/lateral residual without materially increasing mean command,
near-bound residence, or rate-limit residence. Falsify the response gate if
capture timing or distance integral falls back into the `19.70--19.90T`
cluster, the short path is lost, terminal course error or lateral motion does
not improve, the hook grows, or command, joint, load, and wake diagnostics
regress. If falsified, retain the evaluated parent and do not tune this gate
without a held-out release showing the same wrong-sign yaw response.

bookshelf_consulted: true
source_domain: biological C-start response control and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: add a bounded corrective burst only while measured yaw opposes the observed turn request, then release it into the established traveling rhythm
transferable_invariant: use normalized body-frame route demand and measured response disagreement to concentrate posterior wave-shape authority where a commanded reversal has not yet appeared
nontransferable_details: species kinematics, published gains, dimensional burst timing, exact gait or vortex phase, full-body waveforms, and task-specific coordinates or routes
policy_translation: multiply the supported joint-state posterior lag asymmetry by a smooth approach-weighted wrong-sign-yaw gate while preserving its mean lag and the two-joint state-feedback contract
falsification: reject if capture, timing, distance integral, short-path topology, terminal course and lateral residuals, wake coherence, load class, joint margin, rate-limit residence, or command headroom regress beyond completed-rollout variation
