# Crossflow-supported mean-bend unloading candidate

## Evidence and visual diagnosis before the policy edit

- All four sampled solvers satisfy the Phase-2 physical contract: direct
  uniform still-water initialization with `U_infinity=(0,0,0)`, no cylinders
  or prewarm snapshot, active moving-window transport, finite dynamics, and
  capture from `12.32772 L`. Three reproduce the v23 coordinated-release
  baseline exactly at `25.11852 T`, score `-0.5283387731`, mean distance
  `2.4292937801 L`, and final distance `0.7464101911 L`.
- The assigned parent's late crossflow-supported allocation relief is the one
  distinct sampled mechanism. It preserves the capture step while improving
  score to `-0.5281078349`, mean distance to `2.4291113720 L`, and final
  distance to `0.7461675406 L`. Commands first diverge from v23 below
  `1.594 L`; inside `1.6 L` its command changes remain below
  `0.0051/0.0094 rad/T^2`, no joint stop or `30 rad/T^2` command occurs, and
  the terminal lateral-force maximum falls from about `0.00218` to `0.00204`.
- I inspected the complete combined sheets for that parent and for the
  informative completed broad-release regression at score `-0.5304331185`.
  In both top-down rows, the fish self-propels along the same compact curved
  route and sheds a coherent alternating wake through the outer approach. The
  oblique rows confirm finite three-dimensional Lambda2 structures at `8 T`
  and `16 T`, followed by a quiet mean-bend handoff near `24 T`; neither case
  shows advection, collision, domain-exit behavior, or instability. The visual
  distinction is confined to the final held-bend trajectory and is too small
  to rank without the diagnostics.
- The broad response release recovers up to `22%` more carrier as soon as the
  equilibrium is settled. It captures one solver step earlier but regresses
  mean distance to `2.4309369794 L` and crossing depth to `0.7486109138 L`,
  while raising final commands to about `0.138/0.328 rad/T^2`. Thus the
  parent's small positive result validates the late target-helpful-crossflow
  cue, but it does not license more carrier authority.
- The parent remains on a safe collision course while crabbing: from
  `1.6 L` to capture, the body-frame velocity-to-target angular mismatch
  shrinks from about `0.44` to `0.31 rad`, speed stays near `0.65 L/T`, and
  range continues closing. Residual target bearing is therefore not evidence
  for another yaw correction. Since both the inherited terminal controller
  and its carrier share the same target-relative mean bend, changing their
  allocation restores oscillation but does not actually unload that mean.

## Policy hypothesis

Preserve the parent's outer traveling-wave carrier, body-frame target-angle
redirect, closure preview, two-joint equilibrium, paired response release,
actuator limits, and validated target-helpful-crossflow/closure/proximity cue.
Change only the cue's actuator locus: after the original equilibrium has
settled inside the late band, use it to reduce the redirect mean shared by
both the carrier and equilibrium branches, while leaving their inherited
allocation exactly unchanged. This is a bounded mean-curvature adaptation,
not additional carrier recovery, phase selection, joint-role splitting, or a
world-frame route.

Expected result: exact parent commands outside the late gate, the same compact
outer trajectory and coherent two-view wake, and a slightly less curved quiet
terminal crab that retains or improves capture progress without the broad
release's added oscillatory command. Reject the mechanism if its logged-state
gate is dormant, motion changes outside `1.6 L`, capture is delayed or lost,
mean/final distance regresses, the path loops, or joint stops, command
clipping, terminal force/moment growth, or wake degradation returns.

bookshelf_consulted: true
source_domain: robotic-fish mean-curvature steering and organized-wake adaptive swimming
source_mechanism: modulate a rhythmic controller's mean offset from observed target response while preserving useful lateral flow-induced motion
transferable_invariant: when target geometry, body-relative crossflow, positive closure, and settled joint response agree that lateral motion is useful, reduce the persistent corrective mean bend without increasing oscillatory authority
nontransferable_details: published gains, dimensional cadence, species-specific bend envelopes, full-body waveforms, exact vortex phases, cylinder geometry, and task-specific routes
policy_translation: smooth normalized body-frame target side, relative crossflow, range, closure, and two-joint tracking error gate a small shared reduction of the redirect equilibrium used by both controller branches; carrier allocation stays inherited
falsification: reject if the gate is inactive, changes the outer path, worsens capture progress, acts without helpful crossflow and positive closure, or restores oscillation, saturation, joint stops, load spikes, instability, or wake loss

## Non-CFD implementation audit

The returned parameter object owns all 75 policy fields, and replay on every
stored state from the completed parent produces two finite commands. The new
mechanism is exactly command-invariant for `distance >= 1.6 L` and activates
on all 226 stored states inside that band. Its mean-bend reduction averages
`0.00825` and peaks at `0.01401` under the declared `0.015` bound; the largest
per-joint command change is `0.07431 rad/T^2`, and candidate commands inside
the band remain below `0.101/0.263 rad/T^2`. At the final sampled state the
parent replay command `0.0980/0.2464` becomes `0.1009/0.2622 rad/T^2`.
This verifies schema completeness, activation, boundedness, and intended
outer noninterference only. The candidate's coupled-flow result will be
available only after this worker exits and is not claimed here.
