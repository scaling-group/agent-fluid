# Joint-phase recoil-observer candidate

## Visual diagnosis recorded before the policy edit

- All sampled evaluations and the inherited posterior-allocation failure use
  direct uniform still-water initialization with `U_infinity=(0,0,0)`, no
  cylinders, and no prewarm. In both the top-down mid-plane and oblique
  Lambda2 rows, motion begins from quiescent fluid and produces a compact,
  alternating three-dimensional wake; neither imposed advection nor storage-
  window motion explains the route.
- All four sampled distributed-C-bend policies capture. The acceleration-
  feasible assigned parent is the strongest finite result at `19.283T`, score
  `-0.18218`, with a coherent wake through capture. The other response-gated
  copies capture at `19.585T` and `19.888T`, while the collision-course gate
  captures at `19.784T`. Their different terminal headings and approach sides
  show that scalar score alone does not identify one exact route.
- The inherited response-gated posterior-allocation rollout is the informative
  failure. Relieving `75%` of posterior mean steering when the anterior C-bend
  is recruited preserves self-propulsion and a visibly coherent alternating
  wake, but it removes the successful turn: minimum distance degrades from
  `0.749L` to `3.191L`, the fish passes high, and it exits left at `30.096T`
  with final range `9.117L`. Posterior phase-lagged propulsion alone cannot
  replace its mean steering contribution in this topology.
- The assigned-parent trace still requests the posterior acceleration limit
  through much of the route, and inherited notes establish that its velocity-
  only phase-conditioned yaw residual oscillates within a beat. A centered
  one-period diagnostic, used only for offline evidence analysis, shows that
  `heading_rate + 0.82*qd1 + 0.12*qd2` differs from the beat-centered yaw rate
  by `0.75--0.87 rad/T` RMS across the four sampled captures. Adding the two
  joint-position quadratures while retaining those evaluated velocity terms
  reduces that replay residual to `0.29--0.32 rad/T`; leave-one-rollout-out
  fits retain the same signs. This supports an observation change, not another
  carrier or curvature gain edit.

## Policy hypothesis recorded before editing

Start from the assigned parent's acceleration-feasible response-triggered
distributed C-bend. Preserve its normalized body-frame bearing and LOS-rate
request, anterior recruitment gate, posterior mean curvature limit, complete
two-joint traveling carrier, and explicit physical acceleration projection.
Add one mechanism to the achieved-yaw observer: represent periodic joint recoil
with both velocity and position quadratures. Center the anterior position by
the already commanded anterior mean curvature and scale both position terms by
the observed carrier angular frequency, so the correction remains a bounded,
reflection-equivariant joint-state feedback rather than a clock or history.

The expected result is to retain capture while making posterior mean curvature
follow slow route response instead of beat recoil, reducing posterior raw
acceleration conflict and improving or preserving arrival relative to the
`19.283--19.888T` sampled capture band. Offline replay predicts lower raw
posterior-limit exceedance, but that is not a changed-trajectory result.
Falsify the mechanism if capture is lost, the coherent wake weakens, the route
returns to the inherited more-than-`3L` high pass, arrival is later, or completed
diagnostics do not reduce posterior exceedance and force/moment load.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and phase-lagged traveling-wave swimming
source_mechanism: infer slow directional response after separating rhythmic joint-phase recoil into in-phase and quadrature components
transferable_invariant: periodic joint-driven body recoil can contain both position- and velocity-phase components, so route feedback should act on the residual rather than interpret either component as achieved mean yaw
nontransferable_details: published oscillator gains, robot linkage geometry, species kinematics, dimensional frequencies, exact wake phase, and task-specific routes
policy_translation: retain normalized body-frame LOS steering and the two-joint carrier, then augment the evaluated velocity recoil projection with bounded frequency-scaled centered-q1 and q2 terms before computing posterior mean curvature
falsification: reject if capture or wake coherence is lost, the high left pass returns, arrival worsens, or completed load and posterior saturation diagnostics do not improve

## Validation status

- The mandated check-runner reports PASS for the material-guidance check and
  PASS for the solver boundary check. A separate deterministic comparison also
  confirms that every direct `params.FIELD` reference is returned by
  `target_policy_params()`.
- The check-runner's lightweight Julia probe could not start because this
  worker environment has no `julia` executable; searching the available
  system runtime locations found no alternate binary. This is an environment
  limitation, not a runtime pass.
- A translated-formula audit over 10,000 randomized finite states returned
  bounded finite commands and zero numerical residual under lateral reflection;
  this checks the new algebra but does not replace the unavailable Julia probe.
- No CFD rollout was run, and no outcome for this candidate is claimed here.
