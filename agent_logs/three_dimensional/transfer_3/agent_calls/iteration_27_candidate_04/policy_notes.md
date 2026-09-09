# Phase-consensus redirect candidate

## Evidence diagnosis recorded before the policy edit

- All four sampled solver evaluations and the inherited recoil-conditioned
  evaluation satisfy the frozen contract: direct uniform still-water
  initialization with `U_infinity=(0,0,0)`, no cylinders or prewarm, finite
  dynamics, and capture. There is no termination failure in the current
  sample. I therefore compared the fastest finite capture with the slowest
  identical-hash capture and used the inherited recoil-conditioned result as
  the informative mechanism failure.
- I inspected every sampled combined keyframe sheet, plus the inherited
  recoil-conditioned sheet, from release through termination. Each top-down
  row shows body-led translation and a coherent alternating posterior
  vorticity street. Each oblique row independently shows compact shed
  three-dimensional Lambda2 structures following the swimmer. None shows
  passive advection, wake collapse, collision, looping, boundary approach, or
  numerical instability. Local-flow RMS is `0.01781--0.01815U`, so differences
  in this cohort are route/allocation effects rather than ambient transport or
  loss of propulsion.
- The helpful-moment amplitude residual is the strongest sampled base: capture
  at `18.6560T`, score `-0.13321`, mean distance `2.02115L`, acceleration-limit
  occupancy `40.74%/75.74%`, and force/moment RMS `0.01328/0.00691`. The exact
  actuator-consistent baseline hash captures at both `18.6725T` and
  `18.7385T`, so a `0.066T` timing change is unresolved by itself. The
  phase-demodulated moment residual reduces posterior occupancy to `74.14%`
  and loads to `0.01309/0.00682`, but worsens mean distance to `2.02337L`; this
  does not justify another moment allocator or scalar gain edit.
- The inherited candidate tested the proposed integral recoil correction by
  replacing raw bearing everywhere with
  `bearing + 0.82*phi1 + 0.12*phi2`. It still captures at `18.7825T`, but mean
  distance worsens materially to `2.05789L` and force/moment RMS rises to
  `0.01391/0.00728`, despite lower acceleration-limit occupancy
  (`38.04%/70.69%`). Its coherent wake confirms that the negative result is
  route distortion, not propulsive failure. On the best sampled trajectory,
  raw and recoil-conditioned bearings have opposite signs in about `29%` of
  samples; nevertheless, replacing the slow route angle with the conditioned
  value changes the entire trajectory from release. A fixed joint-angle
  projection is therefore not a trustworthy substitute for target geometry.
- The anterior burst path is a narrower place to test the same observation.
  Offline reconstruction on the best/base traces shows that using conditioned
  magnitude only for the bearing component of redirect recruitment would
  change the combined redirect weight by more than `0.05` in about `44--47%`
  of samples, while the raw-bearing/LOS-rate yaw request remains untouched.
  This is behaviorally distinct and does not depend on a small timing delta.

## Policy hypothesis recorded before editing

Start from the strongest finite helpful-moment residual and preserve its raw
normalized body-frame bearing/LOS-rate route, recoil-conditioned yaw-rate
response, response-reversing half-cycle steering, actuator-consistent
posterior phase path, traveling-bend carrier, and physical projection. Compute
the inherited joint-angle-conditioned bearing, but do not let it own the slow
route. Recruit the bearing-triggered anterior redirect only from the geometric
mean magnitude of raw and conditioned bearing when their signs agree; retain
the existing continuous LOS-response recruitment as the fallback. This makes
joint phase a reflection-invariant confidence signal for a transient burst,
not a replacement target angle. It should suppress anterior steering caused
only by carrier recoil while preserving the route and the proven wake.

Support requires capture with coherent top-down and oblique wakes, arrival
inside the inherited identical-hash `18.6725--19.0080T` band, mean distance no
worse than the sampled residual bound `2.02337L`, force/moment RMS no greater
than `0.01350/0.00703`, and a material change in phase-disagreement redirect
recruitment. Falsify the mechanism if capture is lost, the route repeats the
full-conditioning result above `2.05789L`, the response fallback cannot retain
the broad turn, loads exceed the baseline bound, or the new consensus gate is
behaviorally inactive. The current candidate's CFD outcome is not claimed in
this worker.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and wake-interaction control
source_mechanism: separate persistent target-route error from fast gait-correlated body recoil before recruiting a nonsteady redirect
transferable_invariant: preserve normalized target geometry as the slow route and use gait phase only to confirm a bounded transient steering channel while an independently observed response path remains active
nontransferable_details: published gains, species-specific joint envelopes, clock-driven phase, exact vortex timing, organized-wake synchronization, and task-specific routes
policy_translation: retain raw body-frame bearing and inertial LOS rate for yaw demand; use reflection-equivariant joint-angle-conditioned bearing only in a same-sign geometric-consensus gate for anterior redirect recruitment
falsification: reject if capture or wake coherence is lost, mean distance exceeds 2.02337L without a compensating semantic improvement, loads exceed 0.01350/0.00703, or the consensus gate does not materially change redirect recruitment
