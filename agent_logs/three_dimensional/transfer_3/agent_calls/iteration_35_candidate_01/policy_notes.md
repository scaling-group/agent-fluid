# Joint-rate anti-windup candidate

## Evidence diagnosis recorded before the policy edit

- All four sampled solvers satisfy the frozen contract: direct-uniform
  `U_infinity=(0,0,0)` initialization, no prewarm or cylinders, finite
  dynamics, and capture at `18.6560--18.7330T`. The three exact
  actuator-consistent instances span scores `-0.13362-- -0.13142` and mean
  distance `2.01959--2.02129L`; helpful-moment relief scores `-0.13321` and
  arrives only `0.0165T` ahead of the two `18.6725T` exact samples. Its
  inherited approximately `18.9915T` repeat makes that one-run edge smaller
  than policy-repeat variability, so neither another moment gate nor scalar
  tuning is supported.
- I inspected all current combined sheets and compared the best-score exact
  route with the inherited phase-observer failure. In both top-down and
  oblique rows, the current exact route forms a body-led alternating
  vorticity/Lambda2 wake by `4T` and follows a shallow continuously corrected
  approach to capture. Direct-uniform zero flow and local-flow RMS
  `0.01804--0.01816U` rule out passive advection. The failed observer also
  preserves a coherent self-propelled wake, but visibly delays translation
  and makes a much longer late turn; its `22.011T` capture, score `-0.42356`,
  and mean distance `2.31828L` show that lower load without route preservation
  is not an improvement.
- The assigned-parent recovery and inherited logs therefore support keeping
  the normalized bearing-plus-LOS-rate C-bend, traveling carrier, persistent
  same-side phase recruitment, and componentwise acceleration projection.
  The current sample exposes a separate, repeatable actuator inconsistency:
  exact-route traces occupy the `260 deg/T` joint-rate limit for about
  `2.85--3.00%` anteriorly and `7.05--7.36%` posteriorly. Almost every such
  sample still commands acceleration in the same direction as joint motion;
  opposite-sign braking at the limit is only `0--0.03%`. Posterior outward
  rate-limit samples also coincide with acceleration clipping for
  `2.26--2.39%` of the rollout. Those commands cannot increase feasible joint
  speed and are a state-feedback anti-windup opportunity, not evidence for a
  new route or fluid-response channel.

## Policy hypothesis recorded before the policy edit

Preserve the evaluated route and carrier equations exactly, including the
phase actuator and acceleration clamp. Add one reflection-equivariant
joint-rate anti-windup projection at the policy boundary: when a joint is
already at its parameter-owned speed limit, suppress only acceleration whose
product with joint velocity is positive; retain the full opposite-sign
braking command. For the posterior persistence gate, interpret continued raw
outward demand at that exact boundary as the feasible-action witness that the
zeroed return would otherwise hide; release it immediately when demand
reverses. Because the released integrator already enforces the same speed
limit, this should remove infeasible outward effort without changing the
directed traveling bend, steering response, or capture route.

Support requires capture inside the inherited exact-policy
`18.6725--19.0520T` band, mean distance no greater than `2.02129L`, coherent
wakes in both views, and force/moment RMS no higher than `0.01350/0.00703`.
The mechanism is useful only if outward action at the speed limit falls while
braking remains available. Falsify it if integration semantics alter joint
phase enough to lose/delay capture, weaken either wake, or move route/load
outside the replicated envelope; in that case later workers should restore
the plain feasible projection rather than tune the rate threshold.

## Structured bookshelf transfer

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and actuator-envelope gait design
source_mechanism: preserve a coordinated rhythmic carrier while using joint-state feedback to stop commands from winding further into an active actuator constraint
transferable_invariant: the posterior-lagged traveling bend remains primary; at a hard joint-speed boundary suppress only same-direction acceleration and preserve reverse braking authority
nontransferable_details: published gains, dimensional frequencies, species or robot kinematics, full-body waveforms, exact vortex phases, actuator hardware, and task-specific routes
policy_translation: retain the normalized body-frame LOS C-bend and actuator-consistent phase path, project each feasible acceleration with observed joint velocity and a parameter-owned speed limit under an odd reflection-equivariant sign test, and use continued same-side raw posterior demand at that boundary to preserve the existing persistence gate until braking begins
falsification: reject if capture leaves 18.6725--19.0520T, mean distance exceeds 2.02129L, either wake weakens, force/moment RMS exceeds 0.01350/0.00703, or braking/phase is impaired rather than only infeasible outward action being removed

## Offline projection audit after the edit

As a frozen-state check only, applying the one-sided projection to the four
completed traces lowers posterior action RMS from `28.72--28.85` to
`28.06--28.16 rad/T^2` and posterior acceleration-limit occupancy from
`75.19--76.11%` to `72.93--73.84%`; anterior clip occupancy is unchanged and
anterior RMS falls by only `0.04--0.05 rad/T^2`. This confirms that the code
selects the evidenced redundant direction rather than globally weakening the
carrier. It is not a closed-loop result and cannot establish capture, wake, or
load benefit before the post-exit CFD evaluation.

The current candidate's CFD result is produced only after this worker exits
and is not used as evidence here.
