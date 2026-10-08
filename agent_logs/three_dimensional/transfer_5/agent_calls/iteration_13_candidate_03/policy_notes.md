# Wake-policy diagnosis and candidate hypothesis

## Evidence diagnosis

- All four sampled rollouts satisfy the frozen initialization contract:
  direct uniform still water at `U_infinity=(0,0,0)`, no prewarm or cylinders,
  stable dynamics, and capture. In both the top-down vorticity and oblique
  Lambda2 rows, an initially empty flow develops into a coherent alternating
  posterior wake while the fish follows the same broad target-directed turn.
  This is self-propulsion rather than advection. The sampled policy differences
  are too small to separate visually, so the trajectory and load histories
  decide the next intervention.
- The load-selective posterior counter-tangent is the strongest finite sampled
  run by score and scoring mean distance: `-0.535298` and `2.433642L`, with
  capture at `23.8315T`. Relative to the v24 continuous-course baseline
  (`2.434073L`, `23.8315T`), it changes mean absolute filtered yaw inside `3L`
  only from `1.6839` to `1.6816 rad/T` and body-lateral speed only from
  `0.2535U` to `0.2544U`, while peak yaw rises from `3.2076` to
  `3.2645 rad/T`. Thus normalized moment gating preserves progress, but adding
  another posterior counter-tangent still does not buy clean yaw rejection.
- The prefilled half-cycle amplitude-relief child is the most informative
  mechanism failure despite retaining capture and wake coherence. It reduces
  mean/peak absolute filtered yaw inside `3L` to `1.6060/3.0632 rad/T`,
  body-lateral speed to `0.2414U`, and the corresponding mean body-force
  component from `0.01180` to `0.01135`, but capture slips to `23.8755T` and
  mean distance to `2.433993L`. It has no joint-angle-limit exposure, joint-
  speed exposure remains comparable to the other captures, and projected
  acceleration remains below `31.38 rad/T^2`; the trade is selective loss of
  useful posterior impulse rather than a command-feasibility failure.
- The inherited ungated counter-tangent had the complementary trade: it reached
  `23.7930T` but raised terminal mean/peak yaw to `1.7057/3.2886 rad/T` and
  peak moment. Its load-gated descendant improves the scoring distance
  integral and restores mean yaw to baseline scale. Together with the current
  amplitude-relief result, this supports testing load authorization on relief
  rather than changing the carrier, course bend, cadence, or relief gain.

## Policy hypothesis

Retain the prefilled state-feedback oscillator, redirect-to-wave handoff,
continuous body-frame target-course bend, and smooth component-wise command
projection. Add one fast authorization layer: carrier-rejected yaw still
selects the unwanted turn direction and observed `phi1+phi2` still selects the
yaw-supporting posterior half-cycle, but amplitude relief is applied only when
the normalized measured yaw moment has the same sign as the residual yaw.
Naturally opposing fluid moment is allowed to brake the turn without also
weakening the posterior stroke.

This small compatible combination should preserve the prefill's yaw/load
cleanup while recovering some of its `0.044T` arrival regression. Falsify it
if capture or coherent alternating wake is lost; if arrival or scoring mean
distance is worse than the prefill; if yaw, body-lateral speed, or load returns
to the load-selective counter-tangent/baseline range without a meaningful
progress gain; or if joint-speed and projected-command exposure worsens.

```text
bookshelf_consulted: true
source_domain: wake-interaction feedback and sensor-modulated robotic-fish CPG control
source_mechanism: separate slow target-derived mean turning from a small posterior waveform correction authorized by measured disturbance load
transferable_invariant: preserve the propulsive carrier and route bend, and modify a fast posterior stroke only when a normalized body-load observation shows that unwanted yaw is being reinforced
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, full-body waveforms, exact vortex phase, and task-specific routes
policy_translation: normalized body-frame target feedback keeps the continuous course bend; carrier-rejected yaw sets correction direction, observed two-joint tail tangent selects the half-cycle, and normalized yaw moment smoothly gates posterior amplitude relief
falsification: reject if capture or wake coherence regresses, or if arrival/distance integral and terminal yaw, lateral motion, loads, joint-speed exposure, and projected-command exposure do not improve jointly over the prefilled relief and load-gated counter-tangent evidence
```

## Non-CFD validation

- The configured check-runner was invoked, but its fixed model is unavailable
  for this account. Its three prescribed commands were therefore run directly:
  the material-guidance check, lightweight Julia policy contract, and solver
  boundary check all pass. The first guidance run exposed a duplicate marker
  for the same assigned parent in the rendered workspace `README.md`; removing
  only that duplicate listing made the parent comparison unambiguous and pass.
- Every direct `params.FIELD` reference is present in
  `target_policy_params()`. A `32,805`-state grid spanning distance, body-frame
  target side, velocity, yaw, joint state, and yaw moment returned finite
  commands within `31.416 rad/T^2`; the load-selective relief path was active in
  `5,832` states and inactive in the rest. Focused assertions confirm that
  reinforcing moment enables relief, opposing moment disables it, and the
  terminal proximity gate disables it outside `3L`. Non-finite observation
  probes also return finite commands. No CFD was run.
