# Wake-policy candidate notes

## Evidence diagnosis before the edit

- All four sampled episodes satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no prewarm, stable finite dynamics, and `capture`
  termination. The assigned-parent log adds a scalar-only capture at
  `0.748235L`, but it does not include policy bytes, a trace, actuator/load
  diagnostics, or a wake sheet, so it cannot identify a mechanism.
- The combined sheets were inspected from release through capture in both
  views. The top-down rows show self-propulsion with a coherent alternating
  vortex street rather than advection or reciprocal coasting. The oblique
  rows show persistent paired three-dimensional structures and an active
  traveling bend at the final frame. There is no visible collision,
  wake-collapse, or numerical instability to repair.
- Three sheets belong to the exact-byte speed-reserve baseline. They capture
  at `0.74664--0.74939L` in `18.287--18.601T`; their trace-level action clamp
  fractions remain about `68.5--68.7%` for joint 1 and `70.6--70.7%` for joint
  2, with speed-limit residence about `10.4--11.6%`. The highest scalar score
  is not the quickest arrival: its threshold crossing occurs at `18.601T`
  with visibly coherent propulsion but a strongly oblique closest pass. This
  makes terminal path variation, not deficient thrust, the useful target.
- The fourth sampled sheet is the posterior wave-shape pulse. Its wake and
  capture at `0.74797L` look compatible with the baseline, but inherited logs
  contain the exact-policy replay that misses at `1.25888L` and exits below.
  The phase-dependent tail residual therefore does not survive the multi-run
  evidence and is not retained.
- No sampled solver failure has a wake sheet in this workspace. The most
  informative failure evidence is consequently the inherited scalar record,
  interpreted only together with its already distilled parent lesson; it is
  not used to invent visual claims.

## Candidate hypothesis

Preserve the repeat-backed carrier, achieved-course steering, intercept
geometry, and sparse carrier reserve byte-for-byte in behavior outside the
existing near-target intercept gate. Inside that gate, permit the existing
yaw-response release only when the body-frame LOS and inertial velocity course
are already close. This combines the measured body response and the achieved
task-course error without adding steering, changing actuator allocation,
suppressing the carrier, or using time and world coordinates.

The hypothesis is that an apparently correct yaw response can occur at an
unhelpful beat phase while the inertial velocity course is still oblique to
the target. A course-convergence guard should reject only those premature
releases and reduce the observed terminal path variability while preserving
the coherent wake and far-field closure. The short-window body-bearing rate
was considered and rejected before implementation because the sampled traces
show that it oscillates on the beat timescale; using it would recreate the
phase sensitivity already falsified by the posterior-tail replay.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and response-conditioned biological burst turning
source_mechanism: sensor feedback retains curvature until the directional tracking error becomes small, then releases back into the propulsive rhythm
transferable_invariant: maneuver release should depend on resolution of the observed task-direction error, not on body yaw response alone
nontransferable_details: published gains, clock-driven CPG phase, robot geometry, species-specific burst kinematics, exact beat phase, and prescribed routes
policy_translation: within the existing normalized intercept gate, use the rotation-invariant difference between body-frame LOS angle and body-frame inertial-velocity course to guard the existing steering-release fraction; leave the two-joint traveling bend and steering allocation unchanged
falsification: reject if the candidate loses capture, changes far-field distance closure, weakens either wake view, increases load or saturation, or retains threshold-sensitive terminal paths without a repeatable arrival or actuator benefit
