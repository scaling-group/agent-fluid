# Approach-restored carrier-coupling candidate

## Evidence and visual diagnosis before editing

- All four sampled episodes satisfy the frozen release contract: direct uniform
  `U_infinity=(0,0,0)` initialization, no cylinders or prewarm, finite
  moving-window transport, stable dynamics, and `capture`. There is no
  termination failure in this cohort, so mechanism selection must use
  trajectory, integral, actuator, load, and wake evidence rather than capture
  status or terminal radius alone.
- I inspected both rows of the combined keyframe sheets from release through
  capture for the highest-scoring finite sample `solver_0e3ccca5bc77` and the
  most informative contrasting architecture `solver_3fdd63b3fbda`. In each
  top-down row, the fish starts in blank quiescent water, develops a compact
  alternating caudal wake, and follows a continuous shallow arc toward the
  target. Each oblique row retains coherent three-dimensional Lambda2
  structures behind the caudal region. The fish are self-propelled rather than
  advected, and neither policy shows collision, wake collapse, domain exit, or
  numerical instability. The sheets show no visual reason to replace the
  traveling gait or route scaffold.
- The two byte-identical response-released carrier rollouts delimit repeat
  behavior at `16.071--16.088T`, distance integral `1.82203--1.82366L`, score
  `0.05893--0.06072`, and path `13.129--13.166L`. They cross `10/8/6L` at
  `5.808--5.841/7.761--7.799/9.724--9.762T`, ahead of the plain
  redirect-priority carrier at `5.863/7.838/9.779T`. Their peak planar-force
  coefficient spans `0.03427--0.03575`, peak yaw moment
  `0.01702--0.01781`, and anterior/posterior residence above 90% joint rate
  `17.50--17.52/7.93--8.08%`, versus `0.03579/0.01770` and
  `17.76/8.12%` for the plain carrier. These small but repeat-consistent early
  gains support retaining response-released reversal while far from capture.
- The ordering reverses during approach. The plain carrier reaches `4/3/2/1L`
  at `11.726/12.931/14.201/15.604T` and captures at `16.044T`; the response-
  released repeats reach those milestones at
  `11.759--11.776/12.991--13.030/14.284--14.339/15.670--15.708T` and capture
  later. Thus the release benefit has disappeared by 4L. Releasing the added
  redirect curvature itself is not a substitute: `solver_f997a0c1ad0f`
  advances quickly to `3L` but lengthens path to `13.363L`, raises sub-`2L`
  yaw, and delays capture to `16.247T`. This corroborates the assigned-parent
  warning against another terminal redirect or slip tune.
- The assigned guidance and inherited step-29/30 notes support preserving the
  corrected-sign body-frame target vector, distance/closing relief,
  velocity-course redirect, phase-aware steering, posterior handoff, and
  carrier/steering decomposition. The unresolved opportunity is not a new
  route or scalar gain; it is the evidence-defined boundary between useful
  far-field reversal release and the stronger near-field carrier coupling.

## One-candidate policy hypothesis

Keep the prefilled response-released carrier controller and its bounded
two-joint contract. Multiply only its response-conditioned negative-work
reversal release by the complement of the existing normalized 6--4L wave
handoff. The candidate is therefore byte-equivalent in control structure to
the sampled response-released policy at and beyond 6L, transitions continuously
over 6--4L, and restores the evaluated plain redirect-priority carrier at and
inside 4L. Target-conditioned steering remains unchanged throughout.

Expected signature: retain the response-released samples' earlier `10/8/6L`
progress and coherent two-view wake, then recover the plain carrier's earlier
`4/3/2/1L` milestones and capture without exceeding the sampled path, joint-
rate residence, command, angle-margin, force, or moment envelope. Falsify the
handoff if early progress moves back toward the plain-carrier values, the
approach fails to recover its timing/integral class, switching disrupts the
traveling wake, or actuator/load/path diagnostics exceed both parent classes.
The new CFD outcome occurs only after this worker exits and is not evidence
claimed here.

bookshelf_consulted: true
source_domain: biological C-start redirection, sensor-modulated robotic-fish CPG tracking, and terminal pursuit control
source_mechanism: release a directional burst from measured response into a phase-coupled traveling rhythm, while treating the near-target approach as a distinct continuous feedback regime
transferable_invariant: retain a response-conditioned rhythmic release only in the normalized range where rollout progress supports it, then restore phase-coupled carrier authority before terminal capture
nontransferable_details: species-specific C-start stages, published gains and duty ratios, dimensional cadence, exact vortex phase, full-body waveforms, and task-specific coordinates or routes
policy_translation: multiply the measured signed-yaw reversal release by the complement of the existing normalized body-frame distance handoff, leaving target steering and the two-joint carrier decomposition unchanged
falsification: reject if far-field milestones regress, the 4L-to-capture trajectory does not recover the plain-carrier class, or joint margin, command residence, load, path, terminal yaw/slip, or either coherent wake view deteriorates
