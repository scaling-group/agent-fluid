# Wake-policy candidate diagnosis

## Evidence read before editing

- All four sampled rollouts and the three inherited parent-line rollouts use
  direct uniform still-water initialization with `U_infinity=[0,0,0]`, no
  cylinders, and no prewarm. Their translation is self-propulsion rather than
  ambient advection.
- Both rows of the combined keyframe sheets were inspected for the best sampled
  capture and the assigned parent's saturation-priority failure, with the
  prefilled broad failure as a topology cross-check. The successful
  speed-reserve run sustains a coherent alternating top-down street and compact
  oblique Lambda2 structures through capture at `18.20499T`. It arrives from
  above with head `y=9.89098L` and speed `0.90829L/T`. The parent also sustains
  a substantial alternating wake, but passes below with head `y=8.58480L` at
  its `1.42919L` minimum and then curls away. The prefill likewise retains
  propulsion yet reaches only `3.11353L` before a left-domain exit. Missing
  thrust or wake collapse is not the discriminating defect.
- The inherited projected-intercept guard previously improved an exact-policy
  repeat failure from `1.77150L` to `1.05090L`, while joint-state half-cycle
  steering, phase-lag transfer, and static posterior mean curvature regressed.
  The parent's nested-saturation allocation then reached only `1.42919L`.
  In contrast, the sampled speed-reserve allocation—softening only outward
  carrier effort when terminal range, joint speed, previous action, and current
  carrier direction agree—crossed at `0.74796L` without larger observed peak
  loads: peak force was `0.03023` versus `0.03019`, and peak yaw moment was
  `0.01570` versus `0.01592`, for the earlier threshold capture.
- That capture is still fragile evidence. Both joints touch `260 deg/T`, and
  returned acceleration remains clamped on about `68.6%/71.0%` of trace rows.
  A prior LOS-guarded policy captured at `0.74934L` but its exact-byte repeat
  later missed at `1.77150L`. A new mechanism or scalar tuning would confound
  the immediate question of whether speed-reserve allocation survives an
  exact-policy repeat.

## Candidate mechanism and falsification

Submit the sampled speed-reserve policy byte-for-byte as one reproducibility
candidate. It preserves the joint-state traveling bend, achieved-course outer
loop, phase-compensated yaw response, LOS and projected-intercept release
guards, and bounded additive steering. Near the target it attenuates only
carrier acceleration that is observably pushing an already-fast joint farther
outward after a near-saturated previous action; restoring carrier effort and
the steering residual remain intact. This is actuator-state control allocation,
not a new gain sweep, route, clock, or claim of same-worker CFD improvement.

Expected test: reproduce capture near `18.2T` with the coherent alternating 3D
wake and comparable load envelope. An exact repeat is more informative here
than layering a second unevaluated terminal mechanism onto a threshold result.

Falsification: do not call the mechanism robust if this identical policy misses
the `0.75L` disk, returns the lower-exit topology, loses the alternating wake,
or raises speed saturation or hydrodynamic loads. If it fails, later workers
should distrust threshold captures from speed-reserve allocation and seek an
observation that separates the divergent approach states before changing its
reserve gains.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and residual control over rhythmic locomotion
source_mechanism: preserve the rhythmic propulsive carrier while allocating a bounded sensor-driven steering residual through the available actuator envelope
transferable_invariant: normalized actuator state may reserve authority for target feedback without suppressing restoring portions of the traveling bend
nontransferable_details: published gains, robot or species kinematics, dimensional cadence, exact gait or vortex phase, learned routes, and task-specific paths
policy_translation: retain the sampled two-joint carrier and intercept feedback, and replay its body-frame terminal carrier relief only when joint speed, previous action, and carrier direction jointly indicate unusable outward effort
falsification: reject robustness if the exact replay misses capture, weakens the coherent wake, increases speed saturation or loads, or reproduces the lower-domain exit
