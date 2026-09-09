# Phase-aligned posterior-lag replication candidate

## Evidence diagnosis before the policy edit

- All four sampled rollouts and both inherited completed rollouts satisfy the
  frozen contract: direct uniform `U_infinity=(0,0,0)` initialization, no
  cylinders or prewarm, stable moving-window transport, and capture
  termination. The sampled captures span `19.635--19.817T`, mean distance
  `2.10246--2.10672L`, and score `-0.21272-- -0.21655`.
- I inspected the top-down vorticity and oblique body/Lambda2 rows of every
  sampled combined sheet and both inherited sheets from release through
  capture. They show self-propulsion from rest, a coherent alternating wake,
  compact three-dimensional tail structures, monotone broad approach, and the
  same late upward hook. There is no visible passive advection, wake collapse,
  collision, domain exit, or instability. The weakest sampled capture is an
  informative within-class failure rather than a semantic failure: it keeps
  the same topology but arrives at `19.817T` with mean distance `2.10672L`.
- The byte-identical projected-miss/corridor policy varies from
  `19.701T/2.10438L/-0.21449` to `19.817T/2.10672L/-0.21655`, establishing an
  approximately `0.116T` repeat span. Corridor release therefore has no
  repeat-resolved advantage over the plain LOS-led sample at
  `19.706T/2.10594L/-0.21598`.
- The sampled phase-aligned posterior-lag policy is the strongest available
  finite result at `19.635T/2.10246L/-0.21272`. It preserves the same wake and
  load class: peak planar force/yaw-moment coefficients are about
  `0.02476/0.01312`, anterior mean command is `18.55 rad/T^2`, and anterior
  residence above 90% of the smooth bound is `36.30%`. Its scalar lead over
  the plain parent remains smaller than the identical-policy repeat span, so
  it is promising but not yet a proven gain.
- The inherited alternatives sharpen the mechanism boundary. Unsigned
  redirect-magnitude lag compression retained capture but regressed to
  `19.778T/2.10934L/-0.21948`; a same-sign posterior slip residual retained
  capture but reached only `19.899T/2.10786L/-0.21745`. Both sheets retain the
  same coherent late-hook class. This argues against another scalar lag
  reduction or crossflow-curvature gain and for a clean replication of the
  signed joint-phase allocation.

## One-candidate hypothesis

Replace the prefilled corridor-release variant with the evaluated clean
LOS/range/closing/half-cycle scaffold plus one posterior wave-shape mechanism:
use normalized anterior joint velocity and bounded body-frame turn request to
increase posterior lag on one steering half-cycle and decrease it on the
return half-cycle, symmetrically about the supported mean lag. This preserves
far-field propulsion, adds neither a range window nor static curvature, and
tests whether signed state-derived phase allocation—not lag magnitude alone—
accounts for the strongest sampled trajectory.

Expected signature: capture with the same coherent top-down and oblique wake,
arrival and mean distance in or better than the `19.635T/2.10246L` class, and
non-worse joint margin, near-bound residence, or approximately `0.025/0.013`
force/moment envelope. Falsify the mechanism if a repeat falls within the
plain/corridor cluster without a compensating effort or load improvement, if
the late hook grows, or if capture, wake coherence, joint margin, or load class
regresses. A falsified repeat should restore the clean LOS-led scaffold rather
than tune posterior-lag amplitude.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning and two-joint traveling-wave swimming
source_mechanism: bounded phase-lag or wave-shape modulation coupled to steering phase
transferable_invariant: preserve the posterior traveling bend while reallocating its lag continuously and symmetrically from observed joint phase and body-frame turn demand
nontransferable_details: published gains, dimensional cadence, species-specific kinematics, exact vortex phase, full-body waveforms, and task-specific routes
policy_translation: modulate the owned posterior lag about its evaluated mean with a bounded product of normalized anterior joint velocity and target-derived turn request
falsification: reject if repeat-resolved arrival or distance integral does not improve without an effort or load benefit, or if capture topology, wake coherence, joint margin, command residence, force, or moment regresses
