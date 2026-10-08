# Candidate diagnosis and hypothesis

## Evidence read before editing

- All four sampled rollouts are valid direct-uniform still-water evaluations and
  capture at `19.684490 T` with score `-0.261384287`, mean distance
  `2.151092787 L`, final distance `0.748302400 L`, path length
  `12.951133265 L`, and `243` moving-window shifts. Three use the assigned
  `v40` parent. The fourth adds a signed course/yaw allocation branch but is
  trajectory-identical, so it is an informative dormant negative rather than
  an independent reproduction of a response benefit.
- The combined sheets are byte-identical. The top-down row shows self-propelled
  compact target motion with a coherent alternating wake from release through
  capture. The oblique row shows finite, localized three-dimensional
  Lambda2 structures rather than volume-filling or detached instability. The
  target is approached from the upper side without a late loop.
- Trace cross-check: the parent crosses `4 L` at `15.444014 T`, has
  below-`4 L` high-command counts `229/302`, terminal force/moment maxima
  about `0.03052/0.01567`, no joint-angle stop, and no instability. Its signed
  center-course miss is negative. Negative yaw remains target-correcting down
  to about `1 L`; yaw reverses positive near `19.2665 T` at `0.936 L`, after
  which the same course miss and opposite-sign yaw identify a distinct
  target-worsening response through capture.
- The sampled signed course/yaw candidate used same-sign support, which was
  active during the useful correcting turn and peaked near `0.240`. It then
  combined that value with the existing allocation using `max`, so it never
  exceeded the parent's `0.82` floor and changed no trajectory state. The
  inherited phase-lag governor (`46.145020 T`, loop, score `-0.915606`) and
  startup mean-bend test (`23.375013 T`, late turn, score `-0.401182`) are the
  informative failures: outer traveling-wave or startup-curvature changes are
  not justified by this already coherent, compact wake.

## Policy hypothesis

Preserve every outer command and the validated flat intercept-supported
terminal posture. Detect only the late response reversal with the normalized
body-frame invariant `-course_signed_sine * turn_rate > 0`: the course miss and
yaw then have opposite signs, meaning rotation is increasing rather than
closing the translational intercept error under this adapter convention. Use
that support to spend only the terminal redirect allocator's existing
headroom, smoothly moving from its settled `0.82` posture allocation toward
`1.0`. Do not add a turn residual, change mean bend, widen the distance gate,
or restore cadence. This makes the mechanism exactly inactive outside the
existing terminal handoff and during the useful same-sign correcting turn.

Offline falsification checks before CFD: the branch must be zero outside
`4 L`, zero through the useful correcting-yaw interval, active only after the
observed sign reversal, bounded by the existing posture/acceleration limits,
and must change replayed commands without changing parameter ownership. CFD
falsification: reject if capture is delayed or lost, mean/final distance
worsens, useful correcting yaw is damped, the compact trajectory or either
wake view changes materially, or terminal command/load/joint-stop measures
grow.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and terminal capture control
source_mechanism: preserve the propulsive rhythm until sensed response shows target-relative oversteer, then continuously allocate toward a damped bend posture
transferable_invariant: gate rhythm-to-posture allocation by the sign of normalized target-course error relative to measured yaw response, not by time or an assumed beat phase
nontransferable_details: published oscillator gains, robot geometry, duty ratios, dimensional rates, species kinematics, and prescribed routes
policy_translation: use body-frame center-course signed sine, normalized recent yaw rate, existing distance and closure support, and the two-joint terminal posture allocator; add no world-coordinate or clock state
falsification: reject if the gate acts during target-correcting yaw or outside the terminal band, remains dormant, delays or loses capture, worsens distance, raises terminal loads or saturation, or degrades the coherent two-view wake

## Deterministic pre-CFD validation

- Replaying the sampled parent states through both policies reproduces the
  stored parent commands to within `2.55e-4 rad/T^2` (CSV precision). The new
  policy changes `16` states from `19.596493 T`, `0.778352 L`, through the last
  pre-capture state at `19.678989 T`, `0.750037 L`.
- No replayed command changes outside `4 L` or while course miss and yaw have
  the target-correcting same sign. The maximum same-state command difference is
  `0.115015 rad/T^2`; outputs remain within the existing
  `30.543262 rad/T^2` software limit. This proves activity and noninterference,
  not CFD improvement.
- The required guidance check, lightweight finite-action contract check,
  parameter-field schema audit, and solver boundary check pass. No CFD rollout
  was run.
