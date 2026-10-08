# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- All sampled and inherited evaluations used direct-uniform still water with
  `U_infinity=(0,0,0)`, no cylinders, and no prewarm. All terminate in
  capture, so policy choice must use route progress, arrival, wake coherence,
  loads, and actuator viability rather than first-crossing distance alone.
- Both rows of the combined keyframe sheets were inspected for the four
  sampled solvers and the two inherited force-response candidates. The
  top-down views show genuine self-propulsion, a regular alternating wake, and
  a shallow terminal hook; the oblique Lambda2 views show an organized
  three-dimensional wake through capture. There is no imposed advection,
  boundary interaction, moving-window rotation artifact, or wake breakup.
  The visual topology is common, so the finite trajectory differences must be
  cross-checked numerically.
- The assigned solver parent and its duplicate capture at `0.748591L` and
  `26.2405T`, with mean distance `2.518917L`. The translation-consistent sample
  reaches `0.748338L` and `26.2460T`, with mean distance `2.518971L`. Their
  sub-milliscale endpoint and score separation is not a semantic improvement.
  In contrast, the new sampled posterior course-slip vectoring policy captures
  at `0.748361L` and `26.1635T`, raises score from about `-0.61615` to
  `-0.60721`, and lowers mean distance to `2.509866L`. Its distance is already
  better by `0.01072L` at `8T`, `0.04323L` at `16T`, and `0.08085L` at `24T`.
  This is evidence that redirecting posterior wave shape during the previously
  identical far/middle route improves progress, although the final clearance
  and visible hook remain in the same shallow-capture family.
- The vectoring sample stays below all actuator envelopes: maximum joint angle,
  speed, and applied acceleration are `0.76903 rad`, `4.51341 rad/T`, and
  `29.7231 rad/T^2`, versus hard limits `0.78540`, `4.53786`, and `30`.
  Its peak planar force/yaw moment (`0.01944/0.00987`) are only modestly above
  the translation-consistent sample (`0.01883/0.00979`), but that load increase
  is a falsification boundary rather than evidence for stronger vectoring.
- Two completed inherited force-gated anterior residuals are negative controls.
  They preserve the same coherent two-view wake and early load maxima, but
  capture at only `0.748796L`/`26.3725T` and `0.749351L`/`26.2735T`, with
  scores `-0.61703` and `-0.61731`. The earlier `0.976` force/course
  correlation therefore did not make instantaneous force opposition a useful
  steering gate. Do not repeat it, change its scalar, or let force choose the
  route.

## Policy hypothesis

Preserve the assigned parent's state-feedback traveling bend, target-aware
redirect, line-of-sight response, route-priority late arbitration,
capture-scale posterior modulation, coordinated acceleration projection, and
angle/rate viability guards. Add exactly one upstream mechanism from the best
sample: while translation is observable and closing, compare normalized
velocity-to-target course error with body target bearing. When course error is
materially larger, shift the posterior traveling-wave target toward the
geometry-defined course side using anterior joint-state phase. A smooth
distance complement tapers this branch out by `3L`, before the inherited
terminal corridor; startup, low-speed, aligned, non-closing,
redirect-dominated, and near-target states pass through continuously.

The falsifiable expectation is earlier target-directed translation, reduced
mean distance, and earlier capture while retaining the coherent wake and zero
actuator contacts. Reject the mechanism on loss of capture or propulsion, no
upstream trajectory separation, restoration of any actuator contact, a new
load regime, or failure to improve the assigned parent's progress/arrival.
Because the sampled vectoring result does not deepen the terminal crossing,
do not interpret this candidate as a clearance-gain hypothesis.

bookshelf_consulted: true
source_domain: elongated-body reactive propulsion and sensor-modulated robotic-fish phase-lag steering
source_mechanism: retain an anterior rhythmic carrier while bounded target feedback redirects posterior wave shape and reactive thrust
transferable_invariant: when body aim is adequate but translational course is not, allocate correction through the posterior traveling wave rather than demanding only more anterior yaw
nontransferable_details: published gains, dimensional frequencies, species envelopes, robot linkage geometry, clock phase, exact vortex phase, and prescribed routes
policy_translation: use normalized body-frame course error, bearing, distance, closing speed, and joint-state phase to taper a bounded posterior target shift onto the evidenced far/middle route
falsification: reject on lost capture or coherent three-dimensional propulsion, unchanged upstream route, slower approach, actuator contact, or materially greater force or yaw-moment exposure

## Non-CFD audit after the policy edit

- Every direct `params.FIELD` reference is owned by the returned 50-field
  parameter object. The prescribed public-contract state returns two finite
  accelerations, and a deterministic joint-angle/rate/geometry edge grid stays
  within the `30 rad/T^2` command envelope.
- A synthetic observable, closing upstream state changes the posterior command
  from `1.38974` to `1.84429 rad/T^2`; moving the same state inside `3L`
  makes the candidate exactly command-identical to the assigned parent. Its
  lateral reflection produces exactly sign-reflected two-joint commands.
- Reconstructing normalized body-frame geometry and translation over all 4,771
  assigned-parent trajectory rows changes 1,873 post-guard commands, with
  1,402 changes above `0.05 rad/T^2`. Activation spans `0.0165--21.9285T`
  and ends by `3.0024L`; the maximum delta is `3.04769 rad/T^2`, while the
  candidate's peak frozen-state command remains the parent's
  `29.72585 rad/T^2`. This establishes bounded, material upstream activation
  and terminal pass-through only; formal CFD occurs after this worker exits.
- The required check-runner was invoked but its pinned `gpt-5.4-mini` model is
  unavailable on this account. Its exact guidance, Julia contract/schema, and
  solver-boundary commands were run directly and pass. No CFD was run.
