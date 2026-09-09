# Evidence-selected approach carrier restoration

## Visual diagnosis before editing

- All four sampled rollouts satisfy the frozen evidence contract: direct
  uniform `U_infinity=(0,0,0)` initialization, no cylinders or prewarm,
  finite moving-window transport, stable dynamics, and `capture`. There is no
  termination failure in this cohort, so the informative negative is a
  controller-allocation regression rather than a loss of capture.
- I inspected both rows of the combined sheets from release through capture
  for the strongest finite sample `solver_1d05d22ea1fe` and the lowest-scoring
  response-gated sample `solver_8d0068c45885`. In both top-down rows the fish
  starts in blank still water, self-propels on a continuous shallow target arc,
  and leaves compact alternating caudal vortices. Both oblique rows retain
  discrete three-dimensional Lambda2 structures behind the caudal region.
  Neither policy is advected, collides, exits, flails without progress, loses
  wake coherence, or becomes unstable. The evidence supports preserving the
  traveling gait, target sign, and measured velocity-course redirect.
- Metrics distinguish the visually similar candidates. With response-released
  reversal withdrawn over the normalized `6--4L` approach handoff,
  `solver_1d05d22ea1fe` captured at `15.939T`, had distance integral
  `1.82008L`, head path `13.107L`, and force/moment peaks
  `0.03477/0.01715`. Two byte-identical all-distance release samples captured
  at `16.071--16.088T`, had integrals `1.82203--1.82366L`, paths
  `13.129--13.166L`, and peaks up to `0.03575/0.01781`. The response-gated
  half-cycle variant captured at `16.022T/1.82375L` with a `13.144L` path and
  did not reduce rate residence or mean command.
- The actuator boundary remains material: the approach-restored sample spent
  `17.70/8.25%` of the rollout above 90% of the anterior/posterior rate limit,
  slightly more than the all-distance repeats' `17.50--17.52/7.93--8.08%`.
  Inherited logs also show an exact approach-restored repeat at
  `16.170T/1.82951L`, so the single `15.939T` timing lead overlaps run
  variation even though both handoff paths (`13.107--13.122L`) remained below
  the all-distance range. A later positive-closure gate regressed to
  `16.181T/1.82924L` without a material command, load, or rate-residence gain.
  These results reject another scalar response or effort gate.

## One-candidate policy hypothesis

Replace the prefilled all-distance response-released carrier with the evaluated
approach-restored controller as this workspace's single candidate. Preserve its
corrected-sign body-frame target vector, distance/closing drive relief,
velocity-course redirect, joint-phase steering, posterior allocation, common
carrier governor, bounds, and public two-joint contract. Change only the
negative-work reversal release: retain response-conditioned release while far,
then withdraw it continuously over the existing normalized `6--4L` approach
handoff so the phase-coupled redirect-priority carrier is restored before
capture.

Expected signature: retain target-directed self-propulsion, the coherent
two-view wake, and the all-distance controller's far progress while reproducing
the handoff's short-path approach without leaving the completed timing,
distance-integral, joint, command, or load envelope. Falsify if a repeat loses
capture, path exceeds the all-distance class, timing/integral leaves completed
variation without a material actuator or load benefit, or if rate residence,
joint margin, terminal course, finite action, or either wake view worsens. The
new CFD result occurs after this worker exits and is not claimed as evidence.

bookshelf_consulted: true
source_domain: biological C-start redirection, sensor-modulated robotic-fish CPG direction tracking, and terminal pursuit control
source_mechanism: release a bounded directional response into phase-coupled rhythmic propulsion while treating close pursuit as a distinct continuous feedback regime
transferable_invariant: retain response-conditioned rhythmic release only while far-field response supports it, then restore coupled carrier authority before terminal capture
nontransferable_details: species-specific burst stages and kinematics, published gains and duty ratios, dimensional cadence, full-body waveforms, exact vortex phases, and task coordinates or routes
policy_translation: use normalized body-frame distance and signed yaw response to pass negative-work carrier reversal while far, then withdraw that release continuously over the existing approach handoff without changing target steering or the two-joint traveling carrier
falsification: reject if capture or the sampled short-path approach is not retained, or if timing, distance integral, rate residence, command, load, joint margin, terminal yaw/slip, finite action, or coherent top-down and oblique wakes leave the completed useful envelope
