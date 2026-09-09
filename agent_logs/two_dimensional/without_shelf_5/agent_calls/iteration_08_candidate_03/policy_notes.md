# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before finalizing the candidate

- The shared prewarm sheet shows the common held fish at the upper-right
  release pose while the four staggered vortex streets develop and merge
  around the target. It fixes the initial flow condition but cannot distinguish
  policies.
- All four current solver samples are byte-identical `0.40`-anterior,
  gain-`1.7` policies, and their released sheets and metrics repeat exactly.
  The fish visibly self-propels rather than drifting: after an early heading
  correction it leaves a dense alternating tail trail, traverses diagonally
  left and down through the developed wake, and reaches the `0.75L` ring with
  no collision, exit, or instability. Each rollout captures at `39.710`, with
  mean distance `1.874L`, relative-crossflow RMS `0.2265`, force/moment RMS
  `38.40/618.59`, total command energy `54703.2`, and joint maxima
  `0.507/0.528` rad.
- The inherited `0.45`-anterior policy is the most informative current failure
  of a control hypothesis. Its released sheet preserves the broad diagonal
  topology and eventual capture but visibly lags the `0.40` anchor during the
  wake approach. With every other policy parameter fixed, arrival regresses to
  `43.323`, mean distance to `2.025L`, crossflow RMS to `0.2456`, force/moment
  RMS to `41.96/709.54`, total command energy to `60174.8`, and joint maxima to
  `0.544/0.562` rad. Both policies touch the same rate and acceleration caps,
  so moving five percent of the steering center anteriorly neither balances
  excursion nor creates a gentler actuation regime.
- Earlier inherited gain-`1.725` and gain-`1.9` policies also retained the
  route but regressed against gain `1.7`; the target-blind seed exited downward
  and a slower mixed-feedback controller became unstable. The available
  evidence therefore supports preserving the fixed gait, bounded positive
  bearing law, and `0.40` joint distribution rather than fitting another small
  sub-step, changing propulsion, or adding an unscaled observation.

## Candidate hypothesis

Retain the exact current prefill: `0.55` period, 28-degree oscillator,
gain-`1.7` bounded-bearing steering, 12-degree steering bound, posterior phase
lag and damping, and `0.40` anterior steering fraction. Relative to the assigned
parent's tested `0.45` allocation, this is an evidence-backed restoration to
the four-way sampled finite anchor, not a claim that `0.40` is universally
optimal. No semantic policy edit is justified by the current evidence, so the
single non-empty candidate already in `solver/` is deliberately preserved.

The later CFD rollout should preserve capture and reproduce approximately
`39.710` arrival, `1.874L` mean distance, `0.2265` crossflow RMS, and
`38.40/618.59` force/moment RMS. Loss of capture or regression toward the
`0.45` envelope would falsify deterministic restoration. A later worker should
test a different, separately bounded control axis only after such a repeat;
the present evidence does not justify another static allocation interpolation.
