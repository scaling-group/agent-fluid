# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- All four sampled rollouts are contract-valid direct-uniform still water
  (`U_infinity=[0,0,0]`) with no cylinders or prewarm. In the strongest finite
  seed and the inherited parent, the top-down row shows self-propelled motion
  with an alternating caudal vorticity trail, while the oblique row confirms
  compact three-dimensional Lambda2 structures. The motion is not passive
  advection, but neither coherent wake is target-useful.
- The target-blind seed remains the strongest sample: score `-14.825`, minimum
  distance `12.078L`, and final distance `12.380L` before an upper-boundary
  exit at `8.547T`. The three target-driven mean-curvature variants all retain
  that exit topology and worsen closest/final distance: `12.226/13.084L`,
  `12.296/13.405L`, and `12.235/13.829L`.
- The inherited shared-curvature parent makes the failure visually tighter
  and quantitatively stronger. Its heading moves from `0.506` to `-2.132 rad`;
  after the body-frame bearing becomes persistently negative, it still exits
  with heading rate `-1.895 rad/T`. Its private `24 rad/T^2` command clamp is
  active on `38.7%` of samples and a joint reaches the speed cap on `4.5%`, so
  the proposed turn-response damping neither reverses the turn nor leaves
  clean steering authority.
- The slower zero-centered carrier in `solver_3a74301ccb21` eliminates physical
  acceleration and speed saturation while retaining a visible posterior wake.
  Its failure therefore separates the useful reusable scaffold from the
  disproved steering choice: preserve the feasible traveling bend, but do not
  test another DC joint-center or posterior-offset variant.

## Policy hypothesis

Test one new steering mechanism: a smooth zero-mean second harmonic, derived
from the observed anterior joint phase, modulates both joints' half cycles.
Body-frame bearing requests the turn and measured yaw rate releases or reverses
the request. Unlike a mean-curvature offset, this phase-structured residual
does not ask either joint to carry a persistent bend, and it can change sign on
the next half cycle after target overshoot. The carrier remains a bounded
joint-state oscillator with a posterior-emphasized phase lag; there is no
clock, route, target coordinate, wake phase, or mutable state.

A non-CFD joint-only horizon audit of the finalized envelope over constant
neutral and saturated turn requests reached at most `38.5 deg`, `210.1
deg/T`, and `1600.5 deg/T^2`, with no private or physical clamp activation.
This is only a contract check, not evidence of hydrodynamic improvement; the
next rollout must still test propulsion, steering sign, and wake quality.

Falsification: reject the mechanism if bearing becomes persistently negative
without positive-yaw braking, if the fish again exits through the upper
boundary near `9T`, if minimum distance does not beat `12.078L`, if the
alternating three-dimensional wake collapses, or if either the private action
bound or physical joint limits are active recurrently.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning and zero-mean half-cycle asymmetry
source_mechanism: sensor feedback changes the relative strength of opposite propulsive half cycles without imposing static curvature
transferable_invariant: a slow body-frame direction error can modulate a zero-mean phase-structured steering component while measured turn response releases or reverses that modulation
nontransferable_details: published gains, clock-driven phase, species kinematics, prescribed waveforms, exact vortex phase, and task-specific routes
policy_translation: reconstruct phase from normalized anterior joint angle and velocity, apply bounded bearing-plus-yaw feedback to a common second-harmonic acceleration residual, and retain the feasible posterior-lagged state-feedback carrier
falsification: no prompt yaw reversal after bearing changes sign, repeated upper-domain exit, degraded closest approach or wake coherence, or recurrent command and joint saturation
