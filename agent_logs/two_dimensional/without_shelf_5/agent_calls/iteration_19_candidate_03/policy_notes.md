# Multi-wake target-policy candidate notes

## Evidence-first visual diagnosis

- The four shared-prewarm sheets are byte-identical. They show the fish held at
  the upper-right release pose while the four staggered cylinder streets
  develop, merge, and cross the target region. This is the certified common
  initial condition rather than a policy effect.
- All four sampled rollouts are finite target captures. The two `1700` policy
  files and released sheets exactly replicate one another, as do the two
  `1650` files and sheets. Both policies visibly turn left and down, sustain a
  dense alternating propulsive trail, enter the merged wake late in the
  traverse, and reach the target without collision, exit, or instability. The
  motion is active rather than passive: at `1650`, mean body velocity is
  `(-0.3289,-0.1367)` while mean local flow is `(-0.1840,-0.1909)`, so the
  useful leftward speed cannot be explained by advection.
- The `1650 deg/time^2` probe preserves that route and improves the replicated
  `1700` navigation/effort envelope: arrival moves from `34.331` to `33.027`,
  mean distance from `1.714L` to `1.683L`, command energy from `45153` to
  `42310`, and power from `3390` to `3183`. Posterior excursion falls from
  `0.509` to `0.495` rad, and posterior acceleration reaches the active policy
  ceiling (`28.798` rather than `29.671 rad/time^2`).
- The same step makes the mid-route propulsive trail visibly more laterally
  disturbed, and the diagnostics confirm an opposing load trend: relative
  crossflow rises from `0.2312` to `0.2358`, force RMS from `54.48` to `63.93`,
  and moment RMS from `766.14` to `859.31`. Thus the assigned-parent
  continuation hypothesis is rejected by its explicit `850` moment-RMS
  boundary even though the scalar score rises from `0.159531` to `0.189303`;
  the crossflow and force limits (`0.240/65`) are only narrowly retained.
  There is no semantic failure example, so this load-bound violation is the
  informative failed control hypothesis and the accepted `1700` replicate is
  its physical counterexample. It closes equal-step continuation below
  `1650`, not the already demonstrated body-frame bearing route.

## Single-candidate hypothesis

Test one isolated midpoint bracket at `1675 deg/time^2`, holding period,
amplitude, oscillator drive, lag, damping, bounded body-frame bearing law,
steering allocation, and observations exactly fixed. This is not another
monotone continuation: it brackets the replicated, load-acceptable `1700`
endpoint against the faster but moment-rejected `1650` endpoint. The
falsifiable expectation is preservation of the visible safe, self-propelled
turn-then-diagonal capture with some improvement over `1700` in arrival, mean
distance, and effort while keeping crossflow/force/moment at or below
`0.240/65/850` and posterior excursion at or below `0.521` rad. Reject the
midpoint if it loses or changes the route, fails to improve the `1700`
navigation/effort envelope, or violates any load/excursion boundary. A
positive outcome would remain specific to the certified wake phase and start
pose until held-out evidence exists.
