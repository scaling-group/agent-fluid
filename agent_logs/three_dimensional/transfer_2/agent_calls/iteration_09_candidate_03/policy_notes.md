# Posterior half-cycle steering candidate

## Evidence diagnosis before policy edit

- The assigned parent is the middle-field course-redirect controller. Its
  direct-uniform still-water rollout captured at `20.6525T`, with distance
  integral `2.16524L` and score `-0.27336`.
- All four sampled rollouts satisfy the experiment contract: direct uniform
  initialization at `U_infinity=(0,0,0)`, no prewarm snapshot, and capture.
  Consequently there is no sampled semantic failure to compare; the most
  informative weaker finite result is the terminal-only redirect at
  `20.9715T`, `2.16674L`, and `-0.27435`.
- In both top-down and oblique rows, the parent, the weaker terminal-only
  redirect, and the strongest sample visibly self-propel rather than advect.
  They shed a coherent alternating mid-plane street by `4T`, retain discrete
  paired Lambda2 structures through `12--16T`, and execute a late targetward
  C-bend immediately before capture. There is no cylinder collision, boundary
  approach, wake collapse, or visible 3D instability. The sheets therefore
  support changing steering allocation, not replacing the traveling carrier.
- The half-cycle sample is the only materially stronger trajectory: capture at
  `20.2070T`, distance integral `2.11794L`, and score `-0.22712`. Relative to
  the parent it also reduced posterior residence above 95% of the smooth
  `31 rad/T^2` bound from `25.14%` to `23.65%` and posterior peak angle from
  `0.601` to `0.590 rad`; no sample exceeded 90% of the joint-angle limit.
  Its tradeoff is higher anterior mean command (`19.29` versus `18.31
  rad/T^2`) and anterior high-command residence (`23.84%` versus `20.91%`).
  Peak force/moment coefficients remained comparable (`0.0230/0.0128`).
- Widening course authority to `8L` (the parent) and line-of-sight-rate lead
  (`20.4710T`, `2.16055L`) did not create a useful trajectory class. The new
  candidate should therefore preserve the full-vector target/course redirect
  and test the successful state-derived beat-phase mechanism with a different
  actuator allocation, rather than add another distance or lead scalar.
- No inherited `logs/optimize` directory was supplied in this workspace. The
  assigned parent guidance provides its distilled history: wrong-sign exits,
  aligned passes, the distance/closing allocator, and replicated captures.

## Candidate hypothesis

Start from the sampled half-cycle course-redirect scaffold, but apply the
state-derived half-cycle scale only to posterior route curvature. Keep the
anterior oscillator center and direct steering term continuous and unscaled.
This isolates a posterior-emphasized asymmetric stroke: joint 1 sustains and
steers the carrier, while joint 2 strengthens the useful turning half-cycle.
The normalized phase observation is `phi_dot[1] / (omega * active_amplitude)`;
it uses neither clock time nor route memory. The expected result is to retain
the half-cycle sample's earlier target approach while bringing anterior command
residence back toward the parent without increasing posterior saturation.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning plus elongated-body propulsion theory
source_mechanism: half-cycle amplitude asymmetry with posterior emphasis
transferable_invariant: bias the useful turning half-cycle while preserving a lagged posterior traveling bend, and place most phase-shaped authority posteriorly
nontransferable_details: published gains, duty ratios, species kinematics, dimensional beat frequency, exact vortex phase, and task-specific routes
policy_translation: multiply only bounded posterior route curvature by a smooth function of body-frame turn request and normalized anterior joint velocity; keep target/course sensing body-frame and keep the anterior carrier continuous
falsification: reject if capture is lost, arrival or distance integral regresses beyond the parent, coherent top-down or Lambda2 shedding collapses, either joint approaches its angle limit, anterior residence does not fall from the half-cycle sample, or posterior high-command residence exceeds the parent

The new CFD result is not available to this worker and is not claimed as
evidence. Later workers should compare it first against the parent and the
completed full two-joint half-cycle sample.
