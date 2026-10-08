# Response-aware modal actuation reallocation

## Evidence diagnosis before editing

- All four sampled rollouts satisfy the frozen direct-uniform still-water
  contract: `U_infinity=(0,0,0)`, no cylinders, no prewarm, stable dynamics,
  and inertial moving-window transport. All capture, so the no-posterior-
  modulation sample and the inherited completed mechanism tests are the
  informative negative controls rather than a semantic failure.
- The strongest sampled posterior-modulation rollout and its no-terminal-
  modulation control were inspected in both rows of their combined sheets.
  The top-down row shows genuine self-propulsion from rest, a coherent
  alternating vortex train through `24T`, and a smooth target-side hook. The
  oblique row shows a compact, connected three-dimensional wake through the
  turn. The wake trails the fish; neither view shows imposed advection,
  breakup, boundary interaction, or moving-window-induced rotation.
- Three sampled policies and trajectories byte-match at `0.748829L` and
  `26.2955T`. Relative to the no-terminal-modulation control at `0.749242L`,
  the posterior edit leaves the `8/16/24T` route, joint extrema, and peak
  planar force/yaw moment unchanged and moves the centerline by only
  `0.000591L`. The inherited true posterior half-cycle redistribution also
  preserves the same two-view wake and zero hard-limit contacts, but moves the
  centerline by only `0.002082L`, arrives `0.0055T` later, and captures at
  `0.749146L`. Both posterior terminal mechanisms therefore meet their
  falsification boundary; more lag, phase, or corridor scalar tuning is not
  supported.
- The sampled carrier keeps speed near `0.65L/T`, but its signed projected
  miss grows from about `0.50L` at `4.50L` range to `1.15L` at `3.50L` and
  `1.76L` at `3.00L`. Over the same interval the anterior command reaches
  about `29.1--29.6 rad/T^2`, inside the coordinated `27--30 rad/T^2` soft
  envelope, while the line-of-sight response requests the correct turn side.
  The remaining defect is therefore consistent with steering allocation in a
  loaded traveling carrier, not lack of a target signal or a terminal-only
  waveform defect.
- An inherited collision-cone re-entry test already changed the centerline by
  `0.0663L`, so it was a resolved earlier intervention, but it captured only
  at `0.749413L` and `26.5430T`. Directly blending farther toward the existing
  two-joint redirect changed the path without adding clearance and delayed
  arrival; retuning that blend is not the next supported test.

## Policy hypothesis

Preserve the evaluated oscillator, line-of-sight response, redirect, common
soft acceleration envelope, and angle/rate viability guards. Remove the
falsified terminal posterior offset. When a capture-scale projected miss
persists inside the middle approach, course and inertial target-line response
request the same side, the fish is closing, and observed yaw response remains
deficient, make one bounded joint-space allocation change: convert a small
fraction of the instantaneous differential acceleration into common-mode
curvature on the requested side. The conversion reduces the command component
opposing the turn instead of adding acceleration, so it tests steering priority
without raising the command norm or replacing the state-feedback carrier with
a static redirect. Converged, adequately responding, far, and redirect-
dominated states pass through unchanged.

The formal rollout should alter the route before the terminal `1.75L`
corridor, keep capture and the coherent two-view wake, and either deepen the
crossing or improve arrival/load exposure without hard-limit contact. Reject
the mechanism if it repeats the sub-`0.003L` terminal cluster, reproduces the
slower collision-cone path, breaks the traveling wake, loses capture, or
increases force, moment, or actuator-limit exposure. The new CFD result is not
available to this worker and is not claimed here.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and asymmetric rhythmic turning
source_mechanism: closed-loop steering changes the allocation of a productive rhythmic command while retaining the underlying carrier
transferable_invariant: when target error persists despite inadequate observed turn response, reallocate bounded actuation toward curvature rather than increasing total rhythmic effort
nontransferable_details: published gains, dimensional frequencies, robot or species kinematics, oscillator clock phase, exact vortex phase, and task-specific routes
policy_translation: use normalized body-frame projected miss, closing speed, course/target-line side agreement, and yaw-response deficit to convert part of the two-joint differential command into requested-side common mode within the middle approach
falsification: reject if capture or wake coherence is lost, the route remains terminal-cluster equivalent, arrival or clearance regresses like direct redirect re-entry, or load and joint-limit exposure increase
