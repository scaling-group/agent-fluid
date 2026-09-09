# Actuator-consistent route recovery candidate

## Visual and metric diagnosis recorded before the policy edit

- All four sampled rollouts satisfy the frozen evidence contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite dynamics, and capture at
  `18.6725--18.7440T`. I inspected the combined top-down vorticity and oblique
  Lambda2 sheets for the best-score exact route and the prefilled
  moment-residual route from release through capture. In both, the fish moves
  ahead of the initially quiescent fluid, forms an alternating body-led wake
  by `4T`, and keeps a shallow target-directed trajectory without wake breakup,
  boundary contact, collision, or instability. The wake remains coherent and
  compact through terminal approach; local-flow RMS is only
  `0.01804--0.01816U`, so capture is self-propelled rather than advection.
- Three exact `dogfish3d_actuator_consistent_tail_phase_v1` samples capture at
  `18.6725T`, `18.6725T`, and `18.7330T`, with scores
  `-0.13362-- -0.13142`, mean distance `2.01959--2.02129L`, posterior action
  RMS `28.72--28.85 rad/T^2`, posterior acceleration-limit occupancy
  `75.19--76.11%`, and force/moment RMS
  `0.01331--0.01350 / 0.00693--0.00703`. This is the replicated route
  envelope, not three independent controller improvements.
- The prefilled stress-gated physical-moment residual captures at `18.7440T`
  with score `-0.13364`, mean distance `2.02198L`, posterior action RMS
  `28.77 rad/T^2`, posterior occupancy `75.44%`, and force/moment RMS
  `0.01343/0.00699`. Its wake sheet is visually indistinguishable from the
  exact route, and every effort/load quantity overlaps exact-policy spread.
  The residual therefore supplies neither a semantic improvement nor a
  replicated route, load, or actuator benefit.
- The inherited optimizer logs close four nearby alternatives. Contracting
  the near-range carrier amplitude captures later at `18.8705T` and scores
  `-0.15464`; direct radial-approach carrier damping scores `-0.15219`;
  prospective joint-speed headroom scores `-0.16366`; and exact-boundary
  anti-windup's initially neutral `-0.13320` result rebounds to `-0.14324` on
  its completed recovery. Every run still reports capture, so these are
  concrete route/effort negatives rather than new successes or better
  termination classes. They do not justify another scalar gate, damping gain,
  or actuator allocator.

## Policy hypothesis recorded before the policy edit

Produce one recovery candidate by deleting only the unsupported physical yaw
moment residual from the prefilled policy and restoring the replicated
actuator-consistent route. Preserve the normalized body-frame bearing plus LOS
rate C-bend, traveling two-joint carrier, recoil projection,
response-reversing half-cycle steering, persistent same-side posterior phase
recruitment, coefficient-norm-preserving phase rotation, and feasible
componentwise acceleration projection exactly. This is a mechanism ablation,
not scalar gain tuning: `moment_z_L2` and its release scale leave the active
contract, while every parameter and equation on the replicated route remains
unchanged.

Later CFD supports the recovery if it captures with a coherent body-led wake
inside the exact route's completed `18.6725--18.7330T` timing and
`2.01959--2.02129L` mean-distance envelope, or at minimum remains inside the
broader inherited `19.052T` robustness bound without higher loads. Falsify
the recovery if the same-hash route loses capture, weakens early propulsion,
or repeatedly falls outside its established envelope; that would make
trajectory variability itself the next mechanism to diagnose. The new CFD
result occurs only after this worker exits and is not claimed here.

## Structured bookshelf transfer

bookshelf_consulted: true
source_domain: reactive fish propulsion and sensor-modulated robotic-fish CPG control
source_mechanism: preserve a posterior-lagged directed traveling bend and add feedback channels only when they improve route response without destroying propulsion
transferable_invariant: a coherent self-propelled traveling carrier remains primary; an auxiliary physical-response channel must earn retention through repeatable target progress or actuator/load separation
nontransferable_details: published gains, dimensional frequencies, species or robot kinematics, full-body waveforms, prescribed routes, exact vortex phases, and task-specific coordinates
policy_translation: no new primitive is adopted after consultation; remove the falsified instantaneous moment-residual allocator and retain the normalized body-frame LOS route and two-joint actuator-consistent phase controller
falsification: reject the recovery if capture or wake coherence is lost, the repeated route envelope is not recovered, or later replicated evidence shows the removed residual separates route, effort, or load beyond same-policy variability
