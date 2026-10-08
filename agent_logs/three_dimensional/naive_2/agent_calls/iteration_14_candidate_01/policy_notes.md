# Joint-phase-demodulated yaw-response candidate

## Visual and metric diagnosis before the edit

- The four assigned examples all report direct-uniform still-water
  initialization with `U_infinity=[0,0,0]`, no cylinders, and no prewarm. I
  inspected the combined top-down/oblique sheets for the best-score sampled
  rollout (`5.126L` minimum, `20.86T` upper exit), the closest sampled failure
  (`4.530L`, `21.72T` upper exit), and the prefilled solver (`5.000L`,
  `20.52T` upper exit). Each top-down row shows sustained self-propelled
  leftward motion and an alternating vortex street; each oblique row retains
  tail-connected three-dimensional Lambda2 structures. The intact wakes and
  finite loads through exit make route response, not propulsion collapse or
  advection, the common failure.
- The inherited actuator-calibrated yaw-response mechanism remains the useful
  carrier. Its full-wave rollout reached `2.299L` and survived to `28.41T`;
  response-deficit posterior half-cycle relief improved the minimum to
  `2.169L`, the final distance from `8.092L` to `7.727L`, and near-limit
  acceleration residence from about `55.0%` to `52.4%`, with comparable peak
  force/moment (`0.0335/0.0170`). It still passed above the target and exited
  through the upper boundary, so the phase-selective improvement is useful but
  incomplete.
- Two completed attempts to recruit more mean curvature near that miss are
  negative evidence. The additional anterior response center reached only
  `2.931L` and exited at `24.79T`. The assigned parent's closure-loss posterior
  burst reached only `3.254L` and exited at `25.05T`; it drove joint 2 to the
  `45 deg` hard limit and raised peak planar force/moment to approximately
  `0.0450/0.0206`, versus `0.0335/0.0170` for the `2.169L` tail-response
  controller. More static or terminal mean curvature is therefore not the
  supported next actuator mechanism.
- The reason to revise the feedback semantics is visible in the inherited
  minimum: at `18.453T`, instantaneous yaw is `-2.281 rad/T` while joint 1 is
  at `q1=-0.166 rad`, `q1_dot=+4.467 rad/T`. On the completed trajectories,
  least-squares fits of yaw to `(q1,q1_dot)` inside `6L` give angle
  coefficients `1.118--1.473`, velocity coefficients `-0.489---0.638`, and
  explain `93.3--99.7%` of yaw variance across all four assigned samples and
  four inherited rollouts. Thus the short-window yaw observation is primarily
  a beat-phase signal. Using it directly as slow request-versus-response error
  alternately recruits and releases steering within a beat even when the
  translational route has not changed.

## Single policy hypothesis

Start from the best completed response-deficit controller: preserve the full
anterior state-feedback oscillator, posterior lag, bounded mean curvature,
body-frame bearing/course/crossflow route, empirical opposite-sign mapping
from posterior curvature to physical yaw, approach-aware anterior course
redistribution, and response-gated opposing-half-cycle relief. Add one compact
mechanism before forming the yaw-response error: subtract the repeatable yaw
component reconstructed from the current anterior joint angle and velocity.
The resulting residual uses only normalized state feedback and is clock-free;
it estimates directional yaw after removing the carrier's dominant rhythmic
signature.

Use the phase-demodulated residual both in posterior mean tracking and in the
existing response-deficit half-cycle gate. This does not add mean curvature,
attenuate the whole wave, or copy a route. Expected behavior is a more
consistent route-response command over each beat, preserving the inherited
`2.169L` approach while sustaining corrective authority long enough to bend
the course downward or re-approach. Falsify the mechanism if the residual
remains strongly correlated with joint phase, the minimum exceeds `2.169L`,
the same upper exit persists without a materially different useful arc, or
wake organization, acceleration residence, force, or moment worsens.

An algebra-only replay with the candidate's fixed phase coefficients removes
`93.2--98.7%` of raw yaw variance inside `6L` across the same eight completed
histories and reduces yaw standard deviation from `1.46--2.00 rad/T` to
`0.19--0.43 rad/T`. This validates scale and repeatability of the observation
transformation only; it is not a counterfactual CFD or trajectory result.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and wake-control separation
source_mechanism: preserve a rhythmic carrier while feedback acts on measured directional response separated from fast oscillatory motion
transferable_invariant: compare route request with a body-relative response residual after removing the carrier-correlated component, and use that residual to modulate a distinct phase-selective steering channel
nontransferable_details: published gains, robot geometry, dimensional beat timing, species kinematics, exact vortex phases, maneuver duration, and task-specific routes
policy_translation: reconstruct the repeatable yaw carrier from normalized anterior joint angle and velocity, subtract it from measured yaw, then use the bounded residual in the established posterior yaw tracker and opposing-half-cycle response gate
falsification: reject if phase correlation remains, the inherited approach or connected wake degrades, loads or saturation increase, or no capture, re-approach, better termination, or meaningfully different targetward arc appears

## Evaluation boundary

No CFD result is claimed for this candidate. The later evaluation should
compare capture and termination first, then minimum distance, target-relative
trajectory topology, post-minimum re-approach, phase correlation of raw and
compensated yaw, acceleration residence, joint-limit contact, force/moment
peaks, and both wake views against the inherited `2.169L` controller.
