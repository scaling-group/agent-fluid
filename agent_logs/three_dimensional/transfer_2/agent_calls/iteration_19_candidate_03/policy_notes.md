# Middle-course half-cycle candidate

## Visual and diagnostic evidence before the policy edit

- All four sampled episodes satisfy the frozen evidence contract: direct
  uniform `U_infinity=(0,0,0)` initialization, no cylinders or prewarm,
  stable dynamics, and capture termination. They arrive in
  `19.360--19.552T`, with mean distance `2.08911--2.09458L` and score
  `-0.20560-- -0.19989`; the new candidate must preserve this established
  semantic class rather than solve a missing-capture problem.
- Both rows of the combined keyframe sheets for the strongest sampled
  response-gated bend (`solver_1af6c62469a7`) and weakest sampled posterior-
  authority composition (`solver_cb03d3cda781`) were inspected from release
  to capture. Their top-down views show genuine self-propulsion from quiescent
  water, a compact alternating vortex street, a direct approach, and nearly
  identical smooth terminal hooks. Their oblique views show coherent compact
  Lambda2 structures trailing the fish without wake collapse, collision, or
  instability. Thus the score separation does not identify a new wake or
  trajectory topology.
- Trace evidence agrees. The response-gated bend is fastest and has the lowest
  integral (`19.360T/2.08911L/-0.19989`) and a `12.591L` center path, while
  the posterior-approach multiplier reaches
  `19.431T/2.09458L/-0.20560` and `12.598L`. The former also lowers mean
  absolute yaw below `2L` to `0.285 rad/T`, versus `0.349--0.406 rad/T` for
  the posterior-lag and amplitude samples, while retaining the common peak
  force/moment class near `0.025/0.013` and joint angles below `0.61 rad`.
  Its cost is high anterior effort (`19.25 rad/T^2` mean absolute command and
  `37.1%` residence above 90% of the smooth bound), so extra raw drive is not
  supported.
- The assigned parent's approach-time posterior carrier/lag multiplier does
  not improve its response-gated base: it delays capture by `0.071T`, raises
  mean distance by `0.00547L`, and raises posterior near-bound command
  residence from `33.32%` to `34.16%` without changing the wake class.
  Inherited logs independently show that selective posterior rate unloading
  lowers effort but delays capture to `20.207T`, raises the integral to
  `2.14149L`, and widens the terminal arc while both joints still reach the
  hard rate limit. Posterior carrier scaling in either direction is therefore
  not a useful next mechanism on this release.
- Inherited guidance supports joint-state half-cycle asymmetry as the last
  clear trajectory improvement, but its composition with middle-field course
  correction remains untested. Existing course feedback acts through mean
  curvature throughout the approach. The clean unresolved question is whether
  actual velocity-course error can instead select the useful steering stroke
  before the terminal regime, without adding curvature, drive, a clock, or a
  memorized route.
- Reconstructing the same normalized body-frame target and velocity convention
  from the strongest trace gives 962 samples in the proposed `2--6L` window,
  with mean absolute course error `0.216 rad`. The proposed bounded coupling
  would contribute mean/max absolute phase-request increments of
  `0.132/0.387` before the final `[-1,1]` clamp (`0.138/0.397` in the assigned
  parent). The observation is therefore material but remains subordinate to
  the existing bounded route request; its exact zeros outside that window are
  the applicability boundary.

## One-candidate hypothesis

Restore the strongest sampled response-gated posterior-bend scaffold. Preserve
its state-feedback traveling wave, fore/aft-aware body-frame target mapping,
distance/closing drive relief, bounded course redirect and LOS-rate lead,
target-derived half-cycle steering, yaw-opposition posterior bend, and smooth
command limit. Add one reflection-equivariant middle-distance coupling: form a
bounded velocity-course turn request, multiply it by a window that is zero at
the outer approach boundary and at the `2L` terminal boundary, and blend it
only into the joint-velocity-derived useful/return-stroke selector. It changes
which stroke receives existing authority; it adds no mean curvature or raw
propulsion and leaves far-field and terminal control exactly unchanged.

Expected signature: preserve capture and the coherent two-view wake while
producing a measurably straighter or earlier middle approach, improving arrival
or distance integral beyond the `19.360--19.552T`/`2.08911--2.09458L` sampled
envelope without increasing near-bound command residence, rate-limit residence,
joint angle, or the approximately `0.025/0.013` load class. Falsify if the
trajectory stays in the same repeat envelope without an effort benefit, the
terminal hook grows, capture or wake coherence is lost, or command, rate,
joint-margin, force, or moment diagnostics regress.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and asymmetric-flapping turning
source_mechanism: use observed directional response to allocate an existing propulsive rhythm between useful and return steering strokes
transferable_invariant: preserve the traveling bend while a bounded body-frame course residual selects the stronger half-cycle, then release that allocation when the residual regime ends
nontransferable_details: published gains, dimensional cadence, robot morphology, full-body waveform, clock phase, exact vortex phase, and task-specific coordinates or routes
policy_translation: blend a bounded velocity-course request into normalized anterior-joint phase only inside a continuous middle-distance window, under the existing two-joint state-feedback contract
falsification: reject if capture, repeat-resolved timing or distance integral, path topology, wake coherence, command and rate residence, joint margin, force, or yaw-moment class fails to improve or regresses
