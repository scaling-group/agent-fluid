# Joint-local positive-work allocation candidate

## Evidence diagnosis

- The assigned parent is the evaluated `course_resolved_joint_local_guard`
  sample (`score=0.0941021`, capture at `15.598T`, distance integral
  `1.78768L`). Its inherited step-38 and step-39 score logs preserve capture
  and improve scalar score from `0.0867077` to `0.0941021`, so the corrected
  body-frame target sign, course redirect, approach relief, and traveling-wave
  scaffold should remain intact.
- Both rows of the combined keyframes were inspected for the parent and the
  lowest-scoring current sample. They begin from direct uniform still water,
  show self-propelled target progress rather than advection, retain an
  alternating coherent top-down wake and compact oblique Lambda2 structures,
  and show no collision, domain exit, or instability before capture. The
  sheets are visually very similar, so their score spread is an allocation
  distinction rather than a new wake or termination class.
- Cross-checking the four current trajectories sharpens the remaining defect.
  All capture at `15.560--15.604T` with distance integrals
  `1.78768--1.79624L`, yet every rate-guard variant leaves anterior residence
  above 90% of the `260 deg/T` limit at `17.31--17.45%`, and all reach the hard
  anterior rate limit. The parent leads the `6/4/2/1L` milestones and has the
  best distance integral, but its `13.190L` path is longer than the
  `12.994--13.137L` alternatives. Its `0.03802/0.01842` peak planar force/yaw
  moment is finite and below the common-guard sample's
  `0.04226/0.02076`, but does not establish a material actuator benefit from
  the fixed short preview.
- The direct-uniform contract is satisfied in all four diagnostics
  (`U_infinity=[0,0,0]`, `prewarm_snapshot=null`). Instantaneous local flow is
  therefore partly self-wake here; it does not justify adding a crossflow or
  vortex-cancellation residual.

## Policy hypothesis

Keep the parent's target/approach/course feedback, full-demand contact
previews, and energy-direction decomposition. Change only work allocation:
compute a redirect guard from each joint's own predicted contact for that
joint's positive rhythmic work, while retaining the maximum joint event for
shared negative-work reversal. Body-frame steering remains additive. This
removes the current cross-joint coupling in which the anterior bottleneck can
erase posterior positive carrier work, without weakening the shared phase
reversal that preserves the traveling bend during unresolved redirection.
This is an allocation mechanism, not a lower rate threshold.

Expected result: retain capture, the parent's early milestones, coherent wake,
and finite load class while moving path and terminal slip toward the shorter
joint-local/tail-release samples, without worsening anterior rate residence.
Falsify it if capture or distance integral regresses beyond current run spread,
if posterior rate/load or joint margin degrades, or if preserving local tail
work fails to shorten the path or advance arrival.

A post-edit, non-CFD replay of both policy functions on all `2836` recorded
parent states found finite outputs and a selective difference on `48` states.
There were no tail-command sign flips. The largest change occurred at
`2.134T/12.220L`, with anterior rate `-4.480 rad/T` and tail rate only
`0.037 rad/T`: the parent tail command was `7.80 rad/T^2` and the candidate
retained `30.79 rad/T^2` of locally safe positive tail work. This confirms the
intended branch is active, but is not rollout evidence; the formal evaluation
must test whether the brief near-bound tail command raises posterior rate or
load enough to negate its propulsion benefit.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG control plus elongated-body posterior-thrust reasoning
source_mechanism: sensor feedback modulates a low-dimensional rhythmic generator while posterior wave motion retains the principal propulsive role
transferable_invariant: preserve coupled phase reversal, but reduce rhythmic energy injection only at the joint whose normalized state predicts contact so an anterior bottleneck does not erase posterior propulsion
nontransferable_details: published CPG gains, dimensional frequencies, species envelopes, full-body waveforms, exact vortex phases, and task-specific routes
policy_translation: retain each normalized full-demand rate preview; use its local guard for same-joint positive carrier work, while the maximum event continues to protect shared negative-work reversal inside the existing body-frame controller
falsification: reject if the sampled capture/timing/integral and coherent two-view wake are not retained, or if path and arrival fail to improve without worse rate residence, posterior motion, loads, or joint margin
