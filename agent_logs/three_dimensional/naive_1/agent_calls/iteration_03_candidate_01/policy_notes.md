# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- All four sampled rollouts are valid direct-uniform quiescent starts
  (`U_infinity=[0,0,0]`) without prewarm or cylinders. The top-down and
  oblique rows show that their alternating vorticity streets and localized
  three-dimensional Lambda2 structures grow behind actively bending fish;
  the motion is self-propelled rather than background advection.
- The assigned parent's inherited response-gated posterior-curvature policy
  (`solver_4d290a0c05f4`) falsifies its stated early-release hypothesis. It
  retains a coherent wake but curls upward, exits the same boundary at
  `9.311T`, and reaches only `11.789L`, worse than the simpler posterior-only
  sample's monotone `11.096L` endpoint. Bearing trend and recent yaw response
  therefore did not produce a useful mean redirect.
- The strongest finite sample is the differential-curvature turn-rate servo
  (`solver_d282288428b4`, score `-10.625`). Its coherent wake carries the head
  mostly leftward from about `(20.58,13.74)L` to a `4.977L` closest approach
  at `(9.43,14.46)L` and `21.934T`. It then passes the target in `x` while
  remaining roughly `5L` too high and exits the upper boundary at `33.209T`.
  This is a meaningfully useful trajectory, but not target convergence.
- That servo feeds a seven-sample recent turn rate directly into the steering
  sign. During `18--28T` of the long miss, reconstructed body-frame bearing
  stays negative (`-1.52` to `-0.66 rad`) while recent turn rate oscillates
  from about `-2.50` to `+2.49 rad/T`. The desired turn-rate
  cap is only `0.50 rad/T`, so the inner loop reverses the differential bend
  across tail beats even though the route error has not reversed. Its joint
  rates touch their limits on about `16.7%/19.1%` of samples and raw
  accelerations exceed the envelope on about `70.5%/77.6%`; faster response
  gating is not supported by this evidence.
- The informative broad-turn failure (`solver_f0a5c173df3d`) reaches `8.174L`
  before a lower-boundary exit and visibly preserves a strong wake. Together
  with the differential sample, it shows that anterior authority can change
  trajectory topology, but same-sign joint bias or underdamped response should
  not be restored.

## Policy hypothesis

Preserve the seed oscillator and posterior phase lag, and preserve the sampled
opposite-sign anterior/posterior allocation. Replace the beat-scale turn-rate
servo with one bounded line-of-sight differential-curvature request driven only
by normalized body-frame bearing. A persistent bearing sign will then retain a
persistent steering sign instead of being cancelled by oscillatory yaw, while
zero bearing continuously releases the mean bend. This changes the feedback
semantics rather than scalar carrier gains and leaves propulsion intact at zero
route error.

Falsify this candidate if it repeats the best sample's nearly horizontal
`y~14.5L` miss, replaces it with an unbounded upper/lower arc, collapses the
alternating wake, fails to beat `4.977L`, or increases joint-limit contact. A
later evaluation should check target-bearing contraction and semantic
termination before interpreting raw score.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG direction tracking and fish mean-curvature turning
source_mechanism: target-error modulation of differential mean bend around an intact propulsive rhythm
transferable_invariant: a persistent body-frame direction error should retain a bounded steering sign while the phase-lagged carrier remains intact
nontransferable_details: published gains, clocked CPG phase, robot or species kinematics, dimensional beat settings, exact vortex phases, and prescribed routes
policy_translation: map bounded normalized bearing directly to opposite-sign anterior and posterior equilibrium shifts inside the two-joint state-feedback oscillator, without treating beat-scale yaw as mean route response
falsification: reject if bearing does not contract, the horizontal upper miss persists, a broad boundary arc replaces it, wake coherence collapses, or actuator saturation worsens
