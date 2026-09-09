# Wake-policy candidate notes

## Evidence diagnosis before editing

- All four sampled episodes are valid direct-uniform L64 still-water rollouts:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, and lossless moving-window
  shifts. Their motion and wakes therefore diagnose self-propulsion and
  target steering rather than ambient advection.
- The combined top-down and oblique sheets show that the compact
  bearing/rate controller (`solver_b6bb94d9cdaf`) has the strongest finite
  result by score (`-7.6367`) and a persistent alternating three-dimensional
  wake. It reduces distance from `12.3277L` to `5.3570L`, but bearing is about
  `-84.5 deg` at `18T`; the fish passes high and exits the upper boundary at
  `21.79T`. Its soft-bounded actions remain above `95%` of the controller
  limit on about `33.8%/53.1%` of rows, so the useful propulsion does not make
  its beat-scale steering reversal a reusable solution.
- The branch-heavy sign-flip (`solver_e450df1efa49`) retains an especially
  coherent axial wake and makes the closest sampled pass (`4.1281L`), but its
  nearly flat route stays above the target and exits left at `32.02T`; raw
  actions exceed the physical acceleration envelope frequently. The
  course/yaw-rate posterior-curvature controller (`solver_d146183ecace`) is
  the opposite failure: both visual rows show a weak developing wake followed
  by a tight upward curl, only `0.1020L` of closest progress, and an upper exit
  at `8.65T`. Thus neither layered static curvature nor moving the route error
  through another rate loop is supported.
- The prefilled response-release candidate (`solver_59bc4ebdddec`) directly
  falsifies its inherited hypothesis. Although its top-down vortex street and
  oblique Lambda2 structures remain organized and its peak force/moment stay
  below the sampled compact controller, bearing worsens from about `+8.4 deg`
  at release to `+16.1 deg` at `4T`, then crosses abruptly to `-32.0 deg` at
  `6T`. It exits the upper boundary at `14.65T` after reaching only `7.5311L`,
  and actions still lie above `95%` of the `31 rad/T^2` command limit on about
  `25.5%/44.4%` of rows. Preventing rate feedback from reversing curvature did
  not create a settled cycle-mean turn; another release-floor or rate-scale
  adjustment would be scalar tuning of a failed mechanism.
- No sampled fish enters the `0.75L` capture neighborhood, and there is no
  external wake. Terminal scheduling, flow rejection, and cylinder-specific
  behavior are therefore excluded from this test.

## Policy hypothesis

Preserve the evidenced anterior joint-state oscillator, posterior phase lag,
and smooth controller-owned acceleration bound. Replace static mean curvature
and rate-response steering with one new actuator primitive: normalized
body-frame bearing selects a bounded posterior half-cycle amplitude
asymmetry. The posterior traveling-wave tangent is strengthened on the side
that produces the requested cycle-mean bend and weakened on the opposite side;
there is no static offset, anterior equilibrium shift, rate loop, clock, or
world-frame route. Positive sampled bearing strengthens positive posterior
tangent because that was the initially corrective 3D bend convention in the
compact rollout.

Expected result: retain the coherent propulsive wake while obtaining a smooth
cycle-mean turn that does not jump across the target line or hold a static
curl. Falsify the mechanism if the initial bearing does not contract, the same
upper exit occurs without improving on `7.5311L`, propulsion weakens toward the
course-controller failure, the route overshoots toward the inherited lower
exit, or joint angle/rate/command-limit residence worsens.

bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping and classical target-conditioned fish turning superposed on an undulatory traveling bend
source_mechanism: half-cycle amplitude asymmetry with posterior phase lag
transferable_invariant: preserve a directional posterior-lag wave for thrust while persistent body-frame target error strengthens one observed bend half-cycle and weakens the other to create bounded cycle-mean turning
nontransferable_details: published gains, duty ratios, clock-driven CPG phase, species-specific amplitudes and cadence, full-body kinematics, exact vortex phases, and task-specific routes
policy_translation: map bounded body-frame bearing to a reflection-symmetric gain on the posterior wave tangent inferred from joint state; keep the anterior oscillator centered and softly bound both accelerations
falsification: reject if bearing does not contract, coherent propulsion or distance progress collapses, the upper or lower exit topology persists without semantic improvement, or actuator-limit residence increases
