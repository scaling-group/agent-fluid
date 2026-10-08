# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four sampled rollouts satisfy the released direct-uniform still-water
  contract: `U_infinity=(0,0,0)`, no cylinders, no prewarm snapshot, capture
  termination, and no reported numerical instability. Their top-down sheets
  are identical and show continuous target approach behind an alternating
  red/blue caudal street rather than passive advection or a terminal coast.
  The complete oblique sheets for `solver_392ed1eddf30` and
  `solver_6bc696c9a6ab` retain discrete three-dimensional Lambda2 structures
  through capture. The oblique videos for `solver_cb5a6b73ffd9` and
  `solver_d802465f301b` are only 2,149 bytes and their oblique rows are blank;
  those two are render failures, not contrary wake evidence.
- The four candidates differ only in comments and produce the byte-identical
  trajectory. Each captures at `24.326511T` and `0.749329L`, has mean distance
  `2.224097L`, scores `-0.325310`, and retains the inherited peak normalized
  planar force/yaw moment and rate-cap envelope near `0.03165/0.01638` and
  `14.04/6.92%`. This strengthens the assigned parent's terminal-relief result
  from one sampled outcome to deterministic four-way fixed-pose replication;
  it still supplies no evidence about a changed pose or hydrodynamic setting.
- The inherited logs provide the matched allocation evidence. Adding up to
  20% posterior rudder under a one-step closing deficit delayed capture to
  `24.414513T` and raised near-target action effort. Removing up to 20% under
  the same signal advanced the replicated unmodified capture from
  `24.337509T` to `24.326511T` without changing the carrier or load envelope.
  The reusable effect is posterior steering relief, not the one-step distance
  difference itself: the parent explicitly limits that signal to this fixed
  pose and asks later work to try a smoother response observable.
- The terminal trace explains that boundary. Below `1.5L`, one-step head
  closing speed oscillates with articulated head motion even while the body
  translates steadily at roughly `0.6L/T`. At capture, the target error is
  still about `1.31 rad` and yaw rate about `-1.46 rad/T`; the rhythmic carrier
  is active, and complete oblique evidence shows no wake collapse. Suppressing
  the carrier or adding yaw-rate unloading would contradict the earlier
  inertial-coast failure. A normalized target-direction/translation alignment
  can instead identify a poor near-field approach while leaving both joint
  phase and carrier amplitude untouched.

## One candidate hypothesis

Preserve the replicated traveling carrier, anterior redirect, full-angle
half-cycle redistribution, and capture-producing posterior reactive-rudder
sign and recruitment. Replace only the one-step closing-deficit relief gate
with a terminal velocity-alignment gate. Inside a smooth `1.5--0.9L` approach
window, form the cosine between normalized body-frame target displacement and
body translational velocity; as alignment falls from `0.8` toward `0.35`,
smoothly release at most the already tested 20% of the posterior mean rudder.
This is an observation/mechanism change rather than a scalar retune: it removes
articulated head displacement from the response estimate, remains invariant to
world translation and reflection, and never scales the propulsive carrier.

Falsify the candidate if capture is lost or later than `24.326511T`, mean
distance exceeds `2.224097L`, behavior changes outside `1.5L`, or carrier wake,
rate-cap occupancy, action effort, peak force, or yaw moment worsens. Even a
positive fixed-pose result would remain provisional until a complete oblique
render and pose or hydrodynamic perturbation test it.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and terminal capture scheduling
source_mechanism: preserve a rhythmic propulsive carrier while sensory feedback reallocates a bounded steering offset during near-target approach
transferable_invariant: separate propulsion from steering and reduce only excess steering when normalized body-frame motion is poorly aligned with the target
nontransferable_details: published gains, robot linkage geometry, species-specific kinematics, dimensional frequencies, prescribed maneuver timing, exact vortex phase, capture route, and world coordinates
policy_translation: joint state retains carrier phase; normalized target displacement and body velocity form a reflection-invariant alignment cosine that smoothly gates at most 20% posterior-rudder relief only in the near field
falsification: reject if the earlier capture and mean distance are not improved or retained, or if wake coherence, saturation, effort, force, or moment envelopes worsen
