# Proprioceptive rate-envelope candidate

## Visual and diagnostic evidence before the policy edit

- The four sampled solver evaluations and the assigned-parent evaluation are
  valid direct-uniform still-water releases: `U_infinity=(0,0,0)`, no prewarm,
  no cylinders, stable moving-window transport, and `capture` termination.
  This candidate therefore preserves the established propulsion, steering,
  approach-relief, redirect, and posterior-handoff scaffold.
- Both visual rows were inspected from release to capture for the strongest
  finite sample (`solver_bf9554cfba28`), the direct actuator-reserve test
  (`solver_d6f4924b438d`), and the assigned-parent exact response-handoff
  repeat (`solver_78a098464195`). Their top-down views all show active
  self-propulsion from quiescent water, a coherent alternating vorticity
  street, a broadly direct middle-field trajectory, and the same continuous
  late hook into the capture circle. Their oblique views all show compact 3D
  Lambda2 structures following the caudal region without passive advection,
  collision, wake breakup, or instability. The useful problem is actuator
  state allocation within that common wake and trajectory class.
- The response-aware policy's three exact evaluations now span
  `19.162--19.420T`, distance integrals `2.06924--2.08114L`, scores
  `-0.18047-- -0.19159`, and head paths `12.304--12.380L`. The new assigned-
  parent repeat therefore weakens the earlier claim that the response handoff
  itself guarantees the short-path edge, although it continues to support a
  stable coherent-capture scaffold.
- Every sampled architecture touches the `260 deg/T` joint-rate envelope.
  Across distance-only, response-aware, and redirect-reserve policies,
  anterior samples above 99% of the rate limit remain tightly grouped at
  `6.26--6.43%` and posterior samples at `3.02--3.10%`. The indirect redirect-
  reserve mechanism reduced mean command only modestly to `18.23/17.37` from
  the response repeats' `18.28--18.46/17.43--17.56 rad/T^2`; greater-than-90%
  command residence remained `35.51/33.74%`, and its rate residence did not
  improve. Its `19.333T/2.07854L/12.370L` capture lies inside exact-response
  execution spread rather than supplying a new semantic or actuator benefit.
- The inherited negative boundaries remain active: do not expose velocity-
  course curvature outside the approach region, add terminal corridor/slip
  curvature, reinterpret course error as the gait-release signal, or tune the
  redirect-reserve scalar. None addressed the persistent rate-limit contact.

## One-candidate hypothesis

Add one proprioceptive phase-envelope mechanism to the exact response-aware
parent. Normalize each observed joint velocity by the parameter-owned hard
rate envelope. As a joint enters the last part of that envelope, continuously
remove only the component of its raw acceleration that would reinforce the
current velocity; preserve all acceleration that reverses the stroke. This is
state-derived, reflection symmetric, independent for the two joints, and
cannot introduce a mean bend, clock, route memory, fixed world direction, or
extra actuator authority. Unlike the failed redirect-reserve allocation, it
acts exactly where the repeatedly observed constraint contact occurs and
recovers the parent controller away from that contact.

Expected signature: preserve capture, the alternating top-down street, compact
oblique structures, response-aware early progress, and the existing path/load
class while materially reducing the common `>99%` joint-rate residence below
about `6.3%/3.0%`. Falsify if rate residence is unchanged, if the guard merely
trades hard-rate contact for more near-bound acceleration residence, or if
arrival, distance integral, path, joint margin, force/moment loads, capture, or
either wake view leaves the exact-response execution envelope. If falsified,
restore the exact response-aware scaffold and test a different proprioceptive
wave-shape mechanism rather than another redirect or reserve gain.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control with reactive traveling-wave propulsion
source_mechanism: use proprioceptive joint-state feedback to protect a rhythmic gait from an actuator-rate envelope while retaining the posterior traveling bend
transferable_invariant: normalize observed joint velocity by its physical envelope and suppress only velocity-reinforcing rhythmic action near that envelope while preserving stroke reversal and the established wave
nontransferable_details: published CPG gains, dimensional cadence, robot-specific actuator models, species-specific envelopes and kinematics, exact Strouhal values, clock phase, vortex phase, world coordinates, and task-specific routes
policy_translation: under the unchanged two-joint acceleration contract, apply a bounded joint-rate gate independently to each raw command so only its outward phase component fades near the known normalized rate boundary and the exact parent command returns elsewhere
falsification: reject unless rate-limit residence decreases materially while capture, early progress, path and distance integral, joint margin, command residence, force/moment class, and coherent top-down and oblique wakes remain within the response-aware evidence envelope
