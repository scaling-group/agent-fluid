# Candidate diagnosis and hypothesis

## Evidence read before the edit

- All four sampled rollouts satisfy the direct-uniform still-water contract:
  `initialization_mode=uniform_direct`, `U_infinity=(0,0,0)`, no cylinders,
  and no prewarm. The combined sheets were inspected in both their top-down
  vorticity and oblique Lambda2 rows.
- The prefilled policy (`solver_a2617fc44329`) and the three exact repeats of
  the lateral-phase-residual policy (`solver_0f91f918d286`,
  `solver_a176917716bd`, and `solver_b6748f0affb8`) are all self-propelled
  captures. Their top-down sheets show a sustained alternating reverse-street
  wake behind a shallow target-directed arc; their oblique sheets show
  tail-connected three-dimensional structures rather than advection of an
  inactive body. There is no visible topology change between variants.
- The exact repeats make the small semantic difference credible. Relative to
  the prefill, lateral-response demodulation advances capture from
  `16.609995T` to `16.604496T`, improves score from `-0.115560` to
  `-0.113729`, lowers scored distance integral from `1.999656L` to
  `1.998146L`, and crosses deeper (`0.743958L` versus `0.745621L`). Maximum
  joint speed remains at the `4.537856 rad/T` envelope and maximum action
  remains near `31.41 rad/T^2`; the price is a small peak force/moment increase
  from about `0.03583/0.01776` to `0.03717/0.01836`.
- No inherited file exists under `logs/optimize/`; the assigned durable parent
  instead records that raw bearing may contain joint-phase contamination and
  that phase-demodulated response must preserve slow steering offsets.
- Reconstructing body-frame bearing from the sampled trajectories and removing
  a centered whole-beat mean shows a stable approach fit across all repeats.
  Within `6.5L`, `bearing_phase = -0.9257*q1_carrier -
  0.0230*q1_dot` explains `99.86%` of the oscillatory bearing variance and
  reduces its RMS from `0.2401` to `0.0089 rad`; the prefill gives nearly the
  same coefficients and fit. Thus raw instantaneous bearing is mainly a
  carrier-phase observation on approach, even though its beat mean still owns
  the useful route.

## Policy hypothesis

Start from the repeated, stronger lateral-phase-residual controller. Preserve
its full-amplitude traveling-wave carrier, its raw-course anterior center, and
its evidenced lateral and yaw residuals. Add one matched observation
mechanism: subtract the fitted mean-removed anterior phase contribution from
`bearing` only in the posterior route request, with the existing smooth
approach gate. The raw bearing continues to define the anterior centerline
window, so the edit cannot erase the slow target vector or alter the
demonstrated far route. Expected result: preserve capture and wake connectivity
while reducing beat-synchronous posterior steering near the target, improving
distance cost or crossing depth without increasing joint contact or the
already slightly higher force/moment peaks. Falsify the candidate if it loses
capture, worsens score/integral/crossing, changes the useful shallow arc or
wake connectivity, or increases loads and saturation.

bookshelf_consulted: true
source_domain: closed-loop CPG modulation and residual control in robotic fish
source_mechanism: sensor-derived route feedback modulates a low-dimensional rhythmic carrier while the carrier phase remains a separate locomotor state
transferable_invariant: separate slow persistent route geometry from carrier-synchronous response before applying bounded steering feedback
nontransferable_details: published CPG gains, oscillator timing, robot morphology, species kinematics, exact wake phase, and task-specific paths
policy_translation: in normalized body-frame state, preserve raw anterior steering and subtract the evidence-fitted q1_carrier/q1_dot bearing component only from the approach-gated posterior route channel
falsification: reject if capture, distance cost, crossing depth, wake connectivity, joint envelope, or force/moment loads regress relative to the repeated lateral-residual captures
