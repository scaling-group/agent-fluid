# Wake-policy candidate notes

## Evidence diagnosis

- The shared prewarm sheet shows the fish held at the common upper-right release pose while the four staggered cylinder streets develop into the same interacting wake used by every candidate.
- All four released sheets show self-propulsion rather than passive advection: a sharp targetward redirect is followed by a coherent, nearly straight leftward traverse through the developed wake and first-crossing capture. No sampled child changes the route topology or shows a collision, domain-exit, or instability precursor.
- The assigned local-crossflow parent reaches in `33.990` with mean distance `1.59701L`, total/mean command energy `46157.5/1357.97`, and force/moment RMS `94.55/1395.74`. The sampled relative-crossflow-plus-force sibling preserves the visible route but improves every comparable outcome except the immaterial first-crossing final-radius value: `33.726`, `1.59412L`, `45776.3/1357.30`, `93.64/1383.73`, and score `0.278591` versus `0.276097`.
- Raw relative crossflow also improves the assigned parent's load more strongly (`85.04/1244.16`) but is slightly slower and less route-compact (`33.946`, `1.60066L`) than force-validated relative crossflow. The older bearing-closure baseline is still substantially lower-load (`68.96/1036.40`) but slower (`34.711`, `1.62283L`). Thus the evidence supports a crossflow-cue selection, not a claim that crossflow response has solved actuator or hydrodynamic load.
- No failure rollout is present in the current sample. The inherited informative failure remains the slower/smaller curvature-equilibrium carrier, which became unstable at `121.517` with force/moment RMS `16749.8/290421`; its absent keyframes are not used for a new visual claim. The successful carrier, mean steering, half-cycle asymmetry, signed-moment release, and coherent speed release therefore remain fixed.

## Policy hypothesis

Replace the parent's local-flow-only assistance cue with the already sampled force-validated relative-crossflow cue. Relative crossflow represents the fluid/fish interaction seen by the body, while a same-sign lateral-force requirement prevents an alternating crossflow snapshot from being credited unless it is producing targetward hydrodynamic support. Only the optional redirect burst is released; the target-owned mean steering and base asymmetry remain intact. This is one response-cue mechanism change, not scalar gain tuning.

Expected result: reproduce the sampled sibling's capture and coherent route while improving the assigned parent in arrival, distance integral, effort, and load. Reject the mechanism if the rollout loses capture, changes to a wasteful/unsafe route, or fails to retain those joint improvements; do not infer wake-phase robustness from the shared-prewarm replication.

bookshelf_consulted: true
source_domain: Karman-wake interaction and sensor-feedback adaptive swimming
source_mechanism: distinguish useful wake assistance from alternating disturbance using hydrodynamic response, without forcing vortex-phase locking
transferable_invariant: release surplus targetward actuation only when normalized body-frame flow and measured load consistently indicate that the environment is already assisting the requested maneuver
nontransferable_details: published gains, species kinematics, full-body controllers, single-cylinder vortex phase, dimensional frequency, and task-specific routes
policy_translation: preserve the two-joint carrier and target steering; replace local-crossflow-only burst release with bounded same-sign relative-crossflow and lateral-force confirmation, while retaining signed moment and coherent joint-speed release
falsification: reject on lost capture, route regression, higher effort or force/moment than the assigned parent, or failure to replicate under this common prewarm; require changed wake phase or layout before claiming robustness
