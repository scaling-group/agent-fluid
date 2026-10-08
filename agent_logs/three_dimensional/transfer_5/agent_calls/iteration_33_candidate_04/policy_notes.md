# Candidate wake-policy notes

## Evidence diagnosis before editing

All four sampled solver artifacts are finite captures from valid direct-uniform
still water with `U_infinity=(0,0,0)`, no cylinders, and no prewarm snapshot.
Three reproduce the inherited split-observer baseline bit-for-bit: capture at
`23.83702T`, score `-0.535013`, and scoring mean/final distance
`2.433468/0.746096L`. The distinct progress-qualified carrier release captures
at `23.37501T`, improves score to `-0.505158`, and improves scoring mean distance
to `2.402131L`; its final crossing is slightly shallower at `0.748882L` but is a
valid capture. There is no failed termination in the sampled set, so the
replicated baseline is the most informative weaker finite comparison rather
than a true failure.

I inspected the combined keyframe sheets for both behaviors from release to
capture, including the top-down mid-plane-vorticity rows and the oblique
body/Lambda2 rows. Both fish self-propel from quiescent fluid along a smooth
target-directed arc and retain an ordered alternating wake with compact
three-dimensional structures through the final bend. The faster candidate is
visibly farther along the same useful trajectory at corresponding times; it
does not show passive advection, wake collapse, boundary contact, or numerical
instability. The topological similarity makes the load histories decisive for
the remaining defect.

Inside `3L`, the faster carrier release lowers mean absolute target-cross-track
speed from `0.23868U` to `0.23513U`, but raises mean/peak absolute yaw from
`1.67938/3.19386` to `1.71255/3.29199 rad/T`, raises peak cross-track speed from
`0.56914U` to `0.61953U`, and raises peak absolute moment from `0.013581` to
`0.014507`. Maximum projected acceleration remains essentially unchanged near
`31.39 rad/T^2`, and maximum joint speed remains about `4.538 rad/T`. Thus the
bounded target-radial translation cue is a genuine propulsion improvement, but
continuing its extra cadence reserve into the existing terminal yaw regime is
not a clean transfer.

Inherited logs independently reject using a new terminal velocity remapping,
local-flow gate, phase anticipation, or half-cycle envelope redistribution to
repair the same-path terminal defect. Those interventions preserved wake
topology while trading progress or load balance. The present evidence instead
isolates a far/middle/near authority-boundary mismatch between the successful
propulsion cue and the already established terminal steering layer.

## Single candidate hypothesis

Start from the evaluated progress-qualified carrier release. Preserve its
response-released C-bend, continuous anterior course brake, distributed joint
rate only for phase classification, posterior traveling wave, steering gains,
and component-wise smooth command projection. Add one semantic scheduling
mechanism to the small progress-cadence reserve: keep it fully available outside
`4L`, fade it continuously over `4--3L`, and make it zero throughout the
existing inside-`3L` terminal yaw regime. The baseline carrier cadence remains
active everywhere, so this does not coast near capture or modify the posterior
wave.

This predicts retention of most of the `0.462T` arrival and distance-integral
gain accumulated during target-directed translation, while terminal yaw,
cross-track peak, and moment move back toward the replicated split-observer
envelope. Reject the mechanism if capture is lost or delayed to baseline scale,
mean distance materially regresses, the coherent wake changes, terminal yaw and
moment do not improve together, or joint/command feasibility worsens. The new
candidate has not yet been evaluated by CFD.

bookshelf_consulted: true
source_domain: terminal capture scheduling and closed-loop robotic-fish CPG modulation
source_mechanism: preserve an intact posterior-lagged carrier while assigning propulsion reserve and terminal stabilization to continuous observation-defined regimes
transferable_invariant: release only extra rhythmic drive before entering a distinct near-target stabilization regime, without removing baseline propulsion or changing the traveling-wave geometry
nontransferable_details: published gains, dimensional frequencies, species-specific gait envelopes, exact vortex phases, clocked stages, and task-specific routes
policy_translation: multiply the bounded body-frame target-progress cadence reserve by a normalized target-distance gate that is full outside `4L`, fades over `4--3L`, and is zero inside the existing terminal yaw band; leave baseline cadence, steering, and posterior lag unchanged
falsification: reject if direct-uniform or held-out CFD loses the faster capture/progress, coherent alternating wake, improved terminal yaw/load balance, or actuator feasibility

## Validation plan

Do not run formal CFD. After the single solver edit and durable guidance update,
run the prescribed check-runner, the available lightweight smoke check, and a
deterministic parameter-schema audit.

## Validation status

- The configured check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unsupported on this account and failed before workspace inspection. Its
  three prescribed commands were then run directly.
- The guidance-materiality check initially found the assigned parent marker
  duplicated in the rendered `README.md`. Removing only one duplicate marker
  made the assignment unambiguous; the rerun passes.
- The solver boundary check passes and confirms exactly one nonempty candidate.
  Candidate SHA-256 is
  `7d11027455782f20ac7042674ab3ec273cbdfc443110b6ea9988f6ad84917913`.
- Julia is not installed, so the lightweight runtime smoke cannot launch. The
  deterministic fallback finds both public functions exactly once, `71` unique
  direct `params.FIELD` references among `73` returned fields, no undeclared
  reference, and only `version` and `control_period` unused as metadata. It
  finds no explicit clock/step input, randomness, file I/O, cylinder cue, or
  mutable global state.
- Offline replay on all sampled trajectories keeps the new release finite and
  bounded in `[0,1]`, gives mean release about `0.47` over the `4--3L` fade, and
  makes it exactly zero inside `3L`. No formal CFD was run.
