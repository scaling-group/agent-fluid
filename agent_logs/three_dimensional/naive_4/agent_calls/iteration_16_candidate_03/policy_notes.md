# Candidate diagnosis and hypothesis

## Evidence read before the policy edit

- All four sampled evaluations satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, and finite capture.
- I inspected both rows of the combined sheets for the best finite sample
  `solver_5187bb13ebc0` and the most informative regression
  `solver_736250db9a8b`. The top-down views show self-propelled target-directed
  translation and a coherent alternating reverse street rather than passive
  advection; the oblique Lambda2 views show a bounded three-dimensional wake
  through capture. The regression retains the same visible route and wake, so
  it is a terminal control-role failure rather than loss of propulsion or
  instability. `solver_d97cee67d951` is an exact policy/trajectory replicate of
  the best sample; `solver_da1119fe4fc6` supplies a second, smaller terminal
  regression.
- The best anterior-only corridor release captures at `16.0545T`, final
  distance `0.744345L`, score `-0.055617`. Releasing posterior wave settling in
  the same corridor leaves arrival unchanged but worsens final distance to
  `0.745354L`, score to `-0.056672`, and terminal (`distance < 1.75L`)
  posterior acceleration-limit residence from `24.0%` to `29.2%`. Signed-miss
  half-cycle wave relief also leaves arrival unchanged and regresses to
  `0.744660L`, `-0.055945`, without changing that `24.0%` residence.
- The sampled traces agree through the `2L` milestone. On the best trace the
  signed projected miss then oscillates between approximately `-0.50L` and
  `+0.89L` while closing remains positive, whereas the target-versus-course
  error is strongly carrier-phase dependent. At capture the projected miss is
  `+0.49L` and the established redirect is still active. Thus the current
  weakness is not insufficient drive or a missing turn sign; it is terminal
  intercept erosion while the proven carrier and redirect remain coherent.
- The assigned-parent inherited scores also show only finite captures across
  steps 12--15 (`-0.056774`, `-0.056973`, `-0.073591`, `-0.055945`). Together
  with the duplicate best sheets and inherited exact-clamp lesson, this rules
  out another scalar-only or rejected-command wrapper as a meaningful test.

## Policy hypothesis

Preserve the exact far-field carrier, carrier-phase-residual redirect,
posterior wave relief/allocation, and evidence-positive anterior-only corridor
release. During a reliable, closing approach, when the velocity-projected miss
leaves the safe corridor, add one small reflection-equivariant posterior mean
curvature residual opposite the signed miss. This changes feasible mean bend
without attenuating the propulsive wave. It is zero outside the approach and
inside the safe corridor, so the evaluated route through `2L` should remain
unchanged; it must reopen smoothly when the intercept erodes.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG direction tracking and biological mean-curvature turning
source_mechanism: sensor feedback modulates the low-dimensional mean bend while the rhythmic traveling-wave carrier remains intact
transferable_invariant: separate propulsion from navigation and use a bounded target-response residual to correct persistent lateral miss without erasing the posterior traveling wave
nontransferable_details: published gains, actuator layouts, species-specific kinematics, dimensional frequencies, exact vortex phases, and prescribed routes
policy_translation: normalize target and velocity in the body frame, form the signed speed-normalized projected miss, and gate a bounded posterior mean-curvature residual by measured closing, course reliability, proximity, and loss of the safe intercept corridor
falsification: reject if capture or the coherent two-view wake is lost, any pre-2L milestone changes materially, terminal distance integral or crossing depth regresses, posterior limiting rises without route benefit, or the correction fails to reopen and change sign as projected miss changes

## Non-CFD contract audit

- Offline evaluation on every stored state of the best sampled trace changed no
  action outside `1.75L`, changed 24 near-target actions, and kept every changed
  action feasible; the largest pointwise difference was `2.811 rad/T^2`.
- A mirrored synthetic state produced exactly sign-mirrored joint
  accelerations. The guidance semantic check, lightweight Julia contract, and
  editable-boundary check all pass. These checks establish scope and symmetry,
  not hydrodynamic improvement; the latter remains for the next CFD rollout.
