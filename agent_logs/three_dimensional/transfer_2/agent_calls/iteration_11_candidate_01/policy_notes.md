# Candidate diagnosis and hypothesis

## Prior evidence

- The assigned parent and two sampled duplicates use the same course-preview
  policy and produce the same direct-uniform still-water capture at `0.746968L`
  and `24.5795T` (score `-0.460673`).  Their top-down sheets show a broad,
  target-directed bend with a coherent alternating wake; their oblique sheets
  show self-propulsion and persistent three-dimensional vortex shedding without
  wake breakup or a terminal instability.
- The only behaviorally distinct sampled child is the stroke-aware allocator.
  It retains the same coherent capture topology, finishing at `0.748724L` and
  `24.6180T` (score `-0.462756`), so its small route penalty is not a semantic
  regression.  It cuts posterior hard-stop occupancy from `23.38%` to `12.60%`,
  mean absolute posterior raw acceleration from `42.65` to `39.50 rad/T^2`,
  and peak normalized planar force/yaw moment from `0.323/0.143` to
  `0.203/0.089`.  Raw acceleration-envelope exposure is essentially unchanged
  (`72.84%` versus `72.65%`), and the anterior joint remains free of angle-limit
  saturation in both.
- All four sampled evaluations report `U_infinity=[0,0,0]`, uniform direct
  initialization, no cylinders, and capture.  There is therefore no sampled
  failure sheet; the slightly slower stroke-aware capture is the informative
  weaker comparator.  The inherited optimizer log also records the immediate
  pre-preview parent as a `1.092L` near miss with an upper-domain exit, while
  older inherited guidance records the steering-priority parent at `1.076L`.

## Control diagnosis

Course preview is the semantic improvement and must be preserved.  The
stroke-aware result shows that admitting the posterior traveling-wave carrier
near an outward hard-stop request materially reduces pinning and peak load, but
its unconditional release also gives away a small amount of useful steering.
The missing discriminator is whether the translational course has responded:
carrier relief is appropriate only after normalized body-frame course error is
small, not while the same observable still predicts a lateral miss.

## Candidate hypothesis

Retain the captured course-preview controller and its bounded steering-priority
allocator.  Add posterior stroke relief only under the conjunction of observed
tail-angle proximity, outward steering pressure, and course alignment.  This
is a state-dependent authority handoff: a large course error preserves the
capturing parent's steering claim even at the tail stop; an aligned course
continuously restores carrier cancellation/headroom.  It introduces no route,
clock, world-frame direction, or new actuation magnitude.

Expected result: preserve capture and approach timing near the `24.5795T`
parent while reducing posterior hard-stop residence and the exceptional
`0.323/0.143` peak planar force/moment toward the stroke-aware comparator.
Falsify the mechanism if capture is lost, score or arrival degrades materially
beyond the `24.6180T` comparator, tail-stop/load exposure is not reduced from
the parent, raw/rate limit exposure worsens materially, or wake coherence and
far-approach geometry change.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: biological C-start/burst redirects combined with elongated-body posterior reactive thrust
source_mechanism: apply bounded curvature for a large observed route error, then release into the posterior propulsive beat after measured response
transferable_invariant: steering should keep priority while route error persists and hand authority back to a lagged posterior carrier only after course response is observed
nontransferable_details: species kinematics, published gains, dimensional beat frequency, full-body envelopes, exact vortex phase, and task-specific routes
policy_translation: use normalized body-frame velocity/target cross-product, observed posterior joint angle, and signed steering acceleration to gate a bounded carrier-headroom handoff in the two-joint allocator
falsification: reject if the handoff loses capture, delays beyond the sampled stroke-aware child, fails to reduce posterior pinning/load, increases envelope exposure, or disrupts the coherent far wake
