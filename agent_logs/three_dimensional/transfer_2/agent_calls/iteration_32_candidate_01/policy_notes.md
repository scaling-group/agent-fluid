# Approach-restored carrier-coupling candidate

## Evidence and visual diagnosis before editing

- All four sampled episodes satisfy the frozen-release contract: direct
  uniform `U_infinity=(0,0,0)` initialization, no cylinders or prewarm,
  finite moving-window transport, stable dynamics, and `capture`. There is no
  semantic failure in this cohort, so the useful comparison is the strongest
  finite capture against the most informative mechanism regression.
- I inspected both the top-down vorticity row and the oblique body/Lambda2 row
  from release through capture in the combined sheets for the highest-scoring
  sample `solver_1d05d22ea1fe`, the assigned-parent/prefill sample
  `solver_3fdd63b3fbda`, and the slower response-residual sample
  `solver_f997a0c1ad0f`. Each fish starts in blank quiescent water, develops a
  compact alternating caudal wake, and follows a continuous shallow arc to
  the target. The oblique views retain coherent three-dimensional structures
  behind the caudal region. Motion is self-propelled rather than advected;
  there is no collision, wake collapse, domain exit, or numerical instability.
- The inherited logs identify a regime boundary: response-conditioned release
  of negative-work carrier reversal helps far-field progress, but retaining it
  through the approach loses the plain redirect-priority carrier's late
  milestones. The sampled approach-restored controller resolves that boundary
  with the existing normalized 6--4L handoff and is the best current result:
  it captures at `15.939T` with distance integral `1.82008L` and score
  `0.06189`, versus `16.044T/1.82409L/0.05824` for the assigned parent and
  `16.088T/1.82203L/0.06072` for response release at all distances.
- The improvement is trajectory- and load-consistent, not a terminal-radius
  artifact. Relative to the assigned parent, approach restoration shortens
  head path from `13.178L` to `13.107L`, lowers peak planar-force/yaw-moment
  coefficients from `0.03579/0.01770` to `0.03477/0.01715`, and advances the
  `4/2/1L` milestones from `11.726/14.201/15.604T` to
  `11.688/14.185/15.549T`. Relative to the all-distance response release, it
  advances those milestones from `11.776/14.339/15.708T`, so the supported
  change is the handoff architecture rather than another steering or load
  gain.
- The explicit boundary is actuator residence. Anterior/posterior residence
  above 90% of the rate limit is `17.70/8.25%` for approach restoration,
  slightly above `17.50/7.93%` for all-distance response release, and mean
  commands rise from `16.52/15.31` to `16.66/15.41 rad/T^2`. No sampled joint
  exceeds about `38.7 deg`, and the wake and loads improve, so this is a
  bounded cost to monitor rather than evidence for another unvalidated rate
  threshold.

## One-candidate policy hypothesis

Replace the assigned redirect-priority prefill with the already sampled
approach-restored carrier-coupling architecture, without tuning any gains.
Keep response-conditioned negative-work reversal release only while far, then
withdraw it continuously through the existing body-frame distance handoff so
the evaluated phase-coupled carrier is restored by 4L. Preserve the corrected
target vector, velocity-course redirect, target-conditioned steering,
distance/closing drive relief, posterior handoff, action bounds, and public
two-joint state-feedback contract.

Expected signature: reproduce the `15.94T/1.820L` capture class, earlier late
milestones, shorter path, lower peak load, and coherent two-view wake while
retaining the response-release far-field class. Falsify or replace it if a
repeat loses capture, capture/integral regresses beyond the sampled spread,
either wake view loses its alternating traveling structure, or rate residence,
mean command, joint margin, load, terminal yaw/slip, or path exceeds both
parent classes. The candidate's new CFD result occurs only after this worker
exits and is not claimed as evidence here.

bookshelf_consulted: true
source_domain: biological C-start redirection, sensor-modulated robotic-fish CPG direction tracking, and Lighthill-style reactive traveling-wave propulsion
source_mechanism: release a large observed direction correction into posterior traveling-wave propulsion once directional response appears, with a continuous near-target regime change
transferable_invariant: use measured body-frame response to release rhythmic reversal only where rollout progress supports it, then restore phase-coupled carrier authority before terminal capture
nontransferable_details: published gains, dimensional cadence, species-specific burst stages and kinematics, full-body waveforms, exact vortex phase, and task-specific coordinates or routes
policy_translation: multiply response-conditioned negative-work reversal release by the complement of the existing normalized 6--4L distance handoff while leaving target-conditioned steering and both carrier phases unchanged
falsification: reject if far milestones regress, the 4L-to-capture trajectory leaves the sampled best class, or joint margin, command/rate residence, load, path, terminal yaw/slip, or coherent top-down and oblique wakes deteriorate
