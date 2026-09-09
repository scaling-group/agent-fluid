# Wake-policy diagnosis and candidate hypothesis

## Evidence read before candidate selection

- All four sampled solver evaluations and the assigned-parent evaluation use
  direct uniform still-water initialization with `U_infinity=(0,0,0)`, no
  cylinders, and no prewarm. Their translation is self-propulsion rather than
  ambient advection.
- I inspected both rows of the combined keyframe sheets for the strongest
  finite sampled capture (`solver_6b0e320e2f55`) and the assigned-parent
  failure (`solver_a2f61d6b83f3`). The exact speed-reserve baseline develops a
  coherent alternating top-down wake and compact oblique Lambda2 structures,
  turns broadly toward the target, and retains its traveling bend through its
  `0.7494L` capture at `18.6010T`. The parent yaw-brake policy also retains an
  active organized wake through and after its closest pass, but misses below
  at `1.1336L` near `18.8375T`, continues self-propelling at about `0.839L/T`,
  and exits the lower boundary at `33.6545T` with final distance `10.9246L`.
  Neither sheet shows advection, carrier collapse, collision, or numerical
  instability; the discriminating failure is terminal steering geometry.
- The four sampled evaluations share policy SHA-256 `567de354...` and capture
  at `0.7466--0.7499L` over `18.2050--18.6725T`. Their coherent wakes coexist
  with head/tail action clamp fractions near `68.5--68.7%/70.6--71.0%`, speed-
  limit residence near `10.4--10.6%/11.3--11.6%`, peak lateral-force
  coefficient `0.0274--0.0292`, and peak yaw-moment coefficient
  `0.0157--0.0163`.
- The assigned parent added only a small response-opposing residual inside an
  approaching projected corridor. Its own dry replay predicted activation on
  just `3.9--7.7%` of baseline rows and a maximum `2.36 rad/T^2` residual, yet
  its CFD rollout changed capture into a stable lower exit. It did not reduce
  action clipping consistently (`70.2%/69.6%`) and its lower speed-limit
  residence (`8.4%/8.0%`) brought no semantic benefit. This falsifies terminal
  yaw-response braking in this sensitive topology rather than motivating a
  gain or distance-gate retune.
- Other inherited logs already reject projected-miss error replacement, a
  total-command speed governor, and carrier-signed half-cycle redistribution:
  each retained an active wake but changed repeat-supported capture into a
  lower exit. The sampled exact baseline is therefore stronger evidence than
  another stacked terminal mechanism.

## One candidate hypothesis

Select the existing `dogfish3d_intercept_guarded_speed_reserve_v1` file as the
single candidate, byte-identical to the four sampled captures. It preserves
the joint-state traveling carrier, achieved-course route residual, projected
intercept veto, phase-independent steering, and sparse outward-carrier reserve
without the failed yaw brake or another terminal perturbation. Keeping the
exact bytes is deliberate: changing a version string, comment, or scalar would
forfeit the strongest available mechanism-level repeat evidence without
adding a testable capability.

Expected test: reproduce capture, active terminal propulsion, and the sampled
arrival/load envelope. This selection is falsified if its new exact repeat
leaves the domain, loses the coherent alternating wake, or materially exceeds
the sampled force, moment, clipping, or speed-residence envelope. A successful
repeat strengthens fixed-condition reliability but does not establish
robustness to held-out poses or flows.

bookshelf_consulted: true
source_domain: classical undulatory propulsion and robotic-fish closed-loop direction control
source_mechanism: keep a posterior-lagged traveling carrier separate from bounded sensor-driven route correction
transferable_invariant: preserve productive rhythmic propulsion while normalized body-frame target and velocity geometry gate a distinct bounded steering loop
nontransferable_details: published gains, dimensional cadence, species or robot kinematics, exact beat or vortex phase, prescribed routes, and terminal-damping recipes
policy_translation: retain the exact two-joint traveling-bend, achieved-course/intercept, and sparse speed-reserve controller; do not adopt the shelf's optional terminal yaw-damping residual because the assigned-parent CFD falsified it
falsification: reject the selection if an exact repeat loses capture or wake coherence, or leaves the sampled load and saturation envelope; reconsider a new primitive only with an observation that distinguishes the divergent terminal trajectories before actuation changes

## Non-CFD verification

- The selected candidate is nonempty and has SHA-256
  `567de354e2bf646dce0776b20e284aabc896c7816eafff848839efa2937b9dac`,
  exactly matching all four sampled captured policy files.
- The required material-guidance/schema check passes, and the editable solver
  boundary check passes. No sibling candidate or out-of-boundary solver edit
  was created.
- The prescribed Julia runtime smoke test could not execute because Julia is
  absent from this worker environment; a direct official-runtime fetch was
  blocked by an upstream TLS reset. This is an environment limitation, not a
  claimed pass. The byte-identical file nevertheless executed in all four
  sampled CFD evaluations. No formal CFD was run in this worker.
