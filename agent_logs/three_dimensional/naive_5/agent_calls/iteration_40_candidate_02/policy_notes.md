# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen contract: direct uniform
  still-water initialization with `U_infinity=(0,0,0)`, no cylinders or
  prewarm, and inertial moving-window transport. All capture with zero angle,
  rate, or applied-acceleration contact, so route response, distance integral,
  wake organization, and loads are the useful discriminants.
- The assigned policy is independently reproduced in three byte-identical
  rollouts at `0.748598L/25.5090T`, score `-0.556475`, and mean distance
  `2.457773L`. Their identical policy hashes, trajectory metrics, and combined
  sheets establish fixed-condition determinism but also three consecutive
  completed iterations without a new mechanism or semantic trajectory change;
  this triggers the requested bookshelf re-consultation.
- I inspected the combined and view-specific sheets for the assigned parent and
  the distinct strongest sampled comparison in both the top-down mid-plane
  vorticity/body view and the oblique body/Lambda2 view. Each fish visibly
  self-propels from rest, leaves an organized alternating wake, holds a nearly
  straight middle corridor, and makes the same late target-side hook into
  capture. The oblique views retain compact three-dimensional wake structures
  without breakup, passive advection, boundary precursors, or moving-window-
  induced rotation. The comparison is therefore a controller-response result,
  not a different wake topology or a propulsion/stability change.
- The distinct sampled policy replaces the parent's instantaneous body-normal-
  slip recovery and force-qualified curvature residual with one phase-rejected
  posterior reaction mechanism. On the shared upstream duty-ratio carrier it
  improves score to `-0.555926`, mean distance to `2.456908L`, and arrival to
  `25.3495T`. It reaches `2.5498/1.4492L` at `22/24T` versus the parent's
  `2.5563/1.4748L`; over `18--24T`, mean normalized course error falls from
  `0.55363` to `0.54263` and mean projected miss from `1.65965L` to
  `1.63126L`. Peak speed, angle, rate, command, planar force, and yaw moment
  remain the shared `0.70893U`, `0.77093 rad`, `4.51769 rad/T`,
  `29.86795 rad/T^2`, `0.02063`, and `0.01065`, with zero hard contacts.
  This is a finite fixed-pose improvement, not a semantic route change or
  held-out robustness result.
- Earlier inherited logs found the same posterior reaction allocation
  ineffective on the pre-duty carrier, while four middle residual variants
  occupied one shallow-hook cluster. The new controlled comparison narrows
  that negative boundary: a phase-qualified posterior reaction can be useful
  after upstream anterior duty asymmetry changes the carrier response, but it
  should replace the phase-confounded slip/load branches rather than be stacked
  with them. The evidence does not support changing its authority, thresholds,
  or the already productive upstream carrier.

## One-candidate policy hypothesis

Promote exactly the strongest sampled policy. Preserve the state-feedback
traveling bend, anterior course-duty asymmetry, posterior lag, course/miss
redirect, target-line response, upstream vectoring, capture modulation,
coordinated acceleration projection, and angle/rate viability guards. Replace
only the middle instantaneous-slip and force gates with a phase-rejected
target-normal response: subtract the evidenced anterior-rate cadence component,
require the residual side to agree with normalized target/course geometry, and
extend only the posterior half-cycle moving opposite the requested course side
inside the closing middle corridor. This keeps route side geometric and uses
joint state only to qualify the hydrodynamically useful reaction phase.

The falsifiable expectation is deterministic reproduction of the sampled
`18--24T` course-error/miss reduction and capture near `25.3495T`, with the
same coherent two-view wake, zero actuator contacts, and no increase beyond the
parent's load envelope. Reject promotion if the next rollout collapses to the
parent trace, loses capture or wake coherence, restores contact, or raises
loads; do not generalize fixed-pose success unless a later held-out condition
retains the benefit. The current worker does not claim new CFD evidence.

bookshelf_consulted: true
source_domain: wake-interaction sensing and sensor-modulated robotic-fish asymmetric flapping
source_mechanism: separate persistent target response from fast beat-synchronous lateral motion, then extend only a state-qualified hydrodynamically useful half-cycle
transferable_invariant: target geometry owns correction side while joint-state phase only qualifies a bounded within-beat posterior reaction, preserving the traveling-wave carrier outside the response deficit
nontransferable_details: published gains, dimensional frequencies, species envelopes, linkage geometry, clock phase, exact vortex phase, fixed initial pose, and task-specific routes
policy_translation: phase-reject normalized body-frame target-normal velocity with anterior joint rate; require agreement with body-frame course geometry and closing response before applying a bounded joint-2 reaction half-cycle in the middle corridor
falsification: reject on failure to reproduce lower full-beat course error and projected miss, lost or slower capture, incoherent three-dimensional wake, actuator contact, increased load exposure, or lack of benefit under later held-out conditions

## Non-CFD audit after the policy edit

- The candidate byte-matches the strongest distinct sampled artifact at
  SHA-256 `7b79dd4e34ae7ffafcfcc739c609be86c685988904de2e6053c4721a2bef6cc0`.
  This makes the next evaluation a clean fixed-condition replication of an
  already completed mechanism comparison, not same-worker CFD evidence.
- All 65 direct `params.FIELD` references are owned by the 65-field object
  returned from `target_policy_params()`, with no unused fields. The prescribed
  lightweight Julia state returns two finite accelerations.
- The required independent check runner was invoked, but this account does not
  support its pinned `gpt-5.4-mini` model. Following the inherited fallback,
  its three prescribed commands were run directly: the material-guidance,
  Julia contract/schema, and solver editable-boundary checks all pass. The
  guidance check initially exposed a duplicated assigned-parent marker in the
  rendered `README.md`; removing only that duplicate restored an unambiguous
  parent. No formal CFD was run.
