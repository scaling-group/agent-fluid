# Posterior-only terminal course-hold candidate

## Evidence diagnosis before the final policy edit

- All four direct solver samples are finite captures at `24.6730T`, score
  `-0.448647`, mean distance `2.348256L`, and terminal distance `0.748684L`.
  Their complete `4486`-row trajectories and both view-specific keyframe
  sheets are byte-identical. Two samples use the assigned v35 posterior
  steering-residual coast policy; two add a v36 binary course-consistency veto.
  Course-error sign therefore supplies no nominal selectivity and is not a
  semantic improvement.
- The evidence confirms direct uniform still-water initialization at
  `U_infinity=(0,0,0)` with no prewarm. In the top-down rows the fish advances
  under its own traveling bend, sheds a coherent alternating vortex street,
  and bends smoothly onto the capture circle rather than being advected. The
  oblique Lambda2 rows show compact alternating three-dimensional structures
  that persist through the redirect; there is no visible instability or
  out-of-plane escape.
- The inherited optimizer logs contain an evaluated v37 two-joint terminal
  course hold not exposed by the shallow initial inventory. Its normalized
  near-range/positive-closing/large-course-error conjunction changes exactly
  `292/4486` parent-trace commands, beginning only at `1.59963L`. It preserves
  the coherent capture topology and arrives slightly sooner at `24.6620T`, but
  worsens mean distance/score from `2.348256L/-0.448647` to
  `2.348972L/-0.449580` and consumes most of the crossing margin at
  `0.749661L`. Raw acceleration-envelope exposure is essentially unchanged
  (`73.483%` versus `73.473%`), while peak lateral-force/yaw-moment
  coefficients rise from `0.0309/0.0156` to `0.0347/0.0180`. Scaling both
  carrier channels therefore delays or reshapes the same transverse terminal
  sweep without a net control improvement.
- Those logs also show why a continuous course-demand gate inside the final
  posterior coast layer should be abandoned: on the fixed parent trace it
  changes only `2/4486` commands, both on the far approach at
  `8.137--12.204L`, and none in the intended terminal regime. The coast
  layer's output minimum, not a missing route predicate, determines where its
  residual reaches the plant. Broad dual-joint rate braking and synthesized
  follower feedforward remain stronger inherited negatives because they lower
  saturation while converting capture to pass-and-left-exit trajectories.

## Policy hypothesis

Preserve the evaluated v35 controller and the empirically localized v37
terminal conjunction, but apply its bounded carrier relief only to the
posterior thrust carrier. Keep the anterior oscillator at full authority as
the phase and steering anchor, and leave both joints' mean-curvature and
half-cycle steering, course preview, posterior stroke reserve, and posterior
coast guard unchanged. Reusing the evaluated gate and floor isolates actuator
allocation from gate tuning: it tests whether the slight v37 arrival benefit
can survive without the anterior-carrier perturbation that worsened terminal
course quality and loads.

Falsify this mechanism if it changes any command outside the `1.60L` gate,
loses capture, arrives later than the v35 `24.6730T` parent, worsens the
`2.348256L/-0.448647` mean-distance/score pair, narrows the terminal margin,
disrupts the coherent wake, reintroduces posterior hard-stop occupancy, or
raises the v35 low-load class. A rollout that merely interpolates between the
v35 and two-joint-hold traces without improving either is a concrete negative.

bookshelf_consulted: true
source_domain: elongated-body fish propulsion and robotic-fish terminal path following
source_mechanism: maintain the anterior rhythm as a phase and steering anchor while scheduling posterior thrust effort during a target-relative final approach
transferable_invariant: preserve the propulsion wave's organizing phase and closed-loop steering while reducing only follower thrust under simultaneous near-range, positive-closing, and large body-frame course-error evidence
nontransferable_details: published gains, clock phases, species-specific envelopes, dimensional cadence, exact vortex phases, motor models, and prescribed routes
policy_translation: use normalized range, closing speed, and body-frame velocity-course error to scale only the existing posterior carrier acceleration; leave anterior carrier and both steering paths unchanged
falsification: reject on nonlocal command changes, capture loss, worse arrival or distance integral, narrower margin, wake decoherence, hard-stop return, higher loads, or no benefit beyond interpolation between evaluated parents

## Non-CFD locality audit

On the evaluated v35 state trace, the final policy changes zero anterior
commands and `284/4486` posterior commands. The first change is at `22.8305T`
and `1.59963L`; every change is inside the owned `1.60L` range gate. The
posterior carrier scale stays in `[0.82,1.00]`, and the largest fixed-trace
posterior-command difference is `4.897 rad/T^2`, below the owned
`31.416 rad/T^2` acceleration envelope. This verifies locality and
materiality only; it is not a coupled-CFD performance claim.
