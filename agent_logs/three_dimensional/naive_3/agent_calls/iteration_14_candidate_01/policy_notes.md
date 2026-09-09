# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- All four sampled evaluations use direct uniform still-water initialization
  with `U_infinity=(0,0,0)`, no cylinders, and no prewarm snapshot. Their
  translation and wakes are self-propulsion, not advection or inherited-flow
  contamination.
- I inspected all four combined keyframe sheets from release to termination,
  including both the top-down mid-plane vorticity row and the oblique
  body/Lambda2 row. The `2.385L` response-selective brake, `2.443L`
  alignment-gated carrier, `2.512L` joint-phase counterbend, and `2.536L`
  response-released S-bend all form a coherent alternating planar street and
  compact three-dimensional vortex chain. Each follows the same diagonal
  inbound route, passes below the target, rotates onto a nearly vertical
  course, and remains powered into the lower virtual boundary near `31T`.
  None is passively advected, collides, loses wake coherence, or becomes
  numerically unstable; the repeated failure is course topology.
- The assigned prefill's joint-wave-phase posterior counterbend is not a
  surviving mechanism: its `2.512L` minimum and `8.439L` mean distance are
  worse than the carrier's `2.443/8.443L`, and termination is unchanged.
  The best sampled raw-yaw brake reaches `2.385L`, but it also preserves the
  lower exit. Inherited completed evaluations close two more open variants:
  response-gated reallocation reaches only `2.444L`, while response-gated
  posterior phase-lag relief regresses to `2.633L`; both retain the powered
  lower exit. Another posterior gate, counterbend, phase-lag edit, or scalar
  brake-strength change is therefore unsupported.
- A different signal defect is repeatable across the completed traces. Inside
  `3L`, instantaneous heading rate is anticorrelated with anterior joint rate
  at `r=-0.992` to `-0.998`; the fitted relation has slopes `-0.40` to
  `-0.46`, and removing that joint-rate component reduces yaw-rate standard
  deviation from `1.20--1.38` to `0.08--0.15 rad/T`. Raw yaw is principally
  gait-synchronous motion, yet the carrier feeds it directly into anterior
  mean-curvature damping. Replaying a median `0.43` cancellation on the
  sampled states reduces inferred mean-curvature variation inside `3L` by
  roughly half and changes its mean by only `0.07--0.14 deg`; this is a signal
  diagnostic, not a coupled-CFD prediction.

## Policy hypothesis

Return to the simple alignment-gated carrier and introduce one new feedback
mechanism: estimate course yaw by subtracting the repeatable anterior-joint-
rate-synchronous yaw component from measured heading rate before applying the
existing bounded steering damping. Keep the anterior oscillator, target
bearing curvature, posterior lag, alignment envelope, posterior mean, and
command reserve otherwise unchanged. This proprioceptive cancellation is a
memoryless approximation to beat-averaged course response; it does not add a
new posterior intervention or infer a world route.

Expected evidence is a coherent traveling wake and broad approach comparable
to the carrier, but with less beat-scale modulation of anterior steering and a
meaningfully different course near the target. Capture, a useful termination
class, or a minimum materially below `2.385L` without worse mean distance
supports the mechanism. Reject it on degraded far-field progress, a one-sided
or collapsed wake, a tight curl, materially greater actuator/load residence,
or persistence of the same lower exit without useful geometric improvement.

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and tail-beat averaging models
source_mechanism: separate a rhythmic locomotion carrier from slower directional feedback so the controller does not treat carrier-synchronous body motion as course error
transferable_invariant: remove the repeatable gait-synchronous component of a measured response before using that response to damp target-directed steering
nontransferable_details: published gains, dimensional frequencies, robot duty ratios, species-specific envelopes, exact vortex phases, fixed averaging windows, target coordinates, and task-specific routes
policy_translation: normalized body-frame bearing supplies the turn request, while bounded heading_rate plus the oppositely correlated anterior phi_dot estimate a reflection-equivariant course-yaw residual for the existing two-joint state-feedback carrier
falsification: reject on degraded cruise, lost or strongly asymmetric wake coherence, a short-radius curl, increased command or load residence, no material improvement below 2.385L, or persistence of the powered lower exit
```

## Evaluation boundary

This worker cannot claim CFD evidence for the new candidate. Formal evaluation
occurs only after exit; deterministic replay and contract probes establish
only signal behavior, reflection equivariance, finite bounds, and
implementation correctness.

## Implemented candidate and pre-CFD checks

The single candidate returns to the `2.443L` alignment-gated carrier, removes
the assigned prefill's unsupported posterior half-cycle counterbend, and adds
only the course-yaw residual described above. The rollout-fitted coupling
coefficient is owned by `target_policy_params`, as are all other active
propulsion and steering values. Posterior wave shape, alignment authority,
mean split, damping, and the `28 rad/T^2` command reserve are unchanged from
the carrier.

A direct Julia probe confirms exact global reflection equivariance, complete
cancellation for a synthetic gait-locked yaw state, finite outputs under
extreme finite inputs, and adherence to the configured command bound. The
mandated semantic-guidance and parameter-schema check passes, the lightweight
Julia policy contract passes, and the editable-boundary audit passes. The
rendered `README.md` initially marked the same assigned parent twice; removing
only that duplicate marker allowed the required semantic comparison to run.
The independently invoked configured check runner then passed all three
checks. No CFD was run.
