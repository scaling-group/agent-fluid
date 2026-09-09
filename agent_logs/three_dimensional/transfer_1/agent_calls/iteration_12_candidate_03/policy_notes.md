# Wake-policy candidate diagnosis

## Evidence read before editing

- All four sampled episodes and the assigned parent's completed episodes use
  direct uniform initialization in still water with `U_infinity=[0,0,0]`, no
  cylinders, and no prewarm snapshot. Their finite translation and alternating
  wakes are self-propelled rather than ambient advection or initialization
  leakage.
- Both rows of the combined keyframe sheets were inspected. The sampled
  line-of-sight-guarded rollout reaches the `0.74934L` capture threshold at
  `18.6065T` while retaining a coherent alternating top-down vortex street and
  compact oblique Lambda2 structures. The prefilled opposing-half policy
  reaches `1.26695L`, but its late wake and joint excursion collapse and it
  coasts through the lower boundary. The assigned parent's step-9 exact-policy
  capture replay, step-10 collision corridor, and step-11 posterior-lag
  transfer all retain strong terminal wakes yet miss at `1.5891L`, `1.6045L`,
  and `1.6818L` and exit through the same lower boundary. The last three
  iterations therefore meet the bookshelf reconsultation trigger and falsify
  another release threshold, cadence edit, or posterior-lag transfer as the
  next mechanism.
- The useful retained architecture is the normalized target-versus-achieved-
  course outer loop, intact traveling-bend carrier, and carrier-aligned
  terminal steering. The earlier carrier-aligned rollout reached `0.95323L`;
  the sampled capture shows that this route family can cross the target, but
  its exact-policy repeat shows that the narrow yaw-response release is not a
  robust incumbent.
- In the sub-`4L` traces, `|moment_z_L2|` has median values about
  `0.0047--0.0060` and 90th-percentile values about `0.0118--0.0127` while its
  sign alternates with the beat. At closest approach the failed exact-policy
  repeat has signed route-request times yaw moment `+0.0119`, opposing its
  requested turn, whereas the sampled capture has `-0.0055`. This does not
  prove causality from one phase sample, but it supplies the sign and scale for
  a bounded hydrodynamic-response hypothesis. Existing route commands and
  returned accelerations are already near their bounds, so adding scalar gain
  is unsupported.

## Candidate mechanism and falsification

Restore the evidenced carrier-aligned achieved-course controller rather than
the prefilled carrier attenuation or the three failed inherited terminal
variants. Add one terminal wake-disturbance residual: use the reflection-even
product of the slow signed route request and normalized measured yaw moment to
identify the half-cycle in which hydrodynamic torque opposes the requested
turn. Smoothly transfer a minority of the existing, already-bounded steering
pulse from carrier-acceleration phase to that adverse-moment half-cycle. The
two pulse schedules each stay in `[0,2]`, so their convex blend neither adds
mean steering authority nor attenuates the traveling carrier. The transfer is
exactly zero outside `4L`.

Expected test: preserve the inherited far-field closure and coherent
traveling wake, retain the carrier-aligned close-pass topology, and reduce the
adverse terminal yaw/cross-track response enough to improve on the repeatable
`0.95323L` near miss or capture without increasing the steering envelope.

Falsification: reject if behavior outside `4L` changes, minimum distance does
not beat `0.95323L`, the alternating terminal wake or joint excursion weakens,
acceleration/rate saturation or loads grow, or the same lower-exit topology
remains. In that case instantaneous hydrodynamic moment is too beat-sensitive
for phase allocation; later workers should test a window-normalized yaw/slip
residual rather than tune the moment scale or restore the failed corridor and
lag mechanisms.

bookshelf_consulted: true
source_domain: wake-disturbance rejection and sensor-modulated robotic-fish asymmetric flapping
source_mechanism: separate a slow target-directed turn request from fast alternating hydrodynamic yaw disturbance and redistribute bounded rhythmic steering toward the adverse half-cycle
transferable_invariant: reject only the measured wake torque that opposes a persistent route request while preserving the propulsive rhythm and cycle-scale steering budget
nontransferable_details: published gains, dimensional cadence, species or robot kinematics, prescribed duty ratios, exact vortex phase, task-specific routes, and source-specific moment scales
policy_translation: inside a body-frame distance gate, convexly blend the existing joint-state carrier-aligned steering pulse with a reflection-equivariant pulse driven by `turn_command * moment_z_L2`, using the measured rollout scale and unchanged two-joint acceleration bounds
falsification: reject if early closure changes, the sub-0.95323L pass or termination class does not improve, terminal loads or saturation rise, the coherent wake weakens, or the lower-exit topology survives

## Non-CFD verification

- The material-guidance check passes, confirming that these notes exist and
  `guidance/control_experience.md` differs materially from the assigned
  parent. The solver editable-boundary check also passes.
- A static parameter-schema audit finds no direct `params.FIELD` reference
  absent from `target_policy_params()`. An independent replay of the policy
  equations on the prescribed synthetic observation returns two finite
  accelerations; paired lateral reflection negates both outputs with zero
  residual, the terminal steering scales remain inside `[0,2]`, and the new
  transfer gate and steering scales are exactly `0` and `1` outside `4L`.
- The prescribed Julia contract command could not execute because this image
  contains no `julia` binary (including the searched system and project
  locations). This is a toolchain limitation rather than a passed runtime
  assertion. No CFD was run and no performance improvement is claimed for the
  unevaluated candidate.
