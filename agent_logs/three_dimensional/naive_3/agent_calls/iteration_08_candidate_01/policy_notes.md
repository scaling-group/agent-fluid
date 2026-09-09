# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- All four sampled evaluations and the three completed assigned-parent
  rollouts used direct uniform still water (`U_infinity=(0,0,0)`), no
  cylinders, no prewarm snapshot, and finite dynamics. Their translation is
  self-propulsion rather than advection or an initialization artifact.
- I inspected both the top-down vorticity and oblique body/Lambda2 rows for
  the strongest sampled carrier, the sampled distance-relief failure, and the
  assigned parent's course-feedback failures. The `2.443L` carrier maintains
  a coherent alternating three-dimensional wake and substantial speed, but
  passes below the target and remains powered into a lower-boundary exit.
  Distance relief retains the same topology (`2.845L`). The catastrophic
  direct-sideslip controller instead curls upward with a short wake and exits
  at `9.295T`, confirming that course feedback can dominate the useful
  carrier rather than gently repair it.
- The assigned parent's latest matched-window target-ray lead is a completed
  negative result. Although its course at the inbound `8L` and `6L` crossings
  is less downward than the carrier's, the lead persists through the `5--4L`
  region: minimum distance worsens from `2.443L` to `3.167L`, mean distance
  from `8.443L` to `8.602L`, and the same powered lower exit remains. The
  inherited wrong-side posterior course guard similarly reaches only
  `2.697L`. Early slip/line-of-sight feedback is therefore not supported.
- A response-gated C-bend also preserves the lower exit (`2.468L`) while
  raising mean distance to `8.877L` and peak planar load, so more anterior
  bend is not supported. At the best carrier's minimum, however, full
  body-frame target direction is about `1.42 rad`, closing response has nearly
  vanished despite about `0.669U` speed, and the completed diagnostics show
  far less posterior than anterior acceleration-clamp residence
  (`0.354` versus `0.746`). This leaves posterior equilibrium allocation as a
  distinct late-redirect test.

## Policy hypothesis

Preserve the strongest sampled alignment-gated `7 deg` carrier exactly in the
far field: acute bearing/yaw-rate mean curvature, anterior joint-state
oscillator, posterior lag, alignment authority, and command limit remain
unchanged. Add one response-gated posterior redirect only when full
body-frame direction error is material and measured closing speed is
inadequate. A continuous normalized approach envelope confines that
conjunction to the evidenced terminal neighborhood, and correct-sign yaw
releases the residual. The redirect changes only the posterior mean
equilibrium; it does not add anterior curvature, alter wave amplitude or
phase, or act during the early course region that the two completed
course-feedback variants degraded.

Expected evidence is the carrier's coherent early wake and progress followed
by a stronger late correct-sign yaw, a minimum below `2.443L`, and ideally
capture or a meaningfully different finite trajectory. Falsify this mechanism
if early motion changes materially, posterior clamp/load residence rises, the
wake shortens or curls, or the same powered lower exit remains without better
closest approach.

```text
bookshelf_consulted: true
source_domain: Lighthill-style posterior-kinematics emphasis combined with biological C-start and sensor-modulated robotic-fish direction tracking
source_mechanism: preserve the propulsive rhythm while large target error plus inadequate closure gates a bounded posterior redirect that measured turn response releases
transferable_invariant: allocate transient steering to the posterior joint only when normalized body-frame geometry and closing response agree that aligned cruise has failed
nontransferable_details: published gains, dimensional frequencies, species or robot kinematics, open-loop burst duration, exact vortex phases, amplitude ratios, and task-specific routes
policy_translation: full direction from target_body_L, normalized projected closing speed, and a continuous approach envelope gate a reflection-equivariant posterior equilibrium residual around the unchanged two-joint state-feedback carrier
falsification: reject on degraded far-field progress or wake coherence, short-radius curling, higher posterior clamp/load residence, no improvement beyond 2.443L, or persistence of the powered lower exit
```

## Implemented candidate and pre-CFD checks

The candidate adds only the approach-localized posterior equilibrium residual
described above. Replaying the four sampled completed trajectories through its
gate (not a hydrodynamic rollout) gives zero median activation outside `6L`;
for the best carrier, the `95th`-percentile posterior bias is below `0.12 deg`
between `3--6L`, then rises to a `1.52 deg` median and `5.19 deg`
`95th` percentile inside `3L`. This is the intended separation between the
evidenced cruise and terminal redirect, not evidence of improved CFD behavior.

The repository's `324` non-CFD tests pass. Direct policy probes also pass the
parameter-schema guard, global reflection, centerline recovery, late-redirect
activation, extreme-input finiteness, and the configured command bounds.
