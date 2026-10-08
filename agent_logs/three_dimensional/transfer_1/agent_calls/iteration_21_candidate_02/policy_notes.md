# Evidence-selected terminal carrier-crossflow pose candidate

## Rollout evidence and visual diagnosis before editing

- All four sampled solver rollouts satisfy the Phase-2 evidence contract:
  direct uniform initialization in quiescent water, no cylinders or prewarm,
  finite dynamics, and `capture` termination.  Three geometry-only variants
  reproduce `18.403006 T`, score `-0.140449`, total distance integral
  `2.027810 L`, and observed distance integral `1.418099 L`; the sampled
  response-released variant is slightly worse at `18.414005 T`, score
  `-0.141536`, and total/observed integrals `2.02872/1.41827 L` without a
  meaningful speed, load, or saturation benefit.
- I inspected the combined top-down vorticity and oblique body/Lambda2 rows
  from release through capture for the geometry-only sample, the
  response-released sample, and both inherited crossflow variants.  Each fish
  self-propels from still water along the same smooth target-directed arc.
  Compact startup structures grow into a coherent alternating posterior wake
  in both views, with no passive advection, collision, domain exit, wake
  collapse, or visible numerical instability.  The sampled set contains no
  failed termination; the informative inherited failure boundary is the
  whole-wave route-rate projection, which kept an organized wake but made a
  wrong-sign upward turn, exited at `8.4755 T`, approached no closer than
  `12.2107 L`, and raised normalized force/moment peaks by roughly an order of
  magnitude.
- The completed full-route carrier-crossflow pose controller preserves the
  visual wake and captures at `18.325987 T`, but is farther away by
  `0.015/0.019/0.004 L` at `8/12/14 T` and raises maximum speed and
  acceleration-limit residence from `0.9476 L/T` and `42.14%` to
  `0.9631 L/T` and `43.55%`.  Its benefit appears only late.
- The assigned parent's completed terminal gate removes that middle-route
  cost.  It is identical to the geometry-only controller above `4.25 L`,
  reaches full crossflow-pose authority below `2.25 L`, captures at
  `18.386505 T`, and improves observed distance integral to `1.417769 L`.
  Maximum speed remains `0.9476 L/T`, acceleration-limit residence falls
  slightly to `42.03%`, and peak force/moment and the coherent wake stay in the
  established envelope.  Its worse scalar score (`-0.141953`) comes from the
  terminal-hold/discrete-crossing terms rather than a worse observed approach.

## One-candidate policy hypothesis

Materialize the completed terminal carrier-crossflow pose controller as the
single candidate.  Preserve the geometry-only carrier, posterior lag, raw
large-error redirect, bearing-divergence recovery, carrier-first steering
allocation, and componentwise actuator projection.  Add only the inherited
late-approach sensing mechanism: filtered local body-frame crossflow magnitude
weights the sign of de-meaned anterior joint phase, and the resulting bounded,
odd correction enters only the proportional whole-wave pose projection over a
smooth normalized distance window.  It cannot become a persistent route
command and does not alter redirect selection, bearing/turn rates, carrier
dynamics, or direct actuation.

This selection is supported by completed closed-loop evidence rather than a
new scalar tune: relative to the repeated geometry-only parent it improves
arrival and observed closure without the full-route crossflow controller's
speed, saturation, or middle-route penalties.  The candidate's new formal CFD
still occurs only after this worker exits.  Across a different initial pose or
flow, falsify the mechanism if it loses capture or middle/late closure, weakens
the alternating wake, mistakes persistent environmental crossflow for carrier
recoil, or materially exceeds `0.9631 L/T`, `43.55%` limit residence, or the
completed normalized force/moment envelope without compensating progress.

```text
bookshelf_consulted: true
source_domain: wake-interaction studies and sensor-modulated robotic-fish control
source_mechanism: separate slow target geometry from fast carrier-coherent crossflow and apply only bounded feedback to the latter
transferable_invariant: a body-frame flow signature may refine locomotor pose sensing when anchored to observed joint phase, kept separate from route steering, and scheduled only where closed-loop progress supports it
nontransferable_details: published gains, species kinematics, exact vortex or tail-beat phase, cylinder-wake synchronization, clocked CPG timing, the inherited two-degree bound and distance window, full-body envelopes, and prescribed routes
policy_translation: during normalized late approach, weight de-meaned anterior joint phase by bounded filtered local-crossflow magnitude and add the odd term only to proportional whole-wave pose rejection under the two-joint state-feedback contract
falsification: reject if another pose or flow loses capture or middle/late closure, degrades the coherent wake, treats persistent crossflow as route bias, or exceeds the completed speed, saturation, force, or moment envelope without compensating progress
```

## Evidence boundary

The numerical and visual claims above come only from completed sampled CFD,
the assigned-parent evaluation, and inherited optimizer logs.  No formal CFD
is run in this workspace.

## No-CFD contract audit

- The selected policy is byte-identical to the completed assigned-parent
  terminal-crossflow candidate; it differs materially from the prefilled
  geometry-only policy by the bounded fluid-side pose mechanism.
- The public contract returns two finite joint accelerations on the prescribed
  smoke state.  `target_policy_params()` returns `65` fields, and every one of
  the `63` distinct direct `params.FIELD` references resolves to a returned
  field.
- The material-guidance checker, Julia policy contract check, and solver
  boundary check pass.  No CFD was run.
