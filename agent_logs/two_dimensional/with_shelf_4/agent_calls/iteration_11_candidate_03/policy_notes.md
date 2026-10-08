# Multi-wake candidate diagnosis

## Evidence read before the edit

- The sampled shared-prewarm sheet shows the fish held in the upper-right while
  the four developed cylinder streets interact around the second-row capture
  region. This is common initial-condition evidence, not a candidate-specific
  vortex phase or a route to encode.
- All four sampled solver copies reproduce the strongest finite scaffold:
  target capture after `137.357` released units, `4.18356L` mean distance,
  `-10.9139L` upstream and `-4.3711L` cross-stream head displacement,
  `90228.38` command energy, `0.12955` RMS relative crossflow, and
  `14.75/303.02` RMS lateral force/yaw moment. Their released sheets show a
  state-driven alternating posterior-lagged bend, a broad initial U-turn from
  the upper-right release, several beat-scale corridor kinks, and then direct
  entry into the capture circle. The upstream motion relative to mean local
  flow is active propulsion rather than passive advection.
- The assigned parent's inherited disturbance-gating candidate is the cleanest
  current mechanism failure. It preserved capture but relieved half of the
  normalized yaw-moment residual during positive targetward translation. Its
  sheet shows a wider initial loop and longer corridor reversals; arrival
  regressed to `152.526`, mean distance to `4.65798L`, effort to `99467.04`,
  and RMS crossflow/force/moment to `0.13097/15.62/309.29`. Useful translation
  therefore does not make wake-yaw rejection dispensable.
- Inherited logs separately reject unconditioned relative-crossflow addition,
  instantaneous-bearing filtering, static mean-curvature steering, and both
  tested posterior reallocations. The current anterior acceleration already
  peaks at `30.846 rad/time^2` against the `31.416` cap, so the candidate must
  not add a mean-bend acceleration or increase oscillator drive. The remaining
  visible opportunity is the broad geometry-defined initial redirect, before
  the target moves into the forward body half-plane.

## Policy hypothesis

Make exactly one mechanism change from the prefill. Preserve instantaneous
body-frame bearing as route owner, progress-qualified bearing-rate damping,
the full direct yaw-moment residual, zero-mean oscillator, and unchanged
posterior lag. Add a smooth target-aft redirect envelope to the existing
anterior half-cycle asymmetry: normalize the forward component of
`target_body_L` by `distance_L`, activate a small extra asymmetry only for the
aft component, and reduce it
continuously to exactly zero at the body-frame abeam plane. This is a
state-gated nonsteady redirect, not static curvature, extra oscillator drive,
an elapsed-time stage, or a memorized release route.

The formal expectation is a tighter first redirect and earlier entry into the
successful wake corridor while preserving capture, posterior traveling-wave
propulsion, and full disturbance rejection. Falsify the mechanism if it loses
or delays capture beyond `137.357`, increases the initial loop, mean distance,
effort, force/moment load, or actuator-cap contact, suppresses upstream
translation, or fails to return to the baseline asymmetry when the target is
abeam or forward. CFD evaluation occurs only after this worker exits, so these
are testable expectations rather than results.

bookshelf_consulted: true
source_domain: nonsteady biological fish redirect control and sensor-modulated robotic-fish asymmetric flapping
source_mechanism: apply stronger propulsive half-cycle asymmetry during a large target-aft redirect, then release continuously into the established traveling gait as target geometry aligns
transferable_invariant: a normalized body-frame geometry gate can confine extra turning authority to the redirect condition while preserving the zero-mean propulsive equilibrium outside that condition
nontransferable_details: published gains, dimensional beat settings, species-specific C-start curvature and timing, robot linkage geometry, exact vortex phases, cylinder layout, and source-task routes
policy_translation: preserve the evidenced two-joint bearing/moment-controlled half-cycle wave and add a small asymmetry increment multiplied by a smooth gate from the negative normalized body-forward target component
falsification: reject if the target-aft envelope loses or slows capture, widens the initial loop, weakens upstream translation or posterior lag, raises distance integral, effort, loads, or cap contact, or remains active after the target reaches the forward body half-plane
