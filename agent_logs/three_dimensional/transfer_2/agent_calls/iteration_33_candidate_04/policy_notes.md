# Evidence-selected approach carrier handoff

## Visual diagnosis before editing

- All four sampled rollouts meet the frozen experiment contract: direct
  uniform `U_infinity=(0,0,0)` initialization, no cylinders or prewarm,
  finite moving-window transport, stable dynamics, and `capture`. No failed
  termination is present, so the useful contrast is a repeat-bounded change
  in trajectory, actuator behavior, load, and carrier-control semantics.
- I inspected both rows of the combined keyframe sheets from release through
  termination for the strongest finite sample `solver_1d05d22ea1fe` and the
  lowest-score response-released repeat `solver_0e82a9e35a2a`. In both
  top-down rows, the fish starts in blank quiescent water, self-propels on a
  shallow target-directed arc, and leaves a coherent alternating caudal wake.
  Both oblique rows retain compact three-dimensional Lambda2 structures behind
  the caudal region. Neither fish is advected, collides, exits, flails without
  progress, loses wake coherence, or becomes unstable. The sheets therefore
  support preserving the traveling gait and targeting scaffold.
- Metrics resolve the small architectural difference that the similar wake
  sheets cannot. Two byte-identical globally response-released rollouts
  captured at `16.071--16.088T`, with distance integral
  `1.82203--1.82366L`, head path `13.129--13.166L`, and score
  `0.05893--0.06072`. Restoring full carrier coupling only across the existing
  normalized `6--4L` approach handoff captured at `15.939T`, reduced the
  integral to `1.82008L` and path to `13.107L`, and raised score to `0.06189`.
  Its peak planar-force/yaw-moment coefficients, `0.03477/0.01715`, stayed
  within or below the repeat range `0.03427--0.03575/0.01702--0.01781`, and
  neither joint resided above 90% of its angle limit.
- The assigned-parent and inherited notes delimit two rejected alternatives.
  Releasing extra course curvature from same-sign yaw produced a longer
  `13.363L` hook, `0.269 rad/T` sub-`2L` mean yaw, and `16.247T` capture.
  Instantaneous load relief and positive-work-only carrier guards previously
  delayed capture without a material path/load benefit. The remaining cost
  boundary is rate residence: the approach handoff used `17.70/8.25%` above
  90% of anterior/posterior joint rate, slightly above the response-released
  repeats' `17.50--17.52/7.93--8.08%` range.

## One-candidate policy hypothesis

Replace the prefilled globally response-released carrier with the evaluated
range-specific handoff as this workspace's single candidate. Preserve the
corrected-sign body-frame target vector, distance/closing drive relief,
velocity-course redirect, joint-phase steering, posterior allocation,
carrier/steering decomposition, bounds, and public two-joint contract. Change
only the response-conditioned negative-work reversal release: multiply it by
the complement of the normalized `6--4L` handoff so response release remains
available while far and the common phase-coupled carrier is restored through
the approach.

Expected signature: retain self-propulsion, coherent two-view wake, and the
globally released carrier's far-field progress, while reproducing the sampled
`15.94T/1.820L/13.107L` approach class without increasing load or losing joint
angle margin. Falsify if repeat timing or integral leaves known variation, the
far or late milestones regress, either wake loses coherence, or path, terminal
yaw/slip, command effort, force/moment, joint margin, or rate residence worsens
materially. The candidate's new CFD result is not available in this worker.

bookshelf_consulted: true
source_domain: biological C-start redirection, sensor-modulated robotic-fish CPG tracking, and terminal pursuit control
source_mechanism: release a bounded directional maneuver into phase-coupled rhythmic propulsion from measured response, while treating close pursuit as a distinct continuous feedback regime
transferable_invariant: retain response-conditioned rhythmic release only in the normalized range where measured progress supports it, then restore coupled carrier authority before terminal capture
nontransferable_details: species-specific burst stages and kinematics, published gains and duty ratios, dimensional cadence, full-body waveforms, exact vortex phases, and task coordinates or routes
policy_translation: use normalized body-frame distance and signed yaw response to pass negative-work carrier reversal while far, then withdraw that release continuously over the existing approach handoff without changing target steering or the two-joint traveling carrier
falsification: reject if far progress or the improved approach timing and integral are not retained, or if path, rate residence, command, load, joint margin, terminal yaw/slip, finite action, or coherent top-down and oblique wakes deteriorate
