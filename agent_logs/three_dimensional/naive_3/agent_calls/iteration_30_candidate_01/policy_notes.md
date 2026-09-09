# Terminal rear-crossing selector candidate

## Evidence diagnosis before the policy edit

- All four sampled evaluations satisfy the frozen Phase 2 contract: direct
  uniform initialization with `U_infinity=(0,0,0)`, no cylinders or prewarm,
  finite dynamics, and `horizon` termination at `100T`. I inspected both the
  top-down mid-plane-vorticity and oblique body/Lambda2 rows in every combined
  keyframe sheet. The fish are self-propelled, retain coherent alternating
  planar wakes and compact three-dimensional wake structures, and execute
  repeated return loops. Passive advection, wake collapse, collision, domain
  exit, and numerical instability do not explain the misses.
- The assigned parent's continuous course hold is the strongest sampled
  finite result: `1.241/4.158/2.082L` minimum/mean/final distance, about
  `0.47T` inside `1.25L`, and a tight coherent return loop. At its late minimum
  (`97.092T`), speed is about `0.669U`, target-ray/course error is `1.692 rad`,
  course dot is `-0.121`, the target-forward projection is about `-0.855`, and
  useful yaw is only about `0.13 rad/T`. The target is therefore behind while
  the powered course remains nearly tangential.
- The three sampled descendants are concrete negative results. An ungated
  anterior response burst reaches only `2.125/3.901/3.601L`; the same burst
  gated to target-behind geometry reaches `1.987/3.887/3.522L`; and a
  joint-state posterior stroke reaches `1.622/3.964/3.799L`. All retain finite
  coherent wakes and the horizon class but displace the parent's useful close
  return. At the descendants' minima both joints are nearly parked in a common
  negative C-bend, whereas the parent reaches its minimum with an active
  anterior wave (`phi_dot_1` about `-0.260 rad/T`) and modest unclipped
  commands. More response-burst magnitude, posterior stroke release, scalar
  drive relief, or another distance/radius adjustment is not supported.
- The parent's recovery direction is selected from instantaneous lateral
  target side even after the target is behind; its added course reserve uses
  the persistent target-ray/course error. Those selectors can disagree when
  the target crosses the rear centerline. The descendant failures changed
  authority but did not test whether this direction disagreement sustains the
  terminal orbit.

## Policy hypothesis

Preserve the parent's oscillator, bearing curvature, posterior brake and lag
modulation, full-direction C-turn engagement, course-response reserve,
terminal course hold, wave envelope, all curvature magnitudes, and command
limit. Change one selector only: under the existing terminal-response weight,
blend the base C-turn direction from lateral target side toward the signed
target-ray/course error already used by the response reserve. Outside the
terminal region the candidate is effectively the parent; near a rear crossing it
keeps the turn consistent with translational course instead of adding static
curvature or changing propulsion.

Support requires preservation of the coherent first return plus capture, a
pass below `1.241L`, longer near-target residence, or a smaller terminal loop
with improved final/mean distance and comparable clamp/load residence. Reject
if the first return changes materially, the wake curls or stalls, action-limit
residence rises, or the same noncapturing powered orbit remains. If the lateral
and course selectors already agree throughout the terminal encounter, a
negligible coupled change also falsifies the proposed rear-crossing mechanism.

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking
source_mechanism: body-relative direction feedback modulates a maneuvering rhythm while retaining the posteriorly emphasized propulsive wave
transferable_invariant: keep propulsion and steering magnitude intact while resolving maneuver direction from the persistent motion-to-target error when instantaneous target-side geometry becomes ambiguous
nontransferable_details: robot-specific CPG gains, dimensional beat frequency, full-body joint count, published paths, exact vortex phase, capture radius, target coordinates, and clocked maneuver stages
policy_translation: the existing normalized body-frame terminal weight blends lateral target-side direction toward signed target-ray/course error within the two-joint C-turn; no world coordinates, time, hidden state, new gain, or route is introduced
falsification: reject if the first return, wake coherence, or load margin degrades, if near-target distance statistics do not improve, or if replay shows no terminal disagreement between the two direction selectors
```

## Evaluation boundary

The coupled CFD outcome is unavailable until this worker exits. Frozen-trace
replay and dry checks can establish selector locality, boundedness, reflection
equivariance, and parameter ownership, but cannot establish hydrodynamic
improvement.

## Implemented candidate and non-CFD probes

The candidate makes the one proposed selector change and introduces no new
parameter or authority. The convex direction blend is applied only by the
existing terminal-response weight; maximum mean, response, and redirect
curvatures, oscillator, posterior equilibrium and wave, phase modulation,
brake, and `+/-28 rad/T^2` command reserve are unchanged. It contains no time,
step count, mutable state, world coordinate, target identity, route, or file
access.

Frozen replay over all `18182` completed parent states finds real terminal
selector disagreement: inside `1.8L`, the absolute lateral-side versus
course-direction difference has mean/maximum `0.101/0.490`. Corresponding
candidate-parent maximum-joint action change is only `0.000737/0.0240 rad/T^2`
mean/maximum beyond `3L`, but `3.627/10.597 rad/T^2` inside `1.5L`. At the
parent's minimum, frozen action changes from about `(0.970,0.868)` to
`(-0.991,-1.814) rad/T^2`. This establishes an effectively unchanged far
carrier and a material near-field direction test; it does not predict the
coupled trajectory.

All `44` direct parameter references are returned by
`target_policy_params()`. Full parent-trace replay is finite and within the
declared command reserve, a mirrored terminal state negates both actions to
less than `1e-10` residual, the lightweight Julia policy contract passes, and
the solver editable-boundary check passes. The required guidance comparison
also passes after removing a duplicate rendering of the same assigned parent
from `README.md`. No formal CFD was run.
