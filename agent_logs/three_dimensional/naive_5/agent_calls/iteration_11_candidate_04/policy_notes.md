# Bearing-divergence terminal-reflex candidate

## Visual and trace diagnosis before the edit

- Every sampled and inherited evaluation used contract-valid direct-uniform
  still water (`U_infinity=(0,0,0)`, no cylinders, no prewarm).  The top-down
  vorticity and oblique Lambda2 rows for the strongest finite examples show a
  body-attached alternating wake translating with the fish, so their target
  approaches are self-propelled rather than moving-window advection.
- The low-load `solver_8097d423c0eb` baseline makes the only evidenced broad
  downward approach to capture scale.  Its coherent wake persists through a
  `0.829828L` minimum at about `0.659L/T`, with peak planar force and yaw moment
  near `0.0214` and `0.00981`.  From about `1.0L` inward its course-error sine
  is already `0.91--1.00`, but the same-sign redirect settles toward a static
  bend while yaw falls.  Over roughly `26.4--27.6T`, the target bearing becomes
  more negative at about `0.1--0.4 rad/T` despite correct-sign positive yaw;
  at the minimum the projected miss remains about `0.81L`.  The missing
  capability is continuing dynamic steering when the measured line of sight
  is diverging, not detection of the miss or redirect sign.
- The combined sheets for `solver_4f3d51f38935` and the assigned-parent
  `solver_e7a7a878626e` retain essentially the same coherent approach and
  pass-by topology.  Unconditionally deepening the terminal redirect reaches
  `0.832836L`; qualifying a similar depth increment by positive closing speed
  reaches `0.827823L`, only `0.002005L` inside the `0.829828L` baseline and
  still outside capture.  At their minima both joint pairs have again nearly
  settled and the fish still moves near `0.66L/T` with an approximately
  `0.806L` projected miss.  This falsifies another static redirect-depth edit.
- Other inherited completed variants bound nearby alternatives.  Predictive
  redirect entry reaches `0.926872L`, a directionally phased posterior
  recovery pulse reaches `0.895724L`, and posterior approach damping reaches
  only `1.111481L` while terminal speed remains about `0.671L/T`.  The
  posterior-redistribution failure `solver_b6ed3f84ab58` visibly stays in the
  upper corridor, touches the angle boundary, and produces roughly tenfold
  larger force/moment than the low-load near-miss.  Thus neither earlier
  latching, posterior pulses, nor posterior damping is supported.

## Policy hypothesis

Recover the response-released, terminal-miss-vetoed `solver_8097d423c0eb`
controller unchanged outside the capture approach.  Add one new feedback
semantic: when the fish is still closing inside a short approach zone, the
projected miss is unsafe, and the signed history-window bearing rate says the
target is diverging on the requested turn side, restore a bounded anterior
half-cycle steering pulse on top of the otherwise settling redirect.  Joint-1
velocity supplies oscillator phase, and bearing-rate scaling by carrier
frequency makes the response dimensionless.  The reflex vanishes at range,
for a safe intercept, when bearing is converging, on the inactive beat half,
or after closing stops; it does not change posterior allocation or static
redirect depth.

The falsifiable expectation is that the far trajectory and coherent 3D wake
remain unchanged, while positive yaw no longer decays during the terminal
bearing-divergence interval and the head crosses inside `0.75L`.  Reject the
mechanism if it does not beat `0.827823L`, merely changes oscillation without
reducing projected miss, touches the angle boundary, raises speed/acceleration
limit residence, or moves loads toward the posterior-redistribution failure.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish direction tracking and asymmetric flapping control
source_mechanism: sensed route-response error gates a bounded half-cycle amplitude asymmetry instead of holding a deeper mean bend
transferable_invariant: preserve a productive carrier and apply phase-selective steering only while measured target-line response is worsening on the requested turn side
nontransferable_details: published gains, robot linkage geometry, species-specific kinematics, dimensional beat timing, exact vortex phases, and task-specific routes
policy_translation: normalized body-frame distance and projected miss localize the approach, signed history-window bearing rate detects divergence, and observed anterior joint velocity selects one half-cycle of bounded acceleration
falsification: reject if the minimum does not beat `0.827823L`, terminal bearing divergence persists, the coherent wake or far trajectory changes, or angle, speed, acceleration, force, or moment exposure materially worsens

## Non-CFD implementation audit

Replaying the baseline and candidate algebra on all `7278` frozen
`solver_8097d423c0eb` trajectory samples gives exactly zero action difference
at and beyond `1.75L`.  The reflex changes only joint 1 on `330` samples, all
inside that boundary, with a maximum frozen-state command delta of
`1.6672 rad/T^2`; acceleration-clamp incidence is unchanged (`2733` samples
for both policies).  A direct zero-speed state remains finite, and reflected
joint, target, velocity, bearing, bearing-window-rate, and yaw states negate
both commands exactly.  These checks establish locality, material activation,
boundedness, and reflection equivariance only; they do not predict the new CFD
trajectory or claim improvement before evaluation.
