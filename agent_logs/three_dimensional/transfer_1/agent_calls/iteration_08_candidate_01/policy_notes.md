# Candidate wake-policy diagnosis

## Evidence read before editing

- The assigned parent is the prefilled progress-gated posterior-thrust policy.
  All four sampled rollouts report direct uniform still-water initialization
  with `U_infinity=(0,0,0)` and capture.  Three samples are behaviorally
  identical `26.0425 T`, `0.74644 L`, score `-0.69472` rollouts whose policy
  files differ only in comments; the informative weaker comparison is the
  completion-gated redirect at `26.4110 T`, `0.74961 L`, score `-0.71050`.
  The inherited optimizer logs likewise contain only those repeated best
  scores, so they do not establish a new mechanism beyond the parent.
- I inspected both combined keyframe sheets from release to termination.  In
  both, the top-down row shows self-propelled motion (not background advection),
  a coherent alternating red/blue trail, a long nearly straight closing leg,
  and a late target-directed bend.  The oblique Lambda2 row confirms a compact
  alternating three-dimensional vortex chain that remains coherent through
  the turn.  No sampled semantic failure or prewarm artifact is present; the
  later capture is therefore the most informative inferior case rather than a
  true failure example.
- The metric cross-check localizes the remaining weakness before the successful
  late bend.  Relative to the `26.4110 T` captured parent, posterior thrust is
  slightly worse at `2 T` (`12.2663 L` versus `12.2625 L`) and `8 T`
  (`10.7306 L` versus `10.6878 L`), and only establishes a useful route lead
  later.  In the best run the heading error grows from `0.0346 rad` at `2 T` to
  `0.7047 rad` at `8 T` and `0.8607 rad` at `10 T`, while yaw alternates from
  `-1.93 rad/T` at `2 T` to `+2.11 rad/T` at `10 T`.  At `14--24 T`, distance
  is already ahead of the weaker capture and the two-view wake remains
  coherent.  Commands already reach the parameter-owned acceleration boundary
  often, and both runs share the joint-speed limit and essentially the same
  force/moment extrema, so another global carrier or command-envelope change
  is not supported.

## Policy hypothesis

Retain the completion-gated redirect, closure-gated posterior lag, cadence,
approach scheduling, and finite acceleration projection.  Add one small
body-frame steering mechanism for the aligned-to-moderate-error regime: target
angle chooses the desired yaw sign, and a bounded residual is admitted only
when observed yaw has the opposite sign.  Fade it out as the large-error
redirect takes ownership and as the fish approaches the target.  This should
reduce early route-error growth without damping helpful yaw or disturbing the
evidenced late capture topology.

Accept the hypothesis only if the later CFD preserves capture and coherent
top-down/oblique wakes while improving early distance and at least one of
arrival or distance integral without worse force/moment or limit residence.
Reject it if the early heading excursion persists, correct-sign turning is
slowed, the late bend changes side or misses, or loads/saturation materially
increase.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and selective wake-disturbance rejection
source_mechanism: separate slow target-directed steering from fast oscillatory yaw and correct only the disturbance component that opposes the route request
transferable_invariant: sensed locomotor response should gate a bounded residual, while useful response in the requested direction should pass undamped
nontransferable_details: published gains, species and robot kinematics, exact vortex phases, cylinder-wake geometry, and task-specific routes
policy_translation: use normalized body-frame target angle for desired yaw sign and normalized recent yaw rate for an adverse-response gate; add a small target-signed residual only below the existing large-error redirect regime and release it continuously on approach
falsification: reject if early distance and route-error growth do not improve, or if capture, wake coherence, steering authority, actuator residence, force, or moment regresses
