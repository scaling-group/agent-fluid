# Phase 2 posterior-recovery allocation candidate

## Evidence and visual diagnosis before editing

- All four sampled solver results satisfy the frozen rollout contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite moving-window dynamics, and `capture`
  termination. They reproduce one physical baseline behavior: every result
  captures at `19.684490 T` with score `-0.261384287`, mean/final distance
  `2.151092787 L`/`0.748302400 L`, `243` window shifts, and the same combined
  keyframe-sheet hash. Three policy files are v40 and the fourth is the v41
  selector whose additional branch was dormant.
- I inspected both rows of the combined v40 sheet from release to capture.
  The top-down row begins from quiescent fluid, then shows self-propelled
  target-directed translation and a coherent alternating wake rather than
  advection. The route is compact and nearly monotone (`0.006661 L` sampled
  backtracking; `12.951133 L` center path). The oblique row shows finite,
  localized Lambda2 structures following the tail, with no collision, domain
  exit, wake collapse, or volume-filling instability. The final view is a
  quiet curved posture gliding through the capture circle.
- Because the four current sheets are byte-identical, their only informative
  failure is v41 branch dormancy. I therefore compared the baseline sheet
  with the inherited low-speed energy-bootstrap sheet and its completed
  diagnostics. Both tested anterior-energy mechanisms initially advance the
  `12 L` crossing but then widen the approach: v42 reaches `4 L` at
  `17.247997 T` and captures at `22.962509 T` with score `-0.330184330`, mean
  distance `2.226326690 L`, and path `13.571320 L`; v44 reaches `4 L` at
  `17.803501 T` and captures at `23.408014 T` with score `-0.380336665` and
  path `13.553385 L`. In the v44 top-down row the alternating wake stays
  finite but the late body path curves broadly and the terminal sheet becomes
  a long lateral band; the oblique structures remain localized rather than
  unstable. Thus low translation is not a safe proxy for missing oscillator
  energy here: changing anterior phase-space energy changes the later coupled
  state and route despite an exactly terminal-silent same-state gate.
- The inherited posterior-divergence allocator is the more local diagnostic.
  Adding `0.02` common-scaling share while normalized posterior error is
  growing reduces outer lateral-force/yaw-moment maxima from about
  `0.027397/0.015260` to `0.026123/0.015007` and shortens the center path to
  `12.761224 L`, but it delays every `10 L` through `1 L` crossing, worsens
  score/mean distance to `-0.272400020`/`2.162221182 L`, and perturbs the
  realized terminal regime to `280/380` high anterior/posterior commands
  versus `229/302` for v40. Its slightly earlier final threshold crossing is
  therefore not evidence that more common scaling improves target progress.

## Policy hypothesis

Preserve v40's target-relative steering, oscillator, posterior lag target,
base/direction coupled limiter, course-residual allocator, and full terminal
law. Use the already evidenced signed posterior error power only to withdraw
the *extra lag-response* common-scaling share when the posterior joint is
moving away from its traveling-bend target. Independent clipping then retains
more posterior corrective acceleration without changing the command ceiling;
converging motion keeps the proven v40 allocation. The mechanism is exactly
zero at and below `4 L` and cannot edit the mature gait frequency, mean
curvature, or terminal posture.

The expected signature is active but modest outer command reallocation,
earlier or unchanged intermediate range crossings, retention of the compact
alternating wake, and no terminal-command change under equal-state replay. It
is falsified by dormancy, slower intermediate progress or capture, a loop or
wider route, renewed v43-like terminal activity, greater joint-stop dwell or
material load growth, instability, or degradation of either visual row.

bookshelf_consulted: true
source_domain: classical elongated-body fish swimming and two-joint traveling-wave control
source_mechanism: posterior lagged motion supplies directed tail-end kinematics, so allocation should preserve recovery toward the traveling-bend target rather than add uniform attenuation while that response is diverging
transferable_invariant: use observed posterior error direction to preserve corrective authority toward an established lag target while retaining coordinated limiting during converging response
nontransferable_details: published gains, dimensional frequencies, species envelopes, exact body-wave or vortex phases, full-body kinematics, and task-specific routes
policy_translation: normalize posterior lag error by drive amplitude and posterior velocity by amplitude-times-state-derived frequency; outside 4 L only, use positive error-growth power to release the existing lag-conditioned common-scale fraction without altering the lag target, oscillator, steering residual, or command limit
falsification: reject if the branch is dormant or terminal-active, delays intermediate progress or capture, changes the compact route or coherent wake, increases saturation or material loads, causes joint-stop dwell, or destabilizes either visual view

## Pre-evaluation validation

- Reconstructing normalized body-frame observations from all `3,579` stored
  v40 states and comparing this candidate with the sampled v40 source changes
  `608/2,807` states above `4 L`, with maximum and mean-active command deltas
  of `0.378740` and `0.140120 rad/T^2`. Divergence support is independently
  nonzero on 660 outer states, and active changes span recorded distances from
  `12.325914 L` through `4.034126 L`.
- The same reconstruction changes `0/772` commands at or below `4 L`.
  Every candidate output is finite and remains within the unchanged
  `30.543262 rad/T^2` software ceiling. These equal-state checks establish
  activity and terminal isolation, not a CFD improvement.
- The prescribed check-runner was invoked, but its pinned `gpt-5.4-mini`
  model is unavailable for this account and failed before executing. Its three
  manifest commands were therefore run directly: the material guidance/notes
  check, finite two-joint Julia contract and parameter-schema guard, and solver
  edit-boundary check all pass. No formal CFD rollout was run.
