# Candidate wake-policy diagnosis

## Evidence read before the edit

All sampled diagnostics report the required direct-uniform still-water
initialization, zero background velocity, no cylinders, and finite
`left_domain` termination. The combined top-down and oblique sheets show that
the assigned prefill (`80d41cb1405d`) and the stronger transient-redistribution
children are self-propelled: a coherent alternating mid-plane vortex street
and tail-connected three-dimensional Lambda2 structures develop and persist.
The informative large anterior redirect (`bff3d6a0f652`) instead holds a visibly
curled body, produces a shorter and weaker wake, and exits at `10.324T` after
reaching only `11.081L`. The visual evidence therefore supports retaining the
zero-mean anterior carrier and rejects another large or permanent head bend.

The assigned prefill uses a crossflow-assisted posterior mean and a
speed-gated centerline course brake. It exits at `11.594T` with minimum/final
distance `9.880/9.880L`. Redistributing that same transient course cue forward
by at most `3 deg` (`c0a67102cc0a`) preserves the alternating wake, survives to
`23.260T`, and reaches `4.419L`; a `4 deg` version (`6d90d1984e81`) survives to
`27.572T` and reaches the best sampled minimum, `3.161L`. This is a semantic
and trajectory improvement even though the `3 deg` child has the better raw
score and final distance.

The remaining failure is approach control, not insufficient bend amplitude.
The `4 deg` child first crosses `5L` at `14.102T` and `4L` at `15.615T`, reaches
its minimum at `18.227T`, then recedes to `8.569L` and leaves through the upper
boundary. At closest approach its normalized body-frame target vector is
approximately `(-1.748,-2.634)`, bearing is `-0.985 rad`, target-versus-velocity
course error is `-1.488 rad`, forward speed is `0.741U`, and relative crossflow
is `-0.414U`: the target is strongly off-course while the fish retains large
translational momentum. Across the rollout either acceleration lies within
five percent of the soft limit on `73.8%` of samples; both joint speeds reach
`4.538 rad/T`. The `3 deg` child has the same speed maximum and `72.7%`
near-limit action residence. Enlarging the anterior redirect is contradicted
by the failure example; preserving full propulsion through a strongly
misaligned approach is the unresolved hypothesis.

## Single candidate hypothesis

Use the `4 deg` transient-redistribution child as the route controller because
it supplies the best sampled closest approach. Keep its body-frame bearing,
relative-crossflow residual, target-versus-velocity course brake, recent-yaw
damping, posterior mean-curvature bound, full lagged posterior target, and
smooth acceleration envelope. Add one approach-energy mechanism to the
anterior state-feedback oscillator: a bounded damping ratio is activated only
by the product of a normalized near-target distance gate and absolute course
misalignment. It leaves the oscillator unchanged when far away or aligned,
does not shift its mean, and drains rhythmic energy when the fish is close but
moving across the target line. Because the posterior target is still formed
from actual anterior state, its traveling component decays with the carrier
while its bounded mean steering remains available; the Van der Pol drive can
restore the rhythm continuously after course alignment returns.

The expected test is a slower, lower-saturation redirect after entering roughly
the `5L` approach region, without changing the strong child's earlier wake or
route. Falsify the mechanism if it suppresses the alternating wake before the
approach gate becomes material, cannot restore propulsion after alignment,
fails to improve on the `3.161L` minimum or `27.572T` survival, repeats the
post-minimum upper drift without reducing action residence, or increases peak
force and moment beyond the sampled `0.0337` and `0.0175` coefficients.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and distance-conditioned fish approach control
source_mechanism: sensor feedback temporarily reduces rhythmic drive during a large target-relative course error while retaining a separate steering command
transferable_invariant: preserve the propulsive limit cycle during transit, but shed carrier energy when normalized target proximity and measured course misalignment jointly show that momentum is preventing redirection
nontransferable_details: published gains, oscillator clocks, robot or species kinematics, dimensional switching distances, exact vortex phases, and task-specific routes
policy_translation: multiply a bounded damping ratio by smooth `distance_L` and body-frame target-versus-velocity course-error gates, apply it only to anterior oscillator velocity, and retain posterior mean steering and the actual-state lagged wave
falsification: reject if early propulsion or the 3D wake weakens, minimum distance and survival do not beat `3.161L` and `27.572T`, action residence does not fall during approach, or the carrier fails to recover when course alignment returns

## Non-CFD gate audit

Replaying only the new algebraic gate on the `6d90d1984e81` observation
history gives mean damping ratio `0.00243` while distance is at least `8L`,
`0.08225` inside `5L`, and a maximum of `0.11890` near `18.194T` at
`3.162L` with clipped course error `-1.571 rad`. This confirms locality and
boundedness, not hydrodynamic improvement; the latter remains for the next CFD
evaluation.
