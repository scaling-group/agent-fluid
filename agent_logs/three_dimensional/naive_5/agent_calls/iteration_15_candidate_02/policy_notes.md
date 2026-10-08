# Inertial line-of-sight response candidate

## Visual and trace diagnosis before the edit

- The sampled and inherited rollouts are contract-valid direct-uniform still
  water (`U_infinity=(0,0,0)`, no cylinders, no prewarm).  In both the
  top-down mid-plane vorticity row and the oblique body/Lambda2 row, the fish
  translates with a body-attached alternating wake.  The useful approaches
  are self-propelled rather than moving-window advection, and their late misses
  are not preceded by wake collapse or numerical instability.
- The strongest sampled finite example, `solver_fe5535fc7da1`, keeps an
  organized three-dimensional wake through a broad target approach and reaches
  `0.870635L`, but passes at high speed and exits left.  The inherited low-load
  response-released lineage is stronger still (`0.829828L` baseline and
  `0.827823L` best), yet at closest approach its projected miss remains about
  `0.806L`, course error is near saturation, and the joints are almost settled
  in a same-sign bend.  The gap is a translational-course response deficit,
  not missing propulsion.
- The assigned `solver_b6ed3f84ab58` parent is the informative failure.  Both
  visual rows keep it in the high corridor until upper-margin exit; it reaches
  only `5.386122L`, touches the joint-angle boundary, and produces peak planar
  force/yaw moment near `0.212/0.0968`, roughly ten times the low-load near-miss
  class.  More posterior redistribution is therefore unsafe and unsupported.
- Inherited completed logs close the obvious terminal patches: deeper bends,
  anterior same-side and counter-sweep reflexes, a posterior recovery, a
  coordinated recoil, forward and reverse waves, and damping all preserve
  `left_domain`, with minima between about `0.828L` and `1.111L`.  The latest
  upstream instantaneous intercept hold also regresses to `1.096087L` from the
  `0.827823L` reference while retaining the coherent pass-by.  It changed the
  route on beat-scale projected-miss samples, so later work should not retune
  that hold's scalar thresholds or trust instantaneous velocity as a binary
  release decision.

## Policy hypothesis

Recover the evaluated low-load response-released, terminal-miss-vetoed carrier
and remove the failed intercept hold.  Add one different closed-loop semantic:
form inertial line-of-sight rate by summing the history-window body-frame
bearing rate and body turn rate, then compare a bounded proportional-navigation
yaw request with the phase-rejected observed yaw response.  Apply the residual
only through the evidenced anterior half-cycle channel, with speed, closing,
and joint-angle headroom gates.  Unlike the failed intercept hold, this does
not switch steering off when a single beat sample predicts a safe miss; it
adds bounded dynamic steering only when target-line rotation says the measured
turn response is insufficient.  The established C-redirect, posterior
follower, terminal miss veto, and acceleration envelope remain unchanged.

The falsifiable expectation is a coherent low-load wake and the same useful
broad approach, with course correction beginning before the settled terminal
bend and reducing the inherited approximately `0.806L` projected miss enough
for a first crossing inside `0.75L`.  Reject the mechanism if it does not beat
`0.827823L`, repeats the `1.096087L` intercept-hold regression, merely changes
body yaw without rotating velocity, disturbs far propulsion, touches an angle
boundary, or materially increases limit residence, force, or moment.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish direction tracking and bounded CPG residual control
source_mechanism: compare a target-line angular-rate request with measured turn response and inject the remaining correction through phase-selective anterior actuation
transferable_invariant: preserve a productive traveling-wave carrier while bounded state feedback supplies only the steering response that observed target-line rotation still requires
nontransferable_details: published navigation gains, robot linkage geometry, species-specific kinematics, dimensional beat timing, exact vortex phases, world coordinates, and task-specific routes
policy_translation: normalized body-frame bearing-window rate plus observed turn rate reconstruct inertial line-of-sight rate; phase-rejected yaw, closing speed, carrier speed, joint phase, and angle headroom gate one bounded joint-1 half-cycle residual
falsification: reject if capture fails or minimum distance does not beat `0.827823L`, target-line rotation and projected miss do not shrink, the far coherent carrier changes, or joint-limit, load, and actuator-limit exposure materially worsen

## Non-CFD implementation audit

- The required guidance-semantic check, lightweight Julia policy contract, and
  solver editable-boundary check pass.  No CFD was run.
- Every direct `params.FIELD` reference is owned by `target_policy_params`.
  A representative closing state with nonzero inertial target-line rotation
  activates only the new joint-1 residual, changing its unclipped command by
  about `-1.712 rad/T^2` when compared with the same controller with that
  residual disabled.  Reflecting lateral target/velocity, bearing, yaw,
  target-line rates, joint angles, and joint velocities negates both commands
  exactly, and a zero-speed state remains finite and inside the acceleration
  envelope.  These checks establish schema coverage, material activation,
  reflection equivariance, and boundedness only; they do not predict the
  unevaluated CFD result.
