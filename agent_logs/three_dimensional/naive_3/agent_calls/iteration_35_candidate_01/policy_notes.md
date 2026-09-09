# Terminal course-selective posterior-thrust candidate

## Evidence diagnosis before the policy edit

- All four sampled evaluations and the inherited phase-balanced parent/child
  evaluations satisfy the frozen Phase 2 contract: direct uniform still-water
  initialization with `U_infinity=(0,0,0)`, no cylinders or prewarm, finite
  dynamics, and `horizon` termination at `100T`. I inspected both the
  top-down mid-plane-vorticity and oblique body/Lambda2 rows for the sampled
  `1.241L` course hold, the prefilled `2.366L` rear-selector failure, the
  inherited `1.175L` phase-balanced parent, and its `2.362L` asymmetric child.
  Every fish visibly self-propels with a coherent alternating planar wake and
  compact three-dimensional structures. The failures are controlled powered
  orbits, not passive advection, wake collapse, collision, boundary exit, or
  instability.
- The sampled rear-selector, equilibrium-unbend, and fixed-sign-restart
  descendants reach only `2.366L`, `2.215L`, and `2.369L`; each replaces the
  tight return with a broad, nearly stationary common C-bend. In contrast, the
  inherited phase-balanced activity regulator reaches
  `1.175/4.041/3.243L` minimum/mean/final distance, spends about `2.35T`
  inside `1.25L` and `6.62T` inside `1.5L`, and retains mean absolute
  anterior/posterior velocity near `0.775/0.360 rad/T` inside `2L`. Its
  coherent active return makes it the strongest available scaffold even
  though it does not capture.
- The newly completed useful-half-cycle energy asymmetry is a concrete
  negative result. It regresses to `2.362/3.886/3.511L`, never enters `2L`,
  and at its minimum has anterior/posterior velocity only about
  `0.00385/0.00133 rad/T`. Its top-down and oblique rows reproduce the broad
  low-activity orbit of the prefilled rear-selector failure. A small benign
  frozen-trace action delta therefore did not predict the coupled attractor;
  do not retune its duty bias or half-cycle scale.
- At the phase-balanced parent's `1.175L` minimum, the fish remains active and
  fast (`0.683U`) but is tangential and slightly receding: target-ray/course
  error is about `1.682 rad`, course dot is `-0.111`, and measured yaw is only
  about `-0.061 rad/T`. The failure is no longer loss of anterior wave energy.
  The available two-joint split instead permits a distinct test: retain the
  symmetric anterior rhythm and mean curvature while reducing only the lagged
  posterior wave that supplies most propulsive authority during the measured
  near-target poor-course state.

## Policy hypothesis

Start exactly from the completed `1.175L` phase-balanced policy. Preserve its
bearing curvature, target-behind C-turn, continuous course hold, moving joint
equilibria, symmetric two-sided activity regulator, posterior mean curvature,
lag, braking, and command limit. Add one bounded state-feedback mechanism:
under the existing terminal distance/speed selector, continuously attenuate
only the oscillatory posterior wave when body-frame target-ray/course dot is
poor. The mean posterior steering bend remains intact and the attenuation
releases with course alignment, so the fish keeps an active anterior turning
rhythm without continuing full caudal thrust through a tangential pass.

Support requires capture, a pass below `1.175L`, longer residence inside
`1.25L`, or a tighter final return while preserving the coherent first
approach, active terminal joint motion, and comparable clamp/load residence.
Reject the mechanism if posterior attenuation merely coasts, parks either
joint, changes the first return, broadens the wake/orbit, fails to reduce
near-target speed during poor course alignment, or worsens closest approach,
residence, mean distance, and final distance relative to the phase-balanced
parent.

```text
bookshelf_consulted: true
source_domain: Lighthill elongated-body reactive-thrust theory combined with sensor-modulated coupled-oscillator robotic-fish control
source_mechanism: preserve the anterior steering rhythm while treating posterior wave kinematics as the principal thrust actuator, with slow measured target geometry selecting their allocation
transferable_invariant: when an active swimmer overshoots tangentially, preserve the state-feedback turning carrier and reduce only posterior oscillatory thrust until measured course alignment recovers
nontransferable_details: published gains, dimensional frequency, species-specific envelopes, robot amplitude ratios, full-body joint count, clocked CPG phase, exact vortex phase, target coordinates, capture radius, and prescribed routes
policy_translation: normalized body-frame target-ray/course dot and the existing terminal distance/speed weight smoothly attenuate only the lagged posterior wave; anterior phase-balanced energy and both anterior/posterior mean curvatures remain unchanged in the two-joint state-feedback contract
falsification: reject if the coherent first return or active rhythm is lost, the policy parks or coasts, the orbit or wake broadens, command/load margins worsen, or closest approach, near-target residence, and final distance fail to improve over the 1.175L parent
```

## Evaluation boundary

The candidate's coupled CFD result becomes evidence only after this worker
exits. Frozen completed-state replay and direct controller probes can establish
locality, boundedness, reflection equivariance, parameter ownership, and that
the edit affects posterior oscillation rather than mean curvature; they cannot
establish hydrodynamic improvement.

## Implemented candidate and non-CFD probes

The candidate starts from the completed phase-balanced parent and adds three
owned parameters for the one terminal posterior-thrust allocation. Its new
poor-course weight uses normalized target-ray/course dot under the existing
distance, speed, and target-behind geometry; it scales only `posterior_wave`
and retains at least one half of that component. The phase-balanced anterior
energy law, anterior/posterior mean curvatures, lag, braking, oscillator, wave
envelope, and `+/-28 rad/T^2` command reserve are unchanged. The policy uses no
time, step count, hidden state, world coordinate, target identity, route,
randomness, file access, or mutable state.

Exact Julia replay over all `18182` states of the completed `1.175L` parent
leaves anterior action identical. Maximum-joint action changes by only
`0.000206/0.00958 rad/T^2` mean/maximum beyond `3L`, and by
`0.490/1.477 rad/T^2` inside `1.5L`. At the parent's minimum-distance state,
the anterior/posterior action changes from `(5.853,0.282)` to
`(5.853,-0.559) rad/T^2`. Candidate action remains finite and within the
declared reserve, while full-trace lateral reflection negates both actions
with zero observed residual. These probes establish a localized, bounded
posterior-only allocation; they do not predict the coupled trajectory.

All `51` direct parameter references name the `51` fields returned by
`target_policy_params()`. The material-guidance, lightweight Julia contract,
parameter-schema, frozen-replay, and solver editable-boundary checks pass. No
formal CFD was run.
