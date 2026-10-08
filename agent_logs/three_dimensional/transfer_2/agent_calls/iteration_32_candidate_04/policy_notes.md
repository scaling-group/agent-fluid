# Candidate diagnosis and hypothesis

All four sampled solver examples are byte-identical v41 policies and produce
byte-identical combined keyframe sheets.  They capture from direct-uniform
still water at `24.640015T` and `0.748356L`, with mean distance `2.347937L`,
zero sampled posterior hard-stop occupancy, about `13.84%` exact-rate
occupancy, and low peak planar force/yaw-moment coefficients of about
`0.0254/0.0319/0.0156`.  The top-down row shows self-propulsion from quiescent
water through a coherent alternating wake, a broad target-directed approach,
and a compact terminal hook; the oblique row confirms a coherent
three-dimensional shed wake rather than passive advection or instability.
The four sampled results provide no failure keyframe for a visual comparison,
so the inherited v42/v43 failures are used only through their quantified logs:
both coupled redistributions preserve the load class but consume capture
margin and regress score.

On the repeated v41 trajectory, `state.moment_z_L2` is already the normalized
yaw-moment coefficient.  Its peak magnitude is `0.0156`, and its correlation
with the following finite-difference yaw acceleration is about `0.95`.  The
existing dormant angular-damping expression divides this normalized signal by
`L^3` a second time, so it cannot establish a useful wake-response scale.
The proposed mechanism does not activate that additive residual.  It keeps
v41's route, terminal residual bound, joint shares, state-derived tail phase,
and joint-local stroke/rate filters, but multiplies only the existing terminal
phase allocation by a smooth load-opposition gate.  The gate uses the sign of
body-frame collision-course error against the directly normalized measured
yaw moment: adverse hydrodynamic yaw admits correction, while helpful yaw
withdraws it.  This tests hydrodynamic assistance/rejection without increasing
command magnitude, transferring rejected posterior effort to the anterior
phase anchor, or changing the established path outside `2.10L`.

bookshelf_consulted: true
source_domain: wake-interaction studies and sensor-feedback robotic-fish control
source_mechanism: preserve helpful hydrodynamic response and condition bounded rhythmic steering on measured load opposition
transferable_invariant: compare a normalized body-frame route-correction sign with normalized hydrodynamic yaw moment, then spend existing steering only where the fluid response opposes that correction
nontransferable_details: published gains, species kinematics, exact vortex phase, wake geometry, and task-specific routes
policy_translation: multiply v41's already-bounded terminal half-cycle residual by a smooth gate derived from `course_error * moment_z_L2`; add no steering residual and leave far-route and safety allocation unchanged
falsification: reject if capture is lost, the `0.001644L` crossing margin shrinks, commands change outside `2.10L`, projected miss or mean distance worsens, or rate/load/hard-stop classes regress

