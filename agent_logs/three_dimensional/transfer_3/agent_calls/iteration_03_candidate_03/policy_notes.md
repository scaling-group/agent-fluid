# Candidate diagnosis and policy hypothesis

## Evidence diagnosis

- All four sampled rollouts use direct uniform initialization with
  `U_infinity=(0,0,0)`, no cylinders, and no prewarm. Translation and wake
  formation are therefore self-generated rather than imposed advection.
- The strongest finite sample, `solver_19f251537923`, shows a long coherent
  alternating street in both the top-down vorticity row and the oblique
  Lambda2 row. Its `28 deg`, `0.55T` carrier drives range from `12.328L` to
  `6.138L`, but the fish then continues a wrong-side arc and exits the lower
  boundary at `26.147T`. Its two raw joint commands exceed the acceleration
  envelope in `3346/4754` and `3655/4754` samples, so its useful propulsion is
  not evidence that its inherited steering stack is controllable in 3D.
- The assigned parent, `solver_a8731015fd6e`, preserves a visibly coherent
  wake with the same carrier and uses the calibrated positive-bias-to-negative-
  yaw sign. Nevertheless, a static posterior bias capped at only `4 deg`
  crosses the initial `+0.155 rad` line-of-sight error, overshoots to about
  `-1.46 rad`, reaches only `11.878L`, and exits the upper boundary at
  `9.108T`. Raw accelerations still exceed the envelope in `583/1656` and
  `659/1656` samples. Correct polarity and small static authority therefore do
  not supply turn release or braking.
- `solver_97bc3c03d55b` makes better monotonic distance progress to `9.175L`
  with a `12 deg` yaw-rate-driven posterior mean curvature, but it also exits
  upward with line-of-sight error near `-1.5 rad`; its raw actions exceed the
  envelope in `830/2024` and `628/2024` samples. The observation adapter's
  `turn_rate_recent` window is only seven integration samples (about
  `0.0385T`, far shorter than a `0.55T` beat), and the sampled value oscillates
  on the order of `+/-2 rad/T`. Treating it as a beat-averaged yaw response is
  unsupported.
- The envelope-safe `solver_1b4176f9edeb` stays below the raw acceleration
  limit, but its `12 deg`, `0.70T` half-cycle carrier produces visibly weaker
  structures, advances only to `12.165L`, and exits upward at `8.591T`.
  Reducing the carrier and adding phase-gated steering together confounds lost
  thrust with the route failure; the present candidate therefore preserves the
  better-evidenced fast carrier and changes only steering response semantics.
- Local-flow magnitudes are small at the informative closest approaches
  (about `0.02--0.03U`), and no sample reaches the `0.75L` capture region.
  Wake rejection and terminal distance scheduling are not supported by this
  still-water evidence.

## Policy hypothesis

Replace the parent's persistent static posterior curvature with one bounded
response-lead primitive. The normalized body-frame line-of-sight angle remains
the proportional route error. A capped `bearing_window_rate` contribution
advances release when alignment is already improving and permits bounded
countersteer before the angle crosses zero; it can change the effective error
by only a small fraction of a radian and cannot act as an uncapped yaw-rate
loop. The signed effective error then sets the same `4 deg` posterior mean-
curvature envelope on the preserved joint-state traveling-bend carrier.

Expected result: retain the parent's alternating wake and forward authority,
but reduce the initial turn earlier, cross the target line with less yaw
momentum, and avoid monotonically growing opposite-side bearing. Falsify the
mechanism if initial positive bearing does not initially command positive
posterior curvature and negative yaw, if the effective error chatters between
full curvature limits, if the coherent wake collapses, or if the rollout again
exits a boundary with `|bearing|` near one radian without improving on the
parent's `11.878L` closest approach. The new candidate's CFD outcome is not
available to this worker and is not claimed here.

bookshelf_consulted: true
source_domain: biological burst redirect and robotic-fish closed-loop direction tracking
source_mechanism: bounded target-driven curvature is released as observed alignment response appears, then the traveling wave remains the cruise carrier
transferable_invariant: persistent body-frame direction error may request a bend, but improving alignment must continuously withdraw or reverse that bend before turn momentum creates an opposite-side route error
nontransferable_details: C-start timing, clock-driven CPG phase, published gains, dimensional beat rates, species kinematics, exact vortex phase, and task-specific routes
policy_translation: combine normalized `target_body_L` line of sight with a capped short-window bearing trend; map only their bounded effective error to the posterior equilibrium of the two-joint state-feedback carrier
falsification: reject if the initial yaw sign is wrong, curvature chatters at its limits, wake coherence or propulsion collapses, or opposite-side bearing still grows to a boundary exit without a better closest approach
