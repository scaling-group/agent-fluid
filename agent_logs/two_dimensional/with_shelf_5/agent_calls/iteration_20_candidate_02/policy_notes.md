# Multi-wake target-policy candidate notes

## Evidence-first visual diagnosis before the policy edit

- The shared prewarm sheet shows the held fish above and downstream of four
  mature, interacting cylinder streets, with the target inside their merged
  wake. This is identical initial-condition evidence for every candidate, not
  support for a memorized route or vortex phase.
- All four sampled released sheets are finite target captures; there is no
  sampled failure keyframe to reinterpret. The inherited naive-seed
  lower-boundary exit is retained only as metric-backed context: it left after
  `50.127` released time, was predominantly advected, and saturated both joint
  rate and acceleration without a visible target-recovery turn.
- The sampled policies all show the useful topology missing from that seed: a
  decisive downward-left redirect, a strong alternating self-generated wake,
  and compact upstream-left transit into the `0.75L` target circle. For the
  fastest sampled policy, mean velocity `(-0.2781,-0.1162)` versus mean local
  flow `(-0.1531,-0.1687)` gives `0.1250` mean relative upstream motion, so
  target progress is self-propelled rather than passive advection.
- The current prefill (`solver_df084fc68237`) retains circular route history
  throughout the redirect and captures at `39.1104`, with mean distance
  `1.91494L`, relative crossflow `0.21935`, RMS force/moment `57.21/783.64`,
  command energy `50060.7`, and power proxy `3768.8`. The route-history-only
  response release (`solver_a7d11ae4462d`) has the same visible direct
  topology and captures at `39.1159`; it improves score from `-0.038501` to
  `-0.038185` and mean distance to `1.91432L`, while lowering relative
  crossflow to `0.21787`, RMS force/moment to `51.63/734.35`, and power to
  `3760.1` at essentially unchanged command energy (`50066.5`). Its `0.0055`
  arrival delay is negligible relative to the material load reduction.
- The two byte-identical fastest samples (`solver_a68507de2b6a` and
  `solver_209afb1b0e33`) also release the posterior half-cycle boost. They
  capture `0.0660` earlier than the route-only release and reduce mean
  distance by `0.00064L`, but RMS force/moment return to `57.05/783.02`.
  Thus more response-conditioned authority withdrawal is not monotonically
  load-reducing: the evidence isolates stale anterior route-memory release as
  the useful load mechanism and favors retaining posterior rhythmic steering.
- Every sampled policy still reaches both `260 deg/time` joint-rate caps and
  both `1800 deg/time^2` acceleration caps. Aggregate diagnostics do not
  calibrate the sign and time scale of a force, moment, or crossflow residual,
  so this candidate does not add one merely because cap contact remains.

## Policy hypothesis before the edit

Replace the prefill with the evaluated route-memory-only response release from
`solver_a7d11ae4462d`. Reconstruct the oldest wrapped body-frame bearing from
the observed bearing-window delta, measure normalized bearing-error
convergence, and combine it with a smooth small-current-bearing alignment
gate. Multiply only the circular-history offset by the bounded completion
complement. Large, stationary, or diverging error retains full route history;
early padded history leaves the release redirect unchanged. The oscillator,
distance-only approach envelope, current-bearing posterior steering,
joint-state half-cycle gate, and posterior phase lag retain full authority.

This is one feedback-mechanism substitution rather than scalar gain tuning.
The exact sampled policy predicts reproduction of the direct self-propelled
capture near `39.116`, with the `51.6/734` load class instead of the prefill's
`57.2/784` class. Falsify the transfer if the new evaluation loses target
capture, materially delays the direct route, or fails to reproduce lower
crossflow and force/moment evidence. Even if reproduced, unchanged rate and
acceleration maxima mean it is not evidence of cap relief; later workers
should require time-resolved disturbance histories before testing a separate
fast wake-rejection residual.

bookshelf_consulted: true
source_domain: biological burst redirects and closed-loop robotic-fish CPG direction tracking
source_mechanism: release auxiliary target-directed curvature after observed directional response while preserving rhythmic propulsion and posterior steering
transferable_invariant: normalized body-frame error and its measured convergence may withdraw stale route memory without weakening the traveling carrier or its target-favored posterior half-cycle
nontransferable_details: species-specific C-start shape, robot duty ratio, published gains, dimensional frequencies, exact vortex phase, cylinder coordinates, and task-specific routes
policy_translation: apply a bounded convergence-and-alignment completion gate only to the circular-bearing-history offset under the two-joint state-feedback contract
falsification: reject if direct capture is lost or materially delayed, or if relative crossflow and force/moment fail to improve over the no-release prefill

## Pre-evaluation verification

- The required guidance-semantic check passes after removing a duplicated
  marker for the same assigned optimizer parent from the rendered workspace
  `README.md`; the durable lesson is material relative to that parent.
- The solver editable-boundary check passes, leaving exactly one downstream
  candidate edit surface.
- Static schema comparison finds all `14` direct `params.FIELD` references in
  exactly the `14` fields returned by `target_policy_params()`.
- The candidate SHA-256 is `8451c95aaabe5874e9ae10eb40e5507c4e5c0aa954d3933920f432d0d34d75d8`,
  byte-identical to the evaluated `solver_a7d11ae4462d` sample used for the
  route and load hypothesis.
- The prescribed lightweight Julia contract check was invoked but could not
  start because `julia` is unavailable in this image (`command not found`,
  exit `127`). No formal CFD was run; EvE will evaluate the candidate after
  this worker exits.
