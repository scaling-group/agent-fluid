# Evaluated one-sided joint-speed feasibility candidate

## Visual and metric diagnosis before the edit

- The assigned parent (`solver_654687610a5f`) and all four sampled solvers
  report direct-uniform still-water initialization with
  `U_infinity=[0,0,0]`, no cylinders, and no prewarm. Three sampled policies
  retain the parent's mean-preserving joint-phase yaw demodulator; the distinct
  raw-coordinate control also captures. Thus termination, route, actuation,
  and load evidence—not score alone—select the candidate.
- I inspected both rows of the combined sheets for the assigned parent, the
  strongest sampled finite rollout (`solver_a2617fc44329`), the raw-coordinate
  capture (`solver_a46c8c6241a4`), and the inherited carrier-recruitment
  failure (`solver_7a764cc19afc`). The successful top-down rows show
  self-propelled targetward arcs and alternating signed vortex streets; their
  oblique rows retain finite tail-connected Lambda2 structures through target
  entry. The failure also forms an organized three-dimensional wake, but its
  route bends past the target and exits the lower boundary at `28.232T` after
  a `3.491L` minimum. Gross wake coherence therefore does not justify changing
  the demonstrated route mechanism.
- The assigned parent captures at `0.747896L` and `16.631994T`, with score
  `-0.118307`, scored/observed distance integrals `2.001992/1.378485L`, peak
  planar force/moment `0.036777/0.018272`, and maximum joint magnitudes
  `0.547719/0.555689 rad`. It is the route carrier to preserve.
- The sampled one-sided speed guard is the strongest completed controlled
  variant. With every carrier and steering gain unchanged, it captures at
  `0.745621L` and `16.609995T`, improves score to `-0.115560`, lowers the
  scored/observed distance integrals to `1.999656/1.377882L`, lowers maximum
  joints to `0.541097/0.549208 rad`, and lowers peak planar force/moment to
  `0.035828/0.017759`. Its mean absolute requested acceleration falls from
  `22.770/25.434` to `21.738/22.691 rad/T^2`; outward acceleration while above
  99% of the speed envelope falls from `9.656%/14.418%` to
  `1.854%/1.391%` of samples. Near-speed residence changes slightly in the
  wrong direction (`35.979%` to `36.159%` for either joint above 95%), so the
  evidence supports removing infeasible outward command, not claiming less
  time near the speed boundary.

## Single policy hypothesis

Promote the evaluated one-sided speed-feasibility policy as this workspace's
sole candidate. Preserve the full-amplitude anterior oscillator, posterior
traveling-wave lag, normalized body-frame bearing/course/crossflow route,
mean-preserving joint-phase yaw demodulation, and phase-selective posterior
steering exactly through the existing smooth acceleration bound. Add only the
completed final-one-percent speed guard: normalize each observed joint speed
by the policy-owned envelope, smoothly remove acceleration directed farther
outward, and leave all interior and inward/reversal acceleration unchanged.

The completed comparison supports expecting the same alternating connected
wake and target-crossing arc with less discarded command and modestly better
arrival, distance cost, joint excursion, and load peaks. This is evidence for
promotion, not a claim about this unevaluated materialization. Falsify reuse if
capture or route topology fails to repeat, inward reversal is delayed, the
wake class degrades, outward-at-limit command is not reduced, or joint
contact, speed residence, force, or moment becomes materially worse. Do not
generalize the result to broad carrier attenuation: inherited whole-wave
relief and carrier recruitment changed the useful route.

bookshelf_consulted: true
source_domain: low-dimensional robotic-fish CPG control and moderate-amplitude swimming under bounded actuation
source_mechanism: preserve the rhythmic traveling-bend carrier while applying a distinct bounded correction compatible with the actuator envelope
transferable_invariant: remove only joint command that cannot produce farther feasible motion at an active speed boundary while preserving interior carrier motion and inward reversal
nontransferable_details: published gains, dimensional frequency, species or robot kinematics, exact vortex phases, waveform envelopes, maneuver timing, and task-specific routes
policy_translation: normalize each of the two observed joint speeds by a parameter-owned limit and smoothly project only outward acceleration toward zero in the final one-percent guard band after body-frame route and carrier feedback are formed
falsification: reject if capture, targetward route, or connected wake fails to repeat, if reversal is delayed, or if outward-at-limit command, joint contact, speed residence, force, or moment worsens

## Evaluation boundary

Post-worker CFD should compare capture and arrival first, then scored and
observed distance integrals, target-relative trajectory, outward acceleration
conditional on joint speed, mean requested acceleration, reversal timing,
joint contact and speed residence, peak planar force/moment, and both wake
views against `solver_654687610a5f` and the completed implementation
`solver_a2617fc44329`. Fixed-pose repetition remains no evidence of robustness
to a changed pose or flow.
