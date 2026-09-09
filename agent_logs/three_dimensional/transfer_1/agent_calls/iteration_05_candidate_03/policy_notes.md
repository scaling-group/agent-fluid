# Wake-policy candidate diagnosis

## Evidence read before editing

- All four sampled episodes are valid, finite, direct-uniform still-water
  releases with `U_infinity=(0,0,0)`, no cylinders, and no prewarm. Motion is
  self-propelled rather than ambient advection; every termination is
  `left_domain`, not collision or numerical instability.
- Both visual rows were inspected. Every sample forms an alternating
  top-down vorticity street and compact oblique three-dimensional Lambda2
  structures behind an intact swimmer. The inherited `0.55T`, `28 deg`
  joint-state oscillator and posterior lag remain the evidenced propulsive
  carrier. The parent phase-compensated bearing/yaw cascade instead follows an
  almost horizontal upper route, reaches only `3.0031L`, and puts at least one
  joint at the acceleration envelope on `91.7%` of trace rows.
- The terminal opposing-half reallocation rollout `solver_a8af0d71b0de` is the
  strongest semantic sample. It turns below the target and reaches `1.2669L`
  at `18.69T`, with lower peak planar force/moment and any-joint acceleration
  saturation on `56.0%` of rows. It then loses its traveling carrier: between
  about `18.0T` and `20.0T`, joint excursions fall from order `0.3 rad` to
  order `0.1 rad`, joint speeds fall below `0.5 rad/T`, and later keyframes no
  longer show the sustained compact alternating wake seen on approach. The
  fish coasts through the miss with downward world velocity near
  `(-0.49,-0.61)L/T` while the normalized course error remains at its bound.
- The smooth observed-half-cycle rollout `solver_9cc71cad0aa3` supplies the
  complementary negative result. It preserves the rhythmic joint excursions
  and reduces any-joint acceleration saturation to `30.6%`, but its broadly
  active phase asymmetry redirects too early, reaches only `2.7390L`, and
  retains a lower-boundary exit. Thus another global course gain, a deeper
  cadence relief, or always-active half-cycle asymmetry is not supported.
- Assigned-parent guidance and inherited optimizer notes predicted that
  steering realization, not route-error magnitude, was the missing
  capability. The sampled results now narrow that lesson: terminal
  half-cycle reallocation obtains the closest route, but it must relinquish
  authority when its own phase-selective attenuation drains the carrier.
  Local-flow magnitudes and load peaks remain comparable across samples, so a
  wake-rejection residual is not evidenced for this quiescent candidate.

## One candidate mechanism

Use `solver_a8af0d71b0de` as the scaffold and add an observed carrier-energy
guard to its existing terminal opposing-half reallocation. Form a normalized
joint-state phase radius from anterior bend and velocity. Keep the evidenced
terminal reallocation only while that radius indicates a healthy traveling
oscillation; continuously release the attenuation as the radius falls through
a bounded band. The shared achieved-course steering and unattenuated
state-feedback drive remain active, so release restores rather than replaces
the carrier. The mechanism uses normalized body-frame target/course geometry,
normalized distance, and observed joint state only; it has no clock, stage,
world route, or mutable state.

Expected test: match the close-pass rollout outside the `4L` approach gate,
retain its useful downward redirect, then prevent the joint/wake collapse near
`18.5T` so bounded shared steering has another coherent half-cycle in which to
move the head the remaining `0.5169L` into the capture radius. Returned actions
must remain inside the owned acceleration bound.

Falsification: reject the guard if the normalized carrier still collapses,
if it releases so early that closest approach regresses beyond `1.2669L`, if
the rollout repeats the lower exit without a new useful trajectory or better
termination class, if wake coherence or early distance closure degrades, or
if joint angle/rate/acceleration saturation materially exceeds the sampled
terminal-reallocation rollout. Only later CFD evidence can establish capture.

bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping around a self-sustained CPG and biological terminal approach control
source_mechanism: phase-selective steering that yields authority when it begins to suppress the propulsive rhythm
transferable_invariant: preserve the traveling carrier while applying bounded asymmetry, and release that asymmetry from observed carrier response before propulsion is quenched
nontransferable_details: published gains, dimensional cadence, robot or species kinematics, duty ratios, clock phase, exact vortex phase, and task-specific routes
policy_translation: gate terminal opposing-half attenuation by a normalized anterior joint bend-and-velocity phase radius while retaining body-frame target-versus-course steering and the unattenuated two-joint state-feedback drive
falsification: reject if carrier amplitude still collapses, closest approach exceeds 1.2669L, the same lower exit remains without a useful trajectory change, or wake coherence and actuator saturation worsen

## Non-CFD verification

- The required guidance-semantic, Julia policy-contract, parameter-schema, and
  solver-boundary checks pass. The policy returns two finite accelerations
  inside its owned envelope for the formal synthetic multi-wake state.
- Replaying sampled `solver_a8af0d71b0de` states through the parent and new
  equations gives exact action equality on all `3863` rows at or beyond `4L`.
  Inside `4L`, the energy guard changes `1004` of `1613` rows and spans its
  intended full `[0,1]` release range. This verifies scope and gating only;
  replay on frozen states is not evidence of a new CFD trajectory or capture.
- Mirroring target, velocity, joint angles, and joint velocities negates both
  returned accelerations exactly in the replay audit, preserving reflection
  equivariance.
