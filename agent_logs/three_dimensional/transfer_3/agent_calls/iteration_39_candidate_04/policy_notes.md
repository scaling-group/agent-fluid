# Candidate diagnosis and hypothesis

## Evidence read before editing

- All four sampled rollouts use direct uniform still-water initialization with
  `U_infinity=0`, remain finite, and capture in `18.6560--18.7330T`. The two
  exact actuator-consistent copies capture at `18.6725T` and `18.7330T`, with
  scores `-0.13219` and `-0.13142` and mean distances `2.02018L` and
  `2.01959L`. This same-policy spread makes the helpful-moment candidate's
  `18.6560T`, `-0.13321`, and `2.02115L` result non-separating.
- The evaluated one-sided joint-rate anti-windup candidate captures at
  `18.7000T`, score `-0.13320`, and mean distance `2.02103L`, within the exact
  baseline band. It materially changes actuator feasibility: anterior and
  posterior outward-at-speed-limit occupancy falls to `0.618%/0.941%` from
  `2.819--3.004%/7.017--7.334%` in the exact baselines. Posterior acceleration
  clipping falls to `73.912%` from `75.191--75.464%`, overlap of posterior
  speed saturation and acceleration clipping falls to `0.676%` from
  `2.261--2.386%`, and posterior action RMS falls to `28.237` from
  `28.715--28.769 rad/T^2`.
- The anti-windup force/moment RMS (`0.01333/0.00694`) and local-flow RMS
  (`0.01809U`) overlap the exact baselines (`0.01331--0.01335 / 0.00693--0.00695`
  and `0.01804--0.01816U`). The improvement is therefore removal of infeasible
  action, not a claimed load or route advantage.
- The inherited parent notes proposed exact-boundary one-sided anti-windup
  because essentially every speed-limited sample still pointed outward. The
  newly sampled anti-windup rollout validates that mechanism but also shows
  that an exact-boundary switch leaves measurable outward action at the logged
  boundary. A further fluid-response allocator or scalar route-gain change is
  not supported.

## Visual diagnosis

The best-score exact baseline (`solver_0f8ee73693ab`), the anti-windup rollout
(`solver_82cc0204f2e3`), and the non-separating helpful-moment control
(`solver_0288c0d51d57`) have the same useful topology in both rows of their
combined sheets. From release to capture, each body follows a smooth
target-closing arc and sheds a regular alternating mid-plane vortex street.
The oblique Lambda2 frames show body-attached three-dimensional structures and
a coherent downstream chain, establishing self-propulsion rather than passive
advection. No wake collapse, loop, collision, or late route reversal precedes
capture. The anti-windup sheet shows no visible carrier-phase penalty, while
the helpful-moment sheet supplies no distinct route or wake benefit.

## Policy hypothesis

Start from the evaluated joint-rate anti-windup policy and replace its
exact-boundary switch with a one-sided normalized rate barrier. Outward
acceleration is continuously capped by the remaining squared-speed margin as
the observed joint rate approaches its owned hard limit; inward acceleration
is unchanged, so braking and the established traveling-wave phase remain
available. Preserve the raw-demand persistence witness for posterior phase
recruitment, because the projected action must not silently turn off that
established route actuator.

This is a constraint-feedback refinement, not a route or carrier gain change.
Expected result: residual outward-at-limit occupancy should approach zero and
posterior clipping/action RMS should not rebound, while the coherent wake and
capture route remain intact. Falsify it if capture leaves the sampled
`18.6560--19.0520T` band, mean distance exceeds `2.02129L`, force/moment RMS
exceeds `0.01350/0.00703`, braking is attenuated, the wake phase visibly
changes, or the residual outward-at-limit action does not fall below the
evaluated anti-windup's `0.618%/0.941%`.

## Bookshelf protocol

The current inherited guidance contains a newly evaluated controller mechanism
and a semantic actuator-feasibility improvement, so the later-iteration
three-stagnant-iteration trigger is not met. No bookshelf source informs this
edit; the candidate follows directly from sampled rollout evidence.
