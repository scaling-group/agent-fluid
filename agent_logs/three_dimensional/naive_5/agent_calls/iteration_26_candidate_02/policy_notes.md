# Collision-cone redirect re-entry

## Evidence diagnosis before editing

- All four sampled rollouts satisfy the frozen direct-uniform still-water
  contract: `U_infinity=(0,0,0)`, no cylinders, no prewarm, stable dynamics,
  and inertial moving-window transport. All capture at `26.2955T`; three
  byte-match the assigned posterior-modulation policy and capture at
  `0.748829L`, while the no-terminal-modulation control captures at
  `0.749242L`.
- The strongest sample and the informative mechanism control were inspected
  in both rows of their combined keyframe sheets. The top-down vorticity views
  show genuine self-propulsion from rest, an organized alternating wake
  through `24T`, and the same late correct-sign hook into the capture circle.
  The oblique Lambda2 views show a compact, connected three-dimensional wake
  along that route. Neither view shows imposed advection, wake breakup,
  boundary interaction, or moving-window yaw.
- The posterior lag modulation first separates from its no-terminal control
  at about `24.563T`, moves the centerline by at most `0.000591L`, leaves the
  visual topology unresolved, and does not change arrival. Inherited notes
  report the same peak joint state and planar force/yaw-moment envelope
  (`0.77236 rad`, `4.51281 rad/T`, `29.72585 rad/T^2`, and
  `0.018834/0.009789`). Its small scalar edge therefore meets its prior
  falsification boundary and is not evidence for more terminal phase-lag gain.
- The common route supplies an earlier geometric defect that the terminal
  allocation cannot repair. At about `4.05L` range its velocity predicts a
  `1.35L` miss; near `2.96L` it still predicts `1.19L`. Bearing magnitude then
  grows from about `0.37` to `0.44`, `0.56`, and `0.67 rad` as distance falls
  through `4.05`, `2.96`, `1.90`, and `1.37L`. At capture the course cross
  ratio is about `0.94`, projected miss is `0.705L`, transverse speed is about
  `0.61L/T`, and closing speed only `0.22L/T`. The fish therefore crosses the
  radius shallowly after a persistent middle-approach miss, rather than losing
  propulsion or suddenly acquiring a terminal disturbance.
- Earlier inherited evidence rejects static depth, terminal pulses, damping,
  reverse-wave braking, additional anterior or posterior terminal allocation,
  and a binary instantaneous projected-intercept hold. It does not test a
  continuous, add-only re-entry into the already successful two-joint redirect
  when both projected miss and bearing divergence persist before the terminal
  corridor.

## Policy hypothesis

Preserve the capture-proven traveling-bend carrier, line-of-sight response,
large-bearing redirect, coordinated acceleration envelope, and angle/rate
viability guards. Remove the falsified capture-only posterior lag modulation.
Add one bounded collision-cone re-entry: over a normalized middle-to-near
distance window, smoothly blend toward the existing same-sign two-joint
redirect only when projected miss remains outside the capture-scale cone,
positive closing speed is established, and body-frame bearing continues away
from zero. The new request fills only authority not already supplied by the
large-bearing redirect, so it cannot scalar-strengthen a saturated redirect;
converging bearing or an intercept inside the cone releases immediately back
toward the evaluated carrier.

This is deliberately different from the failed intercept hold: it adds a
continuous reorientation request instead of using one velocity projection as a
binary reason to suppress steering. The formal rollout should change the route
before `1.75L`, reduce projected miss or deepen capture, and retain the
coherent two-view wake and zero limit contacts. Reject the mechanism if it
loses capture, starts outside the configured approach window, causes a load or
limit regression, preserves the same milliscale route cluster, or over-turns
despite bearing convergence. The new CFD evaluation occurs only after this
worker exits and is not claimed here.

bookshelf_consulted: true
source_domain: biological C-start redirection and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: a large observed route error triggers bounded curvature and measured response releases the swimmer into its propulsive rhythm
transferable_invariant: reorientation authority should be added only while normalized geometric miss persists and observed target bearing is still diverging, then yield continuously to the productive carrier
nontransferable_details: published gains, dimensional timing, species-specific C-start shapes, robot joint geometry, exact vortex phases, and task-specific routes
policy_translation: use body-frame target and velocity to form projected miss, body-frame bearing history for divergence, positive normalized closing speed, and joint-state feedback to blend toward the existing two-joint redirect within a distance gate
falsification: reject if the action changes outside the approach gate, capture or coherent wake structure is lost, the route remains milliscale-equivalent, bearing convergence still increases redirect authority, or joint contacts and force/moment exposure rise

## Non-CFD implementation audit

- The required checker agent was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable for this account. Its three configured commands were run
  directly and separately: the notes/guidance semantic-delta and parameter-
  schema check, finite Julia policy contract, and solver editable-boundary
  check all pass. No CFD was run.
- A frozen-state comparison against the assigned rollout changes 550 of 4,781
  action rows. The first change occurs at `4.468L`, no action changes outside
  the `4.5L` approach gate, and the maximum two-joint command delta is about
  `7.81 rad/T^2` near `2.98L`. This confirms a materially testable earlier
  mechanism rather than claiming a rollout improvement.
- A deterministic grid of 540 finite states confirms bounded two-joint output
  and exact lateral reflection equivariance. The rendered `README.md`
  duplicated the assigned-parent marker; only that duplicate metadata entry
  was removed so the mandated semantic checker could identify one parent.
