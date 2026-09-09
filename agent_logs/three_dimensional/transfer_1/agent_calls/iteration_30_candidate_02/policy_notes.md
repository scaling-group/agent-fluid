# Candidate diagnosis and hypothesis

## Evidence read before policy edit

- All four sampled evaluations satisfy the frozen contract: direct uniform
  still-water initialization with `U_infinity=(0,0,0)`, no cylinders, no
  prewarm, active moving-window shifts, stable dynamics, and `capture`
  termination. I inspected both the top-down and oblique rows for the
  best-scoring speed-reserve capture (`solver_6b0e320e2f55`), a second
  carrier-phase realization (`solver_2d0a4a628957`), and the fixed anterior-
  transfer capture (`solver_55f3a103ab95`). Each fish self-propels while
  retaining a coherent alternating mid-plane vortex street and compact
  bilateral oblique Lambda2 structures through arrival. There is no visible
  carrier collapse, passive advection, collision, or instability to repair.
- Three samples use the exact prefilled speed-reserve bytes and capture at
  `0.7466--0.7494L` after `18.287--18.601T`. They overlap closely in peak
  speed (`0.922--0.926L/T`), peak planar force (`0.0309--0.0312`), peak yaw
  moment (`0.0160--0.0163`), head/tail action clipping
  (`68.5--68.7%/70.6--70.7%`), and joint-speed-limit residence
  (`10.4--10.6%/11.3--11.6%`). Their terminal sheets and traces nevertheless
  reach the capture circle from different sides and beat phases.
- The fixed unsafe-intercept anterior allocation also preserves both wake
  views and captures at `0.7492L`, but arrives later at `18.7495T` without
  improving clipping or speed residence. The assigned-parent exact result for
  burden-conditioned anterior allocation then misses at `1.3208L`, exits the
  lower boundary at `10.8681L`, and scores `-11.6710`. Together with inherited
  exact misses for fixed allocation, full-band response veto, yaw braking,
  posterior shaping, bearing recovery, midcourse reserve, and course
  demodulation, this rejects another route-gain, response-threshold, carrier-
  phase, or joint-allocation edit.
- Replaying the existing response equations on the four sampled traces shows
  that response-based steering release is meaningfully active (`release>0.01`)
  on `8.0--12.6%` of rows. During those rows, measured body-relative inflow
  has a large lateral angle: mean absolute slip is `0.432--0.442 rad`, with
  maxima `0.623--0.636 rad`. The strongest release-weighted slip has the
  opposite sign to the target turn request: body yaw has responded, but the
  achieved translation has not yet followed. This is a distinct observation
  from the failed yaw-rate brake and gives the existing release channel a
  measured approach-hold role.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: terminal capture control, wake-disturbance rejection, and sensor-modulated robotic-fish direction tracking
source_mechanism: preserve the propulsive rhythm while using body-relative crossflow to damp terminal slip rather than cancelling all lateral motion or releasing control open-loop
transferable_invariant: once target-relative geometry and measured yaw response permit route steering to release, retain a bounded feedback channel that aligns the body with achieved translation without changing the propulsive traveling wave
nontransferable_details: published gains, dimensional cadence, species or robot kinematics, exact vortex or oscillator phase, fixed coordinates, task-specific routes, and any assumption of a cylinder wake
policy_translation: retain the achieved-course route, intercept gate, carrier, cadence, reserve, and joint shares; blend only the released fraction of terminal route steering into a bounded relative-flow slip command formed from normalized body-frame observations
falsification: reject if an exact rollout misses or retains the lower-exit topology, if the slip channel fights unsafe-intercept steering, weakens either wake view, changes far-field closure, or moves arrival, speed, clipping, joint-speed residence, force, or moment outside the sampled scaffold envelope

## One candidate hypothesis

Add a released-authority slip hold to the exact speed-reserve scaffold. Compute
the body-relative inflow angle from `relative_flow_velocity_body_U`, with the
existing forward floor and speed normalization. While the existing response
release is zero, preserve the evaluated target steering byte-for-byte. As the
release gate opens, replace only a bounded fraction of the released route
command with slip-centering feedback; do not add authority on top. This is a
convex blend, so the steering command cannot exceed the existing normalized
envelope, and it becomes identically the evaluated policy outside the release
region.

Expected test: retain the sampled far-field path and active traveling wake,
but keep terminal body-relative slip from leaving the capture-compatible
velocity path entirely to carrier phase. A capture with the established load
and actuator envelope would support an exact repeat; this worker does not claim
the unevaluated CFD outcome as evidence.
