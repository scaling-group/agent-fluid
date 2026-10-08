# Phase 2 candidate diagnosis and hypothesis

## Evidence read before the edit

All four sampled rollouts report direct uniform initialization with
`U_infinity=[0,0,0]`, so the motion and wakes are self-generated rather than
prewarmed or advected. The strongest scalar example is the target-blind seed
(`solver_36a38f7240b3`, score `-14.825`): its top-down row shows a coherent,
alternating posterior wake and about `0.93L` of leftward translation, but the
body curls toward the upper boundary after a best distance of only `12.078L`.
The oblique row confirms a real three-dimensional posterior wake, while the
metrics show that the apparent propulsion is not useful target control: yaw
sweeps about `103 deg`, both joint rates touch `260 deg/T`, and the episode
exits at `8.547T` with distance `12.380L`.

The three target-feedback variants all preserve the same upper-exit topology
and score below the seed. The most informative failure is
`solver_79b9eb651f44` (score `-16.059`, minimum `12.304L`, final `13.487L`):
its target-centered mean-curvature law damps the visible traveling wake early,
then settles near a static `(-8,-4.8) deg` bend while the body continues a
large clockwise curl and exits at `10.147T`. `solver_137608088dcd` similarly
settles near `(-8,-8) deg` and exits at `10.543T`; both keep joint rates below
about `75 deg/T`, showing loss of the carrier rather than actuator saturation.
The prefilled always-on acceleration residual (`solver_1c9001e61100`) retains
more alternating wake and joint motion, but still reverses progress after a
`12.228L` minimum and exits at `8.706T` with final distance `13.258L`.
Local still-water crossflow remains small (at most about `0.018U` in the seed),
so wake rejection is not the missing first mechanism.

## One candidate hypothesis

Keep the naive seed's zero-centered anterior oscillator and posterior lag
unchanged. Replace the always-on/common mean bend with bounded half-cycle
drive asymmetry on joint 1: body-frame target bearing requests a turn, measured
heading rate unloads a turn already developing in the requested direction,
and the sign of observed joint-1 velocity gates added drive to only the useful
half-cycle. The spring remains centered at zero and joint 2 continues to track
the inherited traveling-wave target, so the steering residual cannot create a
static bent equilibrium. This candidate should retain alternating posterior
wake while reversing steering after bearing overshoot, delaying or replacing
the repeated upper-boundary exit with sustained target-distance reduction.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning and biological asymmetric flapping
source_mechanism: target-directed half-cycle amplitude asymmetry around a propulsive rhythm
transferable_invariant: create turning moment by strengthening only the requested bend half-cycle while preserving the underlying traveling wave
nontransferable_details: published gains, dimensional beat frequency, species kinematics, exact vortex phase, and task-specific routes
policy_translation: map normalized body-frame bearing plus measured heading-rate unloading to a bounded turn request, then gate one anterior-joint acceleration residual by the sign of observed joint velocity while retaining the seed posterior lag
falsification: reject if anterior/posterior oscillation or the alternating wake collapses, command saturation becomes more persistent, closest distance does not improve, or the trajectory retains the same clockwise upper-exit curl
