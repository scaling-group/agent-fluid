# Translational line-of-sight response candidate

## Evidence diagnosis before the policy edit

- The assigned parent and all four sampled evaluations satisfy the frozen
  direct-uniform still-water contract: `U_infinity=(0,0,0)`, no cylinders or
  prewarm, finite dynamics, and capture. Motion is self-propelled rather than
  advected. Three sampled policies and the inherited evaluated parent are
  byte-identical forward-speed-gated posterior-emphasis controllers at
  `15.977511T`, `0.744403L`, distance integral `1.928581L`, score
  `-0.045506`, and `238` moving-window shifts. The distinct comparison is a
  carrier-demodulated line-of-sight controller at `16.054371T`, `0.745846L`,
  `1.929840L`, `-0.046900`, and `239` shifts.
- I inspected the strongest and weaker combined keyframe sheets from release
  through termination. Their top-down rows show the release disturbance
  developing into a coherent alternating lateral wake while both fish follow
  nearly the same target-directed arc. Their oblique body/Lambda2 rows show
  compact three-dimensional caudal structures without collision, wake
  collapse, boundary approach, or out-of-plane instability. The weaker
  rollout is therefore an informative finite capture, not a different failure
  topology. Both sheets agree with the distance histories and finite
  force/moment traces.
- The inherited log falsifies the parent's startup-thrust explanation. The
  speed-gated branch delays the `8L/6L` crossings by `0.0165/0.0110T`, leaves
  `4L/2L` unchanged, and advances only `1.25L/0.9L` by `0.0385/0.0880T`.
  It also raises mean posterior command from `24.5845` to
  `25.4727 rad/T^2`, exact acceleration-limit residence from `21.79%` to
  `22.58%`, and peak lateral force from about `0.03239` to `0.03334`.
  Preserve its replicated terminal route benefit, but do not tune its speed
  thresholds or wave gain as if more startup tail amplitude were established
  propulsion recovery.
- Trace reconstruction exposes a distinct terminal ambiguity. In the weaker
  policy below `0.9L`, target-signed body rotation and center translation both
  accompany reopening; the direct body-frame translational line-of-sight rate
  remains `+0.79` to `+0.94 rad/T` and has the same sign as the positive
  bearing. In the sampled-best parent, the current net-bearing damper activates
  through most of the same interval because bearing and measured bearing rate
  are both negative, yet the kinematic translational rate is positive while
  bearing is negative: translation is already closing the angular miss. Only
  the final two samples reverse to `-0.028` and `-0.068 rad/T`, when
  translation actually begins reopening the negative bearing. Thus net
  bearing rate conflates useful target-relative translation with body yaw and
  beat-scale head motion on the selected parent.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and wake-interaction disturbance rejection
source_mechanism: preserve the rhythmic carrier and slow target-directed mean turn while applying bounded residual correction only to a measured response component that worsens the route
transferable_invariant: separate target-relative translational drift from body rotation and carrier motion, then oppose only drift that increases absolute line-of-sight error inside a reliable closing corridor
nontransferable_details: published CPG gains, dimensional frequencies, species-specific kinematics, exact Karman phases, cylinder-wake routes, task coordinates, and fixed burst timing
policy_translation: retain the evaluated oscillator, speed-gated posterior wave, route redirect, yaw residual, approach scheduling, and actuation allocation; replace only the near-capture net-bearing-rate input with the normalized kinematic line-of-sight rate computed from body-frame target displacement and body velocity, gated to reopening translation
falsification: reject if capture, coherent two-view wake, pre-corridor milestones, distance integral, final crossing, limiting, or force envelope regresses; also reject as trajectory-equivalent if the new gate changes no feasible posterior commands

## One candidate hypothesis

Produce exactly one candidate by changing the existing terminal response
damper from net body-frame bearing rate to translational line-of-sight rate.
For a stationary target, the signed rate induced by center translation is the
body-frame cross product of target displacement and velocity divided by
target distance squared. Normalize it by the carrier frequency, and use the
existing bounded curvature and rate scale only when its product with bearing
is positive. This is a semantic feedback change, not a scalar gain sweep.

The middle-approach carrier-demodulated response, the sampled positive
speed-gated branch, and every established navigation and allocation role stay
unchanged. The falsifiable expectation is that the controller stops damping
translation that is already shrinking angular miss, retains a final
correction when translation truly reopens it, and changes feasible posterior
action only inside the reliable closing capture corridor. No same-worker CFD
result is claimed; formal evaluation occurs after exit.

## Non-CFD verification after the edit

- Candidate SHA-256 is
  `d00a50a69b73ad9f1217c17bd7db6b997f8193909b79db0cb56b47e59dbf764b`;
  it differs materially from the sampled and assigned parent.
- Parent-trace replay changes `14` posterior commands, all below or inward of
  the effective acceleration clamp, only from `15.823509T`/`0.899844L` through
  `15.977511T`/`0.744403L`. Maximum absolute command difference is
  `1.586205 rad/T^2`, so the edit has response support and is not a rejected-
  command wrapper. This offline replay is not a new hydrodynamic outcome.
- The lightweight Julia contract returns two finite accelerations. Static
  schema validation resolves all `51` direct `params.FIELD` references against
  the `51` fields returned by `target_policy_params()`, and three cruise/near-
  capture probes preserve reflection-equivariant outputs.
- Guidance materiality and solver editable-boundary checks pass. The first
  guidance run exposed the rendered `README.md` marking the same assigned
  parent twice; retaining one authoritative marker and removing only the
  duplicate repaired that metadata defect.
- The configured `.codex/agents/check-runner.toml` was invoked, but its pinned
  `gpt-5.4-mini` model is unavailable for this account. Its three prescribed
  non-CFD commands were run directly and separately; all pass. No CFD was run.
