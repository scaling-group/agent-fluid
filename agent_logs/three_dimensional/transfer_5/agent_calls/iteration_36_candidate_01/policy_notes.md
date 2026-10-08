# Candidate wake-policy notes

## Evidence diagnosis before editing

All four sampled solver rollouts and the assigned-parent child are finite
captures from direct-uniform still water with `U_infinity=(0,0,0)`, no
cylinders, and no prewarm snapshot. I inspected the combined keyframe sheets
for the strongest and weakest sampled captures, including the top-down
mid-plane-vorticity and oblique body/Lambda2 rows from release through
termination. Both fish self-propel along the same smooth curved approach,
produce an ordered alternating wake, and retain compact three-dimensional
structures through capture. Neither shows passive advection, collision,
boundary exit, wake collapse, or numerical instability. The controller
differences are below keyframe resolution, so the trajectory, load, joint, and
command histories decide the comparison.

The strongest sample is the prefilled two-role stabilization-envelope handoff:
it captures at `23.375013T`, scores `-0.502603`, and has scoring mean/final
distance `2.400102/0.746257L`. The full progress-release comparison captures
on the same step but regresses to `-0.505158/2.402131/0.748882L`. The two
course-demand-only copies lie between them at
`-0.503415/2.400748/0.747085L`. Thus allowing both established terminal
feedback roles to yield only the small progress cadence reserve is a real
distance-progress improvement, not merely a scalar-score fluctuation.

The assigned-parent child supplies a distinct completed comparison. Its
conjunctive target-progress/course-demand handoff also captures at
`23.375013T`, but reaches only `-0.503665/2.400948/0.747334L`; inside `3L` its
mean/peak yaw, moment, and target-line cross-track speed are
`1.71421/3.27985 rad/T`, `0.006596/0.014451`, and
`0.23464/0.61748U`. The sampled two-role envelope improves the corresponding
means to `1.70656 rad/T`, `0.006564`, and `0.23432U`, and raises mean radial
closing to `0.69819U`, but its peaks worsen to `3.28817 rad/T`, `0.015118`,
and `0.62616U`. Recorded commands remain smoothly bounded near
`31.39 rad/T^2`; about `19.3%` of inside-`3L` samples touch a joint-speed cap.
This mixed result supports the two feedback roles but exposes an arbitration
mismatch: the cadence handoff uses the magnitude of the phase-selected yaw
request during both beat halves, whereas the anterior curvature correction is
actually applied only on its yaw-supporting observed half-cycle.

## Single candidate hypothesis

Retain the evaluated target-progress-qualified carrier, response-released
C-bend, anterior-only continuous course response, distributed joint-rate cue
only for phase classification, posterior traveling wave, steering gains, and
component-wise smooth command projection. Change only the feedback-role
coordination: compute the same bounded joint-state tail-side gate used by the
phase-selected anterior correction, and let that role yield progress cadence
only on the half-cycle where the correction is physically active. The
continuous course-brake magnitude remains the other member of the bounded
maximum envelope. No gain, clock, fixed phase, route state, world coordinate,
or task identity is added.

This should preserve the sampled envelope's middle-course progress and
coherent wake while removing needless opposite-half-cycle carrier withdrawal.
Falsify it if capture is delayed, scoring mean/final distance regress beyond
the best sample, inside-`3L` peak moment or cross-track speed fails to improve
from `0.015118` or `0.62616U`, mean yaw/load/cross-track loses the sample's
advantage, or joint/command-limit exposure worsens.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning by asymmetric flapping and sensor-feedback modulation
source_mechanism: coordinate rhythmic carrier authority with a steering correction on the observed beat half-cycle where that correction acts
transferable_invariant: preserve the posterior-lagged carrier and couple reserve propulsion withdrawal to the same bounded joint-state phase event as the active correction
nontransferable_details: published gains, dimensional frequencies, clocked oscillator phase, duty ratios, species-specific kinematics, full-body waveforms, exact vortex phases, and task-specific routes
policy_translation: derive tail side from normalized two-joint tangent state, qualify the phase-selected yaw demand by its existing yaw-supporting half-cycle gate, and combine it with the continuous body-frame course demand only for cadence-reserve handoff
falsification: reject if direct-uniform or held-out CFD loses capture/progress or wake coherence, does not improve the sampled peak cross-track/load defect, or worsens actuator feasibility

## Validation plan

Do not run formal CFD. After materializing the single candidate and durable
guidance update, invoke the configured check runner, execute its prescribed
non-CFD checks, audit the direct parameter schema, and run the lightweight
Julia contract smoke only if a Julia runtime is available.

## Validation status

The configured check runner was invoked, but its pinned `gpt-5.4-mini` model is
unavailable on this account and failed before workspace inspection. Its
prescribed checks were therefore executed directly and separately. The
guidance materiality check passes, confirming that these notes exist and the
assigned-parent experience has a semantic reusable update. The solver boundary
check also passes, with exactly one nonempty canonical candidate.

No Julia executable is installed, so the lightweight runtime contract smoke
cannot launch. A deterministic static audit finds each public function exactly
once and `70` unique direct `params.FIELD` references among `72` returned
fields, with no undeclared reference; only `version` and `control_period` are
metadata. The candidate contains no explicit time/step state, randomness, file
I/O, cylinder or wake-position cue, mutable global state, or memorized route.
Candidate SHA-256:
`9001e6b5e435af3f3237ee14b57fc0653f3bce5c882eaf5e50c6a26e4abc5b60`.
No formal CFD was run.
