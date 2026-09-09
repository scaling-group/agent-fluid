# Candidate diagnosis and hypothesis

## Evidence read before editing

- All four sampled evaluations confirm the required direct uniform still-water
  initialization (`U_infinity=[0,0,0]`), with no cylinders or prewarm. Both
  rows of every combined keyframe sheet were inspected from release to exit.
- The top-down sheets show self-propulsion and a coherent alternating wake,
  not passive advection. The oblique Lambda2 sheets agree: compact paired
  structures persist through the targetward leg, then the trajectory curls
  upward/left while useful interception is lost. The visual turn is therefore
  a navigation/terminal-control failure rather than missing thrust.
- The signed-mean-bend parent (`solver_815b9ef451f0`) is the best sampled
  geometric pass: `2.664L` at `18.004T`, followed by left-domain exit at
  `26.287T` and `7.699L` final distance. At closest approach its body-frame
  velocity course was about `+0.712 rad` while the target course was
  `-0.748 rad`, a `-1.460 rad` course error; speed remained about `0.983L/T`.
  It crossed target x about `2.850L` high.
- Continuous hold (`solver_1fbf1e40b119`) reached `2.703L` but had its
  posterior joint pinned at `-45 deg` at the pass and both joints pinned at
  exit. Tail-specific bend release (`solver_6acb145d7f64`) worsened the pass
  to `3.312L`. Joint-angle phase separation (`solver_ec81137f627b`) has the
  best scalar score but the worst sampled pass (`4.650L`) and crossed target x
  at `y=14.555L`; this is not a semantic improvement.
- All four sampled candidates repeat the same left-domain termination after
  approaching high. Their course errors at minimum distance remain large and
  same-signed (`-0.972` to `-1.460 rad`), even though their alternating wakes
  and targetward translation remain useful. Local-flow crossflow is small in
  still water relative to body speed, so a wake-rejection term is not
  evidenced here.
- The assigned-parent inherited log reports another unevaluated-to-this-worker
  candidate with a much tighter `1.276L` pass but left-domain termination and
  `10.936L` final distance. Because its policy, trajectory, and multimodal
  diagnostics are unavailable, it establishes that tighter geometry is
  attainable but does not identify a transferable controller mechanism.

## One candidate hypothesis

Preserve the parent's state-feedback traveling bend, phase-compensated yaw
response, and shared-joint half-cycle steering in the far field. Replace the
carrier-only misalignment relief and bend-release logic with one
course-aligned approach-hold mechanism:

1. Form a rotation-invariant error between the full-circle body-frame target
   direction and body-frame velocity course, with a forward-course fallback
   when speed is too small for a reliable velocity angle.
2. Inside the approach region, reduce the *complete* rhythmic acceleration
   (carrier and steering together) only while the fish is both closing and
   course-aligned. If course error grows, the hold releases continuously and
   restores full redirect authority.

This preserves the carrier-to-steering ratio instead of letting retained
steering dominate a relieved restorative carrier, the failure shared by the
sampled terminal schedulers. The hypothesis is that an aligned approach loses
enough excess speed to tighten capture, while the observed wrong-course state
at the prior near miss restores the complete gait rather than coasting or
pinning on a one-sided bend. Far-field translation should remain identical
because the hold is proximity gated.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish rhythmic control and terminal capture
source_mechanism: sensory feedback schedules a rhythmic gait across far, approach, and near regimes while preserving propulsion during corrective motion
transferable_invariant: use normalized target geometry, velocity course, closing response, and distance to reduce excess drive only during an aligned approach and release the hold when correction is needed
nontransferable_details: published CPG gains, species-specific kinematics, dimensional speeds, exact vortex phases, and task-specific routes
policy_translation: smoothly co-scale both joint rhythmic commands from body-frame course alignment, normalized closing speed, and normalized distance; retain the existing state-feedback beat and steering outside the gate
falsification: reject if capture or closest approach does not improve over the sampled 2.664L parent, if the same upper/left exit persists, or if far-field translation, wake coherence, actuator reserve, or load quality degrades
