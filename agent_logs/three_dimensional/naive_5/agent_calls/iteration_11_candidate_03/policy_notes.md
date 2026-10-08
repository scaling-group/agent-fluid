# Slip-gated terminal tail-recovery candidate

## Visual and trace diagnosis before the edit

- The sampled evaluations and inherited step-8 through step-10 rollouts are
  contract-valid direct-uniform still-water episodes (`U_infinity=(0,0,0)`, no
  cylinders, no prewarm). In every combined sheet, the top-down vorticity row
  shows a body-attached alternating wake and the oblique Lambda2 row shows a
  three-dimensional trail that translates with the fish. Motion is therefore
  self-propelled rather than imposed advection or moving-window transport.
- The high-corridor `solver_b3b6be8f076f` and high-load
  `solver_b6ed3f84ab58` failures retain coherent wakes but never establish the
  useful downward route. In contrast, the `solver_8097d423c0eb` terminally
  qualified two-joint redirect preserves both visual wake signatures, avoids
  angle contact and high loads, and reaches `0.829828L` before passing above
  the target and exiting left. That response-released carrier remains the
  strongest semantic baseline even though its scalar score is lower.
- The assigned `solver_4f3d51f38935` parent deepens both same-sign redirect
  targets only on a close projected miss. It retains the broad downward wake
  but reaches `0.832836L`, slightly worse than `0.829828L`, with the same
  `left_domain` topology. At closest approach its body heading is `1.460 rad`
  versus `1.385 rad` in the earlier baseline, but the world velocity direction
  changes by only about `0.044 rad`; body/velocity slip grows from about
  `0.638` to `0.757 rad`. More static curvature therefore rotates the body
  without redirecting enough translational momentum.
- The inherited projected-miss braking rollout is a complementary negative
  result. Posterior damping worsens the minimum to `1.111481L`; terminal speed
  remains `0.671L/T`, heading response falls to `1.038 rad`, and the crossing
  stays higher. Suppressing posterior drive did not dissipate the approach or
  produce the missing target-side impulse. Together with the evaluated release
  veto (`0.829828L`), frequency (`0.870123L`), predictive entry (`0.926872L`),
  posterior recovery pulse (`0.895724L`), and curvature-depth (`0.832836L`)
  descendants, this is more than three completed iterations without capture
  or a better termination class, so the bookshelf was consulted again.
- On the assigned parent, slip is small at `1.10L` but grows to about
  `0.435 rad` by `0.90L` while the fish is still closing and the projected miss
  remains outside capture. At that point both joints have settled toward the
  same-sign C-bend. This supports testing a different actuator effect: retain
  the anterior redirect, but reverse the posterior joint toward a bounded
  S-bend only when measured relative crossflow confirms that body orientation
  and translation have separated.

## Policy hypothesis

Return the terminal redirect targets to the evaluated response-released
baseline and add one state-feedback mechanism. In the close bad-intercept
regime, while closing speed is positive and normalized body-relative crossflow
shows material slip, blend the posterior redirect tracker toward a recovery
target opposite the current anterior bend. The anterior joint continues the
established target-side redirect; the posterior joint supplies a dynamic
counterstroke instead of deeper static curvature or generic damping. All gates
are smooth, body-frame, reflection equivariant, and vanish at range, on a safe
projected intercept, at negligible crossflow, or after closest approach.

Expected evidence is the same broad downward coherent route, but with the
velocity vector rotating toward the target before the closest approach and a
first crossing inside `0.75L`; a minimum below `0.829828L` with reduced
projected miss is the weaker threshold. Falsify the mechanism if it repeats the
`0.895724L` posterior-pulse topology, changes only body heading rather than
course, acts materially outside `1.75L`, recreates a high-corridor/static-bend
latch, touches the angle boundary, disrupts the alternating 3D wake, or raises
loads or actuator-limit residence beyond the low-load redirect class.

bookshelf_consulted: true
source_domain: Lighthill-style posterior reactive-force control, biological C-start recovery, and sensor-modulated robotic-fish direction tracking
source_mechanism: posterior kinematics provide a response-generating recovery stroke after a bounded turn bend, with sensed crossflow and target response determining when the stroke is useful
transferable_invariant: when added mean curvature rotates the body but not its velocity, preserve anterior steering and use measured slip to trigger one bounded posterior wave-shape reversal that can supply a lateral impulse
nontransferable_details: published gains, dimensional beat frequencies, full-body C-start timing, species-specific envelopes, robot linkage geometry, exact vortex phases, clocked CPG phase, world coordinates, and task-specific routes
policy_translation: combine normalized body-frame target distance, projected miss, positive closing speed, relative crossflow, and observed joint state to blend only the posterior redirect tracker toward an opposite-bend recovery target while leaving the established anterior redirect and far-field carrier unchanged
falsification: reject if the rollout does not beat `0.829828L`, does not reduce projected miss by rotating course rather than body alone, repeats the failed posterior-pulse path, or worsens wake coherence, high-corridor behavior, angle clearance, loads, or limit residence

## Non-CFD implementation audit

Replaying the candidate and the `solver_8097d423c0eb` response-released
baseline on all `7234` frozen assigned-parent observations changes `157`
commands. Every change is confined to `0.835--1.255L` range and
`26.037--27.385T`; there are zero differences at or beyond `1.75L`. While
active, the mean L1 command change is about `4.89 rad/T^2` and the largest
posterior-component change is `12.13 rad/T^2`. Frozen-state acceleration-clamp
incidence is unchanged (`2687` samples for both policies). The candidate owns
all `40` directly referenced parameter fields, remains finite at zero speed and
zero relative flow, and negates both accelerations exactly under reflected
lateral target, velocity, relative flow, yaw, and joint state. These checks
establish material activation, locality, schema coverage, boundedness, and
reflection equivariance only; they do not predict the unevaluated CFD outcome.
