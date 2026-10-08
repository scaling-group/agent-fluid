# Progress-qualified posterior-reserve candidate

## Visual and quantitative diagnosis before editing

- I reviewed the assigned parent guidance, all four sampled policies, scores,
  observations, metrics, diagnostics, trajectories, and combined keyframe
  sheets, plus the inherited optimizer notes. Every sampled rollout uses
  direct uniform still-water initialization with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, remains stable, and terminates in capture.
- In both the top-down vorticity and oblique Lambda2 rows, all four fish
  self-propel from rest, establish a coherent alternating wake, and retain
  compact three-dimensional posterior structures through capture. There is no
  passive advection, collision, wake breakup, or out-of-plane instability.
  The informative difference is therefore route state, not wake existence.
- The assigned two-joint-energy parent captures at `18.0015T`, score
  `-0.07758522`, on a `13.1271L` center path with `0.6824L` maximum head
  cross-track. It preserves some early propulsion (`12.221512L` mean distance
  over `0--3T`) but reaches approach at `0.3454L` cross-track, averages only
  `0.7139` course alignment inside `2.1L`, and captures at `0.1814` alignment
  and `-1.2868 rad/T` yaw. Qualifying the anterior-energy gate by posterior
  angle-rate energy therefore did not prevent the reserve's persistent route
  displacement.
- The anterior-energy-only reserve has the best scalar score
  (`-0.07395193`) and early distance (`12.214443L`), but captures later at
  `17.9740T` on a `13.0672L` path, with `0.1320` final alignment and
  `-2.1456 rad/T` yaw. It confirms that unqualified extra tail demand improves
  initial translation but perturbs the downstream course.
- The sampled closure-qualified reserve is the strongest balanced result. It
  retains most of the early benefit (`12.220627L` over `0--3T`), improves score
  over the no-reserve control from `-0.08139542` to `-0.07556104`, shortens
  capture from `17.7265T` to `17.6935T`, and reduces maximum cross-track from
  `0.5120L` to `0.4571L`. It follows a `12.8750L` path, averages `0.8806`
  alignment inside `2.1L`, and captures with `0.6371` alignment and
  `-0.0459 rad/T` yaw. Its `69.54/65.12%` acceleration-ceiling residence and
  RMS force/moment (`0.01579/0.00817`) remain in the baseline load class.

## One policy hypothesis

Replace the assigned parent's posterior-response-energy conjunction with the
sampled progress conjunction. Preserve the anterior phase-plane oscillator,
posterior lag and emphasis, odd body-frame target-to-curvature map,
error-qualified far/middle route observer, approach handoff, half-cycle
steering, cadence schedule, and reversal-preserving rate governor. Multiply
the low-carrier-energy gate by the already normalized closing-deficit signal:
zero or negative target closure retains full reserve authority, while useful
positive closure continuously releases extra posterior demand. This promotes
an evaluated architecture rather than retuning a gain or adding terminal
authority.

Expected evidence is deterministic reproduction of stable capture near
`17.69T`, a sub-`12.9L` path, sub-`0.46L` maximum cross-track, positive terminal
alignment, and the coherent two-view traveling wake. Falsify the candidate if
capture, early distance, route directness, terminal alignment/yaw, actuator
residence, force/moment class, reflection symmetry, or either visual wake view
regresses. Because the adapter currently falls back to single-step
`closing_speed_L`, also falsify the broader mechanism if a co-windowed closure
observation later fails to reproduce the same gating effect.

bookshelf_consulted: true
source_domain: Lighthill-style posterior reactive propulsion and sensor-modulated robotic-fish state-feedback oscillators
source_mechanism: restore a posteriorly emphasized traveling bend only while locomotor energy and target progress both show a propulsion deficit
transferable_invariant: extra posterior demand should require an observed carrier deficit and release when normalized body-frame translation becomes useful, leaving target steering on a separate feedback path
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, exact vortex phases, target coordinates, elapsed startup schedules, and task-specific routes
policy_translation: multiply the anterior joint angle-rate energy-deficit gate by a bounded target-closing-deficit gate before scaling the lagged posterior target; preserve the odd two-joint steering contract
falsification: reject if the early-distance benefit disappears or capture, route directness, terminal course state, load class, reflection symmetry, or top-down and oblique wake coherence regress
