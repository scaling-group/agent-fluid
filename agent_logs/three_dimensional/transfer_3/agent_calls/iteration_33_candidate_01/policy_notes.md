# Candidate diagnosis and hypothesis

## Inherited evidence

- All four sampled rollouts are finite captures from direct uniform still-water
  initialization (`U_infinity=[0,0,0]`, no prewarm), with the same capture at
  `19.684490 T`, score `-0.261384287`, mean distance `2.151092787 L`, and
  final distance `0.748302400 L`. Three carry the evaluated `v40` policy; the
  fourth carries the signed course/yaw `v41` branch but produces the identical
  trajectory and keyframe sheet, so that hard-conjunction selector is dormant.
- In the top-down row the fish translates under its own actuation from release
  toward the lower-left target while shedding a coherent alternating wake; it
  does not drift with an imposed flow. The oblique row shows finite, localized
  three-dimensional Lambda2 structures rather than a volume-filling or
  unstable wake. The compact approach remains intact through capture.
- The sampled trace is monotone in its final approach and reaches capture with
  finite speed. Commands still touch the `30.5433 rad/T^2` software limit over
  the full rollout, but the inherited evidence reports that the `v40` handoff
  reduces below-`4 L` high-command counts relative to `v39` without joint-stop
  dwell or a material terminal load increase.
- Inherited optimizer evidence rejects changing posture allocation while joint
  motion is outward from the requested mean bend: adding four points of posture
  support regressed to `-0.261856310`, while retaining carrier during the same
  outward response regressed to `-0.261822240`. It also rejects terminal common
  clipping allocation and unsupported-intercept carrier rescue. The remaining
  disjoint response locus is coupled posture-error energy that is already
  decreasing.

## Policy hypothesis

Preserve the complete `v40` outer allocator, center-intercept corridor, mean
bend, carrier floor, and flat terminal handoff. Measure the normalized descent
of the two-joint posture-error energy directly from joint position error and
joint velocity. Only when that energy is falling, add a small bounded amount of
the existing damped posture controller; when it is flat or rising, retain the
evaluated `v40` command exactly. This is response-conditioned allocation, not
gain-only tuning, a new turn request, phase timing, or a changed equilibrium.

Expected trace-level behavior: the new gate must be independently active on
the completed `v40` trace, must remain exactly zero outside the existing
intercept-supported terminal corridor, and must change neither outer steering
nor total acceleration limits. CFD falsification: reject it for dormancy,
changed pre-`4 L` commands or route, delayed/lost capture, worse distance
integral or final distance, renewed stop dwell, increased terminal command/load
extrema, instability, or degradation of either wake view.

bookshelf_consulted: true
source_domain: biological burst-turn response release and closed-loop robotic-fish CPG modulation
source_mechanism: select gait-to-posture allocation from observed body/joint response rather than a clocked phase
transferable_invariant: target geometry owns the equilibrium while bounded measured response owns continuous mode allocation
nontransferable_details: species-specific C-start kinematics, published gains and frequencies, full-body waveforms, and exact vortex phase
policy_translation: normalize coupled mean-bend position-error descent by the existing joint amplitude and oscillator rate, then use only its positive body-response branch to add bounded terminal posture support under the existing closure/intercept gates
falsification: reject if the gate is dormant, acts outside the terminal corridor, changes the outer path, slows or loses capture, worsens distance, restores joint-stop or command/load spikes, destabilizes the rollout, or degrades either wake view

## Pre-evaluation audit

Replaying the parent and candidate on the same reconstructed stored states
changes 93 commands, all between `1.6008 L` and `3.6268 L`; no state at or
beyond `4 L` changes. The largest same-state command delta is
`0.7215 rad/T^2`, about `2.4%` of the software acceleration cap. This confirms
activity, strict outer noninterference, and bounded authority, but is not a CFD
result and does not establish improvement.
