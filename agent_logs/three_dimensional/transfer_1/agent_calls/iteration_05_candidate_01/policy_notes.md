# Candidate diagnosis and hypothesis

## Evidence read before editing

- All four sampled episodes report `uniform_direct`, `U_infinity=(0,0,0)`, no
  prewarm snapshot, and no cylinders. The combined keyframe sheets show
  self-propelled motion and alternating top-down vorticity together with
  compact three-dimensional Lambda2 structures, rather than passive advection.
- The phase-compensated bearing controller (`solver_5c5f9d80447b`) and its
  achieved-course/yaw-rate cascade (`solver_95d1e880b3e5`) keep a coherent
  traveling wake but pass below the target, bottom out at `3.003L` and
  `3.114L`, and leave the lower boundary. The course cascade therefore did not
  improve the sampled termination class or closest approach by itself.
- Applying half-cycle asymmetry throughout the approach
  (`solver_9cc71cad0aa3`) produces the visibly strongest curved/side-to-side
  path, reaches `2.739L`, then turns away and exits sooner. This is evidence
  against copying a globally active half-cycle actuator or merely increasing
  its gain.
- Terminal opposing-half carrier reallocation (`solver_a8af0d71b0de`) is the
  informative near miss: it preserves the alternating wake and reaches
  `1.267L` at about `18.69T`. At that closest sample its speed is about
  `0.777L/T`, target bearing is `1.287 rad`, achieved course is `-0.322 rad`,
  and heading rate is already the requested-sign `-0.658 rad/T`. The next
  samples show joint oscillation and action collapsing while speed stays near
  `0.78L/T`; the fish coasts past the target and repeats the lower-boundary
  exit. The missing capability is an active large-error terminal redirect,
  not more cadence relief or a larger already-saturated course error.

## Candidate hypothesis

Preserve the near-miss policy's normalized target-versus-achieved-course outer
loop and state-feedback traveling bend outside the capture neighborhood. Near
the target, when course error is large, continuously blend to a bounded
two-joint C-bend position servo and attenuate the oscillatory carrier. Release
the redirect automatically as the observed course aligns, so posterior drive
returns without a clock or hidden stage. This tests whether active curvature
can redirect the retained terminal momentum through the `0.75L` capture disk
instead of letting the gait collapse into a fast coast.

bookshelf_consulted: true
source_domain: biological C-start turning and closed-loop robotic-fish direction tracking
source_mechanism: large observed heading error triggers bounded body curvature, then observed response releases the fish into its propulsive rhythm
transferable_invariant: separate a transient, response-released redirect from the cruise carrier using only current target geometry, course, and joint state
nontransferable_details: species-specific C-start shape and timing, published CPG gains, dimensional frequencies, exact vortex phase, and any fixed route
policy_translation: body-frame target-versus-velocity course error and normalized distance gate a bounded two-joint curvature position servo; the state-feedback carrier is attenuated only during the redirect and returns as error falls
falsification: reject the transfer if early distance closure or wake coherence degrades, joint limits become persistent, closest approach does not beat `1.267L`, or termination remains the same fast lower-boundary pass
