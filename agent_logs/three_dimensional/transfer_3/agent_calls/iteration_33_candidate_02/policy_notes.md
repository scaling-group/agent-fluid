# Course-supported outer mean-curvature redirect candidate

## Evidence and visual diagnosis before the policy edit

- All four sampled evaluations satisfy the Phase-2 flow contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite moving-window dynamics, and `capture`
  termination. They all reproduce the same `v40` trajectory at
  `19.684490 T`, score `-0.261384287`, mean/final distance
  `2.151092787 L`/`0.748302400 L`, and no joint-angle stop dwell. Three
  policies are byte-identical and the nominally different course-worsening
  policy is behaviorally dormant.
- I inspected the complete combined sampled keyframe sheet from release to
  capture. The four combined, top-down, and oblique sheets are independently
  byte-identical, so this inspection covers both the strongest finite sample
  and the dormant-policy failure contrast. The fish visibly self-propels from
  direct-uniform quiescent water along a compact target-directed arc. It sheds
  a coherent alternating posterior wake in the top-down row and retains
  finite localized Lambda2 structures in the oblique row. There is no passive
  advection, loop, collision, boundary-exit precursor, wake collapse,
  out-of-plane excursion, or instability. Visual identity confirms that the
  added course/yaw branch supplies no mechanism evidence despite retaining a
  good result.
- The assigned-parent logs provide the informative active failure. A bounded
  outer phase-lag governor altered most outer commands by at most
  `0.7072 rad/T^2`, but changed the compact `12.9511 L` path into a
  `31.0127 L` orbit, delayed capture to `46.145020 T`, and regressed score and
  mean distance to `-0.915605503` and `2.857986094 L`. It retained finite
  loads and propulsion, so posterior phase is a mean-course determinant here,
  not an isolated feasibility knob. The current candidate must not modify the
  derivative-defined posterior lag.
- Completed terminal tests also close the late allocation locus: extra posture
  during outward response, extra carrier during outward response, extra
  posture during decreasing coupled posture error, and common-ratio clipping
  allocation all preserve capture but regress arrival or distance. The
  repeatedly reproduced `v40` center-intercept posture handoff should remain
  exactly unchanged for equal states at or below `4 L`.
- Reconstructing body-frame target, center-course, seven-sample closure/yaw,
  and current limiter signals on the `3579`-state `v40` trace identifies a
  different outer locus. On `219` startup states from about `12.328` to
  `9.858 L`, translational miss is large and has the same correction sign as
  target geometry, while the existing large-angle redirect is off and
  clipping-direction distortion is low. Before the final smooth taper to zero
  at the large-angle threshold, the normalized screening support is
  response-varying (`0` to about `0.847`, mean `0.115` on active states) and
  is absent below `9.858 L`, rather than being another distance-only gain or a
  terminal allocator.

## Policy hypothesis

Preserve the evaluated `v40` state-feedback oscillator, fixed posterior lag,
target guidance, direction-conditioned coupled limiter, geometry/course
target-residual allocation, closure preview, center-intercept corridor,
terminal posture, and command cap. Add one small course-supported outer
mean-curvature redirect before final command allocation. The new support
requires all of the following normalized observations to agree: range above
the protected terminal band, non-negligible center translation, a severe
constant-velocity course miss, target geometry and signed course correction
with the same sign, target angle below the already active large-angle redirect,
and low command-direction distortion from independent clipping. It reuses the
existing geometry-owned redirect sign and bend targets and may contribute at
most ten percentage points of redirect weight; it never changes posterior lag
or creates a beat-side command.

This tests an independently gated steering mechanism rather than scalar-only
gain tuning. The expected effect is an earlier useful mean-course correction
during startup without disturbing the coherent traveling bend, the established
midcourse allocator, or the quiet terminal handoff. Falsify it if the branch is
dormant or effectively constant, acts at or below `4 L`, stacks materially
with clipping-direction or large-angle redirect authority, changes posterior
lag, delays or loses capture, worsens distance integral, creates a loop or
boundary exit, adds joint-stop dwell or material loads, destabilizes the
rollout, or degrades either wake view. The new CFD evaluation occurs only
after this worker exits and is not claimed here.

bookshelf_consulted: true
source_domain: robotic-fish target-direction control and mean-curvature or tail-beat-bias turning
source_mechanism: add a bounded low-frequency bend bias to an established propulsive rhythm when sensed route error calls for turning
transferable_invariant: when a coherent traveling bend already propels the swimmer, correct an evidenced translational course error with a small geometry-signed mean-curvature bias while preserving the wave phase relation and avoiding competing actuator-allocation regimes
nontransferable_details: published gains, dimensional cadence, species-specific kinematics, full-body envelopes, exact beat or vortex phase, actuator models, target coordinates, capture radius, and task-specific routes
policy_translation: use normalized body-frame target geometry and center-course miss to admit a bounded share of the existing two-joint redirect equilibrium only above the terminal band, only below the large-angle redirect threshold, and only when clipping-direction allocation is inactive
falsification: reject on dormant or overlapping activation, action in the protected terminal regime, altered posterior lag, slower or lost capture, worse distance integral, looping or exit, joint-stop dwell, material load growth, instability, or degraded top-down or oblique wake coherence

## Non-CFD implementation audit

- Replaying the evaluated `v40` and final candidate on all `3579` recorded
  `v40` states changes `220` commands, with maximum component difference
  `1.408632 rad/T^2`. Every change is confined to the startup interval from
  `12.3277` to `9.8581 L` (`0.0110--8.0300 T`), and all `772` sampled states
  at or below `4 L` remain exactly identical. Since all four sampled
  trajectories are identical, this also establishes equal-state selectivity
  on every current sample; it does not establish a changed coupled rollout.
- A deterministic `1,285,956`-state grid spans range, target angle, course
  offset, translation speed, both joint positions and velocities, closure,
  and yaw rate. All candidate outputs are finite and within the declared
  command cap. The mechanism changes `40,452` states by at most
  `2.671001 rad/T^2`; no state at or below `4 L`, with zero translation speed,
  at or above the existing `0.32 rad` redirect threshold, or with disagreeing
  course/geometry signs changes. This verifies boundedness and the intended
  complementary gates, not CFD improvement.
- The deterministic schema audit resolves all `89` direct `params.FIELD`
  references against the `90` fields returned by `target_policy_params()`;
  only the version label is intentionally unused. The lightweight Julia
  public-contract check returns exactly two finite accelerations, and the
  solver edit-boundary check passes.
- The prescribed check-runner was invoked after the material edits, but its
  pinned `gpt-5.4-mini` model is unsupported on this ChatGPT account and
  failed before executing a command. Its three configured non-CFD commands
  were then run directly and separately: the material-guidance, Julia policy
  contract, and solver-boundary checks all pass. The guidance check initially
  exposed two identical assigned-parent markers in the rendered root
  `README.md`; removing only the duplicate marker restored unambiguous parent
  resolution. No formal CFD was run in this workspace.
