# Proprioceptive rate-governor candidate

## Visual and diagnostic evidence before the policy edit

- All four sampled rollouts satisfy the frozen contract: direct uniform
  `U_infinity=(0,0,0)` initialization, no cylinders or prewarm, finite
  moving-window transport, stable dynamics, and `capture` termination. They
  arrive in `19.1620--19.3545T`, with distance integrals
  `2.06924--2.07892L`. This is an actuator-allocation refinement within a
  successful trajectory class, not a propulsion or steering-sign repair.
- Both rows of the combined keyframe sheets for the strongest finite sample,
  the response-aware handoff `solver_bf9554cfba28`, and the informative
  underperforming redirect-reserve sample `solver_d6f4924b438d` were inspected
  from release through capture. Their top-down rows show self-propulsion from
  quiescent water, a coherent alternating posterior vortex street, and the
  same continuous late target-side hook. Their oblique rows show compact 3D
  Lambda2 structures following the caudal region without passive advection,
  wake collapse, collision, or instability. The reserve sample therefore did
  not expose a new wake or success class; it perturbed effort and path within
  the existing useful topology.
- The response-aware controller has two byte-identical captures at
  `19.162/19.338T`, integrals `2.06924/2.07622L`, and paths
  `12.309/12.304L`, establishing repeat variation while confirming its short-
  path scaffold. Both retain the approximately `0.0254/0.0136` peak planar
  force/yaw-moment class and zero angle-limit residence. Their joints do,
  however, sit above 99% of the `260 deg/T` rate envelope for about
  `8.36/4.37%` of anterior/posterior samples.
- The assigned-parent redirect-reserve mechanism is a concrete negative
  result. It still captures, but its `19.3325T/2.07854L` arrival/integral and
  `12.370L` path are worse than both response-aware repeats. It changes
  greater-than-90%-command residence only from `35.69/33.79%` in the matched
  repeat to `35.51/33.74%`, and greater-than-99%-rate residence only from
  `8.36/4.38%` to `8.25/4.35%`. The mismatch is architectural: all sampled
  greater-than-99%-rate events occur outside `4L`, mostly outside `6L`, while
  the reserve is gated by the near-target redirect. Restore the exact
  response-aware scaffold instead of tuning its reserve fraction.
- Across the two response-aware repeats, acceleration has the same sign as
  joint velocity at about `82--83%` of anterior and `78%` of posterior samples
  already above 99% of the rate bound. This identifies outward carrier drive
  at the active hard-rate envelope as a direct, normalized proprioceptive
  signal. It is more specific than global command magnitude and does not
  require another route, slip, or terminal steering gate.

## One-candidate hypothesis

Start from the exact response-aware far-amplitude/near-lag capture scaffold.
Split each raw acceleration into its existing traveling-wave carrier and
steering/approach components. Add one smooth proprioceptive governor: as the
maximum normalized joint speed enters the final part of the known rate
envelope, detect whether a carrier component is still accelerating its joint
outward and continuously attenuate both carrier components by a common factor.
Preserve steering, mean curvature, approach damping, posterior-allocation
endpoints, and the final soft limiter. A common factor retains the two-joint
wave relationship; inward carrier acceleration is unmodified; below the soft
rate threshold the candidate is algebraically identical to the evaluated
response-aware parent.

Expected signature: retain the response-aware early milestones, capture,
`12.30--12.31L` path class, coherent two-view wake, and sampled load class,
while materially reducing rate-limit residence and outward command applied at
the rate bound without increasing near-bound command residence. Falsify if
the governor reduces useful early propulsion, delays arrival or worsens the
integral beyond response-aware repeat variation, lengthens the hook, loses
capture, changes the wake/load class, or fails to reduce rate-bound residence.
If falsified, restore the exact response-aware handoff; do not tune the failed
redirect reserve or lower a global amplitude/frequency scalar.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and bounded biological traveling-wave propulsion
source_mechanism: use proprioceptive state feedback to keep an established rhythmic gait inside the actuator envelope while preserving its directional wave
transferable_invariant: continuously remove only outward propulsive drive that cannot add useful joint speed near a normalized hard-rate boundary, and release the governor immediately when motion turns inward
nontransferable_details: published gains, dimensional cadence, species-specific amplitudes and envelopes, robot motor models, clock phase, exact vortex phase, world coordinates, and task-specific routes
policy_translation: under the two-joint acceleration contract, derive a smooth gate from normalized joint velocity and carrier-acceleration alignment, then apply one common carrier scale while leaving body-frame target steering and approach feedback unchanged
falsification: reject unless rate-bound residence and wasted outward command fall while early progress, capture, short path, joint margin, load class, and coherent top-down and oblique wakes remain within the response-aware evidence bounds
