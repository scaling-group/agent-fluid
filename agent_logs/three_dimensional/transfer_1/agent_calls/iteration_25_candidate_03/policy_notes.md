# Candidate diagnosis and hypothesis

## Evidence read before editing

- All four sampled rollouts report `initialization_mode=uniform_direct`,
  `flow_velocity_L_per_T=[0,0,0]`, no cylinders, finite dynamics, and capture.
  Thus their motion is self-propulsion rather than background advection, and
  no prewarm artifact is present.
- I inspected both rows of all four combined keyframe sheets. The two exact
  speed-reserve runs and the two posterior-pulse runs all develop a coherent
  alternating red/blue top-down wake by `4T`, retain a traveling wake through
  the middle approach, and show compact alternating three-dimensional
  Lambda2 structures behind the body through capture. None shows terminal
  carrier collapse, a visibly reciprocal standing wiggle, or wake breakup.
- The phase-independent speed-reserve policy captures in both sampled repeats
  at `0.7480--0.7494L`, in `18.205--18.601T`, with scores
  `-0.15856-- -0.15140`. The phase-synchronous posterior-pulse policy also
  captures in both sampled repeats at `0.7480--0.7492L`, in
  `18.200--18.469T`, with scores `-0.15855-- -0.15678`. Their action clipping
  (`68.2--68.6%` joint 1 and `70.6--71.0%` joint 2), exact speed-limit
  residence (`10.4--10.6%` and `11.3--11.5%`), peak force coefficient
  (`0.030--0.032`), and peak yaw-moment coefficient (`0.0157--0.0167`)
  overlap. The pulse therefore has no sampled secondary benefit.
- The assigned parent guidance records that the posterior pulse already failed
  an exact replay after two threshold captures, passing at `1.2589L` with the
  wake still active. The assigned parent's available new inherited score is a
  separate `left_domain` outcome with minimum distance `1.4503L`, but it has
  no policy bytes, trajectory, or visual artifact in this workspace; it is
  useful evidence that the parent iteration did not add a robust success, not
  evidence for a specific controller cause. The current sample contains no
  visual failure, so I do not invent a failure-sheet diagnosis.

## Policy hypothesis

Restore the exact phase-independent, intercept-guarded speed-reserve
architecture by deleting the posterior joint-phase pulse. This is a mechanism
reversion rather than scalar tuning: preserve the coherent traveling bend,
the normalized target/velocity interception geometry, the bounded additive
mean-curvature steering, and the sparse outward-carrier reserve, while removing
the only phase-synchronous terminal path perturbation. The candidate should
retain far-field closure and the two organized wake views while recovering the
repeat-backed controller family. It is falsified if exact replays miss, if the
traveling wake weakens, or if capture, arrival, load, or actuator statistics
move outside the sampled speed-reserve envelope.

```text
bookshelf_consulted: true
source_domain: classical undulatory propulsion and robotic-fish turning
source_mechanism: traveling posterior-lagged bend plus bounded mean-curvature bias
transferable_invariant: preserve a directional traveling bend for thrust and realize route steering as phase-independent target-conditioned curvature
nontransferable_details: published gains, dimensional beat rates, species envelopes, exact vortex phases, and source-specific routes
policy_translation: retain the normalized body-frame achieved-course/intercept servo and its bounded common steering residual; remove the extra anterior-phase-conditioned posterior acceleration
falsification: reject if repeated direct-uniform rollouts lose capture, weaken either wake view, or worsen arrival, force/moment, clipping, or speed-limit residence beyond the sampled baseline envelope
```
