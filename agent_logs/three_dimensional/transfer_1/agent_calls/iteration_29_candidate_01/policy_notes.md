# Candidate diagnosis and hypothesis

## Evidence read before editing

- All four sampled evaluations report `uniform_direct` initialization,
  `U_infinity=(0,0,0)`, no cylinders, finite dynamics, and capture at
  `0.7480--0.7494L`; there is no sampled prewarm or numerical-failure artifact.
- The best-scoring sampled speed-reserve baseline
  (`solver_6b0e320e2f55`, score `-0.15140`, `18.6010T`) and its exact-policy
  sample (`solver_6f904f98394f`, `18.2875T`) both show sustained self-propulsion,
  a coherent alternating top-down vortex street, and compact bilateral oblique
  Lambda2 structures through capture. The posterior-wave-shape capture has the
  same qualitative wake, so the surviving distinction is terminal path geometry
  and control allocation, not carrier generation.
- The prefilled fixed unsafe-intercept anterior transfer
  (`solver_55f3a103ab95`) also preserves both wake views and captures, but arrives
  later at `18.7495T`. From its trace, head/tail action clipping remains about
  `68.8%/70.8%` and exact speed-limit residence about `10.7%/11.6%`; neither is
  better than the two baseline samples (about `68.5%/70.6%` clipping and
  `10.4%/11.3--11.5%` speed residence). Force and moment maxima remain in the
  same envelope. Thus a fixed transfer is compatible with propulsion but is not
  evidence of improved actuator use.
- The assigned parent's inherited score logs contain three stable lower exits
  after closest passes of `1.8004L`, `1.6664L`, and `1.3915L`. Sampled guidance
  also records that broader bearing/response edits and unconditional allocation
  did not change that terminal topology reliably. No failure keyframe sheet is
  present for those score-only inherited logs, so visual claims about the failure
  are not invented; the available captured sheets and recorded coherent-wake
  failure summaries jointly localize the open problem to interception geometry.

## Policy hypothesis

Retain the evaluated achieved-course/intercept controller, state-feedback
traveling bend, sparse carrier reserve, steering magnitude, and total steering
share. Replace the fixed unsafe-intercept spatial transfer with a smooth
load-conditioned allocator. Normalize each joint's current speed and previous
action by the hard envelope and combine them as a bounded burden. Transfer a
share of additive steering from tail to head only when all of these hold:

1. the existing terminal geometry says the projected intercept is unsafe;
2. posterior burden is already substantial;
3. posterior burden exceeds anterior burden; and
4. the anterior joint retains envelope margin.

This is intended to protect the posterior traveling-wave actuator without
globally changing the route or carrier. On replayed sampled traces, the proposed
burden conditions are eligible on roughly `28--30%` of rows inside `4L` before
the existing terminal/unsafe-geometry gates, rather than applying the fixed
transfer throughout the unsafe region.

bookshelf_consulted: true
source_domain: Lighthill elongated-body propulsion and sensor-modulated robotic-fish turning
source_mechanism: preserve posterior lag/reactive thrust while realizing bounded steering curvature with the anterior body actuator
transferable_invariant: keep the traveling bend active and move only the steering residual away from the more burdened propulsive joint using observed feedback
nontransferable_details: published gains, species kinematics, dimensional cadence, full-body waves, exact vortex phase, and task-specific routes
policy_translation: use normalized joint speed and previous-action burden plus body-frame target/intercept gates to condition a total-share-preserving tail-to-head steering transfer
falsification: reject if exact repeats do not improve capture reliability or useful actuator burden, or if far-field closure, either coherent wake view, arrival, speed, clipping, force, or moment leaves the evaluated speed-reserve envelope
