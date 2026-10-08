# Intercept-recovery traveling-wave candidate

## Visual and trace diagnosis before the edit

- All four sampled evaluations are contract-valid direct-uniform still-water
  rollouts (`U_infinity=(0,0,0)`, no cylinders, no prewarm). In both the
  top-down vorticity and oblique Lambda2 rows, the fish translates through the
  quiescent fluid and leaves body-generated three-dimensional wake structures;
  neither the progress nor the failures are moving-window advection artifacts.
- The assigned parent, `solver_b6ed3f84ab58`, is the best scalar sample but a
  negative mechanism control. Its posterior half-cycle redistribution keeps an
  alternating wake while the trajectory remains in the upper corridor and
  exits at `(8.770,15.201)L` after `26.043T`, with only a `5.386L` minimum.
  It touches the `45 deg` joint boundary for about `2.85%` of samples and its
  peak planar force and yaw moment are `0.212` and `0.0968`, roughly ten times
  the useful near-miss class. More posterior asymmetry or acceleration
  headroom is therefore unsupported.
- `solver_4f3d51f38935` is the strongest sampled trajectory despite its poor
  terminal score. Its top-down row curves down through the target neighborhood
  and its oblique row preserves compact alternating Lambda2 structures through
  the redirect and recovery. It reaches `0.8328L` at `27.473T` without angle
  contact and with peak planar force/moment only `0.0214/0.00979`, then passes
  the target and exits the left margin. At `5, 3, 1.75, and 1.0L`, its
  projected miss is about `4.09, 2.11, 1.10, and 0.92L`; the head crosses the
  target's x station still `1.55L` high. At closest approach the redirect has
  nearly settled at `-24.1/-25.0 deg`, its commands are only
  `0.165/0.011 rad/T^2`, yet speed remains `0.661L/T`. This is a loss of active
  turning during interception, not wake collapse or a load spike.
- The other samples bound the remedy. Globally holding a static redirect until
  an intercept is acquired (`solver_b3b6be8f076f`) latches the joints near
  `-17.7/-16.7 deg`, stays high, and reaches only `4.278L`; yaw-rate tracking
  (`solver_12fc3441a636`) reaches only `6.268L` with greater limit residence.
  Inherited terminal variants that deepen the same static bend or increase its
  urgency repeatedly skim at `0.8298`, `0.8278`, and `0.8328L`, while the
  inherited posterior-recovery pulse reaches `0.8957L`. Those outcomes reject
  another threshold, bend-depth, redirect-frequency, or posterior-pulse
  adjustment as the primary experiment.

## Policy hypothesis

Recover the sampled sign-corrected traveling carrier and the bounded same-sign
two-joint C-start that produced the target-scale trajectory. Preserve static
redirect entry and response release. When that release would otherwise return
to cruise, but a middle/near-range body-frame projected miss is still unsafe,
blend into a third continuous mode: a low-amplitude traveling wave centered on
bounded same-sign curvature. Joint state supplies phase; the posterior target
lags the anterior deviation about that curved equilibrium. This should keep
generating controlled yaw and thrust while avoiding both the globally static
intercept latch and the unbiased release that crosses the target station high.
The mode fades when the projected intercept becomes capture-safe or target
error is small, and it uses no time, route, world coordinate, or hidden state.

Expected evidence is preservation of the coherent downward trajectory with a
first crossing inside `0.75L`. A useful partial result must beat `0.8278L` and
move the target-x crossing down from its roughly `1.55L` vertical error without
angle contact or load growth beyond the sampled C-start class. Falsify the
mechanism if it repeats the `0.828--0.833L` skim, restores the upper/static
latch, reverses the calibrated turn, destroys the alternating wake, or raises
limit residence or force/moment toward the assigned parent's posterior-only
failure.

bookshelf_consulted: true
source_domain: biological C-start recovery, elongated-body reactive propulsion, and sensor-modulated robotic-fish direction tracking
source_mechanism: release a transient high-curvature redirect into an actively curved traveling wave when sensed translation still predicts a miss
transferable_invariant: maneuver release should preserve directional wave propagation and active fluid impulse until measured interception is safe, rather than settling into static curvature or immediately restoring an unbiased carrier
nontransferable_details: species-specific C-start stages, published gains, full-body curvature envelopes, dimensional cadence, exact vortex phase, and task-specific routes
policy_translation: body-frame bearing and projected miss gate a joint-state-phased low-amplitude anterior oscillator about bounded curvature, with the posterior joint lagging the anterior deviation around its own bounded curvature center
falsification: reject if capture and the target-station crossing do not improve, the coherent wake or calibrated turn side is lost, static-latch behavior returns, or actuator and hydrodynamic exposure materially exceed the sampled near-miss class

## Non-CFD implementation audit

On the frozen `solver_4f3d51f38935` trace, comparison with the same candidate
with its recovery-miss gate disabled changes `1170/3059` states in the
diagnosed `1--6L` band and is exactly unchanged at and beyond `6L`. The largest
frozen-state action difference is `21.65 rad/T^2`, where recovery replaces a
large cruise command rather than adding to it; acceleration-clamp incidence
falls from `2958` to `2935` of `7234` frozen states. Direct zero-speed and
mirrored-state tests are finite, bounded, and reflection-equivariant with zero
numerical reflection error. This verifies isolation, activation, and policy
symmetry only; it does not predict the unevaluated fluid or trajectory response.
