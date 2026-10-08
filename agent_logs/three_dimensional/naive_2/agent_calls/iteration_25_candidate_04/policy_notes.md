# Low-energy carrier-recovery candidate

## Visual and metric diagnosis before the policy edit

- All four sampled solvers satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, finite moving-window
  dynamics, and capture. Their policies, trajectories, and combined and
  view-specific keyframe sheets are byte-identical. Each captures at
  `16.604496T`, score `-0.113729`, final distance `0.743958L`, and scored
  distance integral `1.998146L`. These repeats establish nominal
  reproducibility, not robustness to another pose or flow.
- I inspected the top-down mid-plane and oblique Lambda2 views from release
  through capture for the sampled parent and the inherited
  closure-qualified redirect regression. The parent is not advected: after a
  slow release it develops an alternating tail wake, self-propels along a
  shallow target-crossing arc, and retains compact tail-connected
  three-dimensional structures through capture. There is no collision,
  boundary exit, wake breakup, or instability. The redirect has the same
  visible wake class and capture topology, so its weaker metrics—not vortex
  prominence—make it the informative negative control.
- The completed parent spends its opportunity for improvement before that
  useful wake is established. Its mean-removed anterior phase radius
  `hypot(q1_carrier/amp, q1_dot/(omega*amp))` starts near `0.285`, first
  reaches `0.5` at `2.86T`, and first reaches `0.7` at `3.52T`; distance has
  fallen only from `12.328L` to `12.225L` and `12.133L` at those crossings.
  By contrast, after the radius reaches the established gait, distance falls
  to `11.659L` by `5T` and the two-view wake remains coherent. The visual and
  trajectory evidence therefore support a clock-free carrier-establishment
  mechanism, not stronger terminal steering or whole-wave relief.
- Inherited optimizer logs close two tempting terminal extensions on this
  exact carrier. The closure-qualified posterior redirect retained capture
  and the connected wake but delayed arrival to `16.609995T` and worsened
  score/integral to `-0.114215/1.998537L`. A closure-qualified yaw-response
  release arrived at `16.598995T`, but its shallower `0.744276L` crossing and
  `1.998380L` integral still worsened score to `-0.114037`. These completed
  controls do not support gain-tuning terminal closure channels. The parent
  also already touches the `260 deg/T` speed envelope and peaks near
  `0.037165/0.018356` in planar force/moment, so recovery must vanish before
  the established route and must remain inside the existing soft limits.

## Sole policy hypothesis

Preserve the assigned parent's raw body-frame target geometry, anterior
course center, lateral and yaw phase demodulation, posterior mean and
half-cycle steering, traveling-wave lag, acceleration bound, and one-sided
speed guard. Add one state-derived carrier-recovery mechanism to the anterior
oscillator: measure its dimensionless phase-space radius from the
mean-removed joint angle and angular velocity, and add bounded positive energy
feedback only while that radius is below `0.7` of the requested carrier
amplitude. The posterior joint continues to follow the observed anterior
state, so the addition establishes the existing traveling bend rather than
prescribing a clocked waveform or a new route.

On the completed parent trace, the recovery condition is confined to the
slow release and is absent once the demonstrated carrier is established. A
replay can bound its requested addition but cannot predict the closed-loop
CFD result. Expected test: establish a connected alternating wake earlier,
advance initial target progress and capture, and retain the parent's route,
crossing class, joint envelope, and loads. Falsify it if the phase radius
overshoots, the condition reactivates persistently during healthy swimming,
the wake or target arc changes adversely, capture/score/integral regresses,
or speed, acceleration, force, or moment residence increases materially.

bookshelf_consulted: true
source_domain: classical traveling-wave propulsion and sensor-modulated robotic-fish central pattern generators
source_mechanism: stabilize a rhythmic carrier as a state-feedback limit cycle, then transmit it posteriorly with phase lag to form a propulsive traveling bend
transferable_invariant: use a dimensionless joint phase-space energy deficit to recruit bounded carrier recovery only when the observed rhythm is under-established, while preserving target feedback and posterior wave structure
nontransferable_details: published oscillator gains, dimensional frequencies, species or robot amplitudes, exact body envelopes, vortex phases, startup timing, and source-task trajectories
policy_translation: compute normalized anterior phase radius from mean-removed joint angle and joint velocity; below an owned fractional floor add smooth velocity-aligned energy feedback to joint 1 while joint 2 retains the existing lagged state-feedback target
falsification: reject if earlier self-propulsion and capture do not improve without carrier overshoot, repeated recovery during established swimming, target-route or wake-class change, joint-limit contact, saturation growth, or larger force and moment loads

## Evaluation boundary

No CFD outcome is claimed for this unevaluated candidate. Later evaluation
must compare release-to-`4T` phase-radius growth, early distance progress,
first coherent wake formation in both views, arrival, scored and observed
distance integrals, target-crossing geometry, joint extrema, speed and
acceleration residence, action effort, and peak force/moment against the exact
repeated `-0.113729` parent. Fixed-pose still-water success would not establish
robustness to a changed pose, flow, carrier family, or actuator integration.
