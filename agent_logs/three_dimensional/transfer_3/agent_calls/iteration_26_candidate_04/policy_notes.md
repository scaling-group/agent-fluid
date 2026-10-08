# Course-supported response-exclusive allocation

## Evidence and visual diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen Phase-2 contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite moving-window dynamics, and capture. The two
  `-0.30126617` samples are byte-identical evaluations of the drive-first
  target-residual allocator, so they are reproduction rather than two
  independent mechanisms.
- The assigned-parent response-exclusive allocator is the strongest current
  sample. It captures at `19.612991 T`, scores `-0.282941223`, and has
  mean/final distance `2.172435105 L`/`0.748660505 L`. This improves the
  posterior-response-only sample at `20.096998 T`, `-0.297568587`, and
  `2.188311614 L`, and the drive-first residual sample at `21.735992 T`,
  `-0.301266170`, and `2.194857233 L`. Selecting between the two outer
  priorities from normalized posterior lag state therefore survives CFD
  evidence; neither branch alone explains the gain.
- I inspected the complete combined keyframe sheets for the assigned parent,
  the posterior-response-only parent, and the slower residual allocator,
  including both the top-down mid-plane-vorticity and oblique body/Lambda2
  rows from release through capture. Every fish visibly self-propels from
  quiescent flow along a compact target-directed arc, forms a coherent
  alternating wake, and retains finite localized three-dimensional
  structures. None shows passive advection, a loop, collision, boundary-exit
  precursor, wake collapse, or out-of-plane instability. The strongest
  assigned parent remains visibly undulatory through the upper-right capture,
  while the slower residual allocator enters a long quiet held bend. Because
  no sampled rollout has a failure termination, that slower capture is the
  informative semantic failure.
- The assigned parent crosses `4/3/2/1 L` at about
  `15.664/16.890/18.089/19.316 T` with speed near `0.86--0.88 L/T`, versus
  `15.873/17.116/18.398/19.728 T` and a declining
  `0.84--0.78 L/T` for the posterior-response-only sample. Its faster course
  is therefore already established before the terminal threshold and should
  not be replaced by cadence damping or a forced held-bend handoff.
- The gain carries a physical cost that later evaluation must audit. Below
  `4 L`, the assigned parent has `508/589` anterior/posterior commands above
  `30 rad/T^2`, local force/moment maxima about `0.02847/0.01519`, and it
  captures at joint rates `-4.498/1.538 rad/T` and yaw rate
  `2.858 rad/T`. The existing geometry-gated terminal equilibrium is nearly
  dormant on this realized trajectory: reconstructed redirect support
  averages about `0.004` below `4 L`. By contrast, the slower residual sample
  has only `21/8` high terminal commands, local maxima about
  `0.01615/0.00871`, and settled joints. Same-state distance dormancy did not
  preserve the terminal regime, but forcing the quiet regime would also
  discard the newly evidenced speed mechanism.
- The assigned-parent allocator currently chooses traveling-bend priority
  whenever posterior lag is large even if the measured center course has a
  severe normalized miss from the target ray. On its stored outer states,
  normalized miss fraction has median about `0.40` and upper quartile about
  `0.62`; among high-lag states the upper decile is about `0.94`. This exposes
  a distinct unresolved state: coordinated propulsion needs support, but
  preserving route feedback may be more urgent than another common-limit
  increment.

## Policy hypothesis

Start from the evaluated assigned-parent policy, not the prefilled older
sample. Preserve its oscillator, body-frame target feedback, posterior lag,
redirect equilibrium, closure preview, intercept-supported terminal law, and
response-exclusive saturation allocator. Add one outer-only course-supported
priority selector. Compute predicted miss divided by current range from the
existing body-frame target ray and center-velocity direction, withhold the
signal until observed translation is established, and use only the severe
miss tail to transfer priority continuously from the response-conditioned
common-limit increment to the existing drive-first target residual. The
algebra remains a convex exclusive allocation: it never stacks the two
increments, raises their authority, changes cadence or mean curvature, or
changes any command at or below `4 L`.

The expected benefit is earlier course correction on overloaded high-lag
outer states while retaining the assigned parent's fast compact path and
traveling wake. Falsify the candidate if the new selector is dormant, acts at
negligible translation, changes a same-state command at or below `4 L`,
exceeds the declared acceleration limit, delays or loses capture, worsens
mean distance, erases the fast trajectory, increases stop dwell or global
loads, or degrades either wake view. The new CFD evaluation occurs only after
this worker exits and is not claimed here.

bookshelf_consulted: true
source_domain: sensor-modulated coupled-oscillator robotic-fish path following together with classical traveling-wave propulsion
source_mechanism: preserve rhythmic inter-joint coordination while using observed route error to decide when bounded low-frequency target correction receives actuator priority
transferable_invariant: when a coordinated traveling bend and route correction share bounded actuators, allocate exclusively between them from both realized oscillator response and normalized course error rather than stacking commands or using saturation magnitude alone
nontransferable_details: published gains, dimensional cadence, full-body waveforms, species-specific kinematics, exact phase or vortex timing, actuator models, target coordinates, capture geometry, and task-specific routes
policy_translation: outside the normalized terminal band, use translation-supported predicted-miss fraction from body-frame target and center velocity to transfer the existing convex priority from posterior-response common limiting to the already bounded target residual
falsification: reject on dormancy, activation without translation, terminal same-state interference, slower or lost capture, worse distance integral, changed useful topology, renewed stop dwell, material global load growth, instability, or degraded top-down or oblique wake coherence

## Non-CFD implementation audit

- Reconstructing normalized observations from all three distinct sampled
  trajectories shows that the course selector changes `674/692/796` stored
  outer states from the assigned parent, response-only, and residual-only
  rollouts. Maximum same-state command differences are about
  `2.465/2.557/2.840 rad/T^2`, respectively. Every stored state at or below
  `4 L` is exactly identical to the evaluated assigned parent.
- A deterministic `72,900`-state grid spanning range, body-frame target angle,
  course angle, translation speed, joint positions, and joint velocities has
  `13,040` active cases. All outputs are finite and within the declared
  acceleration limit; all `32,400` states at or below `4 L` and all `18,225`
  zero-translation states are exactly parent-identical. These checks establish
  activity, boundedness, terminal same-state noninterference, and the motion
  support guard, not coupled-flow improvement.
- The deterministic schema audit resolves all `87` direct `params.FIELD`
  references in the `88`-field object returned by `target_policy_params()`;
  only the version label is intentionally unused. The lightweight Julia
  contract and solver edit-boundary checks pass.
- The prescribed check-runner was invoked after the edits, but its pinned
  `gpt-5.4-mini` model is unsupported on this ChatGPT account and failed before
  executing a command. Its three configured non-CFD checks were therefore run
  directly and separately. The guidance check initially found the inherited
  duplicate assigned-parent marker in the rendered root `README.md`; removing
  only that duplicate marker repaired parent resolution, and all three checks
  pass. No formal CFD was run in this workspace.
