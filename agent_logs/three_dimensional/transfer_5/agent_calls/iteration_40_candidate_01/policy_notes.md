# Wake-policy diagnosis and candidate hypothesis

## Evidence read before the edit

All four sampled solver rollouts are valid finite captures from direct-uniform
still water: `U_infinity=[0,0,0]`, no cylinders, and no prewarm snapshot. I
inspected the combined sheets for the strongest broad route-handoff rollout
(`solver_bcd55e3d0db4`, independently reproduced by
`solver_bc6f1708043d`) and the weaker full course observer
(`solver_343870fd8107`), including both their top-down mid-plane-vorticity and
oblique body/Lambda2 rows from release through capture. I also inspected both
rows for the assigned-parent angle-quadrature result
(`solver_79996c1f8fe9`), the most informative inherited regression. Every view
shows self-propelled left-and-down motion, a compact alternating wake that is
established early and curves with the approach, continued body undulation, and
no out-of-plane instability. The sheets contain no new wake class or passive
advection that could explain the numerical ordering.

The two broad-handoff texts produce bit-identical CFD: capture at
`23.441015T`, score/mean/final distance
`-0.501134/2.398743/0.746369L`, and unchanged pre-`3L` threshold crossings.
The full observer has the same capture sample but is weaker at
`-0.501691/2.399184/0.746948L`; withdrawing the main-route course residual
only below `1L` is nearly neutral at `-0.501677/2.399172/0.746933L`.
An inherited attempt to qualify the broad handoff by target-progress confidence
also regresses to `-0.501734/2.399219/0.746987L`, so neither a later distance
window nor radial-progress arbitration should be extended.

The assigned parent proposed adding an anterior-angle quadrature to the
carrier-rejected course residual in every route and terminal role. Completed
CFD falsifies that global scope: it delays the `6L` crossing from `15.3065T`
to `15.5815T` and capture from `23.4410T` to `23.7930T`, worsening
score/mean/final distance to `-0.523774/2.421955/0.747022L`. Yet it supplies a
useful actuator-local observation. Relative to its full-observer structural
parent, inside `3L` its mean/peak yaw improve from `1.6873/3.3497` to
`1.6229/3.0237 rad/T`, mean/peak target-line cross-track speed improve from
`0.2259/0.5830U` to `0.2141/0.5305U`, and peak moment improves from
`0.013886` to `0.013404`. Only about `0.061T` of its total `0.352T` delay is
accumulated after `3L`; most of the loss is caused by admitting the quadrature
to the pre-terminal route observer.

On the strongest completed trajectory, the tested angle coordinate changes the
inside-`3L` rate-only course residual RMS from `0.1307U` to `0.0849U` while
preserving its signed mean (`0.0300U` to `0.0277U`). It changes residual sign
on `23.0%` of terminal samples, mostly between `1--3L`, so it is a material
phase observer rather than a cosmetic scalar perturbation. These offline
measurements establish scale and scope only; they are not evidence for the new
candidate's CFD outcome.

## One-candidate hypothesis

Preserve the strongest sampled controller in full: its posterior-lagged
traveling carrier, broad `3.0L -> 0.75L` main-route handoff, rate-only course
residual for route feedback and terminal desired-yaw classification,
phase-selected anterior correction, cadence-reserve handoff, and smooth command
projection. Add one role-separated observation: only the continuous terminal
course counter receives the tested anterior-angle quadrature. Use the existing
redirect-centered anterior angle so static steering posture is not mistaken
for propulsive phase. This retains the completed quadrature's terminal
carrier-rejection mechanism without letting it bias far or middle route
steering.

Falsify this candidate if formal CFD changes any pre-`3L` crossing, loses
capture or the coherent alternating wake, gives back the broad handoff's
distance benefit without a compensating multi-metric terminal improvement,
fails to improve yaw/cross-track/moment together, or worsens joint-speed or
projected-command feasibility. Formal CFD remains deferred to the post-worker
evaluator.

bookshelf_consulted: true
source_domain: sensor-feedback modulation of robotic-fish coupled oscillators and terminal approach control
source_mechanism: separate the observed propulsive oscillator phase from slow target-course error and restrict a corrective residual to the control role where evidence supports it
transferable_invariant: joint angle and normalized joint rate are observable phase quadratures, but a carrier estimate should affect only the feedback role whose rhythmic contamination it explains while the posterior-lagged traveling wave remains intact
nontransferable_details: published CPG gains, clock phase, robot morphology, species-specific kinematics, dimensional cadence, exact vortex phase, capture radius, and prescribed routes
policy_translation: preserve the normalized body-frame rate-only route observer and two-joint carrier; add the rollout-scaled redirect-centered anterior-angle quadrature only to the continuous terminal target-line course residual
falsification: reject if CFD changes pre-terminal progress, loses capture or wake coherence, regresses score/mean/final distance without a compensating yaw-cross-track-load improvement, or worsens actuator feasibility

## Validation status

The guidance semantic check, parameter-schema audit, and solver boundary check
pass. Static inspection finds one public parameter function, one public policy
function, `74` returned fields, `72` referenced fields, and no undeclared
`params.FIELD`. The required check-runner was invoked but its pinned
`gpt-5.4-mini` model is unsupported by this ChatGPT account, so it failed before
inspection. Julia is not installed (`julia: command not found`), so the
lightweight executable mock-state smoke could not run. No formal CFD was run.
