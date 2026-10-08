# Wake-policy candidate notes

## Evidence diagnosis before policy edit

- All four sampled rollouts satisfy the direct-uniform still-water contract
  (`U_infinity=(0,0,0)`, no prewarm) and capture at `22.154001T`. Three
  executable-identical traces have score `-0.210952`, mean distance
  `2.105583L`, and crossing distance `0.748384L`. The current prefill's extra
  proximity lead on posterior recovery allocation is therefore semantically
  inert relative to the fixed-lead sample: their full trajectories and action,
  force, moment, and rate-cap summaries are identical.
- The complete combined sheet shows a self-propelled S-route, a persistent
  alternating mid-plane vortex street, and discrete three-dimensional
  Lambda2 structures from release through capture. The fish remains rhythmic
  at `20T` and enters the target from its lower-right side rather than coasting.
  The other three sampled combined sheets have blank oblique rows, so they
  support the same top-down route numerically but are not independent 3D-wake
  confirmation.
- The response-gated anterior redirect sample is the informative negative
  comparison. It preserves capture time and the peak normalized force/moment
  (`0.030897/0.015839`) while reducing mean action from `59.932` to `59.695`
  and anterior rate-cap occupancy from `11.50%` to `11.02%`; nevertheless it
  increases mean distance to `2.105967L`, adds a moving-window shift, and
  arrives on a more laterally misaligned terminal trajectory. Instantaneous
  target-signed fluid moment is therefore not a useful release certificate for
  the anterior burst in this controller.
- Relative to the assigned-parent boundary (`22.159500T`, `2.105808L`), the
  sampled proximity-previewed posterior half-cycle envelope advances capture
  by one control step and lowers mean distance to `2.105583L`. Its unchanged
  launch and complete two-view carrier bound support preserving the carrier,
  course, rudder, terminal relief, and posterior-recovery laws.

## Candidate hypothesis

Apply the already evidenced, bounded de-yawed target-line preview to the
*envelope* of the existing anterior redirect, while retaining instantaneous
target side for sign and joint velocity for stroke phase. This is a new
actuator-path allocation, not a gain increase: it moves existing anterior
turning work earlier when target-line translation predicts growing error and
releases it earlier when alignment is predicted. Remove the behaviorally inert
recovery-allocation proximity lead so the candidate tests only this transfer.

Expected result: preserve the unchanged `4/8T` launch and coherent carrier,
then improve on `22.154001T` capture and `2.105583L` mean distance without
exceeding mean action `59.932`, anterior/posterior rate-cap occupancy
`11.50/6.41%`, or peak normalized force/moment `0.030897/0.015839`.
Falsification: later capture, larger mean distance, changed preterminal route,
loss of the alternating two-view wake, or worse action/saturation/load bounds.

bookshelf_consulted: true
source_domain: biological C-start redirect and sensor-modulated robotic-fish CPG steering
source_mechanism: recruit a bounded turn under large observed course error and schedule its release from closed-loop directional response while the propulsive rhythm continues
transferable_invariant: anticipate a changing direction error with measured body-frame target-line motion, but keep turn sign, stroke phase, and authority tied to current observations and the established carrier
nontransferable_details: species-specific burst shape, full-body kinematics, published CPG gains, dimensional timing, and exact tail or vortex phase
policy_translation: use the clamped de-yawed target-line rate and normalized proximity envelope to preview only the anterior redirect error gate; retain instantaneous target-body lateral sign, joint-rate phase qualification, and the existing acceleration ceiling
falsification: reject if the fixed-pose rollout does not beat 22.154001T and 2.105583L or if route, wake coherence, effort, saturation, force, or moment exceed the sampled bounds
