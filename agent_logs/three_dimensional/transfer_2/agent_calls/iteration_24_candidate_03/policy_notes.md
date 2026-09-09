# Candidate diagnosis and hypothesis

## Evidence read before the edit

- The assigned parent guidance preserves the corrected 3D target/capture
  scaffold and identifies far-field joint-rate allocation, rather than another
  terminal steering gate, as the next unresolved control problem. No inherited
  optimizer log file is present in this rendered workspace, so the durable
  parent guidance and all four sampled solver artifacts are the available
  inherited record.
- All four samples use direct uniform still-water initialization
  (`U_infinity=(0,0,0)`) and terminate in capture. The response-aware handoff's
  three byte-identical repeats span `19.162--19.338T`, distance integrals
  `2.06924--2.07983L`, and head paths `12.304--12.370L`; the plain
  distance-only handoff captures at `19.3545T`, `2.07892L`, and `12.416L`.
  The overlap means this batch supports retaining the response-aware scaffold,
  but not another claim based on a small timing delta.
- In the combined keyframes, both the strongest score and the least favorable
  repeat show self-propulsion from the quiescent release, an organized
  alternating top-down wake, compact three-dimensional Lambda2 structures, and
  the same target-directed arc followed by a sharp late capture hook. There is
  no visible wake breakup, passive advection, collision, exit, or instability.
  The plain-handoff visual has the same topology.
- Trajectory cross-check: every sample reaches the joint-rate ceiling on both
  joints. At samples above 99% of `260 deg/T`, acceleration still reinforces
  the current joint velocity on `82.6--83.4%` of anterior events and
  `77.6--79.5%` of posterior events. Peak planar force and yaw-moment
  coefficients remain in the established coherent-wake class
  (`0.02523--0.02542` and `0.01333--0.01356`). Thus the clean new target is
  outward carrier acceleration near the rate envelope, not the visually
  successful route or terminal redirect.

## Architecture proposal

Keep the full response-aware capture scaffold unchanged and add one symmetric
joint-rate governor after its two raw acceleration commands are formed. A
shared smooth gate comes only from the largest normalized absolute joint rate.
For each joint, the gate attenuates only the part of the existing command that
has the same sign as measured joint velocity; reversal commands remain
available. This is normalized joint-state feedback, introduces no mean bend or
route stage, is reflection equivariant, and naturally stays inactive during
the late hook unless a measured rate actually approaches the envelope.

Expected result: reduce greater-than-99%-rate residence and outward-command
impulse near the envelope while retaining the early `10/8/6L` milestones,
capture, short path, load class, and coherent traveling wake. This is a
mechanism test, not a claim that the unevaluated candidate improves CFD
performance.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG modulation with sensor feedback
source_mechanism: modulate a rhythmic locomotor command from measured state while preserving the underlying oscillator
transferable_invariant: use bounded state feedback to withdraw only locally counterproductive propulsive authority without replacing the traveling rhythm or route controller
nontransferable_details: published CPG gains, clock phase, robot kinematics, species envelopes, exact vortex phases, and task-specific routes
policy_translation: form a smooth shared gate from normalized two-joint rate proximity and apply it only where each existing acceleration would further increase that joint's speed
falsification: reject if rate residence and outward command impulse near the envelope do not fall, or if early milestones, capture, path length, joint margin, loads, or wake coherence regress beyond the sampled repeat spread

## Post-edit non-CFD checks

- A held-state command replay over all four inherited trajectories was used
  only to scope the governor, not to predict closed-loop motion. Starting the
  gate at 98% of the owned rate scale leaves all lower-rate commands exactly
  unchanged; with the selected bounded authority it reduces outward command
  impulse by `55.9--56.3%` at sampled greater-than-99%-rate states and by only
  `9.6--9.7%` over each complete inherited trace. The future CFD rollout must
  determine whether that local withdrawal actually shortens rate residence.
- The independent check-runner passes the material-guidance and editable-file
  boundary checks. Static comparison finds a returned parameter field for
  every direct `params.FIELD` reference, and the 3D directory contains one
  target-policy candidate. The Julia executable is absent from this worker
  image, so the lightweight runtime contract command could not be launched;
  no CFD was run.
