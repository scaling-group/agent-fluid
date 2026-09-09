# Multi-Wake Candidate Diagnosis and Hypothesis

## Evidence diagnosis

- The assigned parent restores the `0.75`-period, `22 deg` angle-only gait and
  `16 deg` positive-bearing law with terminal joint guards. Its released sheet
  shows active upstream motion, followed by an early upward turn and upper-domain
  exit without entering the useful wake corridor. Metrics agree: head displacement
  is `(-2.45,+1.73)L`, minimum range is only `10.35L`, and termination occurs at
  `47.35` released time. The joint guards prevent the prior numerical instability,
  but joint-one speed still reaches `4.249 rad/time` and the smooth commands reach
  `29.65/28.85 rad/time^2`; RMS force/moment remain high at `350/5007`. Terminal
  protection alone therefore does not correct the broad turn or establish a
  low-load route.
- The shared prewarm sheet shows the same held upper-right fish, four staggered
  cylinders, target, and fully developed overlapping vortex streets for every
  policy. None of the released candidates reaches the wake corridor, so the
  current evidence supports only a far-field propulsion/course decision, not a
  claim about wake capture or station keeping.
- The target-blind seed visibly produces a body wave and moves upstream at first,
  but it then turns nearly vertical and exits laterally. Its head displacement
  `(-3.55,-13.30)L`, mean velocity y `-0.263` versus local-flow y `-0.241`, and
  contact with both joint speed and acceleration caps show flow-following rather
  than controlled approach.
- The unguarded `16 deg` positive-bearing candidate is the sole sampled mechanism
  with a nearly horizontal upstream leg: head x moves `-3.59L` and progress reaches
  `0.259`. Its final keyframe instead shows a folded body immediately before
  `unstable_dynamics`; joint-one reaches the speed cap, both commands reach the
  acceleration cap, and RMS force/moment explode to `20024/314391`. Its steering
  sign and gait are useful only behind effective yaw and joint-demand control.
- The strongest finite result combines the same fast angle-only gait with a
  `12 deg` bearing limit, local guards, and `0.04` opposing recent-turn-rate
  feedback. It self-propels farther upstream (`-4.08L` head x; mean velocity x
  `-0.0673` versus local flow x `-0.0457`), reaches `6.71L` minimum range, retains
  `0.217` progress for `65.47` time, and cuts RMS force/moment to `66.5/958`.
  Visually, however, its long upstream leg still becomes a broad upward U-turn and
  upper-domain exit. The slower no-turn-rate `12 deg` guarded predecessor instead
  moved `+0.43L` downstream with `-0.090` progress, while the current no-turn-rate
  parent uses different steering/guard values and is also worse. Thus the evidence
  supports the guarded turn-damped compound as the next base, but does not isolate
  `0.04` as an optimal gain.
- Inherited optimizer logs keep two important boundaries: full-orbit radial phase
  regulation produced finite low-load but downstream, flow-following exits, and a
  bearing-window-rate architecture failed after `1.66` time with joint one at the
  hard angle limit and extreme loads. Those mechanisms should not be mixed into
  this test of recent-turn-rate damping.

## One candidate hypothesis

Reproduce every parameter and guard of the strongest finite controller, changing
only the opposing recent-turn-rate gain from `0.04` to `0.06`. This is a bounded,
single-parameter continuation of the one sampled derivative term that coexisted
with active upstream propulsion. The `50%` increase should oppose the visible late
yaw more strongly while the `12 deg` `tanh` steering limit prevents the derivative
request from creating an unbounded joint bias. Keep the `0.75`-period angle-only
oscillator and posterior lag unchanged, because the sampled radial regulators and
slower angle-only gait lost upstream propulsion. Keep the demonstrated `34 deg`,
`200 deg/time`, and smooth `1600 deg/time^2` protection unchanged so the test is
about course damping rather than another guard bundle.

The law uses only normalized body-frame bearing, recent heading rate, and joint
state; it contains no coordinates, route, clock, prescribed inflow, or remote wake
probe. The next CFD rollout supports this candidate only if it preserves negative
head x and relative-flow x, stays finite beyond `65.47` released time, avoids the
upper U-turn, and improves on the `6.71L` minimum range without hard-cap contact or
load growth. It is falsified if the stronger damping suppresses the traveling gait,
restores flow-following/downstream motion, or merely delays the same upper-domain
exit. This worker does not claim an outcome for the unevaluated candidate.
