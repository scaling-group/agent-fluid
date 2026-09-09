# Wake-policy candidate notes

## Inherited and sampled evidence diagnosis

- The assigned parent guidance and its inherited optimization note proposed a
  shared head/tail mean-curvature bias with lateral-slip relief. Its completed
  rollout (`solver_f0a5c173df3d`) is valid direct-uniform still water with no
  prewarm or cylinders. It gives the strongest sampled approach: distance falls
  from `12.328L` to `8.174L` at `16.494T`. The improvement does not persist,
  however; the fish continues below the target, distance returns to `12.336L`,
  and the head exits the lower boundary at `26.043T`. Raw acceleration exceeds
  the fixed envelope on about `57%/61%` of samples and joint-rate contact occurs
  on about `6%/8%`, so this is useful route motion followed by underdamped
  steering, not a stable navigation solution.
- The highest-score finite sample (`solver_c24e37740d95`) puts bounded target
  curvature only in the posterior target and damps it with recent yaw rate. In
  both visual rows it retains a compact alternating mid-plane street and a
  coherent oblique Lambda2 chain. The trace agrees that this is productive
  self-propulsion: distance improves monotonically to `11.096L` while the center
  moves about `2.18L` left. But bearing has already crossed from about `+0.14`
  at `4T` to `-0.07` at `6T`; the fish keeps rotating and translating upward,
  reaches bearing about `-0.83`, and exits the upper boundary at `10.026T`.
  Thus the useful turn is released or reversed too late for the yaw response.
- The equal head/tail bias sample (`solver_6882de278554`) is the counterexample
  to treating bias magnitude as the only issue. Its joint rhythm decays to an
  almost static same-sign bend (maximum joint rates only `0.77/1.27 rad/T`),
  force falls by an order of magnitude relative to the propulsive samples, and
  the fish turns and travels right, ending at `15.361L`. Joint allocation must
  preserve the traveling wave; scalar-only bias tuning is not supported.
- All four sampled runs terminate `left_domain`; none is a positive completion.
  The seed and posterior-only sheets show coherent wakes, while the inherited
  head/tail candidate shows a longer, stronger wake accompanying a broad lower
  arc. The images, distance traces, force/moment scales, and actuator histories
  therefore agree: the missing semantic capability is timely reversal of a
  target-directed turn, not more carrier gain or ambient-flow rejection.

## Policy hypothesis

Preserve the seed oscillator and posterior lag exactly, and retain the sampled
posterior-only target-to-curvature channel because it best preserves propulsion.
Make that curvature response-gated: body-frame bearing supplies the route
request, recent bearing trend anticipates a centerline crossing, and recent yaw
rate damps accumulated rotation. This is one closed-loop turning mechanism, not
a scalar carrier retune. A bearing already contracting toward zero should
release the bend before crossing; a bearing moving away should retain or reverse
authority. All inputs are normalized body-frame/state signals and the command
remains smoothly bounded.

Falsify this candidate if it retains the early upper-boundary topology, replaces
it with rapid left/right switching, fails to improve the `11.096L` posterior-only
minimum, collapses the alternating wake, or increases persistent rate/acceleration
clipping. A later evaluation should prefer semantic termination and sustained
distance progress over a brief closest approach.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and biological burst redirect
source_mechanism: sensor-gated mean-curvature turn that releases when the observed heading response begins
transferable_invariant: preserve the propulsive rhythm while target-error trend and yaw response release or reverse a bounded turn before inertial overshoot
nontransferable_details: published gains, clocked phase, species-specific burst kinematics, exact vortex phases, and source-task routes
policy_translation: map body-frame bearing plus bounded recent bearing and yaw rates to a smooth posterior mean-curvature target inside the two-joint state-feedback oscillator
falsification: reject if the upper exit persists, trend feedback chatters, the wake or thrust collapses, closest approach does not improve, or actuator clipping becomes more persistent
