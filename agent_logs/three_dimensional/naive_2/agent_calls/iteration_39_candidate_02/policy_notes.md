# Approach-scheduled harmonic-excursion candidate

## Visual and metric diagnosis before editing

The assigned-parent rollout and all four sampled solver rollouts satisfy the
frozen initialization contract: direct uniform still water with
`U_infinity=(0,0,0)`, no cylinders or prewarm, finite dynamics, and capture
termination. I inspected the combined sheets from release through capture in
both required views. Their top-down rows show genuine down-left self-propulsion
behind coherent alternating mid-plane wakes, while the oblique rows show
compact body-connected three-dimensional vortex trains. The score-leading
tail-only residual, assigned parent's harmonic predictor, sampled scheduled
linear predictor, and unconditional spillover parent all retain that route and
wake topology. There is no visible passive advection, wake breakup, boundary
interaction, or instability. The propulsive carrier, far-field navigation,
and response-plus-miss handoff therefore remain useful and are preserved.

The synchronized trajectory diagnostics isolate terminal excursion prediction:

- tail-only cubic redirection is fastest and score-best at
  `15.1403T/-0.01094`, but its `0.651L` head-relative course miss,
  `0/1.269%` anterior/posterior `>40 deg` dwell, and `0.04041/0.01902`
  peak normalized planar force/moment show inadequate posterior reserve;
- the assigned parent's one-sided harmonic-peak predictor improves the course
  to `0.419L`, gives `0/0.680%` dwell and `0.03836/0.01819` loads, and keeps
  the compact wake, but arrives at `15.3677T/-0.01809`, just outside the
  inherited `15.14--15.34T` arrival class;
- approach-scheduling a linear angle-plus-rate projection recovers arrival to
  `15.2650T/-0.01575` and improves dwell/loads to `0/0.360%` and
  `0.03781/0.01864`, but widens the course to `0.529L`, failing the established
  `0.461L` margin boundary;
- unconditional absolute-reserve spillover uniquely reaches `0.362L`, but its
  `15.4464T` arrival and `0.285/0.996%` dwell exchange do not dominate the
  harmonic parent.

Thus scheduling is evidenced to recover translation, while harmonic phase-
plane prediction is evidenced to protect course margin without the linear
projection's double counting. The candidate tests their small compatible
combination rather than another reserve threshold, projection gain, carrier
change, or static curvature edit.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: robotic-fish sensor-modulated CPG control and oscillator phase-plane analysis
source_mechanism: preserve a traveling propulsive carrier while scheduling anticipatory excursion protection from measured approach geometry
transferable_invariant: steering reserve should anticipate the next rhythmic excursion, but protective modulation should engage only as task-relative approach geometry makes terminal margin active
nontransferable_details: published gains, dimensional beat frequencies, hardware duty ratios, robot linkage geometry, species-specific envelopes, exact vortex phases, task coordinates, routes, and waypoints
policy_translation: retain normalized body-frame predicted miss for redirect sign; smoothly schedule each joint's one-sided harmonic peak estimate with the existing near-target distance gate, leaving the earlier directional allocator and all carrier terms unchanged
falsification: reject if capture or the compact wake is lost, terminal miss exceeds 0.461L, anterior or posterior dwell exceeds 0/0.681%, peak normalized force/moment exceeds about 0.040/0.019, or arrival remains outside 15.14--15.34T without a compensating margin gain

## Single candidate hypothesis

Start from the assigned parent's harmonic-peak controller and change one
feedback composition. Each joint still uses target-relative redirect sign,
directional rate reserve, and a one-sided harmonic phase-plane peak. Multiply
only the smooth outward-phase interpolation toward that peak by the inherited
body-frame near-target distance gate. Before the gate engages, capacity matches
the faster directional allocator; near capture, it converges to the parent's
nonlinear excursion predictor. No new tunable gain is introduced, and every
carrier, navigation, handoff, residual-magnitude, soft-boundary, and acceleration
parameter remains owned and unchanged.

Support requires capture with the direct compact wake, head-relative course
miss at or below `0.461L`, anterior/posterior `>40 deg` dwell at or below
`0/0.681%`, peak normalized planar force/moment near or below `0.040/0.019`,
and recovery into the `15.14--15.34T` arrival class. Formal CFD remains
deferred to EvE; this worker will claim only dry boundedness and symmetry
checks for the unevaluated candidate.

## Dry validation boundary

The prescribed guidance-materiality check, lightweight Julia policy contract,
deterministic parameter-schema guard, and solver editable-boundary audit pass;
no CFD was run. A deterministic `17,496`-state grid spanning normalized
body-frame target/course geometry, distance, heading response, both joint
angles, and both joint rates produced finite commands inside the owned
`30 rad/T^2` smooth envelope with exact left/right reflection (maximum error
`0.0`). The scheduled harmonic composition changed `6,702` grid states from
the assigned harmonic parent (maximum command difference
`6.28428 rad/T^2`) and `7,100` from the sampled scheduled linear predictor
(maximum `6.98133 rad/T^2`). At `0.8L` its maximum difference from the harmonic
parent was only `0.00228 rad/T^2`, while at `5L` it reached
`4.75580 rad/T^2`, confirming that the intended body-frame approach handoff is
active rather than a comment or gain-only edit. These algebraic checks do not
establish capture, wake, load, joint-history, course-margin, or arrival
improvement; all remain falsifiable in EvE's formal evaluation.
