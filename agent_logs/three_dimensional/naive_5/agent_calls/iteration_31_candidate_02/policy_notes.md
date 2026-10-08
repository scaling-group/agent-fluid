# Wake-policy candidate notes

## Evidence diagnosis before the edit

- All four sampled evaluations satisfy the direct-uniform still-water contract
  (`U_infinity=(0,0,0)`) and terminate in capture. The combined sheets show
  self-propulsion rather than advection: both the top-down mid-plane row and
  oblique Lambda2 row develop a coherent alternating three-dimensional wake,
  followed by the same straight approach and shallow terminal hook.
- The translation-consistent sample is the strongest finite comparison:
  `solver_8e7135ef9173` captures at `0.748338L` and `26.2460T`. The assigned
  prefill's pre-selector arbitration captures slightly earlier at `26.2130T`
  but less deeply at `0.749076L`; it preserves the same visible topology,
  zero angle/rate/action contacts, peak planar force `0.018834`, and nearly
  the same peak yaw moment (`0.009863` versus `0.009789`). The sampled
  course-priority and carrier-relief alternatives likewise stay in the same
  shallow-capture topology at `0.748591--0.748792L`. Therefore another route/
  response arbitration or scalar terminal retune is not supported.
- In the strongest trace after `18T`, body-normal force has median absolute
  magnitude `0.00542`, RMS `0.00730`, and 90th-percentile absolute magnitude
  `0.01212` in normalized `force_body_L` units. Its fast oscillation closely
  tracks course rotation, yet its sign opposes the geometry-defined course
  request in about `54%` of rows. This is a separable response observation:
  it can gate a steering half-cycle without being allowed to choose the route.
- The inherited optimizer logs add scalar-only captures at `0.748796L` and
  `0.749723L` but provide no policy, trace, visual, or load artifact. They do
  not justify a gain, threshold, or force-sign inference.

## Candidate hypothesis

Use `solver_8e7135ef9173`'s translation-consistent carrier as the productive
baseline and omit the assigned prefill's unsuccessful phase-coherence
correction. Add one smooth force-gated response primitive to anterior joint 1.
Inside the existing middle/late translation gate, positive closing speed and
observable course motion enable a bounded acceleration in the course side only
when measured body-normal hydrodynamic force opposes that side. The normalized
target/course geometry retains route authority; force supplies only fast phase
and response timing. The existing coordinated command projection and joint
viability guards remain downstream.

Expected result: the extra pulse changes phase residence and the late hook
without weakening the coherent traveling bend, restoring actuator contacts, or
raising the sampled load regime. Falsify the mechanism if it loses capture,
retains only the milliscale-equivalent shallow path, increases peak planar
force/yaw moment beyond the current `0.018834/0.009789` regime, or creates any
angle, rate, or acceleration contact.

bookshelf_consulted: true
source_domain: wake-interaction control and sensor-modulated robotic-fish CPG steering
source_mechanism: separate persistent target-route feedback from bounded fast hydrodynamic-response modulation
transferable_invariant: geometry selects the desired turn side while an observed alternating load may gate when a small corrective half-cycle is applied
nontransferable_details: published gains, species-specific kinematics, clock phase, exact vortex phase, and task-specific routes
policy_translation: retain normalized body-frame course geometry and the two-joint traveling bend; use normalized lateral force only to gate a bounded anterior route-side pulse in the evidenced middle/late closing corridor
falsification: reject if capture, wake coherence, actuator viability, or load exposure worsens, or if the resulting trajectory remains in the same shallow-capture cluster
