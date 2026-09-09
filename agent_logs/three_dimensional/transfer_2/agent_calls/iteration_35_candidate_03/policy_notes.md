# Evidence-selected approach carrier restoration

## Visual diagnosis before editing

- All four sampled rollouts satisfy the frozen experiment contract: direct
  uniform `U_infinity=(0,0,0)` initialization, no cylinders or prewarm,
  finite moving-window transport, stable dynamics, and `capture`. Because no
  termination failure is present, the informative failure is a controller-
  mechanism regression in timing, trajectory, and actuation rather than loss
  of capture.
- I inspected both rows of the combined keyframe sheets from release through
  termination for the strongest finite sample `solver_1d05d22ea1fe` and the
  lower-score byte-identical all-distance-release sample
  `solver_0e82a9e35a2a`. Their top-down rows begin in blank still water, show
  genuine target-directed self-propulsion, and develop compact alternating
  caudal vortices. Their oblique rows retain discrete three-dimensional
  Lambda2 structures behind the caudal region through the same shallow capture
  arc. Neither fish is advected, collides, exits, flails without progress,
  loses wake coherence, or becomes unstable. The visual evidence therefore
  supports preserving the traveling gait, target sign, and course redirect.
- Quantitative evidence separates the visually similar controllers. The two
  sampled all-distance response-release repeats capture at
  `16.071--16.088T`, with distance integrals `1.82203--1.82366L` and scores
  `0.05893--0.06072`. With identical parameters and steering, withdrawing
  response-conditioned reversal release over the existing normalized `6--4L`
  approach handoff captures at `15.939T`, lowers the integral to `1.82008L`,
  and raises score to `0.06189`. Its `13.107L` head path and peak planar-force/
  yaw-moment coefficients `0.03477/0.01715` are also below the all-distance
  class (`13.129--13.166L`, up to `0.03575/0.01781`), while both joint angles
  retain greater than 10% margin and both wake views remain coherent.
- The assigned parent and inherited logs provide two boundaries. The
  response-residual redirect produced a longer `13.363L` terminal hook and
  `16.247T` capture, so same-sign yaw is not evidence that course error is
  resolved. More recently, adding positive target-closure confirmation to the
  far-field reversal release captured at `16.181T/1.82924L`; it did not reduce
  command, load, or greater-than-90% rate residence materially relative to the
  approach-restored repeats. This rejects another scalar gate on the release
  and supports selecting the simpler range-specific transition already backed
  by three completed coherent captures.

## One-candidate policy hypothesis

Replace the prefilled all-distance response-released carrier with the evaluated
approach-restored carrier as this workspace's single candidate. Preserve the
corrected-sign body-frame target vector, distance/closing drive relief,
velocity-course redirect, joint-phase steering, posterior allocation,
carrier/steering decomposition, soft bounds, and public two-joint contract.
Change only the reversal release: retain response-conditioned negative-work
release while far, then multiply it by the complement of the existing
normalized `6--4L` handoff so full phase-coupled carrier authority is restored
through the terminal approach.

Expected signature: retain the all-distance controller's early progress and
coherent two-view wake, reproduce the sampled shorter late approach and
`15.94--16.10T/1.820--1.825L/13.107--13.142L` repeat class, and remain inside
the sampled joint, command, load, and finite-action envelope. Falsify if
capture is lost; far or late milestones regress; timing or integral exits that
repeat class without a material path/load/rate benefit; or path, terminal
yaw/slip, joint margin, rate residence, command, force/moment, or either wake
view deteriorates.

bookshelf_consulted: true
source_domain: biological C-start redirection, sensor-modulated robotic-fish CPG direction tracking, and terminal pursuit control
source_mechanism: release a bounded directional response into phase-coupled rhythmic propulsion, while treating close pursuit as a distinct continuous feedback regime
transferable_invariant: retain response-conditioned rhythmic release only over the normalized range where completed motion evidence supports it, then restore coupled carrier authority before terminal capture
nontransferable_details: species-specific burst stages and kinematics, published gains or duty ratios, dimensional cadence, full-body waveforms, exact vortex phases, and task coordinates or routes
policy_translation: use normalized body-frame distance and signed yaw response to pass negative-work carrier reversal while far, then withdraw that release continuously over the existing approach handoff without changing target steering or the two-joint traveling carrier
falsification: reject if far progress or the sampled improved approach class is not retained, or if path, rate residence, command, load, joint margin, terminal yaw/slip, finite action, or coherent top-down and oblique wakes deteriorate
