# Wake-policy candidate diagnosis

## Evidence read before editing

- All sampled and inherited rollouts report direct uniform initialization in
  still water with `U_infinity=[0,0,0]`, no cylinders, and no prewarm. Their
  finite translation is self-propulsion rather than ambient advection.
- Both rows of the combined sheets were inspected. The sampled
  `solver_29faa601686c` capture sustains a coherent alternating top-down street
  and compact oblique Lambda2 structures through its `18.6065T` crossing. The
  prefilled `solver_a8af0d71b0de` near miss also self-propels coherently at
  first, but after a `1.2669L` lower pass it lays down little substantial new
  terminal wake and coasts out. The two broader failures retain alternating
  wakes but turn along the wrong route and approach only `3.0031L` and
  `3.1135L`; none supports more route gain or carrier suppression.
- The strongest new inherited evidence is a reproducibility failure. The
  assigned parent reran the exact `solver_29faa601686c` policy bytes
  (`034c915d...`) with matching config, geometry, and IBM hashes. Instead of
  repeating the `0.7493448L` capture, it missed at `1.7715018L` and exited the
  lower boundary. Its two visual rows retain an alternating wake through the
  pass, and its speed at closest approach remains `0.8185L/T`; this is a
  terminal response failure, not wake collapse or instability.
- The matching-policy traces begin separating at sub-grid scale near `0.86T`
  and differ by about `0.70L` by `16T`. Both joints touch the `260 deg/T`
  speed limit; acceleration is clamped on about `69.2%/71.4%` of the sampled
  capture and `70.6%/72.8%` of the repeat failure. The single capture is thus
  a useful mechanism demonstration but not robust success evidence.
- The inherited LOS guard uses signed angular rate to veto response-triggered
  steering release. A recorded-trace projection exposes the missing geometric
  condition: when distance is below `2L`, release-active rows in the repeat
  failure have projected closest-pass distance at least `1.27L`, whereas most
  release retained by the captured trace is already inside an approaching
  capture corridor. A release decision can therefore be conditioned on the
  predicted pass without adding steering authority.

## Candidate mechanism and falsification

Start from the sampled response-released achieved-course controller, not the
prefilled carrier-attenuation failure. Preserve its joint-state traveling bend,
cadence, shared course steering, phase-compensated yaw response, and LOS-rate
guard. Add one continuous terminal intercept-compatibility guard. In normalized
body coordinates, project the current target vector onto the inertial velocity:
the cross product divided by speed estimates closest-pass distance, and the
normalized dot product distinguishes approach from recession. Inside a smooth
`2.75L` to `2.0L` transition, steering release is retained only when the fish
is approaching and its projected pass lies inside a `0.60L` to `1.00L`
corridor. Otherwise the already-existing course steering remains engaged. The
guard never amplifies steering, changes the propulsive carrier, prescribes a
route, or reads a clock.

On the two completed traces, this guard is deliberately conservative rather
than a CFD prediction. Below `2L` it retains about `20.7/22.8` integrated
release units on the captured trace, while reducing the repeat failure's
`7.0` units to zero. Below `2.5L` it suppresses `21.3` release units in the
repeat failure versus `15.2` in the capture. The new CFD evaluation must decide
whether that state discrimination survives closed-loop trajectory changes.

Expected test: retain the far-field trajectory and coherent wake, avoid
releasing steering on a projected miss outside the capture disk, and obtain a
repeatable capture or at least improve the assigned parent's `1.7715L` pass
without increasing the already high saturation or load envelope.

Falsification: reject the intercept guard if it changes closure outside
`2.75L`, loses the alternating terminal wake, fails to improve the assigned
parent's pass, returns the same lower-exit topology, increases saturation or
loads, or oversteers a trajectory whose projected pass was already inside the
capture corridor. One new evaluation cannot establish reproducibility; a
capture must be repeated before it is called robust.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and adaptive prey-capture control
source_mechanism: preserve rhythmic propulsion while current sensed approach geometry gates a bounded steering residual
transferable_invariant: a locomotor response may release target steering only when normalized target-relative state agrees that the achieved motion is compatible with interception
nontransferable_details: published gains, robot or species kinematics, dimensional cadence, exact beat or vortex phase, learned policies, and task-specific routes
policy_translation: preserve the two-joint carrier and existing course servo, but multiply terminal response release by a smooth body-frame projected-pass and approach-alignment guard
falsification: reject if far-field closure changes, the coherent wake weakens, the repeat-failure pass does not improve, capture is lost on the useful topology, or saturation and loads worsen
