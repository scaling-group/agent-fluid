# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- All four sampled solver evaluations and the relevant inherited evaluations
  report direct uniform initialization in still water with
  `U_infinity=(0,0,0)` and no prewarm. Their displacement and wakes are
  self-generated rather than advection or inherited-flow contamination.
- I inspected both the top-down vorticity and oblique body/Lambda2 rows for all
  four sampled policies, then compared the inherited response-selected
  counterstroke and gait-yaw-residual evaluations. Every sheet shows the same
  long alternating three-dimensional wake, diagonal inbound path, turn to a
  near-vertical path below the target, and powered lower-boundary exit near
  `31T`. There is no visible collision, wake collapse, or instability. The
  remaining defect is terminal course correction, not propulsion.
- The sampled measured-yaw posterior brake remains strongest at
  `2.385/8.436L` minimum/mean distance. The assigned parent's completed
  response-selected posterior counterstroke reached only `2.406/8.448L`, and
  inherited gait-yaw demodulation reached only `2.541/8.449L`; both retained
  the coherent wake and `left_domain` lower exit. Together with the sampled
  phase counterbend (`2.512L`) and equilibrium S-bend (`2.536L`), this is
  negative evidence against another posterior reallocation, half-cycle gain,
  scalar brake edit, or fitted joint-rate/yaw residual.
- The body-frame angle from the target ray to translational course supplies a
  distinct persistent signal. Across the four sampled traces plus the two
  inherited completed traces, every observation inside `3L` with speed above
  `0.2U` has the same signed course mismatch; median magnitudes are
  `1.525--1.544 rad`. The best brake still has `1.152 rad` course mismatch,
  `0.705U` speed, and `2.385L` distance at its minimum. Unlike raw yaw, whose
  sign is beat-locked to anterior joint velocity, this mismatch never releases
  during the diagnosed approach. Earlier global sideslip-to-curvature feedback
  failed catastrophically (`12.150L` minimum and upper exit), so any use of
  translational course must be localized to the established near approach and
  must compare full target and velocity directions rather than raw lateral
  velocity.

## Policy hypothesis

Start from the sampled response-gated brake and preserve its oscillator,
bounded target-bearing mean curvature, posterior lag and alignment envelope,
raw-yaw posterior selector, command reserve, and far-field behavior. Add one
continuous approach-localized redirect primitive at the anterior course layer:
when normalized body-frame translational velocity points persistently away
from the target ray, add bounded mean curvature of the same corrective sign;
release it continuously as course aligns, speed vanishes, or distance grows.
This is a geometric course-error burst rather than posterior reallocation,
scalar gain tuning, or direct sideslip damping.

The expected evidence is unchanged far-field progress and a coherent traveling
wake followed by an earlier upward course rotation inside roughly `3.6L`.
Capture, a useful termination-class change, or a minimum materially below
`2.385L` supports the mechanism. It is falsified by changed cruise, a short
tight curl, lost wake coherence, increased limit/load residence, or the same
powered lower exit without a better minimum.

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish direction tracking and biological burst redirect
source_mechanism: large observed course error requests a bounded curvature burst while the traveling-wave carrier continues, then measured geometric correction releases the burst
transferable_invariant: preserve the propulsive wave and apply extra turning authority only while body-frame translational course remains misaligned with the target ray
nontransferable_details: published gains, clock-driven CPG phase, robot geometry, species-specific kinematics, dimensional frequencies, prescribed burst timing, exact vortex phases, and task routes
policy_translation: normalized target_body_L and velocity_body_U define a reflection-equivariant signed course angle; normalized distance, speed, and course error smoothly gate added anterior mean curvature within the two-joint state-feedback carrier
falsification: reject if far-field progress or wake coherence changes, a tight curl or greater actuator/load residence appears, or closest approach and the lower-exit class do not improve over the 2.385L response brake
```

## Evaluation boundary

The new candidate receives formal CFD only after this worker exits. Static
signal, contract, locality, symmetry, and bound checks can validate the
implementation but cannot establish hydrodynamic improvement.

## Implemented candidate and non-CFD checks

The candidate implements only the course-error redirect described above. Its
distance envelope uses a steep approach gate, its zero-speed gate removes the
undefined course direction, and the signed angle is formed from normalized
body-frame target and velocity vectors. At a state reconstructed from the best
brake's minimum, the new mechanism changes the two joint commands by about
`(+7.166,+7.165) rad/T^2`; the same state placed at `8L` changes them by less
than `0.00065 rad/T^2`. These are static action probes, not coupled-flow
predictions.

The mandated material-guidance check, lightweight Julia contract, deterministic
parameter-schema guard, and solver-boundary audit pass. A grid of `54675`
mirrored states remains finite and within the configured `28 rad/T^2` reserve,
with zero numerical reflection error; the zero-target/zero-speed state returns
zero commands. All `324` repository non-CFD assertions pass. Formal CFD was
not run.
