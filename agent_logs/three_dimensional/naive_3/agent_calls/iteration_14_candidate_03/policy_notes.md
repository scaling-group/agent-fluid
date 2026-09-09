# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- All four sampled rollouts report direct uniform initialization in still
  water with `U_infinity=(0,0,0)`, no cylinders, and no prewarm. Their finite
  travel and wakes are self-propulsion, not advection or inherited flow.
- I inspected the combined keyframe sheets for the strongest sampled
  response-selective posterior brake (`2.385L` minimum), the simple
  alignment-gated carrier (`2.443L`), and the informative response-gated
  posterior S-bend failure (`2.536L`), including the full top-down mid-plane
  vorticity and oblique body/Lambda2 rows. All three build a coherent
  alternating planar street and compact three-dimensional vortex chain,
  follow almost the same diagonal inbound route, pass below the target, turn
  nearly vertical, and remain powered to the lower virtual boundary near
  `31T`. No collision, passive drift, wake collapse, or instability explains
  the failure.
- The assigned-parent brake is the strongest current sample: it improves the
  carrier minimum from `2.443L` to `2.385L` and mean distance from about
  `8.443L` to `8.436L`. The semantic result is unchanged, however: all four
  current samples exit low with final distance `9.190--9.207L`. Posterior
  response-gated S-bend (`2.536L`) and joint-wave-phase counterbend (`2.512L`)
  are worse, so another persistent posterior offset or joint-phase proxy is
  unsupported.
- At the brake minimum near `17.87T`, the full target direction remains about
  `1.38 rad` lateral, speed remains about `0.705U`, closure is only about
  `0.014 L/T`, and yaw is in the error-growing sign at about `2.19 rad/T`.
  Inherited trace analysis finds that inside `3L` raw heading rate correlates
  `-0.992-- -0.997` with anterior joint velocity and spends about half the
  samples in each sign. Thus the successful brake is effectively selecting a
  beat half-cycle, not demonstrating a slow yaw-error signal. Anterior
  acceleration is clamped for about `0.747` of the best trace versus `0.356`
  posterior, yet the sampled response interventions have all modified only
  the posterior wave.

## Policy hypothesis

Start from the assigned-parent response gate and preserve its bounded target
curvature, oscillator state, posterior lag, alignment envelope, and command
reserve. Move the gated half-cycle relief from the posterior traveling wave to
the anterior oscillator component: during only the near, materially lateral,
measured error-growing yaw half-cycle, attenuate the anterior oscillatory
acceleration toward a nonzero floor while leaving its mean-curvature steering
term and the complete posterior traveling bend intact. This is an actuator
allocation change, not a scalar carrier-gain tune.

The mechanism should keep the evidenced far-field route and coherent wake but
unsaturate the actuator most coupled to the wrong-way yaw response, while
retaining posterior thrust and mean steering. Capture, a useful termination
change, or a minimum materially below `2.385L` without worse mean progress
would support it. Reject it on changed cruise, a one-sided or collapsed wake,
premature speed loss, a tight curl, increased command/load residence, or the
same powered lower exit without material distance improvement.

```text
bookshelf_consulted: true
source_domain: robotic-fish half-cycle amplitude asymmetry and sensor-modulated CPG direction tracking
source_mechanism: retain the traveling propulsive bend while measured target-relative body response selects bounded relief on the counterproductive anterior beat half-cycle
transferable_invariant: separate rhythmic propulsion from mean steering and apply response-selected asymmetry at the actuator whose saturated half-cycle is coupled to wrong-way yaw, restoring the nominal rhythm on corrective response
nontransferable_details: published gains, dimensional frequencies, species-specific envelopes, robot duty ratios, exact vortex phases, fixed burst durations, approach radii, and task-specific routes
policy_translation: normalized target_body_L and distance_L localize the intervention; bounded heading_rate selects a reflection-equivariant scale on only the anterior oscillator acceleration while mean curvature and posterior lag remain intact under the two-joint state-feedback contract
falsification: reject on altered far-field progress, lost or strongly asymmetric wake coherence, premature speed loss, a short-radius curl, greater actuator/load residence, no material improvement below 2.385L, or persistence of the powered lower exit
```

## Evaluation boundary

The new candidate receives CFD only after this worker exits. Trace replay and
contract probes below can establish locality, symmetry, finite bounds, and the
intended command decomposition; they cannot establish hydrodynamic benefit.

## Implemented candidate and pre-CFD checks

The candidate retains the assigned parent's smooth approach, lateral-error,
and error-growing-yaw gate. It removes that gate from the posterior wave and
applies it only to the anterior oscillatory acceleration, with a
parameter-owned `0.35` floor; the anterior mean-curvature term and complete
posterior lagged target remain active. At the recorded `2.385L` minimum, the
gate weight is about `0.913`. A direct state replay changes the candidate
command from the parent's approximately `(10.96,-0.31)` to
`(12.72,16.20) rad/T^2`, still below the `28 rad/T^2` reserve. This is the
intended response-selective actuator reallocation, not a CFD prediction.

Replay over the assigned-parent trajectory gives mean relief weights of
`0.0031` beyond `4L`, `0.090` from `3--4L`, and `0.302` inside `3L`.
Reconstructed near-field anterior command saturation falls from about
`0.734` to `0.604`; the far-field mean absolute command difference is only
about `(0.013,0.050) rad/T^2`. The reconstructed actions are controller-local
counterfactuals on a fixed history, so coupled hydrodynamics may invalidate
them.

Direct Julia probes pass reflection equivariance, corrective-response release,
far-field locality, finite bounds, and the deterministic parameter-schema
guard for all `21` referenced fields. The mandated material-guidance,
lightweight policy-contract, and solver-boundary checks pass, as do all `324`
repository non-CFD assertions. Formal CFD was not run.
