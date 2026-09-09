# Wake-policy candidate notes

## Evidence diagnosis

- The four sampled examples share the certified prewarm sheet. It shows the
  fish held above and downstream of four already developed, interacting vortex
  streets, so differences after release are controller effects from a common
  flow state.
- The three code-identical trajectory-efficiency-supervisor samples terminate
  at the target in `32.340`, with mean distance `1.63773L`, relative-crossflow
  RMS `0.24372`, and force/moment RMS `65.12/888.56`. Their released sheets are
  identical: a coherent traveling bend drives a compact diagonal route into
  the developed wake only near capture. There is no visible coasting, route
  reversal, or wake-induced loss of target control.
- The strongest sampled score adds a response-confirmed withdrawal signal at
  the same optional posterior residual. Its sheet preserves the same topology,
  and it reaches in `32.318` with mean distance `1.63741L`. The improvement is
  marginal: force RMS rises to `65.52`, moment RMS falls to `881.45`, and
  relative-crossflow RMS is nearly unchanged at `0.24339`. Treat this as one
  fixed-snapshot observation, not a semantic improvement or robustness result.
- Inherited optimizer logs provide the more informative adverse comparison:
  response-conditioned withdrawal distributed into another controller layer
  still captured but regressed to `32.4555`, mean distance `1.64548L`, and
  force/moment RMS `67.83/914.09`. Earlier inherited evidence also shows that
  an undirected physical-limit gate delayed capture to `33.9405`. The current
  sampled set contains no failure keyframe; its documented failure boundary is
  the inherited downstream-exit/no-traveling-wave topology, which must not be
  recreated by moving oscillator centers or weakening the base wave.

## Policy hypothesis

Keep the evaluated target-window supervisor, distributed mean curvature, and
unit-gain lagged traveling wave unchanged. Add one signed hydrodynamic-yaw
yield signal at the existing optional posterior-residual locus. During coherent
closure, a bounded positive product of target turn request and normalized body
yaw moment indicates that the fluid load is already assisting the requested
turn; only then may the controller withdraw part of the optional `8%` residual.
Opposing or ambiguous moment restores the existing controller exactly. The
hypothesis is that this preserves the direct capture and arrival class while
reducing moment/effort attributable to redundant active turning.

bookshelf_consulted: true
source_domain: biological Karman-gait and wake-exploitation studies
source_mechanism: swimmers can yield to organized vortex-induced loading and reduce active effort instead of cancelling every lateral wake motion
transferable_invariant: preserve useful hydrodynamic assistance by withdrawing only optional control effort when a measured body-frame load agrees with the current task-directed response
nontransferable_details: trout kinematics, muscle-activity values, single-cylinder vortex phase, dimensional frequency, species gains, and prescribed wake route
policy_translation: sign normalized `moment_z_L2` by the bounded body-frame target turn, soften it at the locally observed moment scale, and combine it with coherent-closure confidence only at the optional posterior half-cycle residual
falsification: reject if target capture or the compact diagonal topology is lost, arrival and distance integral both regress, moment or force rises without navigation benefit, or held-out wakes expose propulsion loss or phase-sensitive switching

## Scope

This candidate does not cancel crossflow, infer a vortex phase, or use cylinder
coordinates. The current evidence does not show repeated yaw reversal, so a
new additive flow/force residual is not justified. Formal CFD evaluation is
deferred to EvE after this worker exits.
