# Carrier-phase-demodulated course-response candidate

## Visual and metric diagnosis before the edit

- All four assigned examples report direct uniform still-water initialization
  with `U_infinity=[0,0,0]`, no cylinders, and no prewarm. I inspected every
  combined sheet from release to termination. Their top-down rows show
  self-propelled motion with persistent alternating vortex streets, and their
  oblique rows retain tail-connected three-dimensional Lambda2 structures.
  The three failures are therefore directional failures, not advection, wake
  collapse, or numerical instability.
- The phase-demodulated yaw controller is the only assigned semantic success:
  it captures at `16.637T` and `0.7477L`, with mean distance `2.003L`. The
  distance-relief, signed-response half-cycle, and closure-gated variants reach
  only `5.126L`, `4.743L`, and `4.530L`, then all leave through the upper
  boundary at `20.86--21.72T`. The capture sheet visibly bends down toward the
  target after about `12T`; the failure sheets preserve a similarly coherent
  wake but bend upward after their closest approaches.
- The successful rollout uses more of the available carrier than the failures:
  maximum speed is `1.153U`, joint amplitudes remain below about `32.1 deg`,
  and peak planar force/moment are about `0.0295/0.0186`, but joint speed
  reaches the released hard bound and posterior acceleration is above
  `30 rad/T^2` on `49.7%` of samples. This argues against adding propulsion,
  static curvature, or a terminal burst merely to improve the scalar score.
- The assigned parent's selective moment rejection preserved a deep approach
  (`2.358L`) but still exited high, while inherited terminal anterior and
  posterior curvature additions reached only `2.931L` and `3.254L`. Those
  logs reinforce that a faster or larger bend is not the supported follow-up
  once the full traveling-wave carrier is already effective.
- A new observation issue remains inside the successful policy. Reconstructing
  body-frame lateral velocity from its completed trajectory and regressing it
  on anterior joint angle and velocity explains `91.3%` of its full-rollout
  variance and `99.9%` inside `6L`; the corresponding four assigned fits
  explain `85.3--91.3%` over full rollouts and `95.9--99.9%` inside `6L`.
  Thus the target-versus-velocity course angle, like the previously corrected
  yaw rate, is dominated by beat phase. On the captured history, fixed
  coefficients near `-0.50*q1 - 0.12*qd1` describe the carrier-correlated
  lateral component without using time, target identity, or world position.

## Single policy hypothesis

Preserve the completed capture controller's full anterior state-feedback
oscillator, posterior lag, approach-aware anterior course redistribution,
opposite-sign posterior-curvature-to-physical-yaw convention, joint-phase-
demodulated yaw response, crossflow residual, and response-gated opposing
half-cycle relief. Add one semantic observation transform before computing the
course angle: reconstruct the carrier-synchronous part of body-frame lateral
velocity from current anterior joint angle and velocity and subtract it.
Compute target-versus-velocity course error from the resulting directional
velocity, while keeping the raw forward component as the near-rest speed gate.

This is the same compact carrier-versus-direction separation that produced the
first capture, now applied to the other fast route observable rather than a
new actuator or a scalar-only retune. The coefficients come from the assigned
completed rollouts, not the bookshelf. Expected behavior is a course command
that does not change sign merely because the tail beat reverses, preserving
the demonstrated targetward arc while shortening unnecessary steering
oscillation. Falsify it if capture is lost, arrival is later than `16.637T`,
the trajectory returns to an upper-boundary exit, or acceleration residence,
joint-limit contact, peak loads, or either wake view materially worsens.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and wake-control separation
source_mechanism: separate slow directional response from the repeatable rhythmic carrier before closing the route-feedback loop
transferable_invariant: preserve propulsion while feedback acts on a body-relative directional residual after removing motion correlated with the observed carrier phase
nontransferable_details: published gains, robot geometry, dimensional beat frequency, species kinematics, exact vortex phase, maneuver timing, and task-specific routes
policy_translation: use normalized body-frame target and velocity plus current anterior joint state to subtract carrier-synchronous lateral velocity before the existing bounded course, yaw-response, and posterior half-cycle calculations
falsification: reject if the demonstrated capture or coherent connected wake is lost, arrival slows, the upper-exit topology returns, or saturation and hydrodynamic loads increase materially

## Evaluation boundary

No CFD result is claimed for this candidate. The later evaluation should
compare capture and arrival first, then distance integral, course-command phase
correlation, target-relative trajectory, acceleration and joint-speed-limit
residence, peak force/moment, and both visual rows against the completed
`16.637T` capture. Algebraic replay on recorded states can establish only the
new transform's scale and boundedness; it cannot predict the coupled wake or
counterfactual route.
