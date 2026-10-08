# Candidate diagnosis and hypothesis

## Evidence read before editing

- All four sampled rollouts use direct uniform still water with
  `U_infinity=(0,0,0)` and terminate in capture. Three samples reproduce the
  selective speed-guard route at `0.749366L` and `27.577T`; the assigned
  prefill adds a common soft acceleration projection and captures at
  `0.749242L` and `26.296T` with the better score (`-0.617238` versus
  `-0.707508`).
- Both combined visual sheets were inspected from release to termination.
  Their top-down rows show self-propulsion and an ordered alternating wake,
  not background advection. The prefill separates from the comparison route
  by the middle frames and descends toward the target earlier. Both oblique
  rows retain coherent three-dimensional Lambda2 structures through capture;
  neither shows a prewarm artifact or gross wake breakdown.
- Trace cross-check: the common projection removes all `1686/10028` exact
  action-clamp contacts, retains zero angle contacts, changes peak acceleration
  from `30.0` to `29.726`, and lowers peak planar force/yaw moment from
  `0.02218/0.01034` to `0.01883/0.00979`. This is a useful coordination
  mechanism, not evidence for raising drive gains.
- A remaining route-level defect is visible in normalized body-frame
  kinematics: despite capture, the assigned prefill's velocity/target course
  error is about `0.95` at `2T`, stays near `0.68--0.74` through `12T`, and is
  still about `0.95` near `26T`. Its large redirect is demanded only by
  bearing, which remains below the `0.45` redirect threshold through most of
  that early interval. Thus the calibrated cruise selector sees the bad course
  but cannot recruit the already successful two-joint redirect.

## Policy hypothesis

Add one smooth course-error demand channel to the existing observation-gated
redirect. The new gate uses only bounded body-frame course error and its
existing speed observability weight; it combines with, rather than replaces,
the bearing gate. The existing turn-side calibration and yaw/bend response
release remain unchanged. This is intended to make a transient coordinated
turn available when translation clearly points away from the target line,
then return to the evaluated traveling carrier once the measured response is
adequate.

Falsify the candidate if it suppresses the coherent alternating wake, loses or
delays capture relative to `26.296T`, increases angle/speed/acceleration
contacts or peak loads, or merely reproduces the same high-course-error arc.
Because the current worker has no post-edit CFD, no improvement from this
candidate is claimed here.

```text
bookshelf_consulted: true
source_domain: biological and robotic-fish burst turning
source_mechanism: C-start-style bounded redirect with observation-based release
transferable_invariant: large observed directional error can temporarily recruit coordinated curvature, and measured turn response should release it back into a propulsive rhythm
nontransferable_details: species-specific body envelopes, published gains, prescribed timing, exact vortex phase, and task-specific routes
policy_translation: smoothly combine normalized body-frame course-error demand, weighted by measured translation, with the existing bearing redirect; retain two-joint state feedback and yaw/bend release
falsification: reject if capture or wake coherence is lost, the early course error persists, or actuator-limit residence and force/moment loads increase
```
