# Wake-policy diagnosis and candidate hypothesis

## Evidence read before the edit

- All four sampled rollouts use the required direct uniform still-water
  initialization (`U_infinity=0`) and terminate in capture. Three
  executable-equivalent policies reproduce `22.187000T` arrival,
  `2.106255L` mean distance, and score `-0.211504`. Their top-down sheets show
  the same self-propelled S-route and attached alternating wake. Their oblique
  rows are blank render failures and are not independent evidence about the
  three-dimensional wake.
- The assigned parent adds a proximity-grown, de-yawed target-line preview to
  only the slow anterior course request. It preserves the launch through
  `4/8T`, then improves the sampled `16/20/22T` distances to
  `3.980/1.861/0.818L` from `3.983/1.872/0.830L`, captures at `22.159500T`,
  lowers mean distance to `2.105808L`, and improves score to `-0.211168`.
  Its complete combined sheet shows a coherent alternating mid-plane street
  and discrete oblique Lambda2 structures from release through capture. The
  numerical envelope remains finite: mean action about `59.830`, exact
  anterior/posterior rate-cap occupancy `11.47/6.40%`, and peak normalized
  force/moment `0.030897/0.015839`.
- The inherited negative control that permits predictive rudder release but
  not recruitment returns to the slower `22.307997T`, `2.107401L`,
  `-0.212396` trajectory. This rules out treating preview as a release-only
  terminal rule. The inherited step-34 score-only records remain captures at
  `-0.212075`, below the assigned parent; without matching trajectory and
  two-view evidence they do not overturn the parent's mechanism-level bound.

## Visual diagnosis

The parent is self-propelled rather than advected: the zero-flow release grows
an alternating street behind a continuously beating body, and both the
top-down wake and the separated three-dimensional structures remain present
at capture. The route is already target-directed and stable. The useful
remaining difference is small and begins only after the `8.0--5.5L`
proximity envelope opens: predictive anterior course allocation improves
approach while the launch is unchanged. There is no visual or numerical case
for more oscillator, recovery, or rudder gain. The three comparison policies'
blank oblique rows are rendering failures, not wake collapse.

## Candidate hypothesis

Preserve every established carrier, recovery, course, rudder, terminal-relief,
and symmetric posterior-relief expression. Form a predicted full body-frame
target error with the same bounded de-yawed line-of-sight rate and the same
proximity-grown half-cycle lead that improved the anterior course. Use it only
to open or close the existing posterior half-cycle asymmetry envelope; retain
instantaneous measured target side and anterior joint velocity for the stroke
sign. This is a bounded phase-allocation change: it does not increase the
`0.30` asymmetry ceiling, alter the `0.12` recovery budget, or add tail load.
It is inactive before proximity opens, so the evidenced launch should remain
unchanged. The expected effect is earlier target-side posterior loading after
`8L`, improving the `16/20/22T` distance trace and capture time while keeping
the parent's complete wake and load/saturation envelope.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning and asymmetric-flapping control
source_mechanism: retain a rhythmic propulsive carrier while steering through bounded half-cycle effort allocation
transferable_invariant: generate turn authority by redistributing an existing oscillatory action between target-side and return strokes rather than adding static bend or scalar drive
nontransferable_details: published gains, clocked oscillator phase, robot linkage geometry, species kinematics, exact vortex phases, and task-specific routes
policy_translation: use normalized body-frame target geometry plus bounded de-yawed line-of-sight preview to gate only the existing posterior asymmetry; infer stroke side from anterior joint velocity and keep all established ceilings
falsification: reject if capture is later than 22.159500T, mean distance exceeds 2.105808L, launch changes before the proximity gate, or the route, two-view wake, action, rate-cap occupancy, peak force, or peak moment exceeds the assigned-parent envelope
