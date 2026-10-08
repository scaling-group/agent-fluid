# Multi-wake target-policy candidate notes

## Evidence diagnosis before the edit

- All four sampled evaluations satisfy the frozen rollout contract: direct
  uniform still-water initialization (`U_infinity=[0,0,0]`), no cylinders,
  no prewarm, finite dynamics, and moving-window transport.  Their motion and
  wakes are self-generated rather than imposed advection.
- Both the top-down vorticity and oblique Lambda2 rows of all four combined
  keyframe sheets were inspected.  Every candidate retains the inherited
  coherent alternating wake and compact three-dimensional structures, so the
  remaining miss is a steering/topology fault rather than absent propulsion or
  wake breakup.
- The sampled posterior-passage recapture is the only new branch with a useful
  semantic effect.  Against the phase-selective parent it keeps essentially
  the same closest pass (`3.031L` versus `3.033L`) but changes the straight
  westward left exit at `(0.797,5.995)L` and `40.331T` into a broad northward
  loop ending at `(4.230,15.201)L` and `49.319T`.  Final distance improves from
  `9.314L` to `7.528L`, mean distance from `8.346L` to `7.107L`, and recorded
  raw acceleration-envelope exposure from about `93.63%` to `92.77%` and
  joint-rate-limit exposure from `12.68%` to `12.30%`, without angle-limit
  contact.  The visual wake remains coherent throughout the loop.  This is
  evidence that a bounded late mean-curvature branch has route-scale authority,
  but not that its present gate can capture.
- The failure is timing and persistence.  The evaluated recapture is exactly
  dormant until the target becomes posterior at `21.670T`, when the lateral
  body-frame miss is already `3.18L`.  It is still only `3.031L` away at the
  `23.793T` closest pass, then its monotone posterior gate holds the bend as
  distance grows: the fish is near `(2.23,10.50)L` at `40T` and continues
  north to the boundary.  It never converts the loop into a second approach.
- The siblings close two weaker alternatives.  Keeping opposing-half-cycle
  authority tied to persistent route geometry improves closest distance only
  from `3.033L` to `2.999L` and retains the westward left exit; a `3 deg`
  curvature branch armed around abeam likewise reaches only `3.035L` and the
  same exit topology.  Another phase persistence edit, release threshold, or
  small abeam gain is therefore not the present opening.  The positive fact to
  preserve is the `7 deg` branch's demonstrated ability to change the route.

## Policy hypothesis

Start from the evaluated posterior-passage recapture candidate, retaining the
phase-selective carrier and all prior steering.  Replace its monotone
behind-only gate with one compact interception mechanism: a mirror-equivariant
sector pulse that ramps in when a large lateral target approaches abeam,
reaches full authority during positive closing progress, and ramps back to zero
when the target becomes deeply posterior or distance begins materially
diverging.  The lateral deadband keeps it dormant near the route centerline;
the closing gate permits rearming only on a genuine renewed approach.  This is
an architecture change from a persistent posterior bend to a response-released
curvature impulse, not scalar-only gain tuning; it uses only normalized
body-frame target components, normalized closing progress, and observed joint
state.

The pulse should begin during the last useful closing segment, before the
observed `3.18L` passage miss is fixed, while its posterior release prevents
the branch from driving the sampled `49T` upper loop indefinitely.  Expected
evidence is the same coherent early wake through the materially off-axis
onset, followed by an earlier clockwise course bend, reduced lateral distance
near passage, and either capture or a closer/semantically better termination.
Falsify it if it perturbs target-centered states, recreates the inherited
release-pose upper turn, loses the coherent carrier/deep approach, materially
worsens actuator exposure, or merely exchanges the left exit for another
wide non-closing loop.

bookshelf_consulted: true
source_domain: biological C-start redirect and sensor-modulated robotic-fish CPG turning
source_mechanism: apply strong bounded curvature under large observed direction error, then release the burst into the propulsive rhythm as the redirect sector is traversed
transferable_invariant: separate a coherent cruise carrier from a transient geometry-gated curvature impulse whose authority rises before passage and releases when the target sector is traversed or approach progress reverses
nontransferable_details: species-specific C-start shape, published gains, motor timing, dimensional cadence, clock-driven phase, exact vortex phases, task-specific routes, and source turning radii
policy_translation: use normalized body-frame forward target position to form an abeam band-pass gate, require material normalized lateral error for mirror-equivariant sign, release on normalized distance divergence, and add the bounded pulse only to the posterior mean tangent within the two-joint state-feedback contract
falsification: reject the transfer if centered or early target-ahead motion changes, the established deep approach or wake coherence is lost, limit exposure rises materially, the pulse remains active through material divergence, or no closer pass/useful second approach appears

## Pre-evaluation checks

- Fixed-state replay over all `7,333` sampled phase-selective states places the
  effective sector pulse between `14.047T` and `24.332T`, instead of first
  arming after passage at `21.670T`.  At the representative states from `14T`
  through `24T`, its normalized request is respectively `0.000`, `0.097`,
  `0.195`, `0.427`, `0.510`, `0.815`, and `0.000`: it builds as the materially
  lateral target approaches abeam and releases when the sampled distance
  derivative turns non-closing.  Every sampled non-closing state and every
  state beyond the configured deep-posterior boundary has exactly zero pulse.
- On that fixed trace, reconstructed exposure to at least one raw acceleration
  command beyond `1800 deg/T^2` is `93.29%`, between the phase-selective
  parent's `93.65%` and the monotone recapture's `92.32%`; all retain the same
  `112.974 rad/T^2` peak.  On the completed broad-loop trace, the counterfactual
  sector pulse yields `90.02%` exposure versus `92.78%` for the evaluated latch
  with the same peak.  This establishes boundedness and no algebraic increase
  over the preserved carrier, not a prediction of the new closed-loop path.
- All `67` direct `params.FIELD` references resolve among the `69` fields
  returned by `target_policy_params()`.  A deterministic `21,600`-pair grid
  over mirrored body-frame target position, joint state, lateral velocity,
  bearing rate, yaw rate, and closing speed is finite; the new pulse request
  and posterior mean tangent are antisymmetric, exactly zero on the lateral
  centerline, and exactly zero whenever closing speed is nonpositive or the
  target is deeply posterior.
- The reusable-guidance semantic check, lightweight Julia public-contract
  check, and solver editable-boundary audit pass.  Formal CFD remains deferred
  to EvE after this worker exits.
