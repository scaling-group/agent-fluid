# Wake-policy diagnosis and hypothesis

## Evidence read before editing

- All four sampled rollouts report direct uniform still-water initialization,
  `U_infinity=[0,0,0]`, no cylinders, finite dynamics, and capture at
  `24.6730T` with minimum/final distance `0.748684L`, mean distance
  `2.348256L`, and score `-0.448647`.
- The four trajectories and combined keyframe sheets are byte-identical even
  though two samples use the steering-residual coast policy and two add the
  binary course-sign veto. Thus the sign predicate does not distinguish an
  active residual state on this nominal route; it is a controlled no-op, not
  evidence of a more selective controller.
- In the top-down row, the wake grows from quiescent water into a regular,
  alternating reverse-street-like sequence while the world track advances
  toward the target. The late body turn remains smooth enough to cross the
  capture circle; there is no visually evident stalled or passively advected
  segment. In the oblique row, compact three-dimensional Lambda2 structures
  remain organized behind the self-propelled fish through the late turn rather
  than breaking into a diffuse or unstable wake.
- The visual low-load impression agrees with the sampled peak absolute planar
  force/yaw-moment coefficients (`0.0253/0.0309/0.0156`) and zero posterior
  hard-stop occupancy. The remaining concern is allocation: inherited
  diagnostics put posterior/total exact-rate occupancy at `4.637/13.932%`,
  slightly above the pure posterior-coast result (`4.586/13.869%`). No sampled
  failure keyframe exists in this workspace, so the informative comparison is
  the behaviorally identical binary-veto pair plus the inherited failed
  reference-velocity feedforward (`0.993L` miss and left exit).

## Candidate hypothesis

Replace the inert binary course-sign veto with a continuous course-magnitude
allocation. At posterior rate pressure, keep the established velocity-opposing
steering residual only in proportion to the absolute normalized body-frame
course error. This interpolates between pure coasting on a collision-aligned
course and the evaluated steering residual during a material lateral miss. It
does not synthesize acceleration, alter the anterior phase anchor, change the
far guidance law, or use a clock or world-frame route.

The hypothesis is that graded residual allocation will remove unnecessary
posterior follower braking near course alignment while retaining the part of
the residual that recovered arrival time relative to pure coast. Reject it if
the next rollout loses capture, changes the established far path, restores a
posterior hard stop, leaves the low-load class, or fails to reach at least the
pure-coast posterior/total exact-rate occupancy class (`4.586/13.869%`).

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG and residual path-following control
source_mechanism: sensor feedback modulates a follower correction while preserving the locomotor rhythm as the phase-bearing scaffold
transferable_invariant: preserve the demonstrated oscillatory phase anchor and vary only the follower residual continuously with measured route error
nontransferable_details: published CPG gains, robot morphology, dimensional beat settings, learned routes, and species-specific kinematics
policy_translation: multiply only already-requested, posterior velocity-opposing steering at rate pressure by absolute normalized body-frame course error; leave carrier generation and anterior actuation unchanged
falsification: reject on loss of capture or coherent far trajectory, posterior hard-stop recurrence, departure from the low-load class, or posterior and total exact-rate occupancy worse than the pure-coast reference
