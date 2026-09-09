# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- The assigned parent, all four sampled solver evaluations, and the inherited
  optimizer logs report direct uniform still water with
  `U_infinity=(0,0,0)`, no cylinders, and no prewarm snapshot. Their finite
  translation is self-propulsion rather than advection or initialization
  contamination.
- I inspected both the top-down mid-plane-vorticity and oblique body/Lambda2
  rows for the strongest sampled posterior counter-bend (`2.187L` minimum),
  the informative response-gated redirect failure (`2.601L`), and the
  assigned-parent target-ray residual (`2.011L`). All retain long,
  alternating planar streets and compact three-dimensional wake structures
  through approach. None shows wake collapse or instability; each crosses
  below the target while still powered and exits through the lower boundary.
- The sampled carrier, counter-bend, and assigned parent separate a useful
  trend from an unchanged failure topology. Opposite-sign posterior
  counter-bending improved minimum distance from `2.443L` to `2.187L`,
  and adding a bounded target-ray cross-velocity residual improved it again to
  `2.011L`. Parent peak force/moment remained comparable to the carrier
  (`0.0261/0.0150` versus `0.0256/0.0148` in the logged lateral-force and
  yaw-moment channels), while posterior acceleration-clamp residence fell
  from `38.1%` for the counter-bend to `35.0%`. This supports the residual
  sign and feedback information, not more posterior scalar authority.
- The parent nevertheless falsifies posterior-only course correction as a
  complete capture mechanism: it retained the lower exit, worsened mean
  distance from `8.446L` to `8.740L`, and ended at `9.836L`. At its
  `2.011L` closest approach the target was just behind the body-normal plane
  (full body-frame direction error about `1.624 rad`), forward speed remained
  about `0.636U`, and target-ray cross-velocity residual remained about
  `0.642U`. The posterior residual was already near its shared envelope, so
  repeating a larger posterior gain or a geometry-persistent posterior bend
  is not supported; the latter independently reached only `2.477L`.

## Policy hypothesis

Preserve the assigned parent's state-feedback oscillator, yaw-released
mean-curvature steering, alignment-gated posterior wave, wrong-side
counter-bend, terminal target-ray residual, frequency, amplitude, lag, and
command reserve. Add one actuator-topology mechanism: use the already
sign-calibrated, distance-enveloped course residual as a small anterior
equilibrium contribution while it continues to subtract posterior
equilibrium. This creates a differential anterior/posterior course couple
rather than raising the saturated posterior channel alone.

Replay on the completed parent trace, without claiming a new hydrodynamic
result, requests only about `0.13/0.39/0.60 deg` of additional anterior
equilibrium at the inbound `8/6/4L` crossings, rising to
`1.80/2.53/2.74 deg` at `3/2.5/2.011L`. Expected evidence is the parent's
far-field route and coherent wake followed by greater terminal yaw relative
to surge, a closest approach below `2.011L`, and ideally capture or a
meaningfully different redirect. Falsify if release or far-field progress
changes materially, a short-radius curl or wake collapse appears, anterior
joint-limit/load residence rises sharply, minimum distance fails to improve,
or the same powered lower exit persists without a useful trajectory change.

```text
bookshelf_consulted: true
source_domain: elongated-body posterior-kinematics theory, robotic-fish mean-curvature turning, and terminal capture control
source_mechanism: preserve a propulsive state-feedback rhythm while a bounded target-relative course error creates differential anterior/posterior steering during approach
transferable_invariant: a persistent normalized course error can modulate a bounded joint-equilibrium couple without replacing the traveling-wave carrier or relying on exact wake phase
nontransferable_details: published gains, dimensional frequencies, species kinematics, robot geometry, exact vortex phases, approach distances, duty ratios, and task-specific routes
policy_translation: apply the distance-enveloped signed cross product of normalized target_body_L and velocity_body_U weakly to anterior equilibrium and oppositely to the inherited posterior equilibrium
falsification: reject on changed release, lost far-field progress or wake coherence, a terminal curl, sharply greater anterior limits or loads, failure to beat 2.011L, or an unchanged powered lower exit
```
