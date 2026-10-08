# Bidirectional phase-local carrier-work reallocation

## Evidence-led visual diagnosis recorded before the policy edit

- All four sampled rollouts report direct uniform initialization in still water
  with `U_infinity=(0,0,0)`, no cylinders, and no prewarm. The two copies of
  the unguarded soft-envelope carrier are byte-identical and count as one
  physical result. It is the strongest scalar reference: capture at
  `16.943T`, mean distance `2.08985L`, score `-0.205386`, and peak body/local
  flow speeds `1.393U/0.0325U`.
- I inspected the combined sheets for that reference and both evaluated
  high-onset one-way reallocation variants from release through capture. In
  every top-down row the advancing fish leaves a coherent alternating red/blue
  street rather than a standing wiggle; in every oblique row compact paired
  three-dimensional Lambda2 structures remain attached to the caudal wake.
  The body-speed/local-flow separation and moving target-relative trajectory
  confirm self-propulsion rather than ambient or moving-window advection.
- No sampled rollout has a failure termination, so the informative regressions
  are the slower viable captures and the inherited failed overlays. The
  unguarded reference contacts the exact `260 deg/T` speed limit for
  `3.73/3.54%` of the trace. The inherited `0.94` no-transfer guard removes
  contact but captures at `17.115T`; broader `0.90` and linear guards were
  slower still. This supports narrow state-triggered intervention and rules
  out broader symmetric damping as the next test.
- The assigned parent's anterior-to-posterior transfer and the sampled
  posterior-to-anterior transfer independently improve the `0.94`
  no-transfer arrival to `17.053T` and `17.060T`. Both retain zero exact speed
  contact with maxima near `4.519/4.524 rad/T` and the alternating wake. Their
  tradeoffs differ: anterior-to-posterior gives mean distance `2.09541L`,
  force/moment peaks `0.03631/0.01749`, and posterior angle `0.5741 rad`, while
  posterior-to-anterior gives `2.09311L`, `0.03546/0.01767`, and `0.5478 rad`.
  Thus neither direction is a failed mechanism, but neither alone recovers the
  unguarded route.
- The inherited trace analysis supplies the compatibility condition: speed
  contacts are phase-separated. At every unguarded anterior contact the
  posterior joint was below `90%` of its speed limit, and at every posterior
  contact the anterior was below `90%`. The two one-way evaluations provide
  closed-loop confirmation that bounded transfer into the other joint can be
  useful without restoring hard-speed occupancy.

## Single-candidate policy hypothesis

Preserve the demonstrated body-frame target/course observation, zero-centered
anterior oscillator, lagged posterior carrier, terminal steering reserve,
soft acceleration shoulder, and posterior stopping-risk projection. Add the
evaluated `0.94` positive-power speed guard and combine only the two evaluated
one-way allocation channels: guarded anterior work may enter the agreeing
posterior carrier direction within its soft acceleration headroom; guarded
posterior work may enter an already positive-work anterior stroke within the
sampled `0.99` acceleration ceiling. In both directions, require the receiving
joint to remain below the inherited `0.90` normalized speed boundary so a
transfer cannot bypass its own guard. Retain the independently tested `0.35`
bounded fractions rather than tuning carrier gains.

This is one compact phase-local work-reallocation mechanism. Because the
sender contacts are separated in the observed carrier, its two channels
should act on different portions of the beat and recover more useful work than
either one-way variant while leaving low-speed motion unchanged. Falsify it if
capture or alternating three-dimensional shedding is lost, either exact speed
limit is touched, arrival does not beat `17.053T`, mean distance does not beat
`2.09311L`, force/moment exceed `0.03631/0.01767`, posterior angle exceeds
`0.5741 rad`, or the apparent recovery is only a load/saturation trade rather
than better route progress.

```text
bookshelf_consulted: true
source_domain: Lighthill elongated-body reactive propulsion and robotic-fish closed-loop CPG control
source_mechanism: retain a feedback-modulated traveling rhythm while posterior wave kinematics carry reactive thrust and sensor feedback modifies only bounded residual work
transferable_invariant: preserve phase-consistent traveling-bend work and redirect only actuator-unavailable positive work into a compatible receiver stroke with measured headroom
nontransferable_details: published gains, dimensional frequencies, species-specific envelopes, full-body kinematics, exact vortex phases, and task-specific routes
policy_translation: use normalized joint speed and joint-state power sign to guard each output near its limit, then allocate a bounded portion of removed work into the other joint only when its existing carrier direction and normalized speed headroom are compatible
falsification: reject if the bidirectional residual loses capture or alternating shedding, restores speed contact, fails to beat both one-way route references, or increases force, moment, or posterior-angle use beyond their sampled envelope
```
