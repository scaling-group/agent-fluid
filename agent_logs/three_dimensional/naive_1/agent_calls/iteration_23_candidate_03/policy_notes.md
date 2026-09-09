# Multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before editing

- All four sampled rollouts satisfy the frozen evidence contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite moving-window transport, and capture. I
  inspected the top-down vorticity and oblique body/Lambda2 rows and
  cross-checked them against scores, metrics, diagnostics, trajectories,
  executable policy diffs, assigned-parent guidance, and inherited optimizer
  logs. The sampled sheets all show genuine self-propulsion: coherent
  alternating top-down streets follow the turning bodies and compact caudal
  structures persist to first crossing.
- The strongest sampled finite class is the executable-identical common-
  envelope redistribution pair. It captures at `18.8265--18.8815T`, with mean
  distance `2.08855--2.08896L` and minimum distance
  `0.74757--0.74928L`. The geometry-scheduled sample has the same coherent
  wake class and captures sooner at `18.6505T`, but its mean distance is
  `2.09340L`. The redistribution therefore retains a narrow integral benefit,
  not faster arrival or actuation relief; its inherited executable-equivalent
  `0.81206L` near miss and left exit still make semantic robustness the missing
  capability.
- The sampled rearward route multiplier captures at `18.9640T`, but the
  normalized forward target fraction stays positive with a `0.3541` minimum;
  the new branch never activates. It is non-interference evidence only. In the
  inherited near-miss reconstruction, the target instead becomes broadside
  while still ahead and the route nonlinearity is already about `0.995` of
  saturation, so another reserve inside that route argument is structurally
  too late or ineffective.
- The most informative inherited visual failure is posterior-only wave relief:
  its alternating street and oblique caudal structures remain energetic, yet
  it reaches only `3.9248L`, turns away, and exits left at `26.2130T` with
  final distance `6.7410L`. Lower posterior contact is therefore not useful
  relief when it changes the traveling-wave allocation and loses the route.
- A completed inherited broadside-reserve rollout provides the relevant
  positive boundary. On the reliable geometry carrier, the reserve first
  activates at about `1.687L`, while the target remains forward, and retains
  capture at `18.8650T` and `0.74820L`. Both visual rows remain coherent;
  acceleration contact is about `61.1%/72.7%`, rate contact about
  `11.1%/14.9%`, peak planar load `0.03329`, and peak yaw moment `0.01740`, all
  inside the established carrier class. Its mean distance `2.09724L` is not an
  improvement, and an ordinary capture cannot establish near-miss recovery,
  but it does show that direct broadside-gated curvature can activate without
  destroying propulsion or capture.

## Bookshelf transfer

```text
bookshelf_consulted: true
source_domain: biological burst redirect and closed-loop robotic-fish direction tracking
source_mechanism: large observed direction error gates stronger bounded mean curvature while the organized traveling rhythm and response-based release remain intact
transferable_invariant: use normalized body-frame target direction to add bounded curvature authority before overshoot without replacing or reallocating the propulsive traveling wave
nontransferable_details: published gains, robot geometry, species-specific kinematics, dimensional cadence, clock phase, exact vortex phase, world-frame paths, and task-specific routes
policy_translation: retain the captured redistribution parent unchanged and smoothly scale both target-signed anterior and posterior mean-curvature shares when absolute normalized body-lateral target direction exceeds 0.60; keep the existing response release, displacement-only half-cycle steering, common envelope redistribution, posterior lag, and acceleration projection
falsification: reject if capture or either coherent wake row is lost, mean distance leaves the replicated redistribution band without a semantic recovery benefit, the left-exit near-miss topology recurs when broadside authority activates, or actuator contact and planar loads materially exceed the inherited carrier class
```

## Single-candidate policy hypothesis

Add exactly one inherited, already activation-tested broadside curvature-reserve
mechanism to the current redistribution parent. A smoothstep of absolute
normalized body-lateral target direction is zero through `0.60` and rises to
one at broadside. It scales both target-signed mean-curvature shares together
by at most `1.25`, outside the already saturated route nonlinearity, preserving
their ratio, turn sign, displacement-only beat modulation, posterior lag, and
common rhythmic envelope.

This is a cross-carrier mechanism transfer, not scalar-only gain tuning. No
rearward gate, distance stage, alignment release, instantaneous velocity,
velocity-led phase, posterior-only allocation, rate barrier, clock, world
coordinate, or memorized route is added. Formal CFD occurs only after this
worker exits. The new evaluation can establish compatibility with the
redistribution capture/integral class; actual recovery remains unproven unless
a completed activated trace changes the inherited near-miss topology.
