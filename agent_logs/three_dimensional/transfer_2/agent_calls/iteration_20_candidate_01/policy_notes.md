# Evidence-selected course-consistent residual candidate

## Visual diagnosis before the policy edit

- All four sampled solver rollouts and the inherited informative failure use
  direct uniform initialization in still water (`U_infinity=[0,0,0]`), with
  no cylinders and no prewarm.  The prefilled v34 posterior-coast policy
  captures at `25.0635T`, minimum/final distance `0.749973L`, mean distance
  `2.352216L`, and score `-0.452083`.
- Both rows of the strongest captured sheet and the inherited phase-reversal
  failure sheet were inspected from release through termination.  In the
  capture, the top-down row starts wake-free, shows self-propelled diagonal
  progress with a coherent alternating mid-plane vortex street, and ends in a
  compact target-directed hook; the oblique row shows compact three-dimensional
  Lambda2 structures persisting through capture.  The failure also forms a
  coherent three-dimensional wake, but passes outside the disk at `0.993183L`,
  then turns upward and exits left at `37.1470T` and `6.9973L`.  Thus the
  failure is an accumulated controller-route change, not passive advection,
  wake breakup, instability, or a moving-window artifact.
- Two byte-identical v35 steering-residual samples capture at `24.6730T` and
  `0.748684L`, improve mean distance to `2.348256L` and score to `-0.448647`,
  preserve zero sampled posterior hard-stop occupancy, and retain the low peak
  planar force/yaw-moment class (`0.0253/0.0309/0.0156`).  This is useful
  steering allocation, not a saturation cure: posterior/total exact-rate
  occupancy is slightly higher than v34 (`4.637/13.932%` versus
  `4.586/13.869%`).
- The distinct v36 course-consistency veto has now completed and its entire
  `4486`-row trajectory is byte-identical to both v35 replications, including
  arrival, distances, score, loads, and termination.  This confirms the prior
  fixed-trace prediction: the only steering residual retained by v35 on this
  route already agrees with normalized body-frame velocity-course error.  The
  veto is a nominal-route-preserving generalization guard, not a new measured
  performance mechanism.
- In contrast, the inherited reference-velocity follower correction touched
  `306/4557` parent states, reduced posterior/total rate exposure to
  `3.598/12.659%`, but separated the trajectory by `8T` and converted capture
  into the coherent pass-and-turn failure.  Lower rate occupancy cannot justify
  another widespread posterior phase intervention.

## Policy hypothesis

Use the positively evaluated v36 controller as this workspace's single
candidate.  Relative to the v34 prefill, it adopts v35's evaluated posterior
coast allocation: taper velocity-increasing carrier effort at the owned rate
boundary while preserving an already-requested rate-opposing steering residual.
It additionally requires that residual to agree in sign with normalized
body-frame velocity-course error.  The anterior state oscillator, lagged
posterior wave, course-preview route, stroke and braking reserves, steering
bound, and all active gains remain unchanged.  No acceleration is synthesized,
and no clock, world coordinate, fixed direction, target identity, or memorized
route is introduced.

Expected evidence is the established v35/v36 capture family near `24.673T`, a
coherent three-dimensional wake, zero posterior hard-stop occupancy, and peak
planar loads in the roughly `0.035` class.  Falsify the candidate if the new
post-exit evaluation loses capture, changes the sampled trajectory, returns
posterior hard-stop contact, or leaves the low-load class.  The fixed episode
does not test the veto's held-out value; a later reflected or perturbed rollout
must reject it if it suppresses necessary route-corrective steering.  The new
CFD result is not available to this worker and is not claimed here.

bookshelf_consulted: true
source_domain: Lighthill elongated-body reactive swimming and sensor-modulated coupled-oscillator robotic-fish control
source_mechanism: an anterior phase anchor organizes a lagged posterior traveling bend while bounded sensory feedback modulates the follower without replacing the rhythm
transferable_invariant: preserve wave direction and signed target-steering authority, and remove only posterior effort that conflicts with both the actuator envelope and the current body-frame route objective
nontransferable_details: published gains, dimensional cadence, species-specific kinematics and envelopes, full-body waveforms, exact vortex phases, Strouhal targets, motor models, and task-specific routes
policy_translation: retain the evaluated anterior oscillator and posterior coast allocation, and admit its already-requested rate-opposing posterior steering residual only when its sign agrees with normalized body-frame velocity-course error
falsification: reject if capture, the established route, coherent wake, zero posterior hard-stop occupancy, or the low-load class is lost, or if a held-out reflection or perturbation shows the veto suppressing necessary route correction

## Pre-evaluation validation

- The single candidate is byte-identical to the positively evaluated v36
  sample (LF SHA-256
  `8e7924b25b66146e167bfe09f11cb3b36a43b453f59ed03c41da81d2638771fa`).
- The exact Julia public-contract probe loads the policy and returns two finite
  accelerations.  The deterministic schema audit finds all `84` direct
  `params.FIELD` references among the `86` fields returned by
  `target_policy_params()`.
- The configured check runner was invoked, but its pinned `gpt-5.4-mini` model
  is unsupported on this account.  After removing a duplicated assigned-parent
  entry from the rendered workspace README, its three declared no-CFD checks
  pass when run directly and separately: reusable-guidance semantics, the Julia
  contract, and the solver editable-boundary audit.  No formal CFD was run.
