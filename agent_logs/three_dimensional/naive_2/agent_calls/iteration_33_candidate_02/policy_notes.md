# Evidence-preserving multi-wake target-policy candidate

## Visual and rollout diagnosis before candidate selection

- The four sampled policies, trajectories, and combined keyframe sheets are
  byte-identical. Each rollout starts directly from uniform still water with
  `U_infinity=(0,0,0)`, no cylinders, and no prewarm snapshot; each remains
  finite through 237 moving-window shifts and captures at `16.604496T`, with
  crossing distance `0.743958L`, scored distance integral `1.998146L`, and
  score `-0.113729`. Thus the sample is one reproducible nominal experiment,
  not four distinct trajectory classes or held-out robustness evidence.
- I inspected both rows of the shared keyframe sheet from release to capture.
  The top-down row shows self-propelled left/down closure along a shallow
  target-crossing arc and a coherent alternating vorticity street. The
  oblique row shows compact three-dimensional Lambda2 structures attached to
  the posterior body and traveled path. Zero background flow and direct
  initialization exclude passive advection or inherited-wake explanations;
  no collision, boundary exit, wake breakup, or instability is visible.
- No sampled failure image exists because all four examples are exact
  captures. The nearest changed contrast is therefore limited to inherited
  completed metrics and notes: qualified terminal yaw-response release
  crossed one `0.0055T` step earlier but worsened crossing depth from
  `0.743958L` to `0.744276L`, distance integral from `1.998146L` to
  `1.998380L`, and score from `-0.113729` to `-0.114037`, without a meaningful
  action, joint-speed, force, or moment benefit. Other inherited terminal,
  line-of-sight-rate, moment, bearing, and local-flow-residual additions also
  retained finite or capturing motion while worsening target cost.
- Capture occurs during productive motion rather than terminal equilibrium:
  the final translational speed is `1.132762U` and recent yaw rate is
  `2.238745 rad/T`, while the wake stays connected and peak planar
  force/moment remain about `0.037165/0.018356`. Those instantaneous endpoint
  values are not evidence of a defect in this no-dwell first-crossing task.

## Sole candidate and falsifiable hypothesis

Keep the prefilled normalized body-frame two-joint controller behaviorally and
byte-for-byte unchanged as this workspace's one candidate. It preserves the
demonstrated traveling-wave carrier, raw target geometry, mean-preserving yaw
and lateral-response demodulation, relative-crossflow response, phase-selective
posterior steering, smooth acceleration bound, and narrow one-sided joint-speed
guard. A fifth unmotivated terminal or residual channel would confound the
well-replicated carrier without addressing an observed semantic deficit.

Expected result: nominal capture with the same target-directed arc, connected
two-view wake, arrival, distance cost, crossing depth, joint feasibility,
action, force, and moment envelope. Reject this selection if nominal capture
does not reproduce. Reopen one bounded body-frame mechanism only after a
completed held-out pose, target, or flow exposes a repeatable response deficit;
reject that mechanism if it degrades the demonstrated nominal envelope.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking, asymmetric flapping, and biological or learned prey-capture control
source_mechanism: separate productive rhythmic locomotion from bounded route and terminal correction, recruiting a correction only for an observed response deficit
transferable_invariant: preserve an evidenced state-feedback traveling carrier and require state-derived evidence of a miss before adding terminal yaw, slip, drive, or wake-residual modulation
nontransferable_details: published gains, dimensional frequencies, species or robot kinematics, exact vortex phases, capture schedules, and task-specific routes
policy_translation: retain the sampled normalized body-frame two-joint controller exactly because the no-dwell capture has no diagnosed response deficit and completed terminal or residual variants regress
falsification: reconsider one bounded primitive only if held-out evidence shows a repeatable miss and the intervention preserves nominal capture, route cost, wake connectivity, joint feasibility, force, and moment

## Evidence boundary

The positive and negative results above belong to completed sampled and
inherited evaluations. The current candidate receives CFD evaluation only
after this worker exits, so no same-worker improvement is claimed. The absent
sampled failure sheet prevents a new image-level failure comparison, and exact
nominal repeats do not establish robustness to changed pose, target, or flow.
