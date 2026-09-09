# Response-gated posterior-bend replication candidate

## Visual and diagnostic evidence before the policy edit

- All four sampled solver episodes satisfy the direct-uniform still-water
  contract (`U_infinity=(0,0,0)`, no cylinders, no prewarm), remain stable, and
  terminate in capture. Their scores span `-0.20560-- -0.19989`, arrival times
  span `19.360--19.552T`, and distance integrals span `2.08911--2.09458L`.
  There is no sampled termination-class failure, so the comparison must resolve
  trajectory quality and actuator cost rather than invent a missing-success
  problem.
- Both rows of the combined sheets for the strongest finite sample
  (`solver_1af6c62469a7`) and the relatively weakest prefill
  (`solver_cb03d3cda781`) were inspected from release through capture. Each
  shows self-propulsion from quiescent water, a coherent alternating top-down
  wake, compact three-dimensional Lambda2 structures, and a smooth late hook
  into the capture circle. Neither shows passive advection, collision, wake
  breakup, or instability; their visual trajectories are effectively the same
  useful class.
- The inherited rate-governor rollout (`solver_d09ba9d1de88`) supplies the
  informative mechanism failure. Its top-down and oblique rows retain a
  coherent wake and capture, but the terminal arc is visibly wider. Diagnostics
  agree: selective posterior unloading delayed capture to `20.207T`, raised the
  distance integral to `2.14149L`, worsened score to `-0.25057`, lengthened the
  head path to `12.539L`, and raised mean absolute yaw below `2L` to
  `0.405 rad/T`. It reduced mean commands to `18.16/16.93 rad/T^2`, yet both
  joints still reached the exact `260 deg/T` rate limit. Thus reducing local
  rate-pushing effort is not a standalone objective when it weakens the
  traveling-bend response.
- The prefill isolates a second negative result. It differs from the strongest
  sampled response-gated posterior-bend policy only by multiplying posterior
  carrier and lag during closing approach relief. That addition moved arrival
  from `19.360T` to `19.431T`, distance integral from `2.08911L` to `2.09458L`,
  score from `-0.19989` to `-0.20560`, posterior near-command residence from
  `33.32%` to `34.16%`, and head path from `12.052L` to `12.060L`; the common
  approximately `0.025/0.013` force/moment envelope and coherent wake did not
  improve. The deltas are not necessarily repeat-resolved, but they provide no
  reason to retain or tune the added tail-authority scalar.

## One-candidate hypothesis

Perform a controlled ablation and replication rather than stack another
terminal or actuator gate. Remove the unsupported approach-time posterior
carrier/lag multiplier and restore the sampled response-gated posterior-bend
controller exactly. Preserve the full capture scaffold: the joint-state
oscillator and posterior lag, fore/aft-aware body-frame target mapping,
distance/positive-closing drive relief, velocity-course redirect and LOS-rate
lead, target-derived half-cycle asymmetry, bounded mean curvature, and smooth
command limit. The one retained extra mechanism is reflection-equivariant:
during approach it adds a small posterior mean bend only while normalized yaw
opposes the current body-frame turn request, then releases continuously when
the response aligns.

This replication is supported only if formal evaluation preserves capture and
the coherent two-view wake while returning to the prior policy's trajectory
envelope. Treat timing, integral, or score inside the known exact-policy spread
as replication rather than improvement. Falsify the apparent response-gated
benefit if arrival/integral regress toward the `20.207T/2.14149L` governor case,
the late arc or sub-`2L` yaw grows, or command residence, joint margin, loads,
or wake coherence worsen. A repeat-resolved or held-out benefit is required
before tuning or composing this gate again.

bookshelf_consulted: true
source_domain: biological C-start response control and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: concentrate a bounded redirect while measured yaw opposes the observed turn request, then release into the established traveling rhythm
transferable_invariant: gate corrective posterior curvature by normalized disagreement between body-frame route demand and measured yaw response, with continuous release after alignment
nontransferable_details: species-specific C-start kinematics, published gains, dimensional burst timing, clock phase, exact vortex phase, and task-specific coordinates or routes
policy_translation: retain the two-joint state-feedback oscillator and apply only the sampled approach-weighted wrong-sign-yaw posterior bend; remove the unsupported approach carrier multiplier
falsification: reject or stop composing the response gate unless repeat or held-out evidence improves timing, distance integral, terminal yaw, or path without worse command residence, joint margin, loads, capture, or wake coherence
