# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four sampled rollouts satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no cylinders or prewarm snapshot, capture termination,
  and no reported instability. Their policies are executable-equivalent and
  all reproduce the exact `24.326511T`, `0.749329L`, `2.224097L`
  mean-distance capture. This makes the inherited response-scheduled posterior
  relief deterministic at the assigned pose, but does not establish held-out
  robustness.
- The complete `solver_6bc696c9a6ab` combined sheet shows self-propulsion
  rather than advection: a coherent alternating red/blue mid-plane street
  develops from quiescent water, the head follows a continuously closing curved
  path, and discrete oblique Lambda2 structures remain visible through capture.
  The `solver_cb5a6b73ffd9` top-down row reproduces that path and wake, but its
  oblique row is blank. That is a renderer failure and supplies no independent
  3D-wake evidence.
- The assigned-parent logs provide the informative terminal comparison. The
  unmodified reactive rudder captured at `24.337509T` with `2.224316L` mean
  distance. Adding up to 20% rudder on a one-step closing deficit delayed
  capture to `24.4145T` and worsened mean distance to `2.224632L`; removing up
  to 20% under the same signal instead produced the four-times-repeated
  `24.326511T` result. The common peak normalized force/moment envelope remains
  about `0.031649/0.016385`, with approximately `14.04/6.92%`
  anterior/posterior rate-cap occupancy, so the result concerns steering
  allocation rather than added load or saturation.
- The one-step and eight-observation-window relief gates computed on the
  sampled trace have the same bounded range. Inside `2L`, however, the
  windowed gate is active on about `28.8%` of steps with mean `0.117`, versus
  `29.3%` and `0.122` for the one-step gate. This is a small but measurable
  semantic change that rejects some beat-scale derivative excursions without
  changing the evidenced carrier, rudder sign, or distance/error schedule.

## One candidate hypothesis

Replace only `closing_speed_L` in the terminal relief with the supplied
`window_closing_speed_L`, computed over the eight-entry observation history.
Joint state retains the traveling carrier, full normalized head-relative target
geometry retains the posterior reactive-rudder sign, and distance/error gates
retain its successful onset. The response signal alone changes from a one-step
derivative to a short-window normalized trend; no carrier or rudder gain is
tuned.

The candidate is falsified if it loses capture, arrives later than the
four-times-repeated `24.326511T` relief baseline, raises mean distance above
`2.224097L`, or materially worsens the coherent wake, force/moment envelope,
command effort, or joint saturation. Even a better fixed-pose result would not
establish robustness; later evidence must vary pose or hydrodynamic conditions.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and wake-control separation of slow route response from fast oscillatory disturbances
source_mechanism: preserve the rhythmic propulsive carrier while a filtered sensory trend modulates only the bounded steering channel
transferable_invariant: keep carrier generation separate from steering allocation and reject beat-scale response fluctuations before changing mean posterior load
nontransferable_details: published CPG gains, linkage geometry, species-specific kinematics, dimensional filter constants, exact vortex phases, prescribed maneuver timing, and task-specific routes
policy_translation: retain joint-state carrier phase and normalized body-frame target/distance gates, but compute posterior relief from the provided normalized eight-observation closing-speed window instead of the one-step derivative
falsification: reject if capture timing or mean distance regresses, or if wake coherence, effort, saturation, force, or yaw-moment envelopes worsen
