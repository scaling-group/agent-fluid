# Controlled replication of response-aware posterior handoff

## Visual and diagnostic evidence before the policy edit

- All four sampled rollouts are valid direct-uniform still-water releases:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, stable moving-window
  transport, and `capture` termination. Their top-down sheets show genuine
  self-propulsion with coherent alternating vorticity, while the oblique sheets
  show compact three-dimensional Lambda2 structures following the body without
  collision, wake breakup, or instability. All retain the same useful late-hook
  capture topology, so this iteration concerns trajectory allocation rather
  than a missing propulsion or success mechanism.
- The best finite response-aware handoff (`solver_a47435301f18`) and the most
  informative weaker exact base repeat (`solver_b5fc80fd779c`) were compared in
  both rows from release to termination and cross-checked against their metrics,
  diagnostics, and trajectories. The response-aware sample captured at
  `19.338T`, distance integral `2.07622L`, score `-0.18691`, and head path
  `12.304L`; the weaker base repeat captured at `19.613T/2.09432L/-0.20493`
  with a `12.554L` path. Both have coherent wakes and the same approximately
  `0.025/0.013` peak planar-force/yaw-moment class.
- The response gate has the intended nonterminal signature when also compared
  with the better exact base run (`solver_2dfe05597921`). It retains the early
  `6L` milestone (`12.282T` versus `12.293T` and `12.381T` for the base pair),
  reduces mean absolute `2--4L` body-frame course error to `0.289 rad` from
  `0.347/0.441 rad`, reduces lateral speed there to `0.196U` from
  `0.230/0.250U`, and shortens head path from `12.416/12.554L` to `12.304L`.
  It preserves zero joint-angle-limit residence and the common load class, but
  raises mean anterior command to `18.45` from `18.26/18.08 rad/T^2` and still
  touches the joint-rate limit.
- The nominal improvement is not yet causal evidence. The response-aware
  sample improves the integral by only `0.00270L` over the better base run,
  whereas the byte-identical base pair spans `0.01541L`, `0.258T`, `0.138L` of
  head path, and `0.01525` of score. The inherited wrong-sign-yaw bend repeats
  likewise span `19.360--19.591T/2.08911--2.09637L`. This execution variation
  rules out composing another mechanism or tuning the response scalar from one
  favorable rollout.

## One-candidate hypothesis

Exactly replicate `solver_a47435301f18`: preserve the complete capture-proven
far-amplitude/near-lag scaffold and, only inside its existing `6--4L` handoff,
advance release toward posterior lag when the bounded body-frame turn request
and normalized measured yaw agree. The signed-product gate is reflection
equivariant, adds no mean curvature or actuation gain, cannot affect the far
field, and continuously returns to the original distance schedule when the yaw
response is absent or opposed. No scalar, endpoint, redirect, or terminal bend
is changed, so the evaluation is an exact replication rather than a stacked
architecture test.

Support requires another coherent capture that retains the early milestone and
the lower middle-field course error, lateral speed, and path without worsening
command residence, joint/rate margin, or the common load class. A repeat
integral below the base pair's `2.07892--2.09432L` envelope would provide the
clearest positive evidence. Falsify the mechanism if the repeat returns to that
envelope without a compensating path/slip benefit, loses early progress, raises
effort or loads, or changes capture/wake coherence; then restore the simpler
distance-only handoff and do not tune another response gain on this release.

bookshelf_consulted: true
source_domain: biological C-start response release and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: release a bounded redirect into an established traveling rhythm once measured yaw aligns with observed turn demand
transferable_invariant: use normalized agreement between body-frame route demand and measured yaw response to release turn-biased wave allocation continuously without a clock or route state
nontransferable_details: species-specific C-start kinematics, published gains, dimensional timing, robot-specific envelopes, clock phase, exact vortex phase, world coordinates, and task-specific routes
policy_translation: within the existing normalized-distance handoff, use positive turn-request/yaw agreement to advance posterior allocation from amplitude asymmetry toward the already sampled lag asymmetry under the unchanged two-joint acceleration contract
falsification: reject unless exact replication preserves capture and coherent wakes while confirming middle-field path and slip benefits beyond execution variation without worse timing, integral, effort, joint margin, or loads
