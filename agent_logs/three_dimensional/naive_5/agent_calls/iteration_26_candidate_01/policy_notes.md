# Exact target-line response candidate

## Evidence diagnosis

The assigned parent is `solver_7f1d02b1e9e9`; `solver_27d0c0c038bc` and
`solver_168198d1e6b6` byte-match its policy and both visual sheets. All three
reproduce capture at `0.748829L` and `26.2955T`. The earlier
`solver_5de1fba6b9e8` omits only the terminal posterior-lag modulation and
captures at the same step at `0.749242L`. Its centerline differs from the
parent by at most `0.000591L`, although the logged action difference reaches
`0.4386 rad/T^2`. The top-down sheets show the same self-propelled, coherent
alternating wake, broadly straight target approach, and late upward turn into
the capture circle. The oblique Lambda2 sheets likewise show a compact,
spanwise coherent three-dimensional wake through the late turn, with no
visible instability or passive advection. Direct uniform initialization and
`U_infinity=0` are confirmed in every diagnostic.

The metric cross-check also makes the current comparison a negative result
for terminal scalar allocation: both distinct policies have identical sampled
joint extrema (`43.863/44.253 deg`, `258.565/258.259 deg/T`, and
`29.726/29.686 rad/T^2`) and identical peak planar force/yaw moment
(`0.018834/0.009789`). The parent's posterior modulation improves the shallow
boundary crossing by only `0.000413L`, below visual resolution, and supplies
neither a new route nor a new termination class.

## Policy hypothesis

The inherited response controller contains a more consequential semantic
opportunity. The episode defines forward as body `-x`, but constructs bearing
as `atan(target_y, abs(-target_x))`. Consequently its bearing rate has the
opposite orientation from the ordinary right-handed body target-ray angle
while the target remains in front. Adding that rate to body heading rate does
not reconstruct inertial line-of-sight rotation. Recomputing the parent trace
from the logged head, heading, and eight-sample observation window gives the
following existing-proxy versus exact target-ray rates in `rad/T`:

```text
time_T       existing bearing rate + yaw     exact target-ray rate
 7.9915                  +4.6676                       -0.0929
15.9940                  +1.2366                       -0.2119
20.9935                  -1.8253                       -0.0856
25.9930                  +1.6236                       +0.4218
26.2955                  -0.4159                       +0.7067
```

The candidate will replace only that navigation observation with the exact,
reflection-equivariant body-vector identity
`cross(target_body_L, target_body_window_rate_L) / distance_L^2 + heading_rate`.
The proven traveling carrier, redirect, positive response-deficit allocation,
and feasibility guards remain intact. The evidence-negative posterior terminal
modulation is removed rather than retuned. This tests whether geometrically
correct target-line feedback yields a meaningfully different useful route or
deeper capture while retaining the stable carrier.

Falsify the hypothesis if the exact rate reverses the calibrated useful turn,
loses capture, disrupts the coherent wake, increases limit/load exposure, or
only produces another subvisual fixed-pose perturbation. A successful fixed-pose
result would still need varied initial/target geometry before it establishes
robustness.

A no-CFD frozen-state audit on all `4781` assigned-parent samples confirms that
this is a distinct feedback test: the new observer changes `3331` commands,
including `2966` outside `1.75L`, with RMS/max two-joint command deltas of
`1.248/2.758 rad/T^2`. The candidate evaluates to finite bounded actions and
passes a reflected-state sign test. Those checks establish contract behavior,
not hydrodynamic improvement; only the later formal rollout can decide the
hypothesis.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and history-aware fish navigation
source_mechanism: sensory target feedback modulates a low-dimensional propulsive rhythm through a bounded residual rather than prescribing a route or waveform
transferable_invariant: derive steering response from correctly oriented target geometry over observed history while preserving the productive traveling carrier
nontransferable_details: published controller gains, species-specific joint envelopes, clock phase, exact vortex phase, and task-specific trajectories
policy_translation: use normalized body-frame target-vector position and windowed rate to reconstruct inertial line-of-sight rotation, then retain the existing positive-deficit anterior half-cycle channel
falsification: reject if capture or wake coherence is lost, actuator/load exposure rises, or the path change remains below visual and semantic resolution
