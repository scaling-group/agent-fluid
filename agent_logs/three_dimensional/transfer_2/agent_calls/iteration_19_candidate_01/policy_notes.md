# Evidence-selected steering-residual coast candidate

## Visual diagnosis before the policy edit

- The assigned-parent rollout and all four sampled solver rollouts satisfy the
  frozen experiment contract: direct uniform initialization in still water
  with `U_infinity=[0,0,0]`, no cylinders or prewarm, finite dynamics, and
  inertial moving-window transport.
- Both rows of the assigned-parent v35 phase-follower failure, sampled v34
  capture, and sampled v35 steering-residual capture sheets were inspected
  from release through termination.  All start wake-free, move by
  self-propulsion, and form coherent alternating mid-plane streets with compact
  three-dimensional Lambda2 structures.  The captures retain that wake through
  their terminal hooks.  The parent also retains a coherent wake, but its path
  is already about `0.26L` higher at `12T`, misses the capture disk at
  `0.993183L`, turns upward after passage, and exits left at `37.147T`.
  This is a control-induced route change, not advection, wake breakup,
  numerical instability, or a moving-window artifact.
- The replicated v34 posterior-coast policy captures at `25.0635T`,
  minimum/final distance `0.749973L`, mean distance `2.352216L`, score
  `-0.452083`, zero sampled posterior hard-stop occupancy, and peak absolute
  planar force/yaw-moment coefficients `0.0244/0.0337/0.0162`.
- The distinct sampled v35 steering-residual coast changes only the
  rate-boundary allocation: it preserves target steering that already opposes
  posterior velocity while tapering the velocity-increasing remainder.  It
  captures earlier at `24.6730T`, improves mean distance to `2.348256L`
  and score to `-0.448647`, keeps zero posterior hard-stop occupancy, and
  retains the low peak-load class (`0.0253/0.0309/0.0156`).  A common direct
  CSV audit finds slightly more, not less, exact-clamp rate occupancy than v34
  (posterior/any-joint `3.856/13.152%` versus `3.818/13.101%`), so its
  reusable benefit is route-preserving steering allocation rather than a
  claimed saturation cure.
- The assigned parent tested a different reference-velocity feedforward over
  many far-approach half cycles.  Although exact-clamp posterior/any-joint rate
  occupancy falls to `2.991/12.052%` and loads remain low
  (`0.0243/0.0332/0.0159`), it converts capture into the coherent
  `0.993183L` pass-and-turn failure and score `-7.975740`.  This closes the
  upstream phase-reversal-feedforward branch: a lower saturation statistic is
  not evidence of a better follower when the accumulated route changes.

## Policy hypothesis

Select the sampled v35 steering-residual coast as this workspace's single
candidate.  Relative to the prefilled v27 policy, it preserves the established
course-preview route and anterior phase anchor while adding the evaluated
posterior stroke reserve, braking reserve, posterior-only coast layer, and the
small signed steering residual that has positive capture evidence.  Do not
inherit the assigned parent's derived reference-rate feedforward, synthesize
new inward braking, alter the anterior oscillator, or tune another rate band.

The expected evidence is a capture in the established trajectory family near
`24.7T`, a coherent three-dimensional wake, zero posterior hard-stop
occupancy, and peak planar loads in the roughly `0.035` class.  Treat the
selection as falsified if the post-exit rollout loses capture, departs
materially from that route, returns posterior hard-stop contact, or leaves the
sampled low-load class.  The current worker runs no CFD and does not claim its
future evaluation as evidence.

bookshelf_consulted: true
source_domain: Lighthill elongated-body reactive swimming and sensor-modulated coupled-oscillator robotic-fish control
source_mechanism: an anterior phase anchor organizes a traveling bend while bounded proprioceptive feedback adapts a posterior follower without discarding target steering
transferable_invariant: preserve wave direction and signed target-steering authority while removing only posterior carrier effort that conflicts with the owned rate envelope
nontransferable_details: published gains, dimensional cadence, species-specific kinematics and envelopes, full-body waveforms, exact vortex phases, Strouhal targets, and task-specific routes
policy_translation: retain the normalized body-frame course controller and anterior state oscillator, and at the posterior rate boundary taper only velocity-increasing remainder while passing the already-computed velocity-opposing steering residual
falsification: reject if capture, the established route and coherent wake, zero posterior hard-stop occupancy, or the sampled low-load class is lost; do not claim a saturation cure unless rate occupancy also improves

## Pre-evaluation validation

- The candidate is byte-identical to the positively evaluated sampled v35
  steering-residual coast policy (LF SHA-256
  `e92eb0955ad1045ee18fc44ac03c3fda91508dcba387886463051fca90f6e4c6`).
- The exact Julia public-contract probe loads the candidate and returns two
  finite accelerations.  The deterministic schema audit finds all `84`
  direct `params.FIELD` references among the `86` fields returned by
  `target_policy_params()`.
- The configured check runner was invoked, but its pinned `gpt-5.4-mini`
  model is unsupported on this account.  Its three declared no-CFD commands
  were run directly and separately: reusable-guidance semantics, the Julia
  contract, and the solver editable-boundary audit all pass.  No formal CFD
  was run.
