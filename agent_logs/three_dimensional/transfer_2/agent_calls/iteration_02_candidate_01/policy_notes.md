# Wake-policy candidate notes

## Evidence diagnosis before editing

- All four sampled L64 episodes are valid direct-uniform still-water rollouts:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, finite dynamics, and moving
  storage windows.  The evidence therefore measures active self-propulsion and
  steering rather than ambient advection.
- Both rows of the combined keyframe sheets were inspected for the best-score
  sample, the closest-pass sample, and the assigned-parent failure.  The
  `solver_b6bb94d9cdaf` top-down row develops a coherent alternating wake and
  the oblique Lambda2 row shows persistent three-dimensional vortex structures
  through `21.79T`; its `0.632L/T` mean speed and `5.357L` closest distance
  confirm useful propulsion.  The similarly coherent `solver_e450df1efa49`
  wake reaches `4.128L` but passes the target and exits left at `32.02T`, so
  closest distance alone is not controlled approach.
- The best-score policy crosses body-frame target alignment by `4T`: bearing
  changes from `+0.155` to `-0.091 rad` while instantaneous yaw is about
  `-2.38 rad/T`.  It then keeps the target on the negative-bearing side
  (`-1.525 rad` at `20T`), reaches `3.026 rad/T` peak absolute yaw, and exits
  through the upper boundary with distance `5.894L`.  Its smooth acceleration
  bound avoids acceleration-envelope clipping, but joint-speed residence is
  still about `7.9%/14.6%`.  Thus the remaining defect is excessive steering
  response, not weak drive or insufficient scalar curvature gain.
- The assigned-parent response-gated controller is an important negative
  result.  Shifting the anterior oscillator equilibrium by as much as `35%`
  of a `14 deg` curvature command produces only `0.130L/T` mean speed, almost
  no useful progress (`12.328L -> 12.304L -> 13.469L`), a visibly weak wake
  followed by a tight upward curl, and an upper exit at `9.87T`.  Strong
  response gating must not be coupled to an anterior equilibrium shift in this
  failure class.
- The inherited optimizer notes correctly preserve posterior-lag propulsion
  and identify measured-response release as the missing capability, but the
  sampled descendants now falsify both a shared low curvature limit (braking
  remains too weak) and a large distributed mean-bend implementation (drive
  collapses).  No sample reaches the capture neighborhood, so terminal
  scheduling and wake-disturbance residuals remain unsupported additions.

## Policy hypothesis

Preserve the best sample's unshifted anterior joint-state oscillator, posterior
lag, and smooth controller-owned acceleration bound.  Replace its single
saturated mixture of bearing and yaw feedback with one response-gated redirect
mechanism having two physically distinct, independently bounded pieces: a
small body-frame bearing-to-tail-curvature route request and a stronger
same-sign measured-yaw tail curvature that releases or reverses an overspeeding
turn.  Apply both only through the posterior target; do not move the anterior
oscillator equilibrium.  A smooth total-curvature limit keeps their sum
bounded and reflection symmetric.

The candidate is falsified if it loses the coherent traveling wake or mean
translation, still crosses alignment with multi-radian yaw and exits high, or
merely moves saturation from acceleration into persistent joint speed/angle
limits.  A lower peak yaw, smaller bearing at closest pass, better termination
class, or meaningfully more target-directed trajectory would support the
mechanism even before capture.

bookshelf_consulted: true
source_domain: biological burst turning and closed-loop robotic-fish direction tracking
source_mechanism: response-gated curvature redirect with release into the propulsive rhythm
transferable_invariant: preserve the posterior-lag traveling bend while measured turning response cancels or reverses target-driven curvature before alignment overshoot
nontransferable_details: published controller gains, dimensional cadence, species-specific C-start shapes, clocked CPG phases, exact vortex phases, and task-specific routes
policy_translation: map normalized body-frame bearing to a small bounded posterior mean bend and normalized recent yaw rate to a separately bounded opposing-or-releasing posterior bend; retain the unshifted joint-state oscillator and smoothly bound total curvature and acceleration
falsification: reject if coherent propulsion or progress collapses, multi-radian centerline overshoot and the upper exit persist, or joint-limit residence materially increases
