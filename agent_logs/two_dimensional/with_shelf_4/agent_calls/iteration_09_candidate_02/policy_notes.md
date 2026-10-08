# Multi-wake candidate diagnosis

## Evidence read before the edit

- The common prewarm sheet shows the fish held above and far to the right of
  the target while four developed cylinder streets interact around the
  second-row capture region. This fixes the release flow but supplies neither
  a reusable vortex phase nor a case-specific route.
- The three sampled progress-qualified policies are deterministic duplicates
  of the current prefill. Their released sheets show active upstream swimming,
  a persistent alternating posterior-lagged bend, and capture after `137.357`
  units with `4.18356L` mean distance, `-10.9139L` upstream displacement,
  `90228.38` total command energy, `0.12955` RMS relative crossflow, and
  `14.75/303.02` RMS force/moment. The anterior acceleration already reaches
  `30.846 rad/time^2` against the `31.416` cap, so extra gait authority or a
  faster scalar setting is not supported.
- The otherwise identical rate-only predecessor also captures but takes
  `149.605` units, with `4.35835L` mean distance, `96932.99` total energy, and
  higher crossflow/force/moment (`0.13206/15.49/308.48`). This causally
  supports preserving instantaneous bearing, progress-qualified bearing-rate
  damping, the direct moment residual, and the established gait.
- The informative inherited failure closes into an upper-right loop and exits
  the top boundary after `126.428` units. It moves only `-1.116L` upstream and
  regresses from `8.610L` closest distance to `12.046L` final distance; its
  moderate `317.27` RMS moment and feasible joint extrema do not rescue lost
  route topology.
- Later one-change residuals do not improve the strongest scaffold. Circular
  bearing-history averaging delays capture to `149.853` units and raises mean
  distance/energy/load. A direct opposing relative-crossflow residual delays
  capture further to `154.110` units, raises mean distance from `4.184L` to
  `4.687L`, total energy from `90228` to `99457`, and RMS force/moment from
  `14.75/303.02` to `15.85/310.83`, while RMS crossflow barely changes
  (`0.12955` to `0.13005`). A separate lateral-target residual reaches only at
  `159.302` units with `4.722L` mean distance. These results reject more route
  smoothing or an unconditioned flow residual as the next mechanism.
- In the best released sheet, the fish does turn toward the target and retain
  propulsion, but its initial path spends a long segment moving nearly
  cross-stream before the upstream corridor entry. Because the initial target
  lies almost behind the fish, full posterior traveling-wave thrust during
  that redirect is a plausible source of route length; the later wake crossing
  itself is successful and should remain unchanged.

## Policy hypothesis

Make exactly one controller-mechanism change from the prefill: coordinate the
evidenced anterior half-cycle steering with a smooth bearing-dependent release
of posterior propulsion. At very large instantaneous body-frame bearing, reduce
only the posterior phase-lag component, allowing the anterior oscillator to
redirect without applying the full target-misaligned traveling-wave thrust.
Restore the complete posterior lag continuously as bearing alignment returns.
Keep oscillator period/amplitude, progress-qualified route feedback, direct
moment residual, half-cycle asymmetry, tail tracking, and every other gain
unchanged.

This is a state-feedback phase-lag mechanism, not a time stage or a scalar-only
gait edit. The expected formal test is retention of the alternating wave,
upstream translation, and capture with a shorter initial redirect, lower mean
distance or total effort, and no additional actuator-cap contact. Falsify it if
capture is lost or delayed beyond the `137.357` baseline, the initial turn
weakens into a loop or boundary exit, upstream displacement falls, the
posterior wave fails to recover near alignment, or distance, effort, crossflow,
force, moment, or saturation worsens. The candidate CFD runs only after this
worker exits, so these are expectations rather than same-worker evidence.

bookshelf_consulted: true
source_domain: nonsteady fish redirect control, robotic-fish CPG direction tracking, and elongated-body reactive propulsion
source_mechanism: separate a large-error redirect from full posterior propulsive-wave release, then restore posterior emphasis as observed target alignment returns
transferable_invariant: normalized body-frame target error may coordinate steering and posterior traveling-wave authority so thrust is reduced while pointed away from the route and restored continuously after alignment
nontransferable_details: published gains, dimensional frequencies, species-specific C-start envelopes, full-body kinematics, robot linkage geometry, exact vortex phases, cylinder layout, and source-task routes
policy_translation: preserve the evidenced anterior state-feedback half-cycle controller and route/load loops, then smoothly reduce only `tail_lag_gain` as a bounded function of absolute instantaneous bearing and recover the full lag near alignment
falsification: reject if the redirect is slower, capture or upstream translation is lost, the alternating posterior wave does not recover, actuator caps or load rise, or a loop, boundary exit, or longer-distance topology replaces the sampled route
