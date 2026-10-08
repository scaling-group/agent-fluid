# Course-gated posterior recovery candidate

## Visual and trace diagnosis before the edit

- Every sampled and inherited evaluation used contract-valid direct-uniform
  still water (`U_infinity=(0,0,0)`, no cylinders, no prewarm). In both the
  top-down vorticity and oblique Lambda2 rows, the fish translates against the
  quiescent background and leaves an alternating three-dimensional wake. The
  trajectory changes are therefore self-propelled controller responses, not
  imposed advection or moving-window transport.
- The assigned parent, `solver_b3b6be8f076f`, globally conditions C-start
  release on projected interception and positive closing speed. Its coherent
  wake remains in the high corridor, the joints settle near a same-sign static
  bend, and it exits the upper boundary at `27.066T`; minimum distance is only
  `4.278L`. The parent establishes that holding static redirect curvature at
  range is not a substitute for a target-directed propulsive transition.
- `solver_4365157e5ac8` is the strongest current sampled trajectory despite its
  poor final score. Its response-released redirect visibly turns the wake
  downward, reaches `1.165L`, and stays numerically stable with no angle contact
  and peak planar force/yaw moment near `0.0214/0.0097`. It then passes the
  target and exits left, showing useful steering authority but an incorrect
  translational intercept.
- The inherited evaluated `solver_8097d423c0eb` and
  `solver_958c9a496ff3` provide a controlled terminal negative result. Both
  start from the bend-attainment-released carrier that reached `0.8307L`.
  Vetoing release below `1.75L` reaches `0.8298L`, while raising redirect
  frequency below `2.25L` worsens the minimum to `0.8701L`; neither captures.
  Both visual rows preserve the same broad downward arc and alternating wake.
  Their heads cross `x=9L` still about `1.55L` above the target, before either
  terminal gate can materially reshape the route, and their speed and
  acceleration cap residence remain about `35%` and `38%`. More same-sign
  terminal bend urgency is therefore unsupported.

## Policy hypothesis

Recover the evaluated bend-attainment controller's traveling carrier,
calibrated body-frame steering side, and union of yaw-response and two-joint
bend release. Replace the ineffective terminal redirect refinements with one
phase-shape mechanism: when the large-error C-start has attained its same-sign
bend, the normalized velocity/target cross product still reports a middle-range
course miss, and joint-angle headroom remains, add a bounded posterior
counterstroke on the release side. Because the gate is derived from bend
attainment, it turns itself off as the posterior joint crosses out of the
same-sign bend; it neither uses a clock nor holds another static offset. A
smooth distance band makes the mechanism act before the evidenced `x=9L`
crossing and fade in the capture neighborhood.

The expected evidence is the same coherent far-field wake followed by an
earlier posterior phase separation and a lower/right-shifted crossing of the
target neighborhood. Success is capture; a useful partial result must at least
beat `0.8298L` and reduce the roughly `1.55L` vertical error at `x=9L` without
raising limit residence or loads beyond the sampled redirect class. Falsify
the mechanism if it restores the high/static parent path, reverses the turn,
breaks the alternating wake, touches the joint-angle boundary, increases
force/moment materially, or merely reproduces the same `0.83--0.87L` skim.

bookshelf_consulted: true
source_domain: biological C-start recovery and elongated-body reactive propulsion
source_mechanism: release a large-error body bend into a directionally phased posterior stroke so the tail redirects momentum while rhythmic propulsion resumes
transferable_invariant: a transient redirect should transition through an observed posterior counterstroke, rather than remain a static same-sign bend, when measured course error shows that body rotation has not yet produced a capture course
nontransferable_details: species-specific C-start stages and timing, full-body curvature envelopes, published gains, dimensional cadence, exact vortex phases, target route, and world coordinates
policy_translation: infer redirect completion from normalized two-joint bend attainment, gate urgency with body-frame velocity/target course error and normalized distance, and add one bounded reflection-equivariant posterior acceleration that vanishes as the tail leaves the attained bend
falsification: reject if the target crossing does not move toward capture, if the same terminal skim or high-corridor latch remains, or if wake coherence, actuator residence, angle clearance, and hydrodynamic loads worsen

## Non-CFD implementation audit

Replaying the candidate and the same policy with its recovery pulse disabled on
the frozen `solver_8097d423c0eb` observations gives exactly zero difference at
and beyond `5L`. The state-triggered posterior pulse is materially active from
about `20.09T` to `24.87T`, before that rollout crosses the target's `x`
station, and changes one command component by at most `1.34 rad/T^2`.
Frozen-state acceleration-clamp incidence is unchanged both within the
middle-distance band and over the full trace. Direct zero-speed and mirrored
state tests are finite, bounded, and reflection-equivariant to machine
precision. These checks validate isolation, activation, and the policy
contract only; they do not predict the unevaluated fluid response.
