# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before editing

- The shared prewarm sheet shows the common held fish at the upper-right
  release pose while the four staggered cylinder wakes develop and merge near
  the target. Because this sheet is identical across candidates, it establishes
  the initial flow field but gives no controller credit.
- The gain-`1.7` and gain-`1.9` released sheets both show active propulsion: a
  dense alternating tail trail follows an early heading correction and a
  diagonal left-down traverse into the wake corridor and `0.75L` target ring.
  Neither route is passive advection, a collision, an exit, or an instability.
  The gain-`1.9` route looks slightly flatter near capture, consistent with its
  smaller headward y displacement (`-4.224L` versus `-4.360L`), rather than
  visibly establishing a faster turn.
- The compact metrics and embedded wake diagnostics make the local regression
  unambiguous. Relative to gain `1.7`, gain `1.9` arrives later (`40.034`
  versus `39.710`), raises mean distance (`1.901L` versus `1.874L`), relative
  crossflow RMS (`0.2329` versus `0.2265`), force RMS (`41.31` versus `38.40`),
  moment RMS (`657.28` versus `618.59`), power proxy (`4136.9` versus
  `4092.5`), and maximum joint angles (`0.523/0.548` versus `0.507/0.528`
  rad). Both touch the same rate and acceleration envelopes. The small decrease
  in command-energy mean at `1.9` does not offset its longer episode, higher
  total energy, worse navigation metrics, and higher loads.
- The assigned parent and inherited optimizer notes supply the wider control
  boundary. Gain `1.5` reached the target more slowly at `41.316` with mean
  distance `1.919L`, while gain `1.7` improved both navigation and loads. The
  current gain-`1.9` replicas therefore falsify a monotonic continuation beyond
  `1.7`, not the positive bounded-bearing mechanism itself. The inherited
  target-blind seed escaped downward, and the inherited slower multi-signal
  controller became unstable at `2.807`; those results argue against changing
  propulsion, reversing bearing curvature, or adding unscaled velocity/moment
  feedback in this candidate. No current sampled solver is a semantic failure,
  so the gain-`1.9` regression is the most informative current comparator and
  the inherited failure diagnoses are used only as outer boundaries.

## Candidate hypothesis

Preserve the evaluated `0.55`-period, 28-degree oscillator, posterior phase
lag, positive two-joint steering distribution, and 12-degree `tanh` bound.
Change only `steering_gain` from the regressed prefill value `1.9` to `1.725`.
Across the equally spaced evaluated gains `1.5`, `1.7`, and `1.9`, a local
three-point interpolation places the score, mean-distance, and force-RMS peaks
or minima near `1.72`-`1.73`; `1.725` is therefore a bounded interpolation
close to the measured `1.7` anchor, not an extrapolation or a new mechanism.

The later CFD rollout should falsify this interpolation if it loses capture,
arrives later than `39.710`, raises mean distance above `1.874L`, or raises
relative crossflow or force/moment RMS above the gain-`1.7` anchor. If the
predicted small improvement does not materialize, later workers should retain
the measured `1.7` controller and stop treating a fitted sub-step as meaningful
without a denser repeat around the bracket.
