# Closing-stride anterior-envelope allocation

## Visual and quantitative diagnosis before editing

- I read the workspace and guidance contracts, the assigned-parent guidance and
  optimizer notes, all four sampled policies and finite evaluations, and the
  completed assigned-parent v34--v36 evaluations. Every inspected rollout uses
  direct uniform still water with `U_infinity=(0,0,0)`, no prewarm and no
  cylinders; all terminate by capture rather than boundary or instability.
- I inspected both rows of the combined keyframe sheets for the sampled v31
  leader and v26 regression and for the inherited v36 result. In the top-down
  mid-plane row, each fish self-propels from rest, turns toward the target, and
  leaves a coherent alternating reverse wake rather than a standing wiggle. In
  the oblique Lambda2 row, compact three-dimensional posterior structures
  persist through capture without out-of-plane instability or wake breakup.
  The unresolved difference is therefore terminal joint allocation, not
  propulsion creation, advection, or route-turn polarity.
- The three exact sampled v31 evaluations reproduce `18.0125T` capture,
  score/mean distance `-0.064000/1.950346L`, and observed distance integral
  `1.336756L`. The terminal state is still oblique and oscillatory: alignment
  `0.1297`, absolute yaw `0.8077 rad/T`, center path/head cross-track
  `13.2149L/0.7327L`, and near anterior/posterior acceleration-ceiling
  residence `69.29/75.89%`.
- Sampled v26 changes posterior half-cycle work, retains the same two-view wake
  and improves terminal alignment/yaw and posterior residence to
  `0.1728/0.6545 rad/T/74.11%`, but worsens score/mean distance to
  `-0.064149/1.950469L`. Together with the inherited balanced-duty and phase-
  reset regressions, this rules out another posterior duty or phase placement.
- The assigned-parent v34 response-triggered mean-bend allocator and v35
  steering-headroom allocator also retain capture and the coherent wake but
  regress score/mean distance to `-0.064408/1.950675L` and
  `-0.064495/1.950735L`. Their terminal alignment/yaw remain no better than
  `0.1292/0.8088` and `0.1150/0.9445 rad/T`, so another mean-share or direct-
  steering allocation threshold is not supported.
- The inherited v36 common-cadence governor supplies a more useful negative
  contrast. It retains capture and improves alignment/yaw and near ceiling
  residence to `0.1614/0.5049 rad/T` and `68.01/74.31%`, but delays arrival to
  `18.0290T`, widens path/cross-track to `13.2244L/0.7336L`, and worsens
  score/mean/observed distance to
  `-0.065162/1.951313L/1.336912L`. Its replayed selector was active for
  `68.27%` of the approach. This shows that carrier relief can damp the
  terminal oscillation, but slowing the posterior propulsive rhythm together
  with the anterior joint sacrifices useful closure.

## Single policy hypothesis

Preserve evaluated v31's odd body-frame route request, conserved mean tangent,
state-derived phase, cadence, posterior lag and work reserve, course-consensus
duty surface, and reversal-preserving rate governor. Add one joint-specific
amplitude-allocation mechanism. During only a moving, misaligned approach,
use the same phase-invariant fraction of remaining range closed per nominal
beat to reduce the anterior oscillator's energy envelope. Compensate only part
of that envelope reduction in the posterior phase reference, increasing the
posterior-to-anterior amplitude ratio without increasing cadence, total mean
bend, or direct steering.

The mechanism tests the distinction exposed by v36: anterior joint motion is
the dominant carrier-correlated yaw signal, whereas inherited posterior-
priority evidence identifies the lagged posterior wave as the useful thrust
role. The authority is exactly zero outside `2.10L`, while receding, at rest,
or in the aligned capture corridor. Distance, windowed closing speed, speed,
and course alignment are phase-invariant and unchanged by lateral reflection;
the joint states and allocated oscillatory references reverse, so the command
remains reflection equivariant.

Expected evidence is v31-identical far/middle commands and wake, retained
capture and observed-closure class, v36-directed improvement in terminal yaw
and limit residence without v36's path and distance-integral loss, and a still-
coherent posterior traveling wake. Falsify if pre-approach output changes;
the mean tangent, cadence, lag sign, or direct steering changes; posterior
ceiling residence rises materially; capture, observed closure, or path
regresses; terminal alignment and yaw do not improve together; reflection
fails; or either wake view deteriorates.

```text
bookshelf_consulted: true
source_domain: elongated-body reactive propulsion and sensor-modulated robotic-fish CPG control
source_mechanism: assign modest maneuvering motion anteriorly while preserving a stronger lagged posterior wave for reactive thrust, and modulate the joint envelopes from sensory progress
transferable_invariant: preserve state-derived phase, cadence, posterior lag, and total mean bend while changing the posterior-to-anterior oscillatory amplitude ratio only when normalized target-relative progress indicates terminal closing risk
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, linkage geometry, exact vortex phases, world coordinates, target location, capture radius, and task-specific routes
policy_translation: use body-frame course alignment, normalized speed, distance, and windowed closing speed to gate an approach-only anterior phase-plane envelope reduction, with bounded partial compensation of the lagged posterior wave reference
falsification: reject if transit changes, capture or observed closure regresses materially, the posterior wake or lag deteriorates, limit residence increases or migrates, terminal path/alignment/yaw do not improve together, or lateral reflection fails
```

The pending candidate CFD evaluation occurs only after this worker exits; the
hypothesis and static checks below are not claims about its physical outcome.

## Lightweight validation after editing

- The mandated dedicated checker was invoked, but its pinned `gpt-5.4-mini`
  model is unsupported on this account. Running the immutable checks directly,
  the guidance-materiality check reports `PASS` and the solver boundary check
  reports `Boundary check passed`; `candidate_target_policy.jl` is the only
  solver file changed. Julia is not installed, so the executable include and
  finite-action probe cannot run. No CFD was attempted.
- Deterministic static checks find one definition of each public function,
  cover all `70` direct `params.FIELD` references with the `72` unique fields
  returned by `target_policy_params`, confirm balanced delimiters and exactly
  one nonempty candidate under `solver/`, and find no explicit time, elapsed
  time, step count, randomness, file I/O, cylinder coordinate, target
  coordinate, or memorized-route input.
- One hundred thousand deterministic envelope probes preserve exact inactivity
  at zero authority and bound the anterior envelope scale to `[0.78,1.0]`.
  Partial posterior compensation is bounded to phase-reference scale
  `[1.0,1.197436]`; after the anterior envelope settles, the corresponding
  posterior oscillatory amplitude remains in `[0.934,1.0]` of its base value,
  so the mechanism increases posterior-to-anterior emphasis without creating
  a larger steady posterior envelope. The added positive scales are unchanged
  by lateral reflection and multiply odd joint references.
- The selector is algebraically zero at and beyond `2.10L`, for nonpositive
  windowed closure, at rest, and at full capture alignment. Because it is the
  same selector replayed for the completed v36 trace, its prior activation
  support is known (`68.27%` of approach samples, mean/maximum authority
  `0.1971/0.6316`), while the new actuator translation is different. Those are
  reachability and contract checks on completed data, not evidence of the
  pending CFD response.
