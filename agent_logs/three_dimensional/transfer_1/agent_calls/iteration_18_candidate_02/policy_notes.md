# Wake-policy candidate notes

## Evidence and visual diagnosis

- All four sampled evaluations report direct uniform initialization with
  `U_infinity=(0,0,0)`, no cylinders, and no prewarm. The motion in both rows
  is therefore self-propelled rather than imposed advection.
- The prefill policy captured at `18.6065T`, but inherited repeat evidence for
  those exact bytes also contains a `1.7715L` lower exit. Its current sheet
  shows a coherent alternating top-down wake and persistent oblique Lambda2
  structures, so that fragility is a terminal steering/allocation problem,
  not propulsion failure.
- The intercept-guarded carrier-reserve sibling has one policy hash across
  three sampled evaluations and captured in all three at `18.2050--18.6010T`.
  Each top-down row lays down an alternating reverse-street-like wake from
  release through capture, and each oblique row retains compact three-
  dimensional wake structures through the terminal approach; there is no
  visible carrier collapse or passive coast.
- Trace cross-check: the three exact-byte repeats cross at
  `0.8268--0.9083L/T`, both joints reach `260 deg/T`, returned acceleration is
  clamped on about `68.5--68.7%` and `70.6--71.0%` of rows, maximum force norm
  is `0.0302--0.0312 L^2`, and maximum absolute yaw moment is
  `0.0157--0.0163 L^3`. Their final headings span `0.116--0.790 rad` and their
  head crossing positions span `y=9.115--9.891L`, on both sides of the target
  ordinate. That variation argues against endpoint heading, beat-phase, or
  side-specific gating.
- Available inherited optimizer logs include recent lower exits at minimum
  distances `1.125--1.768L` and captures at the threshold. Together with the
  current three-repeat evidence, they favor semantic repeatability over the
  best single scalar score.

## Candidate hypothesis

Adopt the exact sampled `dogfish3d_intercept_guarded_speed_reserve_v1`
controller as the single candidate. Its normalized body-frame projected-miss
and approach gates prevent yaw-response release unless the current velocity
projects through the capture corridor. Its separate state-conditioned reserve
softens only outward carrier acceleration that follows a near-saturated action
near the joint-speed envelope, leaving additive steering and restoring carrier
effort intact. Do not tune its scalar thresholds in this candidate: the
mechanism already has three exact-byte captures across materially different
terminal phases and headings.

The candidate is supported if it captures while retaining the alternating 3D
wake and remains within the sampled speed, clamp, force, and moment envelope.
It is falsified by a lower exit, carrier collapse, a materially worse closest
pass, or increased envelope residence/load. A failed repeat would weaken the
three-of-three robustness claim and make repeat evaluation more valuable than
further threshold tuning.

## Bookshelf protocol

`fish-control-primitives` was checked for its structured trigger. This is not
the common-seed architecture proposal, and inherited guidance contains both a
new carrier-reserve mechanism and a new semantic result (three repeated
captures) in the recent completed iterations. The three-stagnant-iteration
trigger is therefore absent. No shelf reference informed this edit, so no
mechanism-transfer block is claimed.
