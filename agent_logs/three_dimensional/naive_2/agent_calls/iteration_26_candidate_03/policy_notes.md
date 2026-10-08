# Evidence-constrained replicated-best carrier candidate

## Visual and metric diagnosis before candidate selection

- All four sampled solvers are byte-identical controller and keyframe repeats.
  They satisfy the direct-uniform still-water contract with
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, finite moving-window
  dynamics, and capture at `16.604496T`, `0.743958L`, score `-0.113729`, and
  distance integral `1.998146L`. Exact nominal replication supports promotion,
  but does not establish held-out pose or flow robustness.
- I inspected the combined keyframe sheet and both view-specific sheets for
  the sampled best and the assigned parent's projected-corridor descendant.
  From release to capture, the top-down views show targetward self-propulsion
  and a coherent alternating vorticity street; the oblique views show compact,
  finite, tail-connected three-dimensional Lambda2 structures. There is no
  passive advection, wake breakup, collision, domain exit, or instability.
  The sheets are visually indistinguishable at their sampled resolution, so
  the child's weaker scalar result is a directional-control regression rather
  than a reason to alter propulsion.
- The projected-corridor child changed posterior actions from `14.762T` and
  `2.671L` onward but arrived at the same `16.604496T`. It made the crossing
  shallower (`0.744813L` versus `0.743958L`) and raised distance integral from
  `1.998146L` to `1.998871L`, worsening score from `-0.113729` to `-0.114625`.
  Peak planar force/moment (`0.037165/0.018356`), peak joint speed, and
  near-limit residence were effectively unchanged; selectively releasing yaw
  inside a projected velocity-ray corridor therefore supplied no compensating
  load or feasibility benefit.
- The inherited logs make this a repeated controlled boundary rather than one
  unlucky scalar choice. Two line-of-sight-rate additions, bearing
  demodulation, moment-residual rejection, high-alignment yaw release, and
  closure-deficit posterior attenuation all retained finite connected wakes
  but scored below the exact parent. The current evidence does not isolate a
  remaining terminal correction whose expected benefit exceeds the risk of
  perturbing the demonstrated capture arc.

## Sole candidate hypothesis

Promote the exact sampled `-0.113729` response-demodulated controller as the
single candidate. Preserve its full traveling-wave carrier, raw body-frame
target geometry, mean-preserving yaw and lateral phase demodulation, raw-course
anterior center, posterior route/crossflow response, phase-selective relief,
smooth acceleration bound, and one-sided final-band speed guard without a new
terminal gate or scalar retuning. This is an evidence-constrained negative
selection: after the projected-corridor falsification, behavioral identity is
preferred to an unevidenced intervention. Falsify the promotion if nominal
capture or either visual wake class fails to replicate, or if a held-out pose
or flow reveals a semantic directional deficit that the retained observation
channels cannot correct.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and wake-interaction control
source_mechanism: preserve productive rhythmic locomotion while bounded observed residuals independently modulate directional response
transferable_invariant: keep an evidenced traveling carrier separate from route and disturbance feedback, and recruit another mechanism only for a diagnosed response deficit
nontransferable_details: published gains, dimensional frequencies, species or robot kinematics, exact vortex phases, prescribed routes, and source-task terminal geometry
policy_translation: retain the sampled normalized body-frame two-joint carrier and its demodulated response channels exactly; do not adopt another terminal primitive after the projected-corridor intervention regressed
falsification: reject if capture, distance cost, the target-crossing arc, connected three-dimensional wake, joint feasibility, force, or moment fails to replicate, or if held-out evidence exposes a new correctable deficit

## Evaluation boundary

No CFD result is claimed for this workspace. The later evaluation should first
require capture and the same top-down and oblique wake classes, then compare
arrival, distance integral, crossing depth, joint contact, near-limit action,
force, and moment against the four exact sampled repeats. A changed pose, flow,
success radius, observation adapter, or carrier family is a falsification test,
not evidence that this nominal repeat is broadly robust.

## Non-CFD verification

- The candidate is byte-identical to all four sampled evaluated captures.
- Static schema validation found 32 direct `params.FIELD` references and all
  32 are returned by `target_policy_params()`.
- Exactly one nonempty `candidate_target_policy.jl` exists under `solver/`;
  the forbidden-cue scan found no time, step, random, file-I/O, or cylinder
  coordinate access, and the solver boundary check passed.
- The notes and revised experience bullet pass the guidance checker's semantic
  token and parent-difference tests when the assigned parent marker is
  deduplicated. The packaged checker itself stops earlier because the rendered
  workspace `README.md` repeats the same assigned-parent line twice; that file
  is outside the editable candidate, guidance, and provenance surfaces.
- The required dedicated check-runner was invoked but could not start because
  its pinned model is unavailable for this account. The Julia smoke command
  could not run because this environment has no Julia executable or Python
  Julia bridge. No CFD was run.
