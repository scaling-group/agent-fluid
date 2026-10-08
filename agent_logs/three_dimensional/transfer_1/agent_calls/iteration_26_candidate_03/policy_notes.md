# Axial-and-energy-governed posterior-launch candidate

## Completed evidence and visual diagnosis before editing

- All four sampled episodes are finite `capture` rollouts from direct uniform
  still water with `U_infinity=(0,0,0)`, no cylinders, and no prewarm.  They
  share the retained target-directed carrier and differ only in how the
  bounded posterior launch emphasis is governed.
- I inspected every combined keyframe sheet from release through capture,
  including its top-down mid-plane vorticity row and oblique body/Lambda2 row.
  All top-down rows show self-propulsion on the same smooth target-signed arc:
  compact startup vorticity develops into a coherent alternating posterior
  street without drift, route reversal, collision, wake collapse, boundary
  exit, or visible instability.  The assigned phase-weighted parent has the
  only readable oblique row; it confirms compact, bounded three-dimensional
  Lambda2 structures along the retained route.  The other three oblique rows
  are black rendering failures, so no cross-policy 3D wake ranking is claimed.
- The phase-insensitive posterior-energy comparator is the strongest completed
  sample.  It captures at `17.80900 T`, score `-0.088403`, and total/observed
  distance integrals `1.974148/1.358239 L`, versus the assigned outstroke-phase
  parent at `17.91900 T`, `-0.089717`, and `1.976091/1.362683 L`.  It is closer
  by `0.0062/0.0141/0.0351/0.0535/0.0159 L` at `2/4/6/8/10 T` and is within
  `0.043 L` of the parent at each `12-16 T` checkpoint.  Maximum speed and
  any/posterior acceleration-limit residence fall from
  `0.9669 L/T` and `44.72%/6.66%` to `0.9590 L/T` and `42.90%/4.82%`.
  Peak normalized planar force/moment rise modestly from
  `0.03182/0.01612` to `0.03225/0.01657`, which bounds rather than erases the
  positive route result.
- Replacing total-speed release with positive body-axis speed is independently
  useful.  The axial-response comparator captures at `17.83100 T`, improves
  total/observed integrals to `1.974682/1.360029 L`, and reduces maximum speed,
  any/posterior saturation, and peak yaw moment to
  `0.9610 L/T`, `43.74%/5.40%`, and `0.01591`.  The assigned phase allocation,
  by contrast, does not improve arrival over the unweighted v41 launch and
  increases both saturation measures; exact outstroke selection is therefore
  not retained.
- No sampled episode is a semantic failure.  The inherited whole-wave
  route-rate projection remains the informative hard boundary: it produced a
  wrong-sign upward turn, `left_domain` at `8.4755 T`, only `12.2107 L`
  minimum distance, and roughly tenfold force/moment peaks.  Accordingly the
  present launch observation cannot enter target geometry, route rates, mean
  curvature, or direct steering.

## One-candidate policy hypothesis

Start from the completed energy-governed comparator.  Preserve its
state-feedback traveling wave, target-derived mean curvature, raw redirect,
whole-wave pose rejection, crossflow confidence, route-rate feedback,
half-cycle steering, approach scheduling, carrier-first spillover, and final
componentwise acceleration bounds.  Retain its reflection-even posterior
energy deficit and evaluated maximum wave-scale envelope.  Change only the
launch response release: use positive forward body-axis speed rather than
total speed, so early sway cannot falsely announce propulsion.  The energy
deficit adds amplitude only while the observed mean-rejected posterior wave is
underdeveloped; forward speed, closing response, distance, and turn load
release the entire residual continuously.

This is one compact launch-governor combination, not a stack of independent
steering or propulsion gains.  It should exceed the energy comparator's
first-`2 T` closure, retain its lead through `10 T`, and capture no later than
`17.81 T` with total/observed integrals no greater than
`1.9742/1.3583 L`.  Falsify the candidate if the middle or late route regresses,
posterior saturation becomes persistent, capture is delayed, readable
two-view evidence shows wake degradation, or maximum speed and normalized
force/moment materially exceed the completed `0.959/0.03225/0.01657`
envelope.  Formal CFD occurs only after this worker exits; no same-worker
outcome is claimed.

```text
bookshelf_consulted: true
source_domain: Lighthill-style posterior reactive thrust and sensor-modulated robotic-fish CPG amplitude control
source_mechanism: preserve a traveling-wave carrier, emphasize posterior wave motion while propulsive response and locomotor amplitude are underdeveloped, and release the modulation when those observed responses appear
transferable_invariant: posterior thrust authority should be bounded by observed wave state and released by axial propulsive response rather than by lateral motion or an exact prescribed phase
nontransferable_details: published gains, dimensional frequencies, species or robot kinematics, full-body amplitude envelopes, exact vortex phases, clocked CPG phase, and task-specific routes
policy_translation: form a reflection-even normalized posterior wave-energy deficit from mean-rejected two-joint pose and rate, and apply it only inside a positive-forward-speed, positive-closing, far-target, low-turn gate that scales the zero-mean posterior target without changing route or redirect curvature
falsification: reject if early and route-wide closure do not beat the completed energy comparator, posterior saturation persists, capture regresses, the alternating wake degrades in readable views, or speed and normalized loads materially exceed its completed envelope
```

## Evidence boundary

All numerical and visual outcome claims above come from the assigned parent,
sampled completed solver results, inherited guidance, and inherited optimizer
logs.  The candidate below has no same-worker CFD evidence.

## No-CFD implementation audit

- The single candidate SHA-256 is
  `b9a1b4388d90a74b88b6947772d9931402cb867c05b32f46c29bff4a1a0da73b`.
  All `65` distinct direct `params.FIELD` references resolve against the `67`
  fields returned by `target_policy_params()`.
- A synthetic comparison with the completed energy comparator confirms that
  sway changes only the posterior action, positive axial speed at the release
  scale recovers the comparator action exactly, the posterior wave multiplier
  cannot exceed `1.17`, and a grid of joint/velocity states remains finite
  inside the componentwise acceleration bound.  This is a structural audit,
  not a closed-loop result.
- The material-guidance/schema check, lightweight Julia contract, and solver
  editable-boundary check pass.  The prescribed independent check-runner was
  invoked, but its pinned `gpt-5.4-mini` model is unavailable for this account;
  its exact three checks were therefore run locally and separately.  No formal
  CFD was run.
