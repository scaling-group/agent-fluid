# Terminal transverse-course posterior-pulse candidate

## Evidence and visual diagnosis before editing

All four sampled evaluations report direct uniform still water with
`U_infinity=(0,0,0)`, no cylinders, and no prewarm. I inspected the combined
top-down vorticity and oblique Lambda2 sheets for the strongest finite sample
(`solver_d32fb3a02de7`) and the informative prefill failure
(`solver_ec81137f627b`). Both are self-propelled and leave body-connected,
alternating three-dimensional wakes. The prefill failure nevertheless develops
a large curved excursion, pins each joint at `45 deg` (posterior `>40 deg`
dwell `25.4%`), reaches only `4.64998L`, and exits with its head at
`(8.200,15.150)L`. Its failure is loss of target-course control, not absent
thrust or passive advection.

The assigned parent's posterior-pulse policy is the best supported base. Its
new sampled rollout captures at `15.983T` and `0.749982L`, following the
inherited identical-configuration response-gated miss at `0.81002L`. The
capture sheet retains a compact alternating wake through approach, and the
trajectory has zero joint-angle dwell above `40 deg`. This semantic improvement
supports retaining the predictive intercept, yaw-confirmed actuator handoff,
and posterior mid-stroke pulse rather than returning to the prefill's
phase-compensated full-drive approach.

The capture remains nearly tangential. At termination its head is
`(9.619,9.077)L` with world velocity about `(-1.052,-0.515)L/T`; the other
sampled capture ends at `(9.656,9.140)L` with velocity
`(-1.093,-0.408)L/T`. Thus both successful policies cross the lower-right edge
with substantial transverse motion, while the inherited repeat escaped
lower-left. The assigned parent's posterior pulse is requested by predicted
miss, whose magnitude contracts with target distance even when the instantaneous
course still cuts sharply across the line of sight. That leaves a concrete
terminal slip/course residual to test without changing the evidenced far-field
carrier.

## Single candidate hypothesis

Start from the completed sampled `d32` capture policy. Preserve its traveling
bend, body-frame predicted-miss gate, bounded terminal mean bend,
yaw-confirmed half-cycle handoff, and joint-speed-gated posterior pulse. Add one
bounded terminal feedback mechanism: during the ordinary near-target gate,
blend the signed sine of target-relative course error into only the posterior
mid-stroke pulse. This residual persists when transverse course remains large
even as geometric predicted miss shrinks, yet it vanishes outside the terminal
region, at beat reversal, and when course aligns. It neither brakes the
symmetric carrier nor adds static curvature.

Support requires capture with a more central approach signature—smaller
target-normal velocity or visibly less tangential lower-edge crossing—while
retaining the compact wake, zero `>40 deg` dwell, similar load scale, and
far-field route. Falsify on loss of capture, another lower-left escape,
posterior pinning, rate/load growth, wake degradation, or no reduction in the
terminal transverse-course signature. The current candidate's CFD evaluation
occurs only after this worker exits, so no outcome is claimed here.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and fish terminal-approach control
source_mechanism: preserve a propulsive rhythm while a bounded sensor residual reshapes posterior motion to reject remaining target-relative transverse course
transferable_invariant: keep the evidenced carrier intact and recruit a small observation-gated posterior correction only while measured approach misalignment persists
nontransferable_details: published gains, clock phase, robot linkage geometry, species-specific kinematics, dimensional frequencies, exact vortex phases, and task-specific routes
policy_translation: use the sine of normalized body-frame target-versus-velocity course error under the near-target gate to augment only the joint-speed-gated posterior target pulse
falsification: reject if capture or terminal course geometry fails to improve together, or if wake coherence, far-field translation, joint reserve, loads, boundedness, or reflection symmetry degrades

## Dry validation only

The mandated guidance-materiality/schema check, lightweight Julia policy
contract, and editable-boundary check pass. A deterministic `19,440`-state
grid spanning fore/aft and lateral target geometry, body-frame velocity,
distance, both joint states, and heading response produced finite commands
strictly inside the smooth `30 rad/T^2` envelope. Exact left/right reflection
error was `0.0`. In a constructed closing terminal state, disabling only the
new course residual changed posterior acceleration by
`0.02096 rad/T^2`; at `12L` the change was exactly `0.0`. These checks establish
schema, boundedness, symmetry, and gate semantics only; no CFD was run.
