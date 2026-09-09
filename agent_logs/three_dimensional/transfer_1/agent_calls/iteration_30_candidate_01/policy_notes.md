# Candidate diagnosis and hypothesis

## Evidence read before the policy edit

- The assigned parent is `solver_55f3a103ab95`, the fixed unsafe-intercept
  anterior-transfer policy. Its direct-uniform still-water rollout captured at
  `0.7492L` in `18.7495T`. The three sampled exact speed-reserve policies also
  captured, at `0.7466--0.7494L` in `18.2875--18.6010T`. Thus the parent kept
  semantic success but arrived later than every sampled baseline repeat; its
  score and mean distance stayed inside the baseline range rather than showing
  a distinct route benefit.
- I inspected the combined top-down and oblique sheets for the assigned parent,
  the best-scoring baseline repeat (`solver_6b0e320e2f55`), and the slowest-
  scoring baseline repeat (`solver_2d0a4a628957`). All report uniform-direct
  initialization with `U_infinity=[0,0,0]`. From release through capture, the
  top-down rows grow an organized alternating wake while the body advances and
  turns toward the target. The oblique rows retain bilateral Lambda2 structures
  and visible tail motion through the final approach. This is self-propulsion,
  not advection; there is no visible wake collapse or instability to repair.
  No sampled run is a termination failure, so the assigned parent's failure to
  improve its stated allocation objective is the informative negative case.
- Trace cross-check: the parent has head/tail action clipping of
  `68.76%/70.75%` and exact speed-limit residence of `10.74%/11.62%`. Across
  the three baseline repeats those ranges are `68.45--68.66%/70.62--70.67%`
  and `10.41--10.63%/11.30--11.56%`. Peak planar force and yaw moment remain in
  the same envelope. The unconditional `0.55` share transfer therefore neither
  frees the posterior actuator nor creates a new wake/trajectory mechanism.
  Inherited guidance/log summaries also rule out scalar cadence relief,
  carrier suppression, total-command governing, half-cycle reallocation,
  projected-miss replacement, yaw braking, wave-shape pulses, mean-curvature
  tracking, and the tested course observer.
- Replaying the normalized outward-burden observation over the sampled traces
  inside `4L` makes posterior-over-anterior burden positive on only
  `7.6--8.1%` of rows. Among those sparse rows, the positive advantage has
  medians of `0.37--0.54` and first quartiles of `0.11--0.19`. A smooth gate
  that is zero through `0.05` and full at `0.25` rejects tiny phase/noise
  differences while retaining the observed materially burdened subset; these
  normalized thresholds are policy parameters, not hidden constants.

## Bookshelf transfer

```text
bookshelf_consulted: true
source_domain: Lighthill elongated-body propulsion and closed-loop robotic-fish turning
source_mechanism: preserve posterior traveling-wave thrust while applying bounded steering asymmetry only where actuator state shows usable authority
transferable_invariant: separate the posterior propulsive role from the anterior steering role conditionally, while preserving the traveling bend and total steering request
nontransferable_details: published gains, dimensional frequencies, species-specific envelopes, exact phases, body splines, and task-specific routes
policy_translation: within the existing normalized unsafe-intercept gate, transfer at most the parent's steering share only when normalized posterior outward speed/action burden exceeds anterior burden by a threshold, the requested residual would push the posterior joint farther outward, and the anterior joint has margin
falsification: reject if repeated capture is lost or delayed, the lower-pass branch remains, transfer does not reduce useful posterior burden, or far-field closure, either wake, speed, clipping, force, or moment leaves the sampled speed-reserve envelope
```

## Single candidate hypothesis

Keep the exact speed-reserve carrier, raw achieved-course route error,
response/intercept scaffold, steering magnitude, and maximum transfer share.
Replace the parent's spatially unconditional unsafe-terminal transfer with one
thresholded allocation gate derived from normalized joint speed and previous
action. A joint is burdened only when speed and previous action are both near
their envelopes and point outward. Transfer is zero unless posterior burden
clearly exceeds anterior burden, the current steering residual would add to
posterior outward motion, and the anterior actuator has margin. The head/tail
steering-share sum remains invariant. This should keep the policy identical to
the repeat-backed baseline for most of the trajectory, preserve both observed
wakes, and use anterior authority only when it can relieve rather than merely
move posterior saturation.
