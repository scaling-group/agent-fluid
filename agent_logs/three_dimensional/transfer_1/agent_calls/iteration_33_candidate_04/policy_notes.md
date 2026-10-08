# Contraction-only posterior turn-shape recovery

## Completed evidence and visual diagnosis before editing

- All four sampled episodes are finite `capture` rollouts initialized directly
  from uniform still water with `U_infinity=(0,0,0)`, no cylinders, and no
  prewarm snapshot.  Two byte-identical evaluations of the contraction-only
  v47 controller reproduce capture at `17.53399 T`, score `-0.0640479`, and
  total/observed distance integrals `1.949721/1.333721 L`.  This is the best
  sampled score and total integral, rather than a single-run fluctuation.
- The assigned parent's distance-arbitrated v48 controller captures one solver
  step earlier at `17.52849 T`, but worsens score to `-0.0653066`, total
  integral to `1.950718 L`, and the final discrete capture sample from
  `0.746974` to `0.748227 L`.  Its `2-14 T` checkpoint distances are effectively
  identical to contraction-only and it leads by only `0.00134 L` at `16 T`;
  the predicted middle-to-late route crossover therefore did not materialize.
  Its `0.000077 L` observed-integral advantage and one-step arrival difference
  are too small to justify the added distance-scheduled mode.
- The bearing-band-partitioned v48 sibling is an informative mixed result.  It
  captures fastest at `17.47899 T`, has the best observed integral
  (`1.331907 L`), and reduces maximum speed/any-joint acceleration-limit
  residence to `0.96017 L/T` and `40.15%`; however, it trails contraction-only
  by `0.0100/0.0253 L` at `10/12 T`, worsens total integral to `1.950776 L`,
  and ends on the weakest `0.749953 L` capture sample, producing the worst
  sampled score (`-0.0658087`).  It is a meaningfully different useful
  trajectory, but not evidence that response release should replace the
  contraction rule in the scored candidate.
- I inspected all four combined sheets from release to capture.  The readable
  contraction-only, assigned-parent, and partitioned sheets all show active
  self-propulsion on a smooth target-signed arc: compact startup vorticity
  develops into an organized alternating posterior street, and compact paired
  caudal Lambda2 structures remain visible in the oblique row through capture.
  The second contraction-only sheet has a black oblique row after frame 000;
  that is a rendering/evidence failure, so comparative 3D-wake claims use its
  byte-identical readable replicate.  The complete views show no new wake
  topology that could rescue either v48 controller's route tradeoff.
- Trace diagnostics support leaving the carrier and load envelope intact.
  Contraction-only and the assigned parent share `0.97314 L/T` maximum speed
  and `0.03225/0.01609` peak normalized planar force/moment; their any-joint
  acceleration-limit residence is `42.75/42.61%`.  The partitioned sibling's
  lower residence is real but accompanies the middle-route and scored
  regressions, so it is not sufficient evidence for selecting that release.

## One-candidate policy hypothesis

Materialize the twice-reproduced v47 contraction-only policy as the sole
candidate.  Preserve its normalized body-frame target sensing, selective
crossflow pose confidence, state-feedback traveling-wave carrier, posterior
lag, geometric redirect, launch governor, half-cycle steering, carrier-first
spillover, phase-even posterior turn-shape residual, and componentwise actuator
projection.  Remove the assigned parent's distance-based handoff and release
only the supplementary posterior curvature when de-gaited bearing contracts
inside the existing centerline window, with the existing normalized far-route
gate yielding near capture.  No propulsion or steering gain changes.

The next CFD evaluation should reproduce capture near `17.534 T`, score and
total/observed integrals near `-0.06405` and `1.94972/1.33372 L`, the coherent
two-view wake, and the established speed/action/load envelope.  Falsify the
candidate if the repeated result does not reproduce, capture or middle-route
closure regresses, target-signed curvature or wake coherence is lost, or a
different pose or flow scale materially exceeds the sampled envelope.  Formal
CFD runs only after this worker exits.

```text
bookshelf_consulted: true
source_domain: biological burst redirects and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: preserve the propulsive rhythm while releasing supplementary curvature after an observed target-angle response
transferable_invariant: extra wave-shape steering may yield smoothly when normalized body-frame target error is demonstrably contracting while the carrier and base steering remain active
nontransferable_details: published gains, dimensional cadence, species-specific curvature envelopes, full-body CPG state, exact vortex phase, and task-specific routes
policy_translation: use signed de-gaited bearing and its normalized windowed rate to release only the small posterior turn-shape residual inside a bounded centerline window; preserve both-joint carrier dynamics and final actuator projection
falsification: reject if the reproduced score or route integral regresses, target-angle contraction no longer predicts useful release under another pose or wake, capture or coherent propulsion is lost, or speed, saturation, force, or moment materially exceeds the completed envelope
```

## Evidence boundary

All outcome claims above come from the assigned parent, sampled completed
solver results, inherited optimizer notes, and the required two-view visual
inspection.  This worker's candidate is a reproducibility selection from
completed CFD evidence; no same-worker CFD result is claimed.

## No-CFD implementation audit

- The sole candidate is
  `dogfish_target_control_v47_contraction_released_posterior_turn_shape`, with
  SHA-256 `934293ef540c2550dee0eae68c1aedd42da1386f1042f7960e2b5f7c7d2cc0f2`;
  it is byte-identical to both completed contraction-only samples.
- The guidance-provenance check, lightweight Julia policy contract, and solver
  editable-boundary check pass.  All `67` direct `params.FIELD` references
  resolve among the `69` fields returned by `target_policy_params()`.
- The configured check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable for this ChatGPT account.  Its three exact non-CFD commands
  were therefore run locally and separately until all passed.  The first run
  exposed a duplicated assigned-parent marker in the rendered workspace
  `README.md`; removing only the duplicate repaired provenance.  No formal CFD
  was run.
