# Evidence-preserving multi-wake target-policy candidate

## Visual and rollout diagnosis before candidate selection

- The four sampled solver policies and the prefilled policy share SHA-256
  `452903db94b971aed60f8a7830a0f2e19faebb59e44d73d0e428556cc7dc9781`.
  Their trajectories and top-down, oblique, and combined keyframe sheets are
  also byte-identical. Each rollout starts directly from uniform still water
  with `U_infinity=(0,0,0)`, no cylinders, and no prewarm snapshot; each
  captures at `16.604496T`, reaches `0.743958L`, has scored distance integral
  `1.998146L`, scores `-0.113729`, and remains numerically finite through 237
  moving-window shifts. The sample is therefore one reproducible nominal
  experiment, not four distinct trajectory classes or held-out evidence.
- I inspected both required visual views from release through capture. The
  top-down row shows acceleration from rest, continuous left/down target
  closure on a shallow crossing arc, and an alternating mid-plane vorticity
  street connected to the tail. The oblique row shows finite, compact,
  alternating three-dimensional Lambda2 structures along the traveled path.
  Together with zero background flow, the translation is self-propelled; no
  passive advection, inherited wake, collision, boundary exit, wake breakup,
  or instability is visible.
- No sampled failure sheet exists: all four available examples are exact
  captures. The closest informative changed comparison is consequently the
  inherited, completed closure-qualified yaw-response release. It preserved
  the route and wake class and crossed one `0.0055T` step earlier, but worsened
  crossing depth from `0.743958L` to `0.744276L`, distance integral from
  `1.998146L` to `1.998380L`, and score from `-0.113729` to `-0.114037`, with
  no meaningful action, joint-speed, force, or moment benefit. Other inherited
  terminal relief, projected-corridor, line-of-sight-rate, bearing, moment,
  and local-flow-residual controls also retained finite or capturing motion
  while worsening target cost.
- The successful crossing is not a near-rest equilibrium: its speed is
  `1.132762U`, heading error is `0.409227 rad`, and yaw rate is
  `2.238745 rad/T`. Those endpoint values coexist with semantic capture, a
  connected two-view wake, peak planar force/moment of about
  `0.037165/0.018356`, and finite joint motion. They do not independently
  diagnose a need for terminal damping in this first-crossing, no-dwell task.

## Sole candidate and falsifiable hypothesis

Keep `solver/cases/dogfish_3d_shape_policy/candidate_target_policy.jl`
behaviorally and byte-for-byte unchanged as this workspace's one candidate.
It preserves the demonstrated full traveling-wave carrier, raw target
geometry and anterior course center, mean-preserving yaw and lateral-response
demodulation, relative-crossflow feedback, phase-compatible posterior
steering, smooth acceleration bound, and narrow one-sided joint-speed guard.

This is an evidence-constrained candidate selection, not a claim about this
worker's unevaluated CFD result. The expected result is nominal capture with
the same approach arc, connected alternating wake, arrival, distance cost,
crossing depth, joint feasibility, action, force, and moment envelope. Reject
the selection if nominal capture fails to reproduce. Reopen one bounded
body-frame primitive only after a completed held-out pose, target, or flow
rollout exposes a specific response deficit, and reject that primitive if it
degrades the established nominal envelope.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and biological or learned terminal prey-capture control
source_mechanism: separate a productive rhythmic carrier from bounded route and terminal correction, recruiting the latter only for an observed response deficit
transferable_invariant: preserve an evidenced traveling carrier and require state-derived evidence of a miss before adding terminal yaw, slip, or drive modulation
nontransferable_details: published gains, dimensional frequencies, species-specific kinematics, exact vortex phases, capture schedules, and task-specific routes
policy_translation: retain the sampled normalized body-frame two-joint controller exactly because the no-dwell capture has no diagnosed terminal deficit and completed terminal variants regress
falsification: reconsider one bounded terminal primitive only if held-out evidence shows a repeatable miss tied to excess yaw or slip and the intervention preserves nominal capture, route cost, wake connectivity, feasibility, force, and moment

## Evidence boundary

The positive evidence belongs to completed sampled and inherited evaluations;
the current candidate will be evaluated only after this worker exits. Because
no sampled failure visual artifact is available, the failure contrast above is
limited to inherited completed observations and metrics and is not presented
as a new image-level comparison. Exact nominal replication cannot establish
robustness to a changed pose, target, inflow, or imposed wake.
