# Redirect-demand carrier-recoupling candidate

## Evidence and visual diagnosis before editing

- All four sampled solver rollouts satisfy the frozen experiment contract:
  direct uniform `U_infinity=(0,0,0)` initialization, no cylinders or prewarm,
  finite moving-window transport, stable dynamics, and `capture`. The assigned
  parent also contains a completed exact-policy repeat. There is therefore no
  termination failure to repair; the discriminating evidence is progress,
  path topology, actuator/load cost, and repeat spread.
- I inspected the combined top-down vorticity and oblique body/Lambda2 sheets
  from release to capture for the highest-scoring sampled handoff
  `solver_1d05d22ea1fe`, the informative sampled redirect-release regression
  `solver_f997a0c1ad0f`, and the inherited exact handoff repeat
  `solver_c48bfa1d4e2b`. Each fish begins in blank quiescent water, develops a
  coherent alternating caudal wake, and self-propels along a continuous
  target-directed arc. None is advected, collides, exits, loses its wake, or
  becomes unstable. The redirect-release sample has the visibly longer late
  hook; the two handoff views remain in the same coherent wake class, so the
  gait and full target-conditioned redirect should be preserved.
- The two byte-identical approach-handoff evaluations delimit a much wider
  outcome than the favorable sample alone: capture `15.939--16.143T`, score
  `0.05620--0.06189`, distance integral `1.82008--1.82620L`, and head path
  `13.107--13.171L`. The second repeat is later at every `6/4/3/2/1L`
  milestone and raises peak planar-force/yaw-moment coefficients from
  `0.03477/0.01715` to `0.03546/0.01791`, although both remain stable captures
  with coherent wakes and no greater-than-90%-angle residence. Thus the first
  handoff outcome does not establish a repeat-robust timing, integral, path, or
  load improvement.
- The handoff still defines a useful mechanism boundary. Fully
  response-released reversal repeats capture at `16.071--16.088T` with
  `13.129--13.166L` paths, while releasing the redirect curvature itself
  produces the late hook, `13.363L` path, `0.269 rad/T` sub-`2L` mean yaw, and
  `16.247T` capture. Keep the measured-yaw reversal release far away, restore
  the full redirect at all ranges, and recouple the carrier near capture; the
  unsupported part is making recoupling a fixed function of distance alone.
- The fixed 6--4L recoupling is applied independent of whether the measured
  velocity course actually requests extra steering priority. Exact repeats
  can therefore encounter the same distance handoff at different joint/wake
  phase. The existing bounded `redirect_magnitude` already represents unmet
  velocity-course/line-of-sight demand in body coordinates and can condition
  recoupling without adding an observation, threshold, clock, or route.

## One-candidate policy hypothesis

Start from the evaluated full-redirect, response-released carrier controller.
Preserve its corrected body-frame target sign, distance/closing drive relief,
half-cycle steering, posterior allocation, common bounds, and two-joint
carrier/steering decomposition. Replace only the fixed-distance withdrawal of
negative-work reversal release with a smooth redirect-demand recoupling:
multiply normalized approach weight by bounded velocity-course redirect
magnitude, smooth that product, and withdraw the measured signed-yaw release
in proportion to it. Far from the target the controller is identical to the
fully response-released carrier. During approach it retains reversal when the
measured course is already settled, but restores phase-coupled carrier
authority when the target redirect remains unfulfilled.

Expected signature: preserve the sampled early self-propelled progress and
coherent two-view wake, avoid the redirect-release policy's terminal hook, and
remain within or improve the two exact handoff repeats' `15.939--16.143T`,
`1.82008--1.82620L`, and `13.107--13.171L` timing/integral/path envelope
without worse rate residence, joint margin, command effort, force/moment
peaks, terminal yaw/slip, or wake coherence. Falsify the mechanism if it loses
capture, regresses beyond that repeat envelope, behaves like the fully
released late trajectory, or shows that redirect demand merely adds noisy
carrier switching. A single new evaluation can reject a bad trajectory but
cannot by itself prove reduced repeat sensitivity.

## Bookshelf protocol

The later-iteration consultation trigger is not met: the inherited step-31
iteration introduced a new distance-handoff mechanism and a semantic sampled
improvement, followed by only one completed exact repeat. I read the shelf
skill to apply the structured trigger but did not consult or use a source
family for this edit. The policy hypothesis comes from the assigned-parent
repeat and sampled rollout signals, so no source-transfer block is claimed.
