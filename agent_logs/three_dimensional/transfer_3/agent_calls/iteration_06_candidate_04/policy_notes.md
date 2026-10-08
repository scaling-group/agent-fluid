# Response-released terminal reallocation candidate

## Evidence diagnosis before the policy edit

- All four sampled rollouts satisfy the physical initialization contract:
  direct uniform still water with `U_infinity=(0,0,0)`, no cylinders or
  prewarm, and capture at about `25.11T`. The assigned parent
  `solver_6a46e49f8216` scores `-0.52837563`; the strongest finite sample
  `solver_89a97c83567b` scores `-0.52833877` and is the only sampled policy
  with the response-released allocation proposed below.
- The top-down sheets show self-propulsion rather than advection: the fish
  sheds a coherent alternating wake while distance falls from `12.328L` to
  about `9.3L`, `6.7L`, and `4.2L` near `10T`, `15T`, and `20T`, followed by
  a broad target-directed bend and capture. The outer sheets are visually
  indistinguishable at their coarse sampling cadence, consistent with all
  three mechanisms leaving the pre-`4L` controller unchanged.
- In the usable oblique sheets for `solver_89a97c83567b` and the duplicated
  closure-preview sample `solver_d5c9dea468e1`, the released body produces an
  organized three-dimensional Lambda2 chain and remains planar through the
  terminal bend. Several other oblique panels are black, including the whole
  `solver_b9538d7777ef` sheet and most of the parent sheet; these fail the
  visual-evidence contract and are not evidence for or against a policy.
- Metrics resolve what the images cannot. The closure-preview baseline
  captures at `25.1130T` with mean distance `2.430636L`. The parent's
  departure-selective reallocation also captures at `25.1130T`, improves mean
  distance to `2.429298L`, and lowers inside-`4L` force/moment maxima to about
  `0.01427/0.00757`. The response-released sample captures one integration
  step later at `25.1185T`, but has the best mean distance (`2.429294L`), best
  final crossing (`0.746410L`), and best score. Neither response-conditioned
  variant hits an acceleration cap inside `4L`; their outer carrier histories
  retain the same roughly `39.2%/31.4%` command-cap incidence and the same
  `0.6926U` maximum speed.
- At capture the response-released sample still has about `0.667 rad` target
  bearing error, `-0.313 rad/T` yaw rate, and `0.654U` translational speed.
  This task rewards first crossing, so those values support retaining bounded
  propulsion around the target-relative mean bend rather than imposing a
  costly terminal pose hold.

## Policy hypothesis

Replace the parent's departure-half-cycle boost with the sampled
response-released allocation. Preserve the closure preview, geometry-gated
redirect, and damped two-joint curvature equilibrium. Normalize the maximum
joint tracking error by the declared drive amplitude; while the equilibrium is
unsettled, retain full terminal allocation, and once both joints settle,
smoothly recover a bounded share of the posterior-lag carrier around the same
mean bend. This changes no outer-route signal, hidden clock, or world-frame
quantity. The candidate is falsified by loss or delay of capture beyond the
sampled response-released rollout, changed pre-`4L` progress/wake, return of
terminal saturation or large loads, or a repeat evaluation that cannot
separate its score from deterministic/numerical noise.

bookshelf_consulted: true
source_domain: biological C-start/burst redirect and sensor-modulated robotic-fish CPG control
source_mechanism: release a strong redirect into posterior beating only after observed response forms
transferable_invariant: transition locomotor allocation from measured target-relative joint response, not elapsed time, fixed phase, or a memorized route
nontransferable_details: species-specific C-bend magnitude and timing, full-body envelopes, published oscillator gains, exact tail-beat or vortex phase
policy_translation: use bounded drive-amplitude-normalized two-joint tracking error to retain the target-relative curvature equilibrium while unsettled and recover only a bounded posterior-lag carrier share after settling
falsification: reject if outer progress changes, capture is lost or materially delayed, terminal command caps or load spikes return, or repeated CFD cannot distinguish the small sampled score benefit from noise
