# Phase-demodulated redirect candidate

## Evidence diagnosis before editing

Only `solver_c61359212990` is sampled in this workspace, so it is both the
best finite example and the informative failure; there is no independent
successful rollout to compare. It is a valid direct-uniform still-water run
(`U_infinity=[0,0,0]`, no prewarm), is not numerically unstable, and exits the
lower virtual boundary at `27.49T`.

No inherited `logs/optimize/` evidence was present. The assigned parent
guidance therefore supplies the durable prior to preserve useful propulsion
and prefer bounded normalized body-frame feedback; the sampled rollout below
is the only behavioral evidence used to specialize that prior.

The top-down row shows self-propulsion rather than advection: a coherent
alternating wake grows from release through `8T` and remains strong while the
fish advances. By `16T` the path is already below the target corridor, and by
`24T` to termination the fish translates almost vertically downward rather
than recovering toward the target. The oblique Lambda2 row confirms compact
three-dimensional alternating structures and an intact swimmer, not a
collision or loss of wake coherence; its trajectory line bends away from the
world target in the same late interval.

The scalar and trajectory evidence agree. Distance falls from `12.33L` to
`4.78L` at `17.85T`, then rises to `9.71L`; the final center is
`(12.19,0.80)L`. The dominant failure is course control, not propulsion. The
raw requested accelerations exceed the `1800 deg/T^2` envelope on about 71%
of joint-1 samples and 78% of joint-2 samples, while joint-speed clipping is
also visible. More importantly, the inherited controller estimates
`bearing_window_rate` and `turn_rate_recent` over only the last seven CFD
steps (about `0.04T`). Those signals follow within-beat body yaw: offline
replay of the recorded states produces saturated rate corrections of roughly
`+/-1.25` while heading oscillates by about `0.5 rad` from one beat phase to
another. This is not a reliable mean-course estimate. During the late failure,
the target request is persistently negative, yet the beat-mean body heading
drifts positive from about `0.8 rad` near `15T` to `1.28 rad` near `25T`, so
the inherited rate loop and curvature actuator do not arrest the wrong-course
translation in 3D.

## Policy hypothesis

Preserve the evidenced traveling-bend carrier and replace the short-window
bearing/yaw-rate controller with a joint-phase-demodulated redirect primitive.
A one-cycle moving-average audit of the inherited trajectory gives
`mean_theta - theta = 0.505 phi1 + 0.140 phi2` (correlation `0.997`, residual
`0.015 rad`). Rotating the normalized body-frame target vector by the bounded
joint-state estimate `0.50 phi1 + 0.14 phi2` therefore approximates its
beat-mean body frame without time, memory, or world coordinates. On the
recorded trajectory, this corrected bearing changes sign only twice versus 32
times for raw bearing. Drive a bounded, reflection-symmetric mean-tail
curvature from that corrected line of sight, reverse the inherited curvature
sign because sustained positive mean tail tangent accompanies the measured
wrong-way positive heading drift after `15T`, and reduce cadence continuously
while the corrected target error is large. The next CFD evaluation should
falsify the hypothesis if the candidate does not improve on `4.78L`, still
exits through the lower boundary without a meaningfully different trajectory,
loses the coherent wake, or continues persistent hard-envelope clipping during
large-error redirect.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop direction tracking and wake-interaction control
source_mechanism: phase-state-modulated rhythmic propulsion with slow route guidance separated from fast alternating yaw disturbances
transferable_invariant: steer the mean swimming course from persistent target geometry after removing the joint-phase-correlated component of beat-synchronous body yaw
nontransferable_details: published CPG gains, species kinematics, dimensional cadence, exact vortex phase, and task-specific routes
policy_translation: rotate the normalized body-frame target by a bounded joint-state estimate of mean heading, map the corrected line of sight to symmetric mean-tail curvature, and allocate cadence away from propulsion during large observed redirect error
falsification: reject the transfer if target progress or termination class does not improve, the late course remains downward, propulsion coherence collapses, or redirect commands remain persistently clipped

## Lightweight counterfactual check after editing

This is not new CFD evidence. Replaying the completed parent's recorded states
through the candidate leaves the phase-demodulated bearing positive throughout
the trace (zero sign changes), bounds the turn command to `[0.02,0.99]`, and
reduces raw hard-acceleration-envelope exceedance from about `71%/78%` to
`37%/57%`. The remaining exceedance is a reason to inspect the next evaluated
joint history, not a same-worker improvement claim.
