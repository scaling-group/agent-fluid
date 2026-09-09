# Candidate diagnosis and hypothesis

## Evidence read before editing

- All four assigned samples are finite direct-uniform still-water rollouts with
  `U_infinity=(0,0,0)`, no cylinders, and capture at `0.7466--0.7494L` after
  `18.199--18.749T`. The two exact speed-reserve samples, posterior wave-shape
  sample, and fixed anterior-transfer sample all self-propel: their top-down
  sheets retain an alternating signed-vorticity street and their oblique sheets
  retain bilateral Lambda2 structures through capture. None supports changing
  cadence, suppressing the carrier, or inferring ambient advection/prewarm.
- The best assigned score is the exact speed-reserve capture at `0.7494L` and
  `18.601T`. The fixed unsafe-terminal transfer captures only once in the
  assigned population, later at `18.749T`, and inherited exact-byte evaluation
  misses below at `1.3915L`. Its allocation is therefore not retained or
  scalar-tuned. Inherited posterior shaping is likewise already falsified at
  `2/3` despite its assigned capture.
- I inspected both wake rows for the outer-bearing rescue and the latest
  burden-conditioned transfer failures. Both remain active self-propelled
  swimmers with organized top-down and three-dimensional wakes after their
  closest passes, then take the recurrent lower branch and exit. Their
  respective closest passes are `1.5629L` and `1.8544L`; the latter is direct
  completed evidence against promoting the earlier single burden-allocation
  capture. The other conditional pressure and burden-transfer variants also
  exit below at `1.5231L`, `1.1961L`, and `1.8544L`. Observation-side bearing
  rescues miss at `1.8004L` and `1.5629L`. These are semantic failures, not
  propulsion failures or gain-tuning invitations.
- Across every available completed trace, a clock-free missed-pass signature is
  cleanly separable: normalized body-frame target-aft projection combined with
  negative closing speed is zero through all four assigned captures, but
  activates around `1.20--1.88L` on all seven inherited lower-exit trajectories
  and reaches full gate. This offline replay checks selectivity only; it is not
  evidence that the unevaluated closed-loop recovery will capture.

## One candidate hypothesis

Restore the exact achieved-course/intercept-guarded speed-reserve baseline for
the first pass. Add one semantic mode, missed-pass reacquisition: only when the
normalized body-frame target is aft and measured distance is opening, blend
the route request toward bounded target bearing and veto response-based
steering release. The gate vanishes again as the fish points/advances toward
the target, so the controller returns continuously to achieved-course
tracking. The posteriorly lagged carrier, cadence, steering allocation,
intercept geometry, and sparse outward-carrier reserve are unchanged.

Expected test: assigned capture trajectories remain byte-equivalent in their
active first-pass equations up to termination, while a missed first pass turns
back for a second approach instead of continuing into the lower boundary.
Falsify the mechanism if it changes the inbound path, fails to create a return
approach before boundary exit, weakens either wake, causes carrier collapse, or
moves joint saturation, force, or yaw moment outside the speed-reserve
envelope. Even a recovered capture requires an exact repeat before a
robustness claim.

bookshelf_consulted: true
source_domain: observed-response biological C-start redirection and sensor-modulated robotic-fish direction tracking
source_mechanism: use a large observed geometric error to enter a bounded redirect, then release back to rhythmic direction tracking when the measured response becomes useful
transferable_invariant: preserve rhythmic propulsion while an observed unsafe relative-motion state temporarily prioritizes target reacquisition and releases on observed response rather than elapsed time
nontransferable_details: biological burst magnitude and timing, robot morphology, published gains, dimensional cadence, explicit oscillator phase, exact vortex phase, and task-specific routes
policy_translation: combine normalized body-frame target-aft projection with negative normalized closing speed to blend the two-joint route request toward bounded target bearing and prevent steering release only during an actual missed pass
falsification: reject if successful first-pass closure changes, the lower exit persists without a second approach, the coherent traveling wake weakens, or actuator and load metrics leave the repeat-backed envelope
