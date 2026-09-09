# Joint-local full-demand carrier-guard candidate

## Evidence and visual diagnosis before editing

- All four sampled rollouts satisfy the frozen evidence contract: direct
  uniform `U_infinity=(0,0,0)` initialization, no cylinders or prewarm,
  finite moving-window transport, stable dynamics, and `capture` at
  `15.604--16.088T`. There is no failed termination, so the informative
  negative is a controller tradeoff within the successful capture class.
- I inspected both rows of all four combined keyframe sheets from release to
  capture, comparing the highest-score full-demand common guard
  (`solver_6dada5e7a98a`) with the slowest response-released reversal
  (`solver_0e3ccca5bc77`) in detail. In each, the fish self-propels from blank
  quiescent water on a shallow target-directed arc. The top-down row shows a
  compact alternating vorticity street and the oblique row shows discrete
  coherent Lambda2 structures; none is passively advected, collides, exits,
  becomes unstable, or loses its traveling wake. The wake sheets are too
  similar to justify changing propulsion frequency, amplitude, or steering
  gain from visual prominence alone.
- Metrics distinguish the mechanisms. The common guard driven by full
  pre-limit joint demand is the progress leader at `15.604T`, score `0.08781`,
  and distance integral `1.79354L`, with every `10--1L` milestone earlier than
  the other sampled controllers. Its boundary is a `13.137L` path, peak planar
  force/yaw moment `0.04226/0.02076`, and anterior/posterior rate residence
  above 90% of `17.45/6.66%`. The carrier-only joint-local guard is slower at
  `15.730T/1.80572L`, but shortens path to `12.848L`, lowers peaks to
  `0.03558/0.01724`, and lowers rate residence to `17.10/5.77%`. The
  course-resolved common prefill is no better in time and has a longer
  `12.940L` path, higher `0.03892/0.01931` peaks, and higher `17.34/6.57%`
  rate residence than the joint-local sample, so its reversal-release rule is
  not retained.
- The inherited step-38 log supplies a completed composition not yet distilled
  in the assigned parent: a joint-local guard with full-demand previews also
  captured and scored `0.08633`, improving materially on the sampled
  joint-local carrier-only (`0.07575`) and current prefill (`0.07511`) while
  remaining only `0.00149` below the common full-demand leader. Only its score,
  capture termination, and final distance survive in this workspace, so this
  supports the architecture but does not prove its intended path/load/rate
  benefit. The next evaluation must recover those diagnostics rather than
  infer them from score.

## One-candidate policy hypothesis

Preserve the corrected body-frame target geometry, distance/closing drive
relief, full velocity-course redirect, joint-phase steering, posterior wave
allocation, carrier/steering decomposition, soft bounds, and public two-joint
contract. Replace the common carrier governor with joint-local smooth guards.
Each joint previews rate contact from its own full pre-limit demand (carrier
plus steering), but the preview withdraws only that joint's same-sign positive-
work carrier. Target-conditioned steering and negative-work reversal remain
outside the local power attenuation; the shared unresolved-redirect request
retains the sampled far-field response release. This reproduces the completed
high-score structural composition without scalar gain tuning.

Expected signature: retain capture, the full-demand sample's early progress,
and the coherent two-view traveling wake, while recovering the joint-local
sample's shorter path and lower load/rate-residence class. Falsify the
mechanism if the new evaluation loses capture or coherent propulsion; timing
or integral regresses beyond the sampled class; or path, joint margin, either
rate-residence fraction, command effort, force/moment peak, terminal course,
or finite-action checks fail to improve on the common full-demand tradeoff.
The new CFD evaluation occurs after this worker exits and is not claimed as
evidence here.

bookshelf_consulted: true
source_domain: Lighthill elongated-body reactive propulsion and sensor-modulated robotic-fish CPG control
source_mechanism: anterior motion sustains and steers a posteriorly lagged traveling bend while feedback modulates rhythmic effort without erasing posterior thrust
transferable_invariant: sense actuator-envelope approach from combined state and outward demand, but protect each actuator locally so steering, reversal, and the other joint's useful traveling-wave contribution remain available
nontransferable_details: published gains, dimensional cadence, species-specific amplitude envelopes, clocked phases, full-body waveforms, exact vortex phases, and task-specific routes or coordinates
policy_translation: use normalized joint rates and bounded same-joint full acceleration to preview contact, then attenuate only that joint's positive carrier work under the body-frame two-joint feedback contract
falsification: reject if capture, timing/integral, short path, joint and rate margin, loads, terminal course, finite action, or coherent top-down and oblique wakes leave the sampled useful class
