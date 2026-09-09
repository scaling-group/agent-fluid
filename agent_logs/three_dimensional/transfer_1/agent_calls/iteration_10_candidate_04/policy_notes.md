# Wake-policy candidate diagnosis

## Evidence read before editing

- The sampled and inherited episodes are direct-uniform releases in still
  water with `U_infinity=[0,0,0]`, no cylinders, and no prewarm snapshot.
  Their finite trajectories and alternating wakes establish self-propulsion,
  not ambient advection or numerical instability.
- Both rows of the combined sheets were inspected. The sampled
  phase-compensated bearing and achieved-course rate cascades retain coherent
  top-down vortex streets and compact oblique Lambda2 structures, but pass
  above the target and reach only `3.0031L` and `3.1135L`. The prefilled
  opposing-half allocator turns down to `1.2669L`, after which joint excursion
  falls below `9 deg`, the late wake fades in both views, and the fish coasts
  through the lower boundary. Further carrier attenuation is unsupported.
- Carrier-aligned duty steering preserves a strong alternating terminal wake
  and reaches `0.95323L`, only `0.20323L` outside capture. Its failure remains
  a fast target-normal lower pass, so the useful reusable pieces are its
  achieved-course outer signal, intact carrier, and within-beat steering
  allocation—not more scalar steering gain.
- The sampled line-of-sight-guarded response release captures once at
  `0.7493448L` after `18.6065T`, with a coherent terminal wake. However, two
  semantically identical inherited replays fail at `1.5891L` and `1.7715L`
  and return to the same lower-exit topology. The first capture was only
  `0.00065L` inside the threshold and its actions were at the acceleration
  envelope on roughly three quarters of terminal rows. A release boundary
  based on phase-compensated yaw response is therefore too narrow to treat as
  a robust incumbent.
- Assigned-parent experiments already show that terminal carrier recovery
  (`1.1444L`), additive slip curvature (`1.0561L`), and closing-speed cadence
  relief (`1.0959L`) preserve the lower exit. The missing semantic mechanism
  is a stable decision about when the existing turn is no longer needed, not
  another energy, curvature, cadence, or course-gain adjustment.

## Candidate mechanism and falsification

Restore the evaluated carrier-aligned achieved-course controller. Inside a
terminal distance gate only, construct a collision corridor from normalized
body-frame target range and measured achieved course. The course error is the
angular excess outside the corridor: if the present velocity ray already
passes conservatively through the target neighborhood, release route steering
while preserving the full traveling carrier; if it does not, the geometric
excess continuously restores the same bounded carrier-aligned steering. This
uses translational interception geometry rather than joint-sensitive yaw
response and is exactly the inherited carrier-aligned policy outside `3L`.

Expected test: preserve the coherent far-field route and terminal carrier,
avoid steering through a course that already intersects the target corridor,
and convert the `0.95323L` fast lower pass into capture or a meaningfully
smaller, repeatable near miss without increasing action saturation.

Falsification: reject if behavior outside `3L` changes, minimum distance does
not beat `0.95323L`, the alternating wake or joint excursion collapses,
acceleration saturation grows, or the same fast lower exit remains. Then the
velocity-ray corridor is not sufficient; later workers should test a bounded
phase-lag steering actuator rather than tune the corridor width or resurrect
the non-reproducible yaw-response gate.

bookshelf_consulted: true
source_domain: terminal interception control and sensor-modulated robotic-fish direction control
source_mechanism: release rhythmic steering once measured motion lies inside a target collision corridor, and restore it from geometric miss rather than elapsed or beat phase
transferable_invariant: preserve the propulsive rhythm while normalized target-relative motion, not a narrow yaw-response threshold, determines whether bounded steering is still necessary
nontransferable_details: published gains, dimensional cadence, robot or species kinematics, prescribed CPG phase, exact capture routes, exact vortex phases, and source-specific corridor sizes
policy_translation: inside a body-frame distance gate, subtract a range-normalized target corridor from achieved-course error and feed only the remaining miss through the existing two-joint carrier-aligned steering allocator
falsification: reject if the sub-0.95323L pass, capture class, coherent terminal wake, action saturation, or lower-exit topology does not improve
