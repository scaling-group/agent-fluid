# Candidate diagnosis and hypothesis

## Evidence diagnosis before the policy edit

- All four sampled solver results are the same fixed-pose candidate and
  reproduce `capture` at `24.310009T`, minimum/final distance `0.749162L`,
  mean distance `2.223959L`, 4,420 steps, and 282 moving-window shifts.  Their
  top-down sheets are byte-identical.  The direct-uniform diagnostics confirm
  still water (`U_infinity=(0,0,0)`), no cylinders, and no prewarm, so the
  advance is self-propelled rather than imposed advection.
- The complete combined sheet in `solver_43e27134a723` shows the body laying
  down an alternating mid-plane street from release through the smooth
  target-side bend and capture.  Its oblique row shows discrete paired
  Lambda2 structures at `8T`, `16T`, and through `24.31T`; propulsion and the
  traveling carrier therefore survive the existing rudder/relief schedule.
  The other three combined sheets have the same top-down row but blank
  oblique panels (identical 2,149-byte oblique artifacts), so they support
  numerical and top-down determinism, not three additional confirmations of
  the 3D wake.
- There is no sampled failure policy to compare visually in this workspace.
  The inherited evidence bank supplies the relevant negative controls:
  upper/lower exits before the reactive rudder, harmful closing-deficit
  rudder boost, later translation-alignment relief, and worse posterior-phase
  broadening.  Those results rule out another terminal-gate, sign, or scalar
  relief edit.
- The reusable terminal mechanism is already tightly resolved, but the
  successful trace has a large startup transient: distance changes only from
  `12.328L` to `12.266L` by `2T`.  Body-forward speed averages about `0.183U`
  before `4T`, then about `0.625U` over the established cruise portion; only
  about 1.3% of post-`4T`, preterminal samples fall below `0.45U`.  The wake is
  coherent after it develops and loads remain bounded (peak normalized
  force/moment about `0.031649/0.016385`), so the evidence points to slow
  carrier recruitment rather than missing cruise thrust or steering.

## Policy hypothesis

Preserve the full target-geometry rudder, its measured opposite posterior
sign, and the reproduced target-side anterior-stroke terminal relief exactly.
Add one new closed-loop mechanism to the anterior oscillator: smoothly
increase its state-feedback energy injection only while normalized body-frame
forward speed is below the observed lower cruise envelope, reaching the
bounded maximum below `0.20U` and returning to the inherited oscillator by
`0.45U`.  This uses no clock or memorized route and naturally becomes inactive
during the sampled cruise and terminal approach.  It should shorten wake
startup and improve the distance integral without changing the established
turn/capture topology; after an unmodeled slowdown it can also re-recruit the
carrier from measured motion.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control, constrained by traveling-wave and elongated-body propulsion models
source_mechanism: sensory feedback recruits rhythmic oscillator energy after locomotor slowdown while retaining posterior phase lag
transferable_invariant: restore a traveling carrier from measured normalized forward-speed deficit and release the recovery continuously once useful advance returns
nontransferable_details: published gains, robot sensor calibration, species-specific kinematics, exact vortex phase, dimensional speed targets, and task routes
policy_translation: add bounded body-forward-speed feedback to anterior Van der Pol energy injection while leaving the two-joint posterior lag, target rudder, and terminal stroke allocation unchanged
falsification: reject if capture is later than 24.310009T, mean distance exceeds 2.223959L, progress by 2T does not improve from the 0.062L baseline, or rate-cap occupancy, action effort, peak force/moment, or the alternating 3D wake worsens

The numerical thresholds come only from the sampled rollout's normalized
speed distribution; they are not literature gains.  The new CFD outcome is
not available to this worker and is not claimed here.
