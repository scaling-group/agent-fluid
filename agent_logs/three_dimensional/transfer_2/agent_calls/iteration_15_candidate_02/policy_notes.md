# Turn-phase posterior-lag replication candidate

## Evidence diagnosis before the policy edit

- All four sampled solver episodes and the assigned-parent episode satisfy the
  frozen rollout contract: direct uniform `U_infinity=(0,0,0)` initialization,
  no cylinders or prewarm, finite moving-window transport, stable dynamics,
  and `capture` termination. The two byte-identical projected-miss/corridor
  samples span `19.701--19.817T` and scores `-0.21449-- -0.21655`, so a small
  scalar difference inside that interval is not evidence of a new mechanism.
- I inspected both rows of the combined keyframe sheets for the strongest
  sampled turn-phase posterior-lag episode (`solver_17ed583a64e1`), the slower
  exact corridor repeat (`solver_2adc39f18b21`), and the assigned parent's
  redirect-magnitude lag-compression episode (`solver_bbb0389024ad`). Their
  top-down rows show self-propulsion from quiescent water, a coherent
  alternating mid-plane wake, and the same broad approach followed by a late
  target hook. Their oblique rows show compact three-dimensional Lambda2
  structures trailing the fish without wake collapse, collision, or numerical
  instability. The policies differ in terminal response, not wake class.
- The assigned parent's magnitude-only lag compression is a concrete negative
  result. It captured at `19.778T`, mean distance `2.10934L`, and score
  `-0.21948`, versus the plain LOS-led scaffold at
  `19.706T/2.10594L/-0.21598`; its terminal yaw was `0.482 rad/T`, also above
  the plain sample's `0.389 rad/T`. Compressing posterior lag whenever redirect
  magnitude is large therefore did not make the late response more prompt or
  less hooked and should not be gain-tuned on this release.
- The sampled signed turn-phase allocation is the strongest available
  mechanism candidate: it captured at `19.635T`, mean distance `2.10246L`, and
  score `-0.21272`, and terminal yaw fell to `0.243 rad/T`. It preserved zero
  joint-angle-limit residence and the coherent wake class. Its boundary is
  actuator cost: mean absolute commands rose to `18.55/17.44 rad/T^2` from the
  plain sample's `18.20/17.02`, while peak planar force rose slightly to
  `0.02476` from `0.02458`. One evaluation is not enough to distinguish the
  timing gain from the corridor repeat span, so combination with another
  mechanism is premature.

## One-candidate hypothesis

Replace the unsupported corridor prefill with an exact controlled replication
of the sampled turn-phase posterior-lag controller. Preserve the clean
fore/aft-aware LOS/range/closing scaffold, continuous velocity-course redirect,
LOS-rate lead, route half-cycle steering, and smooth action limit. Add only the
evaluated posterior mechanism: infer useful versus return stroke from
normalized anterior-joint velocity times the current body-frame turn request,
then vary posterior lag symmetrically around its unchanged mean. This allocates
wave timing without adding static curvature, redirect-magnitude compression,
crossflow feedback, a clock, or a memorized route.

Expected signature: reproduce capture with both coherent wake views, terminal
yaw near the lower sampled class, and arrival/mean distance at least outside
the slower corridor and parent-lag-compression results. Falsify portability if
replication returns to the `19.70--19.82T` repeat band without a terminal-yaw or
path benefit, or if mean command, near-bound residence, joint-rate residence,
force/moment load, joint margin, or wake coherence worsens. A failed
replication should restore the plain LOS-led scaffold rather than tune the lag
asymmetry scalar.

bookshelf_consulted: true
source_domain: Lighthill-style posterior reactive thrust and sensor-modulated robotic-fish CPG turning
source_mechanism: bounded useful/return-stroke phase-lag allocation within a posterior traveling bend
transferable_invariant: preserve the mean posterior traveling-wave lag while reallocating lag continuously from observed joint phase and body-frame turn demand
nontransferable_details: published gains, dimensional cadence, species-specific kinematics, full-body waveforms, exact vortex phase, and task-specific routes or coordinates
policy_translation: modulate the owned posterior lag symmetrically with bounded normalized anterior-joint velocity times the equivariant target-derived turn command under the existing two-joint action limit
falsification: reject if replication fails to improve arrival, distance integral, terminal yaw, or useful path shape beyond repeat variation, or if command headroom, rate residence, joint margin, loads, or either wake view regress
