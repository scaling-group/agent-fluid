# Phase-ahead speed-guard candidate

## Evidence read before editing

- All available evaluations use the required direct-uniform still-water setup:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, and inertial-coordinate
  moving-window transport. The assigned-parent rollout and three sampled
  rollouts byte-match the prefilled speed-viability policy and combined visual
  sheet. Each captures at `0.7493656L` and `27.5770T`, establishing deterministic
  fixed-condition transfer but not robustness or trajectory diversity.
- The two distinct combined sheets were inspected from release to termination.
  Both the angle-only predecessor and the speed-guard descendant self-propel
  from rest on coherent alternating top-down wakes and compact oblique Lambda2
  structures, translate continuously toward the target, and make the same
  late correct-sign turn into the capture circle. The speed guard produces the
  visibly shallower terminal heading and arrives `0.1925T` earlier. Wake
  structures trail the body as the window follows it, so neither route is
  imposed-flow advection or a moving-window artifact. No sampled failure sheet
  is present; the angle-only policy is the informative safety-defect contrast,
  while the inherited failure digest supplies the semantic contrast of
  coherent terminal-waveform variants that still exited left.
- Metrics confirm the visual read. Relative to the angle-only predecessor, the
  current guard preserves zero angle contacts, removes `1124/10098` exact speed
  contacts, slightly reduces acceleration-clamp exposure from `1700/10098` to
  `1686/10028`, and leaves peak planar force effectively unchanged
  (`0.02212` to `0.02218`) while slightly lowering peak yaw moment (`0.01041`
  to `0.01034`). Maximum joint rates remain just inside the envelope at
  `259.63/258.03 deg/T`.
- Exact rate clearance hides a switching defect. Across both the sampled and
  assigned-parent copies, the anterior command changes by as much as
  `28.1668 rad/T^2` in one control step when the present-speed gate activates;
  the angle-only predecessor's maximum is `5.9299 rad/T^2`. The narrow
  `250--260 deg/T` band is crossed in roughly one CFD step under the observed
  worsening acceleration, so a smooth gate of present speed can still behave
  almost discontinuously. The unchanged force and moment peaks mean this is a
  falsifiable viability concern, not evidence of an already destabilized wake.
- The inherited stronger fixed-brake test is not a remedy: it retained 34 rate
  contacts, increased clamp exposure to 1725 samples, raised peak force/yaw
  moment to `0.02418/0.01124`, and scored worse despite capture. This candidate
  therefore does not increase brake magnitude or retune the carrier.

## Policy hypothesis

Preserve the evaluated traveling-bend carrier, posterior allocation, body-frame
target/course selector, same-sign redirect, terminal miss veto, positive
line-of-sight response deficit, angle stopping guard, speed soft limit, and
speed-guard brake. Change only speed-guard activation: for a joint whose
combined command would increase its measured rate magnitude, project the rate
increment over a small normalized carrier-phase horizon. Use that projected
increment to move the smooth transition onset inward, while retaining the hard
rate limit as the fixed upper end. Large worsening commands then receive a
wider, earlier transition; small commands approach the existing gate; and
speed-reducing commands remain exact pass-through. Apply the same signed rule
to both joints to preserve lateral reflection equivariance.

The falsifiable expectation is repeat capture with the same coherent route and
zero angle/rate contacts, but with the anterior one-step action jump materially
below `28.1668 rad/T^2` and without greater acceleration-clamp residence, force,
or yaw-moment exposure. Reject the mechanism if it weakens the ordinary
traveling bend enough to lose capture, changes speed-reducing phases, causes
soft-boundary chatter, restores angle/rate contact, or merely moves switching
or load exposure earlier in the beat.

bookshelf_consulted: true
source_domain: sensor-modulated rhythmic robotic-fish control and finite-envelope feedback for traveling-wave propulsion
source_mechanism: preserve an autonomous propulsive rhythm while measured actuator headroom schedules a bounded residual before a constraint is consumed
transferable_invariant: constraint intervention should be reflection-equivariant, phase-normalized, inactive for commands that restore headroom, and earlier for states whose measured command predicts faster envelope consumption
nontransferable_details: published gains, dimensional controller rates, species-specific kinematics, exact vortex phases, Strouhal targets, task coordinates, and memorized routes
policy_translation: retain the body-frame two-joint carrier and guard authority; for each speed-increasing command, project one small carrier-phase rate increment and smoothly dilate only that joint's near-limit activation band
falsification: reject if capture or coherent propulsion is lost, a speed-reducing command changes, angle or rate contact returns, the maximum one-step action jump is not reduced, or clamp, force, or yaw-moment exposure increases

## Non-CFD implementation audit

- A joint-only `20T` integration at the released `0.0055T` step preserved the
  carrier rather than globally damping it: anterior/posterior angle extrema
  changed from about `41.32/41.26 deg` to `41.18/41.05 deg`, maximum rates
  changed from `258.51/257.79 deg/T` to `256.50/256.14 deg/T`, and neither
  policy contacted the rate limit. The maximum synthetic one-step command
  changes fell from `19.79/7.15` to `8.13/4.01 rad/T^2`. This is a contract and
  mechanism check only, not CFD evidence or a capture claim.
- Direct mirrored-state assertions confirm lateral reflection equivariance.
  The candidate exactly matches the sampled parent at low joint rate and when
  a near-limit command restores rate headroom.
- The required check-runner was invoked, but its pinned `gpt-5.4-mini` model is
  unavailable for this account. Its three prescribed checks were then run
  directly and separately: the guidance semantic-delta/schema guard passes,
  the Julia policy contract returns two finite accelerations, and the solver
  editable-boundary check passes. No CFD was run.
