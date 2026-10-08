# Wake-policy candidate notes

## Inherited and sampled evidence

- The assigned-parent guidance and all sampled diagnostics describe the frozen
  direct-uniform still-water case: `U_infinity=(0,0,0)`, no cylinders, and no
  prewarm. The visible translation is therefore self-propulsion rather than
  ambient advection.
- The highest-score sampled rollout (`solver_53a6ee05b4ed`, `-7.749`) and the
  most informative low-score continuously beating failure
  (`solver_851bdc7bfac6`, `-8.884`) agree visually on the useful mechanism.
  Their top-down rows form a coherent alternating signed-vorticity street and
  their oblique rows resolve persistent three-dimensional Lambda2 structures
  during broad travel. Both move left toward the target through about `12T`;
  neither is a wake-breakup or unstable-CFD failure.
- Both sheets also show the common failure: the path and wake rotate into a
  steep upper hook after the fish passes high. Metrics confirm that the
  highest-score approach hold reaches only `3.592L`, its joints decay toward
  an almost static posterior bend, and it still coasts near `0.73U` into the
  upper boundary at `21.54T`. The continuously beating half-cycle variant
  reaches `3.013L` but exits by the same boundary at `26.16T` with a worse
  `7.457L` final distance.
- The unrelieved inherited bearing-minus-slip carrier remains the strongest
  broad-approach reference: it descends from center `y=14.000L` to about
  `12.324L` and reaches `2.960L` at `17.70T`. Its full-quadrant target angle is
  already about `-0.87 rad` at `16T`, then grows beyond `-2 rad` as heading
  continues the wrong way and the fish exits high. This establishes that the
  missing capability is post-crossing yaw reversal, not more forward drive.
- The assigned parent's latest completed full-quadrant counterstroke relief
  reaches `2.986L` and ends at `6.616L`; the sampled close-pass relief reaches
  `3.013L`. Together with the earlier `11.655L` two-sided half-cycle result,
  these completed rollouts reject more tail-only amplitude/duty attenuation:
  it changes effort or tail waveform without changing termination class.
- Geometry-only carrier relief and distributed static bends likewise fail.
  The sampled hold and full-quadrant redirect settle toward static joint
  postures and coast into the boundary. An inherited state-gated active bend
  retained a nonzero carrier and improved closest approach to `2.679L`, but
  its positive-closing gate released at the pass and it still followed the
  upper-exit topology. A useful redirect must therefore remain available
  while the target is behind and yaw is still moving away, yet release when
  the measured yaw response becomes corrective.

## Policy hypothesis

Restore the unattenuated zero-centered anterior oscillator, posterior lag, and
bounded bearing-minus-slip tail curvature. Recover signed full-quadrant target
angle from normalized `target_body_L`. Add one response-released active
redirect: only outside the broad-approach angular corridor, and only while the
measured normalized heading rate has the wrong sign for the requested turn,
smoothly shift the anterior oscillator center toward a modest target-relative
bend. Do not reduce the oscillator amplitude or posterior carrier. Because the
gate is the reflection-invariant product of turn request and heading rate, the
bend is recruited on wrong-way portions of the observed response and vanishes
as soon as yaw turns correctly; it cannot persist merely because the target is
behind.

The next rollout should exactly recover the sampled carrier in the far or
aligned regime, retain alternating 3D shedding during correction, and produce
a positive-yaw response after the high pass instead of another inertial upper
hook. Falsify the mechanism if it changes broad-approach motion, collapses into
a fixed C-bend, materially increases angle/rate/acceleration limit occupancy,
fails to improve the `2.960L` closest-approach reference, or repeats the same
upper-boundary exit without a distinct recovery arc.

```text
bookshelf_consulted: true
source_domain: biological C-start redirection and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: large direction error recruits a bounded body bend, while measured directional response releases the bend back into rhythmic propulsion
transferable_invariant: preserve the traveling carrier during broad locomotion; when target-relative error is large, apply active curvature only while observed yaw remains wrong-way and release it when yaw becomes corrective
nontransferable_details: species-specific C-start angles, published CPG gains, dimensional thresholds, clock phase, exact vortex phases, and task-specific routes
policy_translation: use normalized full-quadrant target_body_L and body-frame slip for turn direction, combine that request with normalized heading_rate for a smooth response gate, and shift only the gated anterior state-feedback oscillator center while leaving both carrier amplitudes intact
falsification: reject if far-field wake or progress changes, correction becomes a static posture, actuator-limit occupancy rises materially, or bearing and termination topology do not improve
```
