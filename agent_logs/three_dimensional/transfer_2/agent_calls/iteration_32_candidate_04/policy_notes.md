# Evidence-selected approach-handoff candidate

## Visual diagnosis and evidence before the policy edit

- All four sampled rollouts satisfy the frozen contract: direct uniform
  `U_infinity=(0,0,0)` initialization, no cylinders or prewarm, finite
  moving-window transport, stable dynamics, and `capture`. There is no
  termination failure to repair; the useful comparison is the trajectory and
  actuator effect of carrier-control semantics.
- I inspected the combined top-down vorticity and oblique body/Lambda2 sheets
  from release through capture for the highest-scoring finite sample
  `solver_1d05d22ea1fe` and the assigned prefill
  `solver_f997a0c1ad0f`, the most informative sampled mechanism regression.
  Both fish begin in blank quiescent water and self-propel along a continuous
  target-directed arc. Alternating caudal vortices trail the body in the
  top-down row and compact three-dimensional Lambda2 structures remain
  coherent in the oblique row. Neither rollout is advected, collides, exits,
  loses its traveling wake, or becomes unstable. The prefill develops the
  visibly longer terminal hook, so the wake evidence supports preserving the
  gait and selecting the better carrier handoff rather than suppressing
  lateral motion or changing propulsion gains.
- The assigned-parent step-31 hypothesis is now positively evaluated.
  Restoring carrier coupling over the existing normalized `6--4L` approach
  handoff gives the cohort's best score, `0.061891`, captures at `15.939T`,
  and reduces the distance integral to `1.82008L`. It reaches `6/4/2/1L` at
  `9.718/11.688/14.185/15.549T`, earlier than the plain redirect-priority
  carrier's `9.779/11.726/14.201/15.604T` and the fully response-released
  carrier's `9.762/11.776/14.339/15.708T`. The handoff therefore retained the
  far release benefit and improved, rather than merely recovered, every late
  milestone.
- That semantic gain is not a terminal-radius or scalar-score artifact. The
  handoff's `13.107L` head path is shorter than the fully response-released
  sample's `13.129L`, the plain carrier's `13.178L`, and the prefill's
  `13.363L`. Its peak planar-force/yaw-moment coefficients are
  `0.03477/0.01715`, below the fully released sample's `0.03575/0.01781` and
  the plain carrier's `0.03579/0.01770`; both wake views remain coherent and
  neither joint resides above 90% of its angle limit.
- The mechanism has an actuator boundary rather than a clean cost win.
  Anterior/posterior residence above 90% joint rate is `17.70/8.25%` and
  above 99% is `12.18/1.31%`, overlapping or slightly exceeding the fully
  released and plain-carrier classes. The inherited error-confirmed redirect
  release also remained a capture but scored only `0.05602`, while the sampled
  yaw-only redirect release lengthened the terminal hook without protecting
  rates or loads. Thus the evidence supports materializing the evaluated
  approach handoff, not stacking another redirect-release, slip, load, or rate
  threshold onto it without a distinct failure signature.

## One-candidate policy hypothesis

Replace the weaker prefill with the evaluated
`dogfish3d_approach_restored_carrier_coupling_v1` controller as the single
candidate. This is evidence-backed mechanism selection: measured signed yaw
may release negative-work carrier reversal while far, but that release is
withdrawn continuously through the normalized `6--4L` approach regime so the
phase-coupled redirect-priority carrier is restored for capture. The corrected
body-frame target vector, distance/closing drive relief, velocity-course
redirect, half-cycle steering, posterior allocation, common bounds, and
two-joint public contract remain unchanged.

Expected signature: reproduce the sampled capture, `15.94T/1.820L` timing and
integral class, early and late milestone ordering, short target-directed path,
bounded joint angles, and coherent top-down and oblique wakes. Falsify the
selection if a repeat moves outside known CFD variation, loses the far-field
milestones or capture, or materially worsens path, command effort, rate
residence, force/moment peaks, terminal yaw/slip, joint margin, or either wake
view. The current worker does not claim a new CFD outcome.

bookshelf_consulted: true
source_domain: biological C-start redirection, sensor-modulated robotic-fish CPG tracking, and terminal pursuit control
source_mechanism: release a strong directional response into rhythmic propulsion, while treating near-target pursuit as a distinct continuous feedback regime
transferable_invariant: response-conditioned carrier release is useful only while measured progress supports it; restore phase-coupled two-joint authority before terminal capture
nontransferable_details: species-specific burst stages, published gains and duty ratios, dimensional cadence, full-body waveforms, exact vortex phase, and task coordinates or routes
policy_translation: gate negative-work reversal release with normalized signed yaw response while far, then withdraw that release using the existing normalized body-frame distance handoff without altering target-conditioned steering
falsification: reject if repeat capture, milestone timing, or distance integral regress beyond sampled variation, or if path, rate residence, load, joint margin, terminal yaw/slip, or either coherent wake view leaves the sampled useful class
