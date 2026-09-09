# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- All four sampled rollouts are valid direct-uniform still-water evaluations:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, and finite dynamics. Their
  displacement is self-propulsion, not advection or inherited-flow carryover.
- I inspected every top-down mid-plane and oblique Lambda2 panel in the
  combined sheets for the strongest sampled course-selected posterior
  phase-lag policy (`2.326L` minimum, `8.424L` mean) and the informative
  response-gated posterior S-bend failure (`2.536L`, `8.436L`). Both show an
  alternating planar wake and compact three-dimensional shedding from release
  through termination. Both approach diagonally, pass laterally outside the
  capture disk, rotate onto the same steep downward leg, and remain powered to
  the lower boundary near `31.6T`. Wake collapse, weak cruise, instability,
  and moving-window transport are therefore not the primary failure.
- The assigned parent is the yaw-response-selected posterior brake (`2.385L`
  minimum, `8.436L` mean). Against it, anterior duty asymmetry worsens the
  minimum to `2.433L`, and response-gated posterior S-bending worsens it to
  `2.536L`. Posterior phase-lag modulation gives the only favorable movement,
  to `2.326L` and `8.424L`, but retains the identical powered lower exit.
  Inherited notes report a median target-ray/course mismatch near `1.53 rad`
  inside `3L`; the new phase-lag rollout confirms that small continuous
  waveform edits can trim distance without supplying a semantic recovery.
- The inherited record already rejects scalar brake edits, static C/S-bend
  allocation, persistent posterior redirects, gait-yaw course estimation, and
  small anterior duty modulation. The surviving physical opportunity is a
  genuinely nonsteady redirect: finite speed and coherent propulsion remain at
  closest approach, while the slow course mismatch is large and one-signed.

## Policy hypothesis

Preserve the assigned parent's far-field mean-curvature carrier, posterior
lag, alignment envelope, wrong-way-yaw half-cycle brake, and acceleration
reserve. Add one response-released burst mechanism. A smooth envelope of
normalized distance, speed, and signed body-frame target-ray/course mismatch
commands a bounded same-sign equilibrium displacement at both joints, forming
a C-bend rather than reallocating the ordinary traveling wave. The same
envelope attenuates the oscillatory wave during preparation; course alignment
continuously removes the C-bend and restores the full lagged posterior beat.
There is no clock, stage counter, fixed route, or world-frame direction.

Expected evidence is unchanged far-field progress and coherent cruise wake,
then a distinct compact redirect before the old lateral pass, followed by
release into renewed propulsion. Capture, a recovery trajectory, a new
termination class, or a materially smaller minimum than `2.326L` supports the
mechanism. Falsify it on any early-course change, a persistent tight curl,
joint-limit residence or load growth, collapsed/reversed shedding, failure to
release after course alignment, or the same powered lower exit without a
material closest-approach improvement.

```text
bookshelf_consulted: true
source_domain: biological C-start maneuvers and sensor-modulated robotic-fish CPG control
source_mechanism: large-error bounded C-bend preparation followed by response-dependent release into a propulsive traveling beat
transferable_invariant: a persistent directional error may call for a temporary nonsteady whole-tail redirect whose release is determined by observed response rather than elapsed time
nontransferable_details: species-specific C-start angles, published robot gains, dimensional frequencies, body envelopes, clocked CPG stages, exact vortex phases, capture radius, and task-specific route
policy_translation: normalized body-frame target and velocity directions select a reflection-equivariant course-error envelope; near the target it displaces both joint equilibria to the same bend side and attenuates the lagged wave, while decreasing course error continuously releases the state-feedback oscillator and posterior traveling bend
falsification: reject if cruise changes, the maneuver becomes a persistent curl, actuation or loads rise materially, the coherent wake is lost, release does not follow course correction, or closest approach and lower-exit topology remain materially unchanged
```

## Evaluation boundary

Formal CFD runs only after this worker exits. Local checks can establish the
contract, boundedness, reflection behavior, far-field locality, and intended
mode transition, but cannot claim hydrodynamic improvement.

## Implemented candidate and controller-only audit

The candidate adds only the response-released C-bend mechanism described
above to the assigned `2.385L` brake. At the parent's recorded minimum-distance
state (`2.385L`, course mismatch `1.152 rad`), the normalized burst weight is
`0.764`; the command changes from `(10.960,-0.306)` to
`(26.108,4.536) rad/T^2`. Thus both joints are driven toward the requested bend
side without consuming the `+/-28 rad/T^2` software reserve at that state.

Counterfactual replay on the completed parent states gives mean burst weight
`0.717` inside `3L`, `0.464` between `3--4L`, and `0.019` outside `4L`. At a
copy of the minimum state moved to `12L`, the weight is `1.44e-6` and action
deltas are below `3e-5 rad/T^2`; aligning velocity with the target ray reduces
the weight to `4.30e-4` and action deltas below `0.003 rad/T^2`. Replayed
anterior clamp fraction decreases slightly (`0.747` to `0.743`), while
posterior clamp fraction would rise from `0.356` to `0.413`; the latter is a
specific CFD falsification risk, not a claim about the new coupled trajectory.
Mirrored target, velocity, joint, bearing, and yaw inputs have zero action
reflection residual. Extreme finite probes remain clamped to the declared
reserve, and all `31` unique direct `params.FIELD` references are declared.

The mandated material-guidance, lightweight Julia policy-contract, and solver
boundary checks pass. Formal CFD was not run.
