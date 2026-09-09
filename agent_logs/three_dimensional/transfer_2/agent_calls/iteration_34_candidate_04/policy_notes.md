# Course-error-confirmed approach carrier candidate

## Evidence and visual diagnosis before editing

- All sampled and inherited episodes used direct uniform still water
  `U_infinity=(0,0,0)`, no cylinders or prewarm, finite moving-window
  transport, and ended in stable capture. No failed termination is available
  in this cohort, so the informative contrast is the latest mechanism
  regression rather than a semantic failure.
- I inspected the combined sheets from release through capture for the
  strongest finite sample `solver_1d05d22ea1fe`, the assigned prefill/parent
  `solver_0e82a9e35a2a`, and inherited response-gated-half-cycle result
  `solver_8d0068c45885`. In every top-down row the fish self-propels from a
  wake-free release along a shallow target-directed arc and leaves an
  alternating caudal wake. Every oblique row retains compact three-dimensional
  Lambda2 structures behind the caudal region. None shows passive advection,
  collision, domain exit, wake collapse, unproductive flailing, or numerical
  instability. The half-cycle result needs one extra terminal frame and shows
  a slightly longer approach curve than the strongest sample, supporting a
  feedback-allocation change rather than propulsion or wake cancellation.
- Quantitative evidence weakens the inherited claim that the normalized
  `6--4L` distance-only carrier handoff is established. Byte-identical handoff
  runs capture at `15.939T` and `16.170T`, with distance integrals
  `1.82008L` and `1.82951L`, bracketing the global response-release repeats at
  `16.071--16.088T/1.82203--1.82366L`. The handoff paths are consistently
  short (`13.107--13.122L` versus `13.129--13.166L`), but anterior residence
  above 90% rate is slightly higher (`17.55--17.70%` versus
  `17.50--17.52%`). A fixed range transition may preserve path while entering
  carrier priority when the instantaneous directional need does not warrant it.
- The inherited response-gated-half-cycle test does not solve that actuator
  boundary. It captures at `16.022T/1.82375L`, but its `13.144L` path is
  longer than both handoff repeats; anterior greater-than-90/99%-rate residence
  is `17.71/12.15%`, and mean anterior command is `16.65 rad/T^2`, all within
  or worse than the ungated handoff ranges. Its coherent wake and
  `0.03456/0.01707` peak force/moment preserve stability, but measured yaw and
  target-bearing response are not selective proxies for the carrier-driven
  rate cost. Restore full joint-phase half-cycle allocation rather than tuning
  that gate.

## One-candidate policy hypothesis

Preserve the assigned parent's target-vector steering, distance/closing drive
relief, velocity-course redirect, full half-cycle asymmetry, posterior wave
allocation, carrier/steering decomposition, bounds, and public two-joint
contract. Refine only the sampled approach carrier handoff: multiply the
near-target withdrawal of response-released negative-work reversal by the
speed-authorized bounded velocity-course error magnitude. Thus the carrier
returns toward redirect priority when a measurable approach course remains
unresolved, but retains response-released reversal when the measured course is
already aligned or too slow to define reliably. This uses normalized
body-frame state and has no clock, route, or new scalar gain.

Expected signature: preserve capture and the alternating two-view wake, retain
the handoff's short-path class, and reduce run-to-run sensitivity by avoiding
unneeded carrier suppression on aligned approach segments. Falsify if capture
timing/integral leaves the combined repeat envelope, if path exceeds the global
release class, if unresolved course error or terminal yaw/slip increases, or
if command, rate residence, joint margin, force/moment, finite action, or wake
coherence deteriorates. The new CFD evaluation occurs after this worker exits
and is not evidence available here.

bookshelf_consulted: true
source_domain: biological C-start redirection and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: strong curvature and rhythm-priority allocation are released continuously only as the observed directional error is resolved
transferable_invariant: a near-target regime transition should be conditioned on unresolved normalized body-frame direction demand, not range alone
nontransferable_details: species-specific maneuver stages and kinematics, published gains and duty ratios, dimensional cadence, full-body waveforms, exact vortex phase, and task-specific coordinates or routes
policy_translation: preserve target-conditioned steering and the two-joint traveling carrier; withdraw response-released negative-work reversal near the target in proportion to speed-authorized bounded velocity-course error
falsification: reject if repeat capture, timing/integral, short path, joint margin, actuator residence, loads, terminal course, finite action, or coherent top-down and oblique wakes leave the sampled useful envelope
