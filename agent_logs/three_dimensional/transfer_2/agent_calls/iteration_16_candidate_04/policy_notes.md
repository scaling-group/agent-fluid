# Signed course-phase allocation candidate

## Evidence diagnosis before the policy edit

- All four sampled episodes satisfy the frozen rollout contract: direct uniform
  `U_infinity=(0,0,0)` initialization, no cylinders or prewarm, finite moving-
  window transport, stable dynamics, and `capture` termination. They reach the
  `0.75L` capture boundary in `19.409--19.635T` with scores from `-0.20288` to
  `-0.21272`; there is no semantic failure in this batch, so the slower exact
  parent replication is the informative failure-side comparator.
- I inspected both rows of the combined sheets for the strongest exact parent
  (`solver_7ac67a265211`), its slower exact replication
  (`solver_17ed583a64e1`), and the response-gated posterior variant
  (`solver_37425e4b74e2`) from release through capture. The top-down views show
  genuine self-propulsion from rest, a compact alternating wake, a direct broad
  approach, and the same bounded late hook. The oblique Lambda2 views show
  coherent three-dimensional tail structures along every path. None shows
  passive advection, wake breakup, wasteful wandering, collision, domain exit,
  or numerical instability.
- Three byte-identical phase-aligned posterior-lag parents span
  `19.409--19.635T`, scores `-0.20288-- -0.21272`, head paths
  `12.095--12.222L`, anterior mean absolute commands `18.55--19.03`, and
  anterior smooth-bound residence `36.3--36.9%`. The sampled wrong-sign-yaw
  posterior boost lands inside every relevant envelope at
  `19.486T/-0.20571/12.098L`, with anterior command `18.99`, residence `36.9%`,
  and peak planar force/yaw moment `0.02465/0.01312`. Its sub-`1L` mean course
  error, lateral speed, and yaw magnitude (`0.253 rad/0.115U/0.272 rad/T`) are
  also bracketed by the exact parents. This does not establish a response-gate
  benefit and argues against tuning its boost on this fixed release.
- Inherited optimizer logs supply two compatible negative boundaries. Unsigned
  redirect-magnitude compression of the mean posterior lag regressed to
  `19.778T/2.10934L/-0.21948`, and same-sign relative-crossflow posterior mean
  curvature regressed to `19.899T/2.10786L/-0.21745`; both retained the same
  coherent late-hook class. Therefore this candidate changes neither mean lag
  nor mean curvature and does not read slip.

## One-candidate hypothesis

Preserve the complete captured target-vector, distance/closing relief,
velocity-course redirect, anterior half-cycle, and posterior phase-allocation
scaffold. Add one signed posterior actuator-path mechanism: during the existing
approach/course redirect only, blend its bounded direction into the turn
request used to allocate posterior useful versus return stroke. Keep anterior
half-cycle steering on the original route/yaw request and preserve the
evaluated mean posterior lag. This asks the posterior traveling bend to support
the already-computed velocity-course correction instead of adding another
range gate, static curvature residual, raw drive, or response boost.

Expected signature: preserve capture and both coherent wake views, retain the
short `12.1--12.2L` path and approximately `0.025/0.013` load class, and reduce
terminal course/lateral residual or improve arrival and distance integral
beyond the exact-parent repeat envelope without increasing posterior command
residence or joint-rate residence. Falsify the mechanism if capture is lost;
arrival, score/integral, or path falls into the inherited `19.78--19.90T`
regression class; the hook grows; or command headroom, joint margin, force,
moment, or either wake view regresses. If falsified, restore the clean
phase-aligned parent rather than tune this course-phase coefficient.

bookshelf_consulted: true
source_domain: Lighthill-style posterior reactive thrust and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: bounded signed phase-lag or wave-shape allocation coupled to observed steering demand
transferable_invariant: preserve the posterior traveling bend while reallocating its useful and return strokes continuously from normalized body-frame course demand
nontransferable_details: published gains, dimensional cadence, species-specific kinematics, exact gait or vortex phase, full-body waveforms, and task-specific routes
policy_translation: blend the existing bounded velocity-course redirect direction into posterior-only joint-state phase alignment while leaving mean lag, anterior steering, and the two-joint soft bounds unchanged
falsification: reject if repeat-resolved capture timing or distance integral does not improve without an effort or load benefit, or if terminal course, path, capture topology, wake coherence, joint margin, rate residence, force, or moment regresses
