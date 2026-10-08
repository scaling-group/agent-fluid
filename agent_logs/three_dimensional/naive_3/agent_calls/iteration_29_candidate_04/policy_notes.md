# Soft-headroom bidirectional carrier allocation

## Evidence-led visual diagnosis recorded before the policy edit

- All four sampled rollouts satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no cylinders, and no prewarm. All terminate in capture.
  I read their combined sheets from release through termination. The top-down
  rows show a coherent alternating red/blue street, and the oblique rows show
  compact three-dimensional Lambda2 structures following the caudal region.
  There is no standing wiggle, collision, wake collapse, or terminal coast.
- The motion is self-propelled rather than ambient or moving-window advection.
  The unguarded soft-envelope sample reaches `1.393U` while peak local flow is
  only `0.0325U`; the sampled transfer policies similarly reach
  `1.374--1.402U` against at most `0.0329U` local flow. The visual route and
  these velocity ratios agree.
- The unguarded prefill is the fastest sample (`16.943T`) but holds both joints
  exactly at `260 deg/T` for `115/109` trace rows. The duplicated best finite
  policy is the bidirectional high-onset allocation: it preserves capture and
  the alternating wake, stays below both speed stops at `258.91/259.19 deg/T`,
  and improves mean distance/score to `2.08931L/-0.204764`, although arrival is
  `0.045T` later and peak force/yaw moment rise slightly to
  `0.03634/0.01804` from the unguarded `0.03609/0.01766`.
- The posterior-biased one-way allocation is the most informative sampled
  regression: it remains stable and speed-viable with the same wake topology,
  but captures at `17.035T`, mean distance `2.09268L`, and score `-0.207429`.
  Thus the posterior-to-anterior branch in the bidirectional policy contributes
  useful route work and should not simply be deleted.
- The inherited phase-confidence continuation supplies a sharper negative
  result. Its low-posterior-speed gate suppressed 90 of 124 sampled
  anterior-to-posterior corrections while preserving capture, coherent
  shedding, and zero speed contact, yet it regressed from the ungated
  bidirectional reference to `17.065T`, `2.09307L`, and score `-0.208516`;
  force/yaw-moment peaks also rose to `0.03736/0.01845`. Receiver speed near a
  reversal is therefore not evidence that the counterphase correction is
  incompatible. A receiver constraint should act on bounded command headroom,
  not erase the low-speed part of the traveling-wave coupling.

## Single-candidate policy hypothesis

Start from the sampled bidirectional high-onset controller, retaining its
body-frame target/course observation, zero-centered anterior oscillator,
posterior carrier and steering reserve, two positive-power speed guards,
cross-joint compatibility signs, receiver-speed headroom, and posterior angle
stopping projection. Change only how the posterior-to-anterior residual enters
the receiver. Remove the separate `0.99` acceleration ceiling, which allowed
the sampled anterior command to reach `31.102 rad/T^2` after the established
soft envelope, and pass the requested residual through a smooth exponential
map of the anterior joint's remaining soft-envelope headroom. This leaves
near-zero-speed receiver phases eligible, makes small residuals approximately
identity, and asymptotically keeps their assembled command below the existing
`0.95` soft ceiling.

The mechanism tests composition of useful inter-joint coordination with the
demonstrated command envelope rather than another carrier-gain setting. It
should preserve capture, the alternating three-dimensional wake, and zero
exact speed contact while retaining enough of the posterior-to-anterior path
to beat the one-way `17.035T/2.09268L` reference. Falsify it if capture or wake
coherence is lost, either speed stop returns, arrival or mean distance is no
better than that one-way reference, or force/yaw moment fail to improve on the
ungated bidirectional `0.03634/0.01804` envelope. Even if loads improve, do not
call it a route improvement unless score beats `-0.204764` or arrival beats
`16.988T` without another mechanical regression.

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and elongated-body reactive propulsion
source_mechanism: preserve phase-coupled rhythmic coordination while admitting feedback residuals only through bounded actuator authority
transferable_invariant: retain the traveling-bend phase relationship and compose cross-joint residual work with measured receiver headroom rather than bypassing the carrier envelope
nontransferable_details: published gains, dimensional beat frequencies, species-specific envelopes, full-body kinematics, prescribed phase offsets, exact vortex timing, and task-specific routes
policy_translation: use normalized joint speed and joint-state work sign for the existing bidirectional guard, then map posterior-to-anterior residual acceleration smoothly into the anterior command's remaining soft-envelope headroom without suppressing low-speed reversal phases
falsification: reject if capture or alternating three-dimensional shedding is lost, speed contact returns, route metrics fall to the one-way reference, or force and yaw moment do not improve on the ungated bidirectional envelope
```

## Post-edit contract check

Offline replay on the sampled bidirectional source states reproduces its logged
actions to within `1.59e-4 rad/T^2`. The new receiver map changes exactly the
72 rows where the posterior-to-anterior branch was active, with maximum action
delta `1.257 rad/T^2` (`4.0%` of the physical acceleration envelope), while
both replayed command peaks remain at the existing `29.845 rad/T^2` soft
ceiling. This establishes a localized, non-duplicate policy change; it is not
CFD outcome evidence and does not establish the hypothesis.
