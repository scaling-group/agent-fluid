# Evidence-selected stroke-aware course-preview candidate

## Visual diagnosis before the policy edit

- All four sampled solver rollouts satisfy the frozen evidence contract:
  direct uniform still-water initialization with `U_infinity=[0,0,0]`, no
  cylinders or prewarm snapshot, finite dynamics, and moving-window transport.
  Their translation and wakes are self-generated rather than imposed
  advection.
- Both rows of the combined keyframe sheets were inspected for the replicated
  course-preview capture, the stroke-aware capture, and the inherited
  `1.092L` left-domain failure.  The top-down row shows a coherent alternating
  propulsive wake in every case.  The failure preserves that wake but passes
  outside the capture circle, makes a broad post-passage hairpin, and exits at
  `37.493T`; the course-preview family bends before passage and captures near
  `24.6T`.  The oblique Lambda2 row likewise retains compact three-dimensional
  shedding through approach and turn, so passive advection, wake breakup, or
  loss of propulsion is not the current intervention target.
- Three byte-identical v27 examples capture at `24.5795T`, `0.746968L`, and
  mean distance `2.36044L`.  The distinct v28 stroke-aware allocator preserves
  the same visual trajectory class and captures at `24.6180T`, `0.748724L`,
  and mean distance `2.36225L`; its `0.0385T` arrival penalty and `0.00181L`
  mean-distance penalty are small relative to the retained semantic success.
- Trace metrics show the material improvement hidden by the slightly lower
  scalar score.  Relative to v27, v28 cuts posterior hard-stop occupancy from
  `23.38%` to `12.60%`, mean absolute posterior raw acceleration from
  `42.65` to `39.50 rad/T^2`, peak planar force magnitude from `0.323` to
  `0.203`, and peak yaw-moment coefficient from `0.143` to `0.089`.  Raw
  acceleration-envelope exposure (`72.84%` versus `72.65%`) and joint-rate
  exposure (`15.15%` versus `15.10%`) are essentially unchanged, so the guard
  is specifically a stroke/load improvement rather than a general command-
  saturation remedy.
- The completed inherited v29 branches bound further refinement.  Conditioning
  relief on course alignment delays capture to `24.7610T` and gives back most
  of the physical benefit (`21.59%` posterior hard-stop occupancy, `0.274`
  peak planar force, `0.121` peak moment).  Conditioning the handoff on inward
  beat phase is effectively neutral versus v28: it captures at `24.6015T`
  but leaves hard-stop occupancy at `12.68%`, peak force/moment at
  `0.203/0.089`, and raw/rate exposure unchanged.  Neither result supports
  another response threshold, phase blend, or scalar relief edit.

## Policy hypothesis

Materialize the sampled v28 mechanism unchanged as this workspace's one
candidate.  Preserve v27's validated normalized body-frame translational-course
preview and bounded steering-priority allocation.  When observed posterior
angle is near its stroke boundary and the decomposed steering acceleration
pushes farther outward, continuously reduce only the posterior steering-
priority claim and admit the already-bounded inward traveling-wave carrier.
Inside the stroke reserve or under inward steering, the capturing parent is
unchanged.  This uses only joint state and existing body-frame feedback; it
adds no clock, route, world-frame direction, or actuation magnitude.

The falsifiable expectation is another coherent capture-class trajectory near
the v27/v28 timing range with posterior hard-stop occupancy and peak load in
the sampled v28 class.  Reject the mechanism if capture is lost, the far
approach changes, posterior occupancy returns materially toward `23.38%`, peak
planar force/moment returns toward `0.323/0.143`, or raw/rate exposure is
claimed as solved without a measured reduction.  Formal CFD remains deferred
to EvE; the current worker does not claim a new rollout result.

## Bookshelf transfer

The mandatory three-stagnant-iteration trigger is not met because the recent
lineage introduced course-preview capture and then a stroke/load improvement.
The shelf was nevertheless consulted after the current visuals and metrics;
its sensor-modulated rhythmic-control and posterior traveling-wave invariants
support selecting the already-evaluated structural guard, not tuning a scalar.

bookshelf_consulted: true
source_domain: elongated-body reactive propulsion and sensor-modulated robotic-fish CPG control
source_mechanism: preserve a lagged posterior propulsive wave while proprioceptive feedback withdraws control effort that reinforces an active stroke constraint
transferable_invariant: keep route steering bounded, but continuously return constrained posterior authority to the traveling-wave carrier when observed joint side and steering direction show that the steering allocation pushes farther into the limit
nontransferable_details: published gains, species kinematics, dimensional cadence, full-body envelopes, motor limits, exact vortex phase, and task-specific routes
policy_translation: use observed posterior joint angle relative to owned stroke thresholds and signed posterior steering acceleration to reduce only the existing two-joint steering-priority gate near an outward limit; preserve normalized body-frame course preview and the carrier bound
falsification: reject if capture or far-path invariance is lost, posterior hard-stop and force/moment loads do not remain below the unguarded capture class, or propulsion and wake coherence deteriorate

## Pre-evaluation checks

- The candidate SHA-256 is
  `ae63cc9c0b9abb9f67698c74a5b82ba0c55573cba75579a0338e9228eeb90716`
  and it is byte-identical to the sampled v28 controller.  It remains non-empty
  and preserves the public parameter/policy contract.
- The configured check runner was invoked, but its pinned `gpt-5.4-mini`
  model is unavailable for this ChatGPT account.  Its three prescribed no-CFD
  commands were therefore run directly and separately.  The first check found
  two identical assigned-parent markers in the rendered workspace README;
  removing only the duplicate repaired parent selection.  The reusable-
  guidance check, finite two-joint Julia contract/schema check, and solver
  editable-boundary audit all pass.
- No formal CFD was run.  The sampled v28 rollout is prior evidence for
  selecting this candidate; its post-worker evaluation remains evidence for a
  later generation.
