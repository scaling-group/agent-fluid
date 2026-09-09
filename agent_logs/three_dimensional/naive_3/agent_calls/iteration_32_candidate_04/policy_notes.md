# Terminal stroke-energy candidate

## Evidence diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen Phase 2 contract: direct
  uniform initialization at `U_infinity=(0,0,0)`, no cylinders or prewarm,
  finite dynamics, and `horizon` termination at `100T`. I inspected both the
  top-down mid-plane-vorticity and oblique body/Lambda2 rows in every combined
  keyframe sheet. The fish self-propel from rest, form coherent curved
  alternating wakes with compact three-dimensional structures, and execute
  repeated return loops. Passive advection, wake collapse, boundary exit, and
  numerical instability do not explain the misses.
- The terminal course-hold sample remains the useful finite comparison. It
  reaches `1.241L`, spends about `0.47T` inside `1.25L`, and ends at `2.082L`.
  Its tighter late loop is visible in both views. At the minimum it is still
  moving at `0.669U`, with target-ray/course error `1.692 rad`, but retains an
  active anterior stroke (`phi_dot_1=-0.260 rad/T`) and modest commands
  `(0.747,0.923) rad/T^2` rather than parking.
- The assigned optimizer parent's low-activity anterior restart is now
  completed evidence, not a pending hypothesis. Although its frozen replay
  was almost exactly local outside `3L`, coupled CFD regressed to
  `2.369/3.868/3.455L` minimum/mean/final distance versus the course hold's
  `1.241/4.157/2.082L`. Its top-down path and oblique trajectory remain a broad
  powered loop, and at its minimum both joints are nearly stationary in a
  common negative C-bend (`phi=(-0.358,-0.376) rad`,
  `phi_dot=(-0.000,0.002) rad/T`) with commands near zero. The additive
  course-signed kick therefore neither restored a traveling bend nor preserved
  the useful close return; its better mean distance is not a terminal semantic
  improvement.
- Two sibling results independently close equilibrium manipulation as the
  immediate remedy. Joint-state unbending reaches only
  `2.215/3.859/3.416L`, and rear-centerline direction blending reaches
  `2.366/3.875/3.502L`; both show the same broad coherent loop and nearly
  motionless common C-bend near their minima. These results do not support
  another curvature release, course-signed kick, rear selector, posterior
  stroke, or scalar gate/authority retune.

## Policy hypothesis

Return to the completed terminal-course-hold policy and change one mechanism:
when the existing full target-behind and terminal course-hold gates coincide
with abnormally low normalized anterior phase-plane activity, add a bounded
acceleration with the sign of measured anterior joint velocity. This is a
state-dependent energy-shaping term: it supplies energy on either stroke
half-cycle but has no fixed bend direction. The unchanged posterior lag must
then turn recovered anterior motion into the established traveling bend. At
zero velocity the term is zero, and it releases continuously as normalized
activity recovers, so it cannot define a hidden phase or new equilibrium.

The transfer is supported only if the candidate preserves the first recovery
and coherent wake while beating the `1.241L` minimum, increasing residence
inside `1.25L`, capturing, or materially improving the final close return with
comparable command/load residence. Reject it if the term cannot escape the
quiet bend, creates high-frequency chatter, inflates clamp/load residence,
disrupts the anterior-to-posterior lag, changes the first recovery, or retains
the same broad noncapturing orbit. In particular, frozen-trace locality will
not be treated as evidence of coupled-trajectory locality after the assigned
parent's negative result.

```text
bookshelf_consulted: true
source_domain: traveling-wave swimming theory and sensor-modulated robotic-fish CPG control
source_mechanism: preserve a directionally propagating anterior-to-posterior bend while feedback restores energy to a weakened rhythmic carrier
transferable_invariant: recovery feedback should add alternating stroke energy without changing the mean steering equilibrium; posterior lag then converts anterior rhythm into a traveling bend
nontransferable_details: published gains, dimensional beat frequency, species-specific envelopes, full-body joint count, exact vortex phase, clocked CPG phase, target coordinates, capture radius, and prescribed routes
policy_translation: normalized anterior phase-plane activity about the existing body-frame terminal equilibrium gates a bounded acceleration odd in measured anterior joint velocity; the unchanged two-joint posterior state-feedback lag propagates the recovered stroke
falsification: reject if the quiet bend persists, the action becomes one-sided or chatters, the first recovery or wake coherence changes, clamp/load residence worsens, or near-target and final-distance statistics do not improve
```

## Evaluation boundary

The new coupled CFD result is unavailable until this worker exits. Local
checks may establish parameter ownership, boundedness, reflection equivariance,
and where the new feedback acts, but cannot establish hydrodynamic improvement.

## Implemented candidate and non-CFD probes

The candidate returns exactly to the completed terminal-course-hold scaffold
and adds four owned parameters for one stroke-energy mechanism. The normalized
phase-plane radius gates a smooth acceleration proportional to the sign of
normalized anterior velocity. At exact zero velocity the candidate is
identical to the scaffold; positive and negative residual stroke velocities
receive equal-and-opposite anterior acceleration, and the posterior command is
unchanged directly. No steering equilibrium, curvature authority, posterior
lag, carrier amplitude, or command bound changed.

An active synthetic terminal probe found a maximum `0.0992 rad/T^2` action
difference at `phi_dot_1=0.005 rad/T`; reversing that velocity reversed the
difference exactly, while `phi_dot_1=0` produced zero difference. A mirrored
terminal probe negated both actions with zero numerical residual, and all
probed actions remained finite and inside the declared `+/-28 rad/T^2`
reserve. All 48 direct `params.FIELD` references are owned by
`target_policy_params()`.

The required material-guidance check, lightweight Julia contract, deterministic
parameter-schema guard, and solver editable-boundary check pass. The duplicate
assigned-parent marker in the rendered workspace `README.md` was removed so
the mandated checker could identify one parent. No formal CFD was run.
