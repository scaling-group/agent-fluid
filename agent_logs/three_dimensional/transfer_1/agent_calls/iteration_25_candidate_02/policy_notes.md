# Axial-response posterior launch candidate

## Completed evidence and visual diagnosis before editing

- All four sampled episodes are finite `capture` rollouts from direct uniform
  still water with `U_infinity=(0,0,0)`, no cylinders, and no prewarm.  The
  strongest completed policy is v41's response-released posterior launch: it
  captures at `17.918999 T`, score `-0.093208`, and total/observed distance
  integrals `1.979413/1.365311 L`.  Relative to the two reproduced v38
  captures at `18.232491 T`, `-0.126500`, and `2.012983/1.399804 L`, v41 is
  closer at every `2 T` checkpoint, including leads of `0.0227/0.0767/0.0817 L`
  at `2/4/6 T` and `0.3160/0.3625 L` at `12/16 T`.
- I inspected the combined sheets and both view-specific sheets for v41, the
  assigned v39 parent, and a reproduced v38 control.  Their top-down rows show
  self-propulsion from quiescent water on smooth target-signed arcs, with
  compact startup vorticity developing into coherent alternating posterior
  wakes through capture.  There is no visible drift, reversal, collision,
  wake collapse, boundary exit, or instability.  Every sampled oblique row is
  black in this rendered workspace, however, so the current examples cannot
  support a new Lambda2 or three-dimensional-wake comparison.  That is an
  evaluation-artifact boundary, not evidence of oblique wake quality.  I also
  inspected the readable inherited v38 oblique sheet; it shows the retained
  carrier's compact alternating Lambda2 structures from startup through
  capture, but cannot establish an oblique difference for v39 or v41.
- V41 improves first-`2 T` closure from v38's `0.0742 L` to `0.0969 L`, then
  compounds the lead across the route.  Mean/max speed rises moderately from
  `0.7032/0.9519` to `0.7128/0.9675 L/T`, any-joint acceleration-limit
  residence from `41.54%` to `43.92%`, and peak normalized force/moment from
  `0.03068/0.01579` to `0.03182/0.01608`.  The posterior joint has no
  acceleration-limit residence through `12 T`, so the sampled result supports
  retaining the bounded posterior wave-shape mechanism rather than adding
  carrier amplitude, route steering, or cross-joint spillover.
- The assigned v39 response-gated reverse spillover is the informative
  mechanism underperformance.  It is trajectory-identical to v38 through
  `8 T`, then is farther away at `10/12/14 T`, and captures only `0.0385 T`
  earlier at `18.1940 T`; its observed integral improves by just `0.00067 L`.
  It remains a safe capture, but does not address the launch deficit and is
  decisively weaker than v41.  Inherited load-confidence extensions also
  regressed route integrals, while whole-wave route-rate projection caused a
  wrong-sign turn and roughly tenfold load peaks.  Neither mechanism is
  stacked onto the candidate.
- The remaining v41 sensor mismatch is measurable in its completed trace.
  During `0-1/1-2 T`, mean forward body-axis speed is only
  `0.0118/0.0793 L/T`, while mean absolute sway is `0.0892/0.1736 L/T`.
  Consequently the existing total-speed launch gate averages only
  `0.795/0.552`, whereas a forward-speed gate at the same normalized scale
  averages `0.972/0.824`.  The mismatch persists through `2-4 T` and vanishes
  after axial propulsion is established; it can therefore be corrected
  without a clock or route schedule.

## One-candidate policy hypothesis

Materialize v41 as the single candidate and change only the response variable
that releases its posterior launch emphasis.  Replace total body-speed
magnitude with positive forward body-frame speed, using the model's native
negative-x forward convention.  Keep the productive-closing, far-distance,
and low-turn gates; keep route and redirect means outside the scaled term.
This preserves the evaluated state-feedback oscillator, posterior lag,
crossflow-confidence pose rejection, route-rate correction, half-cycle
steering, cadence release, approach scheduling, and carrier-first spillover.

The candidate should retain posterior emphasis when early motion is mostly
sway, then release it as axial propulsion and target closure appear.  The
intended signature is greater first-`2 T` closure than v41's `0.0969 L`, no
loss at the `4-16 T` checkpoints, and capture before `17.919 T`, without
materially exceeding v41's `0.968 L/T`, `44.0%`, `0.03182`, and `0.01608`
speed/saturation/normalized-force/moment envelope.  Formal CFD occurs only
after worker exit; none of these intended outcomes is claimed here.

```text
bookshelf_consulted: true
source_domain: Lighthill-style posterior reactive thrust and sensor-modulated robotic-fish rhythmic control
source_mechanism: emphasize the posterior traveling wave while propulsive response is weak, then release the modulation when forward response appears
transferable_invariant: lateral body motion is not equivalent to axial propulsion, so bounded thrust emphasis should be released by response in the propulsive body axis while target and steering gates retain route authority
nontransferable_details: published gains, dimensional frequencies, species or robot kinematics, full-body amplitude envelopes, exact vortex phases, and task-specific routes
policy_translation: retain v41's zero-mean posterior wave scaling but replace its total-speed release with normalized positive forward body-frame speed; preserve the existing normalized closing-response, distance, and turn-load gates in the two-joint state-feedback contract
falsification: reject if first-2T closure does not improve, middle or late closure or capture regresses, posterior saturation becomes persistent, readable two-view evidence shows wake degradation, or speed, normalized force, or yaw moment materially exceeds the completed v41 envelope
```

## Evidence boundary

All numerical outcomes and visual claims above come from completed sampled CFD,
the assigned parent, and inherited optimizer logs.  The current candidate's
evaluation becomes evidence only for a later worker.

## No-CFD implementation audit

- The single candidate SHA-256 is
  `c80922631ad964b1037612661701a702e4817aacb3fb459e51a6a35dde0d3d3e`.
  It is the completed v41 policy except for the total-speed-to-forward-speed
  launch-release translation and its associated parameter/result names.
- The required check-runner was invoked, but its pinned `gpt-5.4-mini` model is
  unavailable for this account.  Its three commands were run locally and
  separately after removing a duplicated assigned-parent marker from the
  rendered workspace `README.md`; the material-guidance check, lightweight
  Julia policy contract, and solver editable-boundary check all pass.
- A targeted Julia audit confirms that every direct `params.FIELD` reference
  resolves against `target_policy_params()`, lateral speed does not change the
  axial launch gate, increasing positive forward speed releases it, and tested
  actions remain finite inside the componentwise acceleration bound.  No
  formal CFD was run.
