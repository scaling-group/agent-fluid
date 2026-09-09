# Joint-quadrature recoil observer candidate

## Evidence diagnosis recorded before the policy edit

- All four sampled rollouts satisfy the frozen contract: direct uniform
  `U_infinity=(0,0,0)` initialization, no cylinders or prewarm, finite
  dynamics, and capture at `18.6560--18.7440T`. There is no termination
  failure in this batch. The informative negative evidence is instead that
  instantaneous hydrodynamic-response allocators have not separated from
  same-policy variation.
- I inspected every combined keyframe sheet from release through capture. In
  all four top-down rows, the body advances toward the target while shedding a
  coherent alternating posterior vorticity street. All four oblique rows show
  compact three-dimensional Lambda2 structures trailing the translating fish
  through target closure. There is no visible passive advection, wake breakup,
  growing wasteful sway, collision, boundary approach, or instability.
  Local-flow RMS `0.01807--0.01816U` and body-speed RMS `0.7040--0.7077U`
  support the visual diagnosis of coherent self-propulsion.
- The prefilled actuator-consistent policy has two exact-hash samples. Both
  capture at `18.6725T`, but their scores (`-0.13362`, `-0.13219`), anterior/
  posterior acceleration-limit occupancy (`42.15%/76.11%`,
  `40.71%/75.46%`), and force/moment RMS (`0.01350/0.00703`,
  `0.01331/0.00693`) differ enough to bound background variation. Helpful-
  moment relief captures at `18.6560T` in the current sample, but the assigned
  parent's exact repeat took about `18.9915T`; stress-confirmed relief takes
  `18.7440T`. These completed results reject another instantaneous moment,
  force, flow, LOS, or scalar allocator edit.
- The inherited logs correctly identify `turn_rate_recent` as a seven-step,
  approximately `0.0385T` signal rather than a full `0.55T` beat average. I do
  not use it as a falsely labelled beat-scale state. Instead, I regressed each
  completed trajectory's one-period high-pass yaw rate against observable
  joint-state quadratures. Anterior angle plus anterior and posterior velocity
  explains the within-beat recoil consistently (`R^2=0.99435--0.99447`), with
  fitted coefficients varying only from `-1.48` to `-1.55`, `-0.716` to
  `-0.720`, and `-0.341` to `-0.351`. The existing velocity-only correction
  leaves `0.397--0.406 rad/T` fast residual; the fitted quadrature form leaves
  about `0.103 rad/T`. This is offline evidence for an observation transform,
  not permission to use elapsed time or a rolling buffer in the policy.

## Policy hypothesis recorded before the policy edit

Preserve the evaluated normalized bearing-plus-LOS-rate route, distributed
C-bend, state-feedback traveling carrier, response-reversing half-cycle path,
persistent same-side actuator-consistency gate, posterior phase rotation, and
componentwise feasibility projection. Change only the yaw-response observer:
center anterior angle on the already bounded target-geometry redirect, then
combine that position quadrature with both joint velocities to cancel
carrier-correlated recoil. This should make mean curvature and phase response
track slow body yaw rather than within-beat body recoil without adding hidden
state, a clock, a route, or a hydrodynamic residual allocator.

Support requires another capture inside the established `18.6725--19.0520T`
band, coherent wakes in both views, posterior acceleration-limit occupancy no
higher than `76.2%`, and force/moment RMS no higher than
`0.01350/0.00703`. The mechanism is falsified if capture is lost, arrival
leaves that band, either wake weakens, or load/occupancy exceeds those bounds.
Later workers should also reconstruct the new observer from the trajectory and
reject it if its one-period fast residual is not materially below the current
approximately `0.40 rad/T` baseline; a cleaner offline signal without retained
capture is not a control improvement.

## Structured bookshelf transfer

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and tail-beat-averaged turning models
source_mechanism: preserve a productive rhythmic carrier while sensory feedback acts on a slow steering response separated from carrier phase
transferable_invariant: route feedback should respond to body-scale yaw rather than joint-correlated within-beat recoil, while the posterior-lagged traveling bend remains the primary propulsor
nontransferable_details: published gains, dimensional frequencies, species or robot kinematics, full-body waveforms, exact vortex phases, averaging-window implementations, and task-specific routes
policy_translation: use normalized body-frame bearing and LOS rate for route demand, and estimate slow yaw from measured heading rate plus fitted anterior-angle and two-joint-velocity quadratures centered on the bounded anterior redirect
falsification: reject if capture leaves 18.6725--19.0520T, either wake loses coherence, posterior occupancy exceeds 76.2%, force/moment RMS exceeds 0.01350/0.00703, or reconstructed within-beat observer residual is not materially reduced

The current candidate's CFD result is produced only after this worker exits
and is not claimed as evidence here.

bookshelf_consulted: true
source_domain: wake-interaction and adaptive-swimming control
source_mechanism: use a slow target-geometry steering request and add only a small bounded residual for organized crossflow or wake disturbance
transferable_invariant: wake signals should modulate routing without replacing the traveling bend or the geometry-driven target command
nontransferable_details: exact wake phase locking, fixed vortex timing, species-specific wake exploitation, and any scalar-only gain schedule
policy_translation: combine normalized bearing and LOS demand with a small body-frame wake residual built from local and relative flow, then feed that residual only into the bounded yaw request
falsification: reject if the wake residual dominates the route command, if capture is lost, or if later runs show the residual adds no improvement over the geometry-only route
