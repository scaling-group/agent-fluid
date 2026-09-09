# Posterior rate-headroom phase-braking candidate

## Visual and metric diagnosis recorded before the policy edit

- All four sampled solver rollouts satisfy the frozen contract: direct-uniform
  `U_infinity=(0,0,0)` initialization, no prewarm or cylinders, finite
  dynamics, and capture at `18.6560--18.7330T`. I inspected both rows of the
  combined sheets for the best-score exact route, the sampled joint-rate
  anti-windup policy, and the inherited closing-speed-envelope negative from
  release through termination. Their top-down views show body-led translation
  and coherent alternating caudal-vorticity streets; their oblique views show
  compact Lambda2 structures forming behind the tail. Local-flow RMS is only
  `0.01804--0.01816U` in the current exact and anti-windup samples, agreeing
  that these are self-propelled route/actuator differences rather than passive
  advection. None shows wake breakup, growing lateral waste, collision,
  boundary contact, or numerical instability.
- The exact prefilled policy captures twice at `18.6725T` and `18.7330T`, with
  mean distance `2.02018L` and `2.01959L`, posterior action RMS
  `28.77` and `28.72 rad/T^2`, posterior acceleration-limit occupancy
  `75.46%` and `75.19%`, and posterior rate-limit residence
  `7.36%` and `7.02%`. Its two sheets are visibly indistinguishable at the
  available sampling cadence, so their small score/timing spread is the route
  baseline rather than evidence for an instantaneous fluid-response edit.
- The same joint-rate anti-windup policy now has two completed evaluations.
  Its current sample captures at `18.7000T`, but the assigned-parent repeat
  captures only at `19.0905T`, raises mean distance to `2.05157L`, and scores
  `-0.16317`. Both wakes remain coherent and body-led, and both runs do lower
  posterior action RMS to `28.24` and `28.15 rad/T^2` and acceleration-limit
  occupancy to `73.91%` and `73.00%`. Yet posterior rate-limit residence is
  not reduced (`7.32--7.89%` versus `7.02--7.36%` for the exact samples).
  Hard-zeroing outward acceleration at the already-active speed boundary is
  therefore reproducible command cleanup but not a robust route-neutral or
  rate-residence improvement.
- The inherited closing-speed carrier envelope is the complementary negative:
  it retains a coherent wake but slows capture to `18.8705T`, raises mean
  distance to `2.04281L`, and shifts effort upstream while lowering posterior
  load. Together these results rule out weakening carrier amplitude or merely
  clipping more commands. They support changing when the posterior wave turns
  around: use the observed joint-rate headroom before the boundary, while
  keeping the evaluated LOS route and traveling-bend coefficient norm.

## Policy hypothesis recorded before the policy edit

Preserve the normalized bearing-plus-LOS-rate C-bend, response-reversing
half-cycle steering, persistent same-side phase recruitment, and physical
acceleration projection. Add one bounded posterior actuator mechanism:
normalize posterior joint rate by the parameter-owned physical speed limit,
detect same-direction acceleration as rate headroom closes, and rotate the
existing posterior position/velocity wave coefficients toward reverse
acceleration. The rotation direction is computed from observed posterior rate
and the local phase gradient, so its first-order target change opposes outward
motion; it does not zero the carrier, withdraw route steering, use a clock, or
redistribute curvature to the anterior joint. The signed products are
reflection-invariant and the rotated wave remains reflection-odd.

Support in the later CFD evaluation requires capture no later than `19.0520T`,
mean distance no greater than `2.02129L`, coherent self-propelled wakes in both
views, posterior rate-limit residence below the exact-route lower bound of
`7.02%`, and posterior action RMS or acceleration-limit occupancy below
`28.72 rad/T^2` / `75.19%` without moving saturation upstream or exceeding
`0.01350/0.00703` force/moment RMS. Falsify the mechanism on lost/delayed
capture, weaker early propulsion or wake, phase/steering conflict, unchanged
rate residence, or effort reduction obtained only through route slowing. The
current candidate's CFD result is produced only after this worker exits and is
not evidence here.

A causal dry replay over the two exact-policy traces uses each completed row's
state and previous action to predict the following command. It is a scope check,
not an altered-flow prediction. The rate-headroom mechanism changes the
posterior command by more than `0.05 rad/T^2` on only `197/3405` and
`200/3394` rows, with maximum changes `0.934` and `0.957 rad/T^2`. On those
fixed traces, aggregate command change times posterior rate is negative
(`-416` and `-430` in replay units), and the replayed posterior action RMS
changes from `28.7185/28.7718` to `28.7047/28.7573 rad/T^2`. This verifies
that the implementation is a small pre-boundary phase intervention on the
exact route; only later CFD can test rate residence, route, wake, and loads.

## Structured bookshelf transfer

bookshelf_consulted: true
source_domain: robotic-fish CPG phase modulation and actuator-envelope gait design
source_mechanism: preserve a directed rhythmic traveling bend while sensor feedback shifts posterior phase before an actuator boundary rather than suppressing the carrier after saturation
transferable_invariant: use normalized posterior joint-rate headroom and the observed wave phase gradient to turn the tail wave toward braking while slow body-frame LOS feedback continues to own the route
nontransferable_details: published CPG gains, dimensional frequencies, species or robot kinematics, prescribed gait envelopes, exact vortex phases, actuator hardware, and task-specific routes
policy_translation: retain the evaluated two-joint LOS route and coefficient-norm-preserving posterior wave, then add a bounded reflection-equivariant phase rotation whose first-order target change opposes same-direction acceleration as normalized joint-rate headroom closes
falsification: reject if capture leaves the replicated route band, either wake or early propulsion weakens, phase braking conflicts with steering, posterior rate-limit residence does not fall below 7.02%, or lower effort is explained by delayed progress
