# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- All four sampled evaluations report direct uniform initialization in still
  water with `U_infinity=(0,0,0)`, no cylinders, and no prewarm. Their finite
  motion is self-propulsion rather than advection or inherited-flow carryover.
- I inspected the combined sheets for the strongest sampled response-selective
  posterior brake (`2.385L` minimum, `8.436L` mean) and the newest informative
  course-selected differential S-bend failure (`2.469L`, `8.439L`), including
  every top-down vorticity frame and oblique body/Lambda2 frame. Both sustain an
  alternating planar wake and compact three-dimensional vortex structures,
  follow the same diagonal inbound path, pass below the target, turn onto a
  nearly vertical downward leg, and remain powered until lower-boundary exit
  near `31T`. The defect is terminal course steering, not wake collapse,
  collision, instability, or weak propulsion.
- The alignment-gated carrier reaches `2.443L`; weakening the posterior wave
  only on measured error-growing yaw half-cycles improves it modestly to
  `2.385L`. The sampled response-gated posterior S-bend reaches `2.536L`, and
  the course-selected differential S-bend reaches `2.469L`. Inherited completed
  evaluations also leave geometric posterior persistence (`2.484L`), symmetric
  approach hold (`2.429L`), response-selected posterior reallocation
  (`2.444L` or worse), polarity reversal (`2.406L` or worse), gait-yaw
  residualization (`2.541L`), and closure-gated anterior equilibrium redirect
  (`2.569L`) in the same lower-exit class. This rejects another scalar brake
  edit, static joint offset, or posterior half-cycle reallocation.
- A slower geometric signal does survive: reconstructed target-ray/course
  error has the same positive sign for every sampled state inside `3L`, with
  median magnitude about `1.53 rad` in all four traces. At the best minimum it
  remains `1.15 rad` while speed is `0.705U`; by contrast instantaneous yaw is
  beat-locked and alternates. The course selector is therefore persistent
  enough to choose a corrective bend side, although the failed shared and
  differential equilibrium allocations show that it should not command
  another static C- or S-bend.

## Policy hypothesis

Start from the strongest sampled response-selective posterior brake and
preserve its mean-curvature cruise steering, posterior lag, alignment envelope,
wrong-way-yaw brake, and command reserve. Add one actuator mechanism: when a
smooth near-target envelope, finite speed, and signed target-ray/course error
agree, make the anterior state-feedback oscillator traverse the error-opposing
bend faster and dwell modestly on the corrective bend. This is a bounded
duty-ratio asymmetry in oscillator restoring authority, not an equilibrium
shift, amplitude/gain-only retune, clocked phase, or prescribed route. It
releases continuously with distance, speed, or course alignment.

Expected evidence is the established cruise trajectory and coherent wake,
followed by an earlier upward course rotation without a static tight curl.
Capture, a useful new termination class, or a minimum materially below
`2.385L` with retained mean distance would support the mechanism. Falsify it
on altered far-field progress, lost or strongly one-sided wake coherence,
premature speed loss, a tight curl, materially higher anterior limit/load
residence, or the same powered lower exit without useful closest-approach
improvement.

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG turning and asymmetric flapping
source_mechanism: target-directed turning by changing the relative dwell of the two bend half-cycles while retaining a traveling propulsive rhythm
transferable_invariant: persistent directional error can select a bounded corrective-side duty asymmetry without replacing the propulsive carrier or relying on elapsed-time phase
nontransferable_details: published gains, dimensional frequencies, robot geometry, species-specific kinematics, clocked CPG phase, exact duty ratios, vortex phases, approach radii, and task-specific routes
policy_translation: normalized body-frame target and velocity directions form a reflection-equivariant course error; normalized distance and speed localize a joint-angle-selected, bounded side-dependent restoring coefficient in the anterior state-feedback oscillator while its joint-velocity drive and the evidenced posterior brake remain unchanged
falsification: reject on changed cruise, a one-sided or collapsed wake, premature speed loss, a tight curl, increased anterior saturation or load residence, no material improvement below 2.385L, or persistence of the powered lower exit
```

## Evaluation boundary

Formal CFD occurs only after this worker exits. Controller replay and contract
checks can establish locality, reflection equivariance, finite bounds, and the
intended duty asymmetry, but cannot establish hydrodynamic improvement.

## Implemented candidate and pre-CFD checks

The candidate implements only the course-selected anterior duty asymmetry
described above. It starts from the sampled `2.385L` brake; the posterior mean,
lagged wave, alignment envelope, response-selective attenuation, and command
bound are unchanged for every identical input state. All `29` direct
`params.FIELD` references are declared by `target_policy_params()`.

At a state reconstructed from the best sample's minimum, the candidate changes
the anterior command from `10.960` to `11.784 rad/T^2` and leaves the posterior
command exactly unchanged. Moving the same state to `8L` reduces the anterior
difference to `5.7e-5 rad/T^2`; aligning translational course with the target
ray reduces it to `2.4e-6 rad/T^2`. In an unsaturated phase probe, a `0.15 rad`
corrective bend relaxes restoring acceleration from `-19.58` to
`-17.95 rad/T^2`, while the mirrored opposing bend is driven back faster
(`19.58` to `21.21 rad/T^2`). These establish the intended dwell/traverse
asymmetry without predicting coupled hydrodynamics.

Re-evaluating the candidate and sampled brake on completed states gives mean
absolute anterior-command differences of `0.0030--0.0033 rad/T^2` beyond `4L`,
`0.148--0.166 rad/T^2` between `3--4L`, and `0.307--0.326 rad/T^2` inside `3L`.
Posterior-command difference is exactly zero, and replayed anterior clamp
residence decreases slightly rather than rising. Direct probes give zero
reflection residual, finite extreme-input actions within `+/-28 rad/T^2`,
course-alignment release, and far-field locality.

After removing only a duplicate assigned-parent marker from the rendered
workspace `README.md`, the mandated material-guidance, lightweight Julia
contract, and solver-boundary checks pass. All `324` repository non-CFD
assertions also pass. Formal CFD was not run.
