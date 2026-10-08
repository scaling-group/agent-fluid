# Wake-policy diagnosis and candidate hypothesis

## Evidence read before the edit

All four sampled solver evaluations and the assigned-parent inherited rollout
are valid finite captures from the required direct-uniform still-water start:
`U_infinity=[0,0,0]`, no cylinders, and no prewarm snapshot. I inspected the
combined keyframe sheets for the strongest sampled policy and the informative
assigned-parent regression, including the top-down mid-plane-vorticity and
oblique body/Lambda2 rows from release through termination. In both cases the
fish self-propels along the same smooth left-and-down target arc. A compact
alternating wake forms behind the body, remains coherent as the route curves,
and has corresponding three-dimensional Lambda2 structures without passive
advection, wake collapse, or out-of-plane instability. The keyframes are
visually indistinguishable at their sampling cadence, so the evidence supports
preserving the carrier and treating the measured differences as a terminal
route-authority effect rather than a new wake class.

The full course observer (`solver_343870fd8107`) captures at `23.441015T` with
score and scoring mean/final distance
`-0.501691/2.399184/0.746948L`. Withdrawing only its slow course residual from
the main steering request across the existing `3.0L -> 0.75L` terminal window
is independently reproduced by `solver_bc6f1708043d` and
`solver_bcd55e3d0db4`: both retain every `6/3/2/1L` crossing and the same
capture step while improving score and mean/final distance to
`-0.501134/2.398743/0.746369L`. The benefit is narrow rather than a load cure.
Inside `3L`, mean absolute yaw changes from `1.68733` to `1.68837 rad/T`,
mean/peak target-line cross-track speed from `0.22592/0.58297U` to
`0.22619/0.58481U`, and peak absolute moment from `0.013886` to `0.014319`;
only peak yaw improves slightly from `3.34971` to `3.34789 rad/T`.

The inherited assigned-parent policy qualifies that broad proximity handoff by
the normalized positive radial-progress fraction and swimmer-speed confidence.
Its completed rollout (`solver_8a8fede7562f`) keeps the same threshold
crossings, capture step, and visible wake but regresses score and mean/final
distance to `-0.501734/2.399219/0.746987L`, slightly worse than even the full
observer. It recovers mean/peak yaw to `1.68726/3.34642 rad/T` and trims the
broad handoff's peak moment to `0.014167`, but cross-track motion remains worse
than the full observer and peak moment still exceeds its `0.013886`. Thus
reintroducing the course term whenever instantaneous progress quality falls is
not a useful arbitration mechanism: it removes the only reproduced distance
benefit without jointly restoring the prior load balance. The sampled
below-`1L` handoff is likewise a near-no-op at `-0.501677` with the same
capture sample, so another qualification gate or threshold refinement is not
supported.

## One-candidate hypothesis

Produce exactly one candidate by restoring the independently reproduced broad
terminal route-layer handoff. Keep the normalized carrier-rejected target-course
observer at full authority outside `3L` and in terminal desired-yaw
classification. Over the already established continuous terminal-proximity
window, withdraw only that observer's contribution to the main geometric
request. Preserve bearing/vector/rate steering, target-progress cadence,
stabilization-envelope cadence withdrawal, anterior phase-selected correction,
posterior traveling-wave lag, and smooth component-wise command projection.
This is a structural replay of the strongest sampled controller, not another
scalar gain or gate, and it adds no clock, memory, world coordinate, or
task-specific route.

The falsifiable expectation is deterministic reproduction of the sampled
capture, coherent alternating wake, unchanged pre-`3L` trajectory, and improved
mean/final distance. Reject it if post-worker CFD fails to reproduce those
properties, loses actuator feasibility, or raises peak moment beyond the
already measured trade. Future work should treat the remaining load defect as
requiring a distinct actuator or feedback primitive, not another route-handoff
qualification.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG path following and terminal approach control
source_mechanism: a slow target-course correction modulates a preserved rhythmic carrier and yields continuously to measured near-field stabilization
transferable_invariant: separate persistent route correction from the posterior-lagged propulsive carrier and hand off only the route layer when bounded terminal feedback becomes authoritative
nontransferable_details: published gains, dimensional cadence, robot morphology, species-specific envelopes, duty ratios, exact oscillator or vortex phase, capture radius, and prescribed routes
policy_translation: use normalized body-frame distance to complement the existing terminal-proximity coordinate and withdraw only the carrier-rejected course residual from the main two-joint steering request while preserving its observer role and the full traveling carrier
falsification: reject if CFD fails to reproduce capture, coherent wake, pre-terminal progress, and the sampled mean/final-distance benefit, or if actuator feasibility or the measured peak-load trade worsens

Formal CFD is intentionally deferred to the post-worker evaluator.

## Validation status

The prescribed guidance/material-change and editable-boundary checks pass. An
independent static audit finds `73` returned parameter fields, `71` referenced
fields, and no undeclared reference; it also verifies the default `L=64.0`, the
required mock-state fields, and the two-element `phi_ddot` return shape. The
configured check-runner was invoked but could not start because its pinned
`gpt-5.4-mini` model is unavailable to this account, so an available read-only
fallback agent reran the same checks. Julia is not installed (`julia: command
not found`), preventing only the executable mock-state smoke. No formal CFD was
run.
