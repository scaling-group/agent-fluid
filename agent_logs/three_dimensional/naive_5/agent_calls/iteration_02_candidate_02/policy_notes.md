# Wake-policy candidate diagnosis

## Evidence diagnosis before the edit

- The evidence is contract-valid direct-uniform still water: every sampled
  rollout reports `U_infinity=[0,0,0]`, no prewarm, and moving-window shifts.
- The best finite sample is the target-blind naive carrier at score `-14.825`.
  Its top-down row shows a coherent alternating wake and genuine self-motion,
  while the oblique Lambda2 row shows a compact, three-dimensional vortex trail
  attached to the bending tail.  It nevertheless improves distance by only
  `0.250L`, then curls upward and leaves the virtual domain at `8.547T` after a
  `-1.288 rad` heading change.  This is not passive advection.  Its raw action
  exceeds the physical acceleration envelope on `52.3%` of logged samples and
  both joint speeds reach `260 deg/T`.
- The prefilled whole-body mean-curvature sample is the most informative
  failure.  Both visual rows show a much tighter C-shaped turn and a stronger,
  sharply curved local wake rather than target-directed translation.  Its
  closest approach occurs by `3.70T`; it then reaches the `45 deg` anterior
  angle cap and `260 deg/T` speed cap, changes heading by `-2.638 rad`, and
  exits upward at `8.850T` with final distance `13.829L`.  Its force/moment RMS
  levels are also several times those of the naive carrier.
- The two tail-only mean-bend variants are less violent but preserve the same
  topology.  They remain below the acceleration cap, yet cross from positive
  to negative body-frame bearing near `4--5T`, continue turning in the old
  direction, and exit upward near `9T` with final distances `13.084L` and
  `13.405L`.  Thus actuator headroom alone falsifies the assigned parent's
  provisional boundary: a persistent mean-curvature request is too slow or
  too gait-destructive to arrest the established turn in this evidence set.
- The inherited optimizer scores agree with the multimodal ranking: none of
  the three target-aware mean-bend descendants beats the naive carrier, and an
  additional inherited worker ended even farther away at `15.366L`.

## Candidate hypothesis

Retain an unsaturated state-feedback traveling bend, remove persistent
whole-body curvature, and steer by a phase-gated posterior half-cycle
asymmetry.  A bounded body-frame bearing requests a turn rate; measured recent
turn rate closes the response loop.  Only the tail half-cycle already bending
toward the requested side is enlarged, so a reversing request can act on the
next compatible stroke without dragging the anterior oscillator toward a hard
limit.  The expected observable change is that bearing reversal near `4--5T`
causes a yaw reversal while the alternating wake and forward motion remain;
the first falsification is the same upper-boundary exit with monotonically
wrong-sign yaw, and secondary falsifications are lost wake coherence or
renewed joint/action saturation.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning by asymmetric flapping with sensor-feedback modulation
source_mechanism: gait-phase-gated half-cycle amplitude asymmetry closed on direction error and measured response
transferable_invariant: preserve the traveling propulsive rhythm and concentrate bounded steering authority on the compatible half-stroke, releasing or reversing it when the observed turn catches the target request
nontransferable_details: published gains, clock-driven CPG phase, robot linkage geometry, exact duty ratios, species kinematics, and task-specific routes
policy_translation: infer phase from the lagged tail target reconstructed from joint state; map normalized body-frame bearing to desired yaw; use recent yaw response to select and enlarge only one posterior half-cycle within the two-joint acceleration contract
falsification: reject if the rollout repeats the near-9T upper exit without yaw recovery, destroys the coherent alternating wake, loses early distance progress, or spends materially at joint, speed, or acceleration limits
