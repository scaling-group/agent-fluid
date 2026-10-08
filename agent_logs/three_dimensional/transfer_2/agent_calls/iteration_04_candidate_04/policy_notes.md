# Wake-policy diagnosis and candidate hypothesis

## Inherited evidence

- All four sampled evaluations are valid direct-uniform still-water rollouts:
  `U_infinity=(0,0,0)`, no prewarm, no cylinders, and moving-window transport
  only.  The combined sheets show self-propulsion rather than advection.
- The transferred seed (`solver_e1a03f18d808`) sheds a coherent alternating
  top-down and 3D Lambda2 wake, reaches `4.780L` at `17.85T`, then continues
  below the target and exits the lower boundary at `27.49T`.  Its raw action
  exceeds the `1800 deg/T^2` envelope on `97.9%` of samples and its yaw-rate
  sign reverses 82 times above the `0.1 rad/T` threshold.
- The response-release prefill (`solver_dc5e319e8345`) preserves essentially
  the same wake and trajectory topology (`4.660L`, lower exit at `28.37T`,
  `98.0%` raw acceleration exceedance, 84 yaw reversals).  The seven-sample
  yaw estimate spans only about `0.0385T`, so its route-release signal is
  contaminated by the tail beat.
- The strongest sampled policy (`solver_045019f39c2a`) releases cycle-mean
  tail curvature when normalized body-frame route error contradicts that
  bend.  It retains the coherent carrier, improves the minimum to `4.141L`,
  and survives to `32.20T`; this is useful evidence for retaining that
  release.  It still exits below after crossing the closest-approach point,
  with `98.1%` raw acceleration exceedance and 95 thresholded yaw reversals.
  Reconstructing its normalized course signal shows that once its off-axis
  gate activates, target-vector angle minus swimming-course angle has a
  stable positive sign on `99.88%` of samples (mean `1.181 rad`).  Thus a
  slow translational course mismatch is available even though recent yaw is
  beat-dominated.
- The soft-limited slow-gait failure (`solver_a1d9e06dfe8a`) has no raw
  acceleration exceedance but weakens/changes the carrier and exits above at
  `14.91T`, reaching only `8.752L`.  Together with inherited static and
  course-released mean-curvature failures (`12.206L` and `12.083L` minima),
  this rules out another wholesale slowdown or always-on mean bend; it does
  not test actuator allocation around the successful `0.55T`, 28-degree
  carrier.

## Visual diagnosis

The three fast policies produce compact, alternating reverse-street-like
vorticity and paired 3D structures rather than a reciprocal wiggle.  Their
wakes remain organized through failure, so propulsion collapse or numerical
instability is not the primary defect.  In the strongest sheet the fish
turns progressively downward while the target track moves farther to its
lateral side; after about `20.7T`, distance increases monotonically until the
lower exit.  The soft-limited sheet instead shows a weaker short wake and an
upper-boundary trajectory.  These views agree with the distance, center,
velocity, joint, action, and termination histories.

## Policy hypothesis

Start from the evidence-backed curvature-release policy, not the unevaluated
assumption that a new carrier is needed.  Add one compact mechanism: a
course-qualified half-cycle actuator allocator.  Derive swimming-course error
from normalized body-frame target vector and velocity, keep it dormant inside
the existing material off-axis gate, and use it to reserve a small bounded
acceleration asymmetry after carrier clipping.  On the carrier half-cycle
opposed to the requested course correction, the reserved command reduces the
stroke amplitude; on the useful half-cycle it saturates at the existing
envelope.  At full activation this replaces the beat-contaminated recent-yaw
steer, but it does not add a cycle-mean tail target.  The early aligned path is
therefore unchanged, the demonstrated traveling carrier remains, and steering
is no longer numerically erased by the hard action limit.

Falsify the hypothesis if the rollout loses the coherent early wake/deep
approach, exits above (wrong phase/polarity), retains the same lower-exit
topology without a materially better minimum or survival, or develops angle,
velocity, or load saturation despite bounded returned accelerations.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning and classical reactive swimming
source_mechanism: half-cycle amplitude or duty-ratio asymmetry applied to a posterior-emphasized traveling bend
transferable_invariant: preserve the propulsive traveling wave and obtain yaw by making only the course-corrective half-cycle stronger than its opposite
nontransferable_details: published gains, dimensional beat frequencies, species envelopes, prescribed CPG phase, and task-specific routes
policy_translation: use normalized body-frame target/velocity course error and observed joint-state carrier phase to allocate bounded two-joint acceleration inside the existing envelope, with no clock or mean-bend route
falsification: reject if early propulsion degrades, the exit switches above, or lower-exit course error and closest approach do not materially improve
