# Candidate diagnosis and policy hypothesis

## Evidence read before the policy edit

- All four assigned rollouts use the required direct uniform still-water
  initialization with `U_infinity=(0,0,0)`, no cylinders, and no prewarm.
  Their combined sheets were inspected from release to capture in both the
  top-down vorticity row and oblique body/Lambda2 row. The swimmers are
  self-propelled: each develops the same coherent alternating wake and compact
  target-directed trajectory rather than being advected by an imposed flow.
- The prefilled terminal curvature-reallocation policy
  (`solver_a1253ad45bc8`) remains the strongest assigned result. It captures at
  `25.2615T`, scores `-0.530646`, and has mean distance `2.43180L`. Inside
  `4L`, it smoothly replaces the carrier with a shared curvature equilibrium;
  terminal force and yaw-moment coefficient magnitudes stay below about
  `0.01593` and `0.00834`, and the joint angles settle near `-6.6/-12.3 deg`
  instead of dwelling at the `45 deg` stop.
- The three later mechanisms do not improve that result. A recession-release
  gate (`solver_4731656a97d2`) is exactly inactive on the strongly closing
  parent trajectory and reproduces the parent score and trace. Two bounded
  velocity-course residuals preserve capture but regress the score: the
  course-alignment variant (`solver_53c22b6c3b9c`) reaches the circle about
  `0.0385T` earlier yet scores `-0.531035` with mean distance `2.43200L`, while
  the course-regulated variant (`solver_8945310ce86a`) scores `-0.531768` with
  mean distance `2.43271L`. Neither changes the visible wake or trajectory
  topology enough to justify changing the terminal bend direction.
- The assigned parent's trace still exposes a narrow transition cost that the
  successful equilibrium does not address. At the first `4L` crossing, the
  fish is closing at about `0.576L/T`, but the distance-only allocation gate is
  zero; joint 1 is already at `-43.0 deg` and its command is at the acceleration
  envelope. By `3.5L` the closing speed is about `0.658L/T`, while the original
  proximity gate is only about `0.23`. The command settles by roughly `2.7L`,
  and closure then stays positive (`0.384--0.685L/T` over all inherited
  inside-`4L` samples). This supports changing when the validated allocation
  begins, not adding another course or curvature command.
- The slower approach-hold capture (`solver_e7a7bd0d3fe2`, inherited optimizer
  evidence) is the informative counterexample. Its top-down and oblique sheets
  show broad drive relief producing a large orbit before capture at
  `51.645T`. Thus response scheduling must preserve the parent carrier outside
  the narrow terminal transition and must not treat low positive closure as a
  reason to coast indefinitely.

## Policy hypothesis

Preserve the evaluated geometry redirect, curvature equilibrium, carrier
floor, and every far-field command. Replace only the distance-only terminal
transition with a bounded closure-qualified range preview: positive measured
closure projects normalized range a fraction of one control period ahead, so
a fast approach begins reallocation slightly before the physical `4L`
crossing; loss of closure continuously suppresses the terminal hold and
restores the posterior-lag carrier. Target geometry still owns activation,
turn sign, and both joint equilibria. Closing speed can only schedule actuator
allocation and cannot generate a steering residual.

Expected evidence is an unchanged outer wake and trajectory, lower command-cap
occupancy at the `4L` transition, and capture no later than the validated
`25.2615T` result without increasing terminal force or moment. Reject this
mechanism if it changes commands outside the short preview band, weakens the
coherent approach, creates a low-drive loop, delays or loses capture, or merely
reproduces the same transition clipping without an independently activated
recovery branch.

bookshelf_consulted: true
source_domain: biological burst-redirect turning and sensor-modulated robotic-fish rhythmic control
source_mechanism: target-error-gated actuator reallocation with response-conditioned entry and release
transferable_invariant: when propulsion and steering share limited joints, persistent body-frame target geometry should own the bend while normalized range and observed closure schedule when joint excursion is transferred from the rhythmic carrier to that bend
nontransferable_details: published gains, dimensional cadence, species-specific C-start kinematics, exact vortex phases, prescribed routes, and full-body waveforms
policy_translation: the existing body-frame geometry gate and two-joint curvature equilibrium are retained; bounded normalized closing speed previews distance by less than one declared control period and suppresses the terminal blend when closure is not supported
falsification: reject if the far-field carrier changes, transition saturation or loads do not fall, capture is delayed or lost, a low-drive orbit appears, or recession does not restore rhythmic propulsion

## Non-CFD implementation audit

Replaying the completed parent's recorded state trajectory through the parent
and candidate policies shows exact command equivalence for every sample at or
beyond `4.34L`. The preview first changes a command at `4.174L`, advances
range by at most `0.283L`, and sees an inherited inside-`4L` closing range of
`0.384--0.685L/T`, so its closure-support factor is fully active there. On
those fixed states, head-command envelope incidence inside `4L` falls from
about `0.98%` to zero and the tail remains at zero; this is only an activation
and boundedness audit, not coupled CFD evidence. A synthetic `-0.20L/T`
recession sets the terminal allocation gate exactly to zero, confirming that
the response branch restores the carrier without selecting a turn direction.
