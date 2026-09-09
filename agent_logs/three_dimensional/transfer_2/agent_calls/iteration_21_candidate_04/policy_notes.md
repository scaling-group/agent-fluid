# Course-response posterior-allocation handoff candidate

## Visual and diagnostic evidence before the policy edit

- All four sampled rollouts satisfy the frozen evaluation contract: direct
  uniform `U_infinity=(0,0,0)` initialization, no cylinders or prewarm,
  finite moving-window transport, stable dynamics, and `capture` termination.
  The scores span `-0.20493-- -0.18691`, capture times span
  `19.3380--19.6130T`, and distance integrals span `2.07622--2.09432L`.
  This candidate therefore refines a proven capture trajectory rather than
  trying to repair propulsion, stability, or the termination class.
- Both rows of the combined keyframe sheets for the strongest current sample
  (`solver_a47435301f18`) and the informative slower distance-only handoff
  repeat (`solver_b5fc80fd779c`) were inspected from release through capture.
  The top-down rows show self-propulsion from quiescent water, a coherent
  alternating vortex street, broadly target-directed travel, and the same
  continuous late hook into the capture circle. The oblique rows show compact
  three-dimensional Lambda2 structures following the fish without passive
  advection, collision, wake breakup, or instability. The useful distinction
  is thus course/path control and effort, not wake or success class.
- The inherited response-aware handoff survived its first evaluation in the
  intended direction. Relative to the two sampled distance-only handoff
  executions, it reduced head path to `12.304L` from `12.416/12.554L`, reduced
  mean absolute body-frame course error in the `2--4L` band to `0.289 rad`
  from `0.347/0.441 rad`, reduced mean absolute lateral speed there to `0.196U`
  from `0.230/0.250U`, and produced the best distance integral (`2.07622L`)
  and arrival (`19.338T`). It retained the coherent two-view wake, zero
  angle-limit failure, and the sampled peak force/moment class at
  `0.02535/0.01335`.
- That result is provisional rather than a scalar-tuning warrant. The integral
  improvement over the best distance-only handoff is only `0.00270L`, whereas
  its byte-identical sampled executions differ by `0.01541L`; mean anterior
  command also rose to `18.45` from `18.26/18.08 rad/T^2`. The current gate
  compares yaw with a route command that includes target bearing and yaw-rate
  braking, so it can flip sign even when the measured velocity course still
  needs correction. Do not increase its gain or add another terminal bend.
- Inherited logs give a hard architecture boundary: exposing velocity-course
  redirect curvature outside the validated approach region left the domain at
  `8.750T` after reaching only `11.895L`. The new mechanism must remain inside
  the existing `6--4L` gait handoff and may only remove phase allocation; it
  must not add middle-field mean curvature or steering acceleration.

## One-candidate hypothesis

Preserve the complete capture scaffold and the evaluated far-amplitude/
near-lag endpoints. Replace only the response signal that can advance their
existing normalized-distance blend. Derive a bounded course-correction demand
from the already computed body-frame target-versus-velocity course error, and
release posterior amplitude allocation toward the proven lag allocation only
when normalized measured yaw has the same corrective sign. When course and yaw
disagree, retain the distance-only schedule. The signed-product agreement is
reflection invariant; approach weighting prevents any effect beyond `6L`;
the gate adds no mean bend, drive, command authority, clock, or route memory.

Expected signature: preserve the evaluated early progress and coherent wake,
while making the `6--4L` release track actual trajectory response more directly
than the broader route request. Support requires capture plus a meaningfully
different useful middle/near trajectory: lower course error, lateral speed,
or head path with distance integral/arrival beyond handoff repeat variation,
without worse command residence, joint margin, force, moment, or either wake
view. Falsify if early milestones regress, the late hook/path grows, capture or
wake coherence is lost, or the change only perturbs the scalar score inside
repeat spread; in that case restore the evaluated response-aware handoff and
do not tune this agreement gain.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and biological response-gated redirect release
source_mechanism: use measured direction response to release a transient wave allocation back into the established propulsive rhythm
transferable_invariant: compare a normalized task-relevant directional error with measured yaw response and continuously remove extra gait allocation once that response is correcting the actual course
nontransferable_details: published CPG gains, dimensional cadence, robot-specific joint envelopes, species-specific burst kinematics, clock phase, exact vortex phase, world coordinates, and task-specific routes
policy_translation: inside the existing body-frame distance handoff, replace route-command/yaw agreement with signed velocity-course-correction/yaw agreement to advance posterior amplitude asymmetry toward the sampled lag asymmetry under the unchanged two-joint acceleration contract
falsification: reject if early progress, capture, path, course error, lateral speed, command or rate residence, joint margin, load class, or coherent top-down and oblique wakes fail the bounds above
