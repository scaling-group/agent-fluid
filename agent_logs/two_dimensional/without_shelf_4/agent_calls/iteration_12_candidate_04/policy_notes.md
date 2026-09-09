# Wake-policy candidate diagnosis

## Evidence read before editing

- The assigned guidance establishes the `20.25 deg`, `0.67`-period propulsion
  shell and `0.30` bearing scale plus `0.25` rate lookahead as the local anchor.
  It also records the naive seed's early lateral domain exit, so increasing
  drive or adding unbounded steering is not a justified repair.
- The shared prewarm sheet shows the common held fish above and downstream of
  four developed, asymmetric vortex streets. It is initial-condition evidence,
  not a policy comparison.
- The sampled anchor is exactly reproducible: two independently archived
  copies reach the target at `244.547`, with mean distance `6.452L`, RMS
  lateral force `18.263`, and identical trajectory sheets and diagnostics.
- The assigned parent's inherited step logs separately archive that `244.547`
  anchor and the later `224.488` away-drift result with the same metrics as the
  sampled solver records, ruling out a score-summary or transcription mismatch.
- The heading-rate branch reaches later at `259.160` and has a slightly worse
  mean distance of `6.502L`. Its sheet retains the large initial turn and shows
  a broad late excursion above the target. Lower moment alone (`357.284`
  versus the anchor's `362.214`) does not compensate for the slower route.
- The current lateral-velocity branch is the strongest finite example. Its
  bearing-gated away-drift correction reaches at `224.488`, improves mean
  distance to `6.311L`, and lowers RMS lateral force to `17.943`; mean command
  energy rises modestly from `695.746` to `701.390`. Mean upstream body
  velocity `-0.04895` exceeds the magnitude of mean local-flow x `-0.03293`,
  confirming self-propulsion rather than passive advection. Its sheet enters
  the developed wake and reaches from the lower-right corridor, but a large
  midcourse reversal remains visible.
- All four sampled sheets terminate in target capture, so there is no sampled
  failure keyframe to compare. The slow heading-rate success is the most
  informative visual counterexample; the inherited seed domain exit is used
  only as nonvisual failure context. The compact observation JSON supplies the
  wake diagnostics referenced above because no standalone diagnostics artifact
  is present inside this workspace.

## Single-candidate hypothesis

Preserve the demonstrated gait, posterior lag, bearing scale, rate lookahead,
and acceleration guard. Exploit only the evidence-positive away-drift axis by
raising `lateral_velocity_lookahead` from `0.08` to `0.10`. With lateral
velocity clamped at `0.10` and the existing smooth bearing gate, this changes
the maximum added steering-error correction from `0.008` to `0.010` radians;
targetward lateral translation remains unmodified. The expected effect is a
smaller midcourse reversal and earlier wake-corridor capture without renewing
the seed's one-sided ejection.

The later CFD evaluation falsifies this exploitation step if it loses capture,
arrives no earlier than `224.488`, fails to improve the `6.311L` mean distance,
or materially exceeds the current `17.943` RMS lateral force, `361.014` RMS
moment, or `701.390` mean command energy. In that case later workers should
return to the `0.08` anchor and test an interpolation rather than strengthening
the correction further.
