# Multi-wake candidate diagnosis and hypothesis

## Evidence read before the policy edit

- The shared prewarm sheet is the common initial condition: the fish is held
  high and downstream/right of the target while the four staggered-cylinder
  vortex streets develop and merge through the target corridor. It does not
  distinguish policies or establish robustness to another wake phase.
- The inherited matched `19 deg`, `0.67`-period controller is the informative
  failure. Its released sheet shows a broad initial turn and active lateral
  corrections, but it never acquires the strong upstream corridor and remains
  well to the right of the target at the horizon. It finishes at its `5.812L`
  minimum with head displacement `(-5.846,-4.282)L`; mean x velocity is
  `-0.01942` while mean local-flow x is only `-0.00682`. Joint maxima remain
  finite (`19.0/24.3 deg`, `178/134 deg/time`, and `1670/1260 deg/time^2`), so
  the failure is insufficient corridor acquisition rather than cap contact,
  numerical instability, or passive downstream advection.
- The assigned-parent `20 deg` controller changes only the anterior shell
  relative to that `19 deg` comparison (apart from an inactive local guard).
  Its sheet straightens into the interacting wake and reaches the target from
  the right at `266.255`, with mean distance `7.218L`, head displacement
  `(-11.031,-4.702)L`, and no collision, exit, or instability. Its mean
  velocity `(-0.04144,-0.01765)` nearly matches local flow
  `(-0.03889,-0.02029)`, so control selects and retains useful wake transport
  rather than producing large sustained velocity relative to the water.
- The strongest current sample keeps the parent's `0.67` period, `0.65/0.80`
  posterior lag/damping, `0.30` bearing scale, and negative bounded posterior
  steering, while increasing only the anterior shell to `20.25 deg` and
  mechanically lifting the local guard to `31.2 rad/time^2`. Its sheet retains
  the parent's broad initial correction and right-side target entry, but it
  reaches at `244.547`, lowers mean distance to `6.452L`, and reduces total
  command energy to `170142` from `177753` because the episode ends earlier.
  Maximum anterior acceleration is `31.055`, below the policy guard and the
  episode envelope; force is essentially unchanged (`18.263` versus `18.262`
  RMS), while RMS moment rises modestly from `353.2` to `362.2`.
- The current `20 deg`, `0.28` bearing-scale sample is a useful negative
  control for steering. It still captures, but its visibly deeper early
  lateral excursion accompanies a worse `8.112L` mean distance and `262.895`
  arrival; lateral force/moment do not improve (`18.583/353.823`). Sharpening
  the bearing response therefore does not explain the `20.25 deg` gain and is
  not supported as a simultaneous edit. Inherited logs also show that stronger
  posterior lag nearly eliminated upstream travel and that a coupled `21 deg`,
  `0.69`-period, softened-steering variant rebounded after approach, so neither
  is a justified extrapolation.

## Candidate hypothesis

Adopt the fully evaluated `20.25 deg` anterior shell and its `31.2 rad/time^2`
inactive guard while preserving every steering, period, lag, and damping value
from the assigned-parent `20 deg` controller. This is a single-axis replacement
with direct fixed-prewarm evidence: it should reproduce target capture and the
same wake-corridor topology while retaining the sampled improvement in arrival
and distance integral. It uses only bounded joint-state and body-frame-bearing
feedback; it adds no route, coordinate, target identity, time signal, or wake
probe.

Falsify this candidate if a repeat misses or reaches later than the `20 deg`
anchor, if the `31.2` guard becomes active, if the trajectory approaches and
then rebounds, or if lateral moment growth ceases to be modest. Do not increase
the shell to `20.5 deg` at this period: its nominal anterior acceleration would
exceed the episode's `1800 deg/time^2` envelope. If the `20.25 deg` result fails
to repeat, restore `20 deg` and test bounded corridor-retention feedback as an
isolated change rather than sharpening bearing gain or posterior lag.
