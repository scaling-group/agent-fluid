# Multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before editing

- All four sampled rollouts satisfy the frozen contract: direct uniform
  still-water initialization with `U_infinity=(0,0,0)`, no cylinders or
  prewarm, finite moving-window transport, and `termination=capture`. I
  inspected both the top-down vorticity and oblique body/Lambda2 rows and
  cross-checked them against scores, metrics, diagnostics, trajectories,
  executable policy diffs, the assigned-parent guidance, and inherited logs.
- The two executable-identical common-envelope redistribution samples retain
  a coherent target-bending top-down street and compact caudal Lambda2
  structures, reproduce the best mean-distance band
  (`2.08855--2.08896L`), and capture at `18.8265--18.8815T`. The prefilled
  geometry-scheduled carrier is in the same coherent wake class, captures
  earlier at `18.6835T`, and has mean distance `2.09405L`. This confirms useful
  propulsion but does not resolve the redistribution's inherited
  executable-equivalent near-miss, so the reliable geometry carrier remains
  the appropriate base for a distinct recovery test.
- The most informative inherited failure is valid direct-uniform evidence.
  Its top-down street stays energetic and its oblique caudal structures remain
  compact, yet it misses at `0.85155L`, turns down and away, and exits left at
  `34.0285T` with final distance `10.33926L`. This is a route-authority
  failure, not wake collapse or instability.
- Reconstructing normalized body-frame target direction from that trajectory
  shows the failed route first crosses `|lateral_fraction|=0.60` at
  `17.358T`, distance `2.01338L`, while the target is still forward
  (`forward_fraction=0.79693`). At closest approach it is still forward
  (`0.40805`) and strongly lateral (`0.91296`). The existing route request is
  then already `tanh(0.91296/0.30)`, about `0.995`; another multiplier or
  additive reserve inside that saturation cannot materially strengthen the
  pre-overshoot curvature. The completed behind-reserve failure and sampled
  rearward-multiplier capture therefore do not establish recovery: both new
  terms are inactive while the target is ahead, and the latter's target never
  becomes rearward.

## Bookshelf transfer

```text
bookshelf_consulted: true
source_domain: biological burst redirect and closed-loop robotic-fish direction tracking
source_mechanism: large observed direction error gates stronger bounded mean curvature while the organized traveling rhythm and response-based release remain intact
transferable_invariant: use normalized body-frame target direction to add bounded curvature authority before overshoot without replacing the propulsive traveling wave
nontransferable_details: published gains, robot geometry, species-specific kinematics, clock phase, dimensional cadence, exact vortex phase, and task-specific routes
policy_translation: on the geometry-scheduled carrier, smoothly increase both target-signed anterior and posterior mean-curvature shares only when absolute normalized body-lateral target direction exceeds the ordinary-capture sector; retain the existing correcting-yaw release, displacement half-cycle steering, posterior lag, common envelope, and acceleration projection
falsification: reject if an ordinary capture or either coherent wake row is lost, the broadside near miss still exits left, actuator contact or planar loads materially worsen, or stronger curvature destroys the established traveling-wave relation
```

## Single-candidate policy hypothesis

Add exactly one broadside curvature-reserve mechanism to the prefilled
geometry-scheduled carrier. A smoothstep of absolute normalized body-lateral
target direction is zero through `0.60`, then rises continuously to one at the
broadside limit. It multiplies both inherited target-signed curvature shares
by at most `1.25`, preserving their ratio and turn sign. The current prefill's
sampled capture never exceeds `0.52169` absolute lateral fraction, so the new
mechanism is exactly inactive across that completed ordinary-capture trace;
the inherited failure activates it near `2L`, before closest approach rather
than after the target has already passed behind.

This is one observation-gated feedback mechanism, not a propulsion-gain
retune. No distance stage, clock, world coordinate, target identity, route,
velocity phase, posterior-only allocation, terminal residual, or rate barrier
is added. Formal CFD occurs only after this worker exits. Accept the candidate
only if it retains the ordinary geometry-carrier capture/wake/demand class or
converts the broadside near-miss topology into capture or renewed approach.
