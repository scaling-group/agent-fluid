# Candidate diagnosis and policy hypothesis

## Evidence read before the edit

- All four sampled rollouts and the assigned-parent rollout use direct uniform
  still-water initialization at `U_infinity=(0,0,0)`, with no cylinders or
  prewarm. Their motion and wakes are released-swimmer behavior, not advection.
- Two sampled exact speed-reserve baselines capture at `0.7466--0.7494L` and
  `18.3205--18.6010T`. Two sampled posterior-wave copies also capture at
  `0.7480--0.7492L` and `18.2050--18.4690T`, but the assigned parent's exact
  posterior-wave repeat reaches only `1.7867L` and exits the lower boundary.
  Thus the posterior addition is `2/3` in the available exact-policy evidence
  and has no demonstrated score, load, or actuator benefit over the simpler
  repeat-supported baseline.
- I inspected the combined top-down vorticity and oblique Lambda2 rows for the
  highest-scoring baseline capture, a posterior-wave capture, and the exact
  posterior-wave failure. All three remain self-propelled with an organized
  alternating mid-plane street and compact three-dimensional structures. The
  failed repeat continues laying down an active wake after passing below the
  target, so its failure is route geometry rather than carrier collapse,
  advection, collision, or numerical instability.
- Reconstructed body-frame traces distinguish where the failure develops.
  The two posterior captures enter `2.75L` with projected misses of about
  `0.64L` and `1.02L`; the failed repeat is already at `2.00L`, with both
  accelerations clamped in the requested turn direction. A posterior pulse
  that begins only inside the same gate cannot recover that middle-range miss.
- Across the four sampled captures and the inherited posterior failure,
  anterior joint speed and raw body-frame lateral velocity have correlation
  about `-0.95`. Per-rollout fits give `v_y = offset - (0.094--0.102) qdot_1`;
  subtracting that one carrier component reduces lateral-velocity standard
  deviation from `0.295--0.326` to `0.084--0.103 L/T`. The current achieved-
  course servo therefore spends much of each beat reacting to self-induced
  lateral velocity even though physical target/velocity projection remains a
  useful interception observation.

## One candidate hypothesis

Restore the exact speed-reserve baseline and add one phase-decontaminated
course observation. Use the evidence-calibrated anterior-joint term only when
forming achieved course: `route_v_y = raw_v_y + 0.10 qdot_1`. Keep raw physical
velocity unchanged for speed gating, closing behavior, LOS rate, projected
miss, and approach alignment. Preserve the evaluated traveling bend, cadence,
response release, intercept guard, additive steering, carrier reserve, and
actuator limits byte-for-byte otherwise.

Expected test: reducing carrier-synchronous sign reversals in the slow route
loop should preserve the coherent wake while making middle-range intercept
geometry less sensitive to exact-run variation. A useful result must retain
capture, enter `2.75L` near the repeat-supported projected corridor, and avoid
raising clamp residence or force/moment peaks beyond the baseline envelope.

Falsification: reject the compensation and restore the exact speed-reserve
baseline if far-field closure worsens, the alternating wake weakens, capture
is lost, course correction develops a persistent bias, saturation or loads
increase, or the same below-target branch remains. Do not answer a failure by
tuning the single coefficient or stacking the rejected posterior pulse,
half-cycle allocator, or yaw damper.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish direction tracking and rhythmic locomotion control
source_mechanism: separate the slow target-directed route command from fast gait-synchronous lateral motion while leaving the propulsive oscillator active
transferable_invariant: a route loop should respond to persistent body-frame course error rather than the carrier's own alternating lateral velocity
nontransferable_details: published gains, dimensional cadence, robot or species kinematics, oscillator clocks, exact wake phase, prescribed paths, and task coordinates
policy_translation: use the evaluated normalized anterior joint speed to remove its evidenced linear carrier component only from body-frame achieved course; retain raw normalized velocity for physical intercept geometry and retain the two-joint traveling bend unchanged
falsification: reject if capture, far-field closure, wake coherence, projected corridor entry, actuator saturation, or force and yaw-moment loads worsen versus the exact speed-reserve baseline

## Non-CFD verification

- The mandated guidance-semantic, Julia policy-contract, and solver editable-
  boundary checks pass. The contract used the bundled Julia `1.12.6` runtime;
  no CFD rollout was run.
- Static schema validation finds all 43 direct `params.FIELD` references in
  the 45 fields returned by `target_policy_params()`, with no missing field.
- A mirrored target, lateral velocity, joint state, yaw rate, and previous
  action produce exactly sign-mirrored joint accelerations. A representative
  non-symmetric state also differs materially from the exact sampled baseline,
  confirming that the phase-compensated course mechanism is active.
