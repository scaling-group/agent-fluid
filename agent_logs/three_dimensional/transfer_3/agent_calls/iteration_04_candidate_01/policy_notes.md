# Phase-2 carrier rate-reserve candidate

## Evidence and visual diagnosis

- All four sampled rollouts are valid direct-uniform still-water evaluations
  (`U_infinity=0`) and terminate in capture. There is therefore no sampled
  failure to contrast with the strongest finite run; the comparison below uses
  the best parent-equivalent capture and the weakest capture.
- In both top-down and oblique rows, the parent-equivalent
  `solver_a1253ad45bc8` and weakest `solver_8945310ce86a` are self-propelled
  along the same smooth target-reaching arc. The top-down row shows a coherent
  alternating red/blue wake from release through the terminal turn; the
  oblique row shows bounded three-dimensional Lambda2 structures following the
  fish, with no visible advection source, wake breakup, boundary event, or
  instability before capture.
- The parent and closing-supported release variant are numerically identical:
  score `-0.53064634`, capture at `25.2615T`, and mean distance `2.431797L`.
  Thus recession release was inactive on this continuously closing approach.
  Two speed-gated terminal velocity-course residuals preserve capture but do
  not improve the integral: `solver_53c22b6c3b9c` scores `-0.53103485` with
  mean distance `2.4319998L`, and `solver_8945310ce86a` scores `-0.53176764`
  with mean distance `2.4327134L`. Their trajectories remain identical to the
  parent until the terminal mechanism activates near `4L`.
- Cross-checking the trajectories localizes the remaining measurable burden
  outside the successful terminal controller. Above `4L`, every sample has
  acceleration-cap incidence about `50.5%/40.3%`, both joint rates reach the
  `260 deg/T` limit, and joint 1 approaches `0.773 rad`. Inside `2.1L`, the
  parent has zero acceleration-cap incidence, mean speed remains about
  `0.647U`, and force/yaw-moment maxima fall to about `0.0029/0.0009` in the
  recorded normalizations. Additional terminal course curvature is therefore
  not the next evidenced need.

## Policy hypothesis

Preserve the captured body-frame geometry redirect and terminal carrier-to-
curvature reallocation exactly. Add one reflection-equivariant carrier
rate-reserve mechanism: normalize each observed joint rate by the owned
`260 deg/T` envelope, and smoothly attenuate only a carrier acceleration whose
sign would push that joint farther in its current direction near the rate
limit. Leave opposing acceleration untouched so reversal and steering braking
retain authority. This tests whether avoiding repeated hard rate contact can
retain the traveling posterior-lag wake while making the propulsive carrier
less limit-dominated; it is not a scalar cadence or curvature retune.

Falsification: reject the mechanism if capture is lost, arrival or mean
distance degrades materially, the top-down/oblique wake loses its coherent
traveling structure, far-field rate/cap occupancy does not fall, joint angle or
load peaks increase, or the terminal low-load capture topology changes. A
positive result in direct-uniform still water still would not establish wake-
disturbance rejection under imposed inflow.

bookshelf_consulted: true
source_domain: Lighthill-style reactive propulsion and sensor-modulated robotic-fish CPG control
source_mechanism: preserve a posterior-lag traveling bend while modulating a state-feedback oscillator with measured actuator state
transferable_invariant: propulsion should retain wave direction and posterior lag while bounded joint-state feedback preserves actuator authority instead of repeatedly demanding motion beyond the envelope
nontransferable_details: published gains, dimensional frequencies, species-specific amplitudes, full-body waveforms, exact vortex phases, and task-specific routes
policy_translation: keep the existing two-joint body-frame target feedback and posterior-lag carrier; apply a smooth per-joint rate-normalized outward-acceleration guard before the owned acceleration clamp
falsification: reject if capture, coherent wake, or terminal behavior changes adversely, or if far-field limit occupancy and loads fail to improve
