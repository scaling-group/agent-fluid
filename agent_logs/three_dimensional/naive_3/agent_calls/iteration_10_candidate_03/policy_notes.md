# Terminal-capture course-policy candidate

## Evidence and visual diagnosis before editing

- All four sampled solver evaluations and the assigned-parent evaluation use
  direct uniform still-water initialization with `U_infinity=(0,0,0)`, no
  cylinders, and no prewarm.  Their combined sheets show self-propelled
  motion: the top-down rows contain an alternating signed-vorticity street and
  the oblique rows contain coherent three-dimensional Lambda2 structures
  during broad approach.  Every sampled case still terminates `left_domain`.
- The sampled full-quadrant static redirect reaches `2.999L`, then its joints
  settle near `(-10,-12) deg` and it coasts into the upper boundary.  The
  approach hold and posterior relief reach only `3.592L` and `3.162L`; their
  weakened or nearly fixed late wakes do not form recovery arcs.  The
  scalar-best anterior half-cycle stiffness policy keeps an alternating wake
  but worsens closest approach to `4.859L` and raises acceleration demand.
  Thus damping, static bends, posterior relief, and anterior stiffness
  asymmetry did not solve the repeated pass-and-hook topology.
- A later inherited course-error rollout is a semantic improvement even though
  its scalar score is worse.  Replacing dimensional lateral-slip subtraction
  with the signed angle between body-frame target ray and velocity course
  reduced minimum distance to `0.856995L`.  Its visual path descends toward the
  capture circle without the earlier high hook and its wake remains
  alternating.  At the `19.058T` minimum, the head is only `0.153L` past and
  `0.843L` high relative to the target while speed is about `0.845U`; it misses
  the `0.75L` radius by `0.106995L`, then continues beating and exits high.
  This is the first inherited trajectory for which broad course control works
  well enough to isolate terminal overshoot rather than wholesale steering
  failure.
- The bookshelf terminal-capture primitive applies only after that broad
  evidence: reduce excess drive near capture without coasting prematurely.
  Earlier distance holds began near `5L` under the failed bearing/slip
  controller and damaged approach, so they do not justify another early or
  carrier-wide hold.

## Policy hypothesis

Restore the evidenced speed-gated body-frame course controller exactly in the
far and middle approach.  Add one terminal allocation gate that is nonzero
only inside the final `2L` approach and only while measured distance is still
closing.  The gate leaves the zero-centered anterior oscillator untouched and
reduces only the oscillatory share of the posterior target; the bounded course
curvature remains fully active.  This should retain the proven route, reduce
posterior thrust and rate demand during the last body length, increase the
relative steering share, and give the oscillating head enough residence time
to cross the capture circle.  If distance starts opening after a miss, the
brake releases while course steering and the full carrier remain available.

Reject the mechanism if the alternating approach wake changes before `2L`,
minimum distance does not beat `0.856995L`, acceleration/rate occupancy rises,
or the rollout repeats `left_domain` without capture or a distinct recovery
arc.  In particular, do not interpret an unevaluated gate as evidence that
terminal relief works; its CFD result belongs to the next generation.

An offline replay of the new algebra on the inherited course-policy states is
only an envelope check, not a rollout prediction.  It confirms exactly zero
command change for all logged states at or beyond `2L`; on closing states the
posterior carrier scale reaches a bounded minimum of `0.557`.  Reconstructed
raw joint-2 acceleration-cap occupancy changes from `67.55%` to `67.76%`
(`+0.21` percentage points), so the gate does not materially add command
clipping on those fixed states.  Synthetic mirrored states produce equal and
opposite joint accelerations with an unchanged scalar gate.

bookshelf_consulted: true
source_domain: fish-swimming terminal capture and sensor-modulated robotic-fish direction tracking
source_mechanism: continuous near-target drive allocation around an intact closed-loop rhythmic carrier
transferable_invariant: after broad target-directed motion is demonstrated, reduce excess propulsive share only during a closing near approach while preserving steering and the state-feedback rhythm
nontransferable_details: published gains, species stopping distance, dimensional speed, exact tail phase, gait envelope, and task-specific route
policy_translation: use normalized distance and closing speed to gate bounded posterior-carrier relief around the proven body-frame course-error curvature; keep the anterior oscillator zero-centered and release relief when distance opens
falsification: reject if the pre-2L wake or route changes, actuator occupancy rises, closest distance fails to beat 0.856995L, or capture and termination topology do not improve
