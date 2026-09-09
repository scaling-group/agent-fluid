# Demand-allocated response-reversing tail candidate

## Evidence diagnosis recorded before the policy edit

- All four sampled rollouts and the inherited allocation failure use direct
  uniform `U_infinity=(0,0,0)` initialization without cylinders or prewarm.
  In the sampled capture sheets, the top-down row shows body-led translation
  and a coherent alternating mid-plane street, while the oblique row shows
  compact tail-associated Lambda2 structures through capture. Local-flow
  magnitude RMS is only `0.0180--0.0188U`; neither ambient advection nor
  moving-window transport explains the progress.
- The prefilled response-reversing half-cycle policy is the strongest sampled
  finite result. It captures at `18.931T` with score `-0.15357`, versus
  `19.234T` and `-0.17657` for the acceleration-feasible distributed C-bend.
  Its action RMS (`25.22/28.86 rad/T^2`) is nearly unchanged from that baseline
  (`25.19/28.56`), while force-magnitude and moment RMS rise only from
  `0.01322/0.00690` to `0.01357/0.00707`. At `18T` it is already `1.386L`
  from capture rather than `1.560L`, supporting the response-reversing
  posterior half-cycle as useful route authority rather than scalar drive.
- The assigned parent's large-demand, sign-coherent curvature allocator also
  captures, at `19.751T` with score `-0.21838`. Relative to the bounded
  baseline it lowers action RMS to `20.88/25.33 rad/T^2`, body-lateral speed
  RMS from `0.257U` to `0.214U`, force-magnitude RMS to `0.01067`, and moment
  RMS to `0.00562`. Its route stays about `1.08L` above the fastest policy at
  `18T`, so the evidence establishes a load/route tradeoff rather than a
  dominant replacement for the half-cycle mechanism.
- The inherited gate-only posterior-relief failure is the relevant negative
  boundary. Both visual rows retain an alternating wake, but deleting slow
  posterior curvature without conserving the total bend misses at `3.191L`
  near `19.283T` and exits left at `30.096T`; action RMS also grows to
  `41.18/62.56 rad/T^2`. This is a route-closure failure, not wake collapse,
  and rules out another unconserved posterior-relief edit.

## Policy hypothesis recorded before editing

Preserve the evaluated normalized body-frame bearing and rotation-invariant
LOS-rate request, phase-conditioned yaw residual, continuously closed
two-joint steering, `28 degree`/`0.55T` state-feedback carrier, explicit
acceleration projection, and the sampled response-reversing posterior
half-cycle. Add exactly the parent's allocation semantic: when the existing
large LOS-response weight is active and anterior and posterior slow-curvature
requests have the same sign, transfer a smooth fraction of posterior mean
curvature into the anterior oscillator center. Add and subtract the same
amount so total slow curvature is conserved; retain all opposing posterior
correction and the complete traveling wave. No range, time, route, or fixed
coordinate gate is introduced.

The compatible combination should retain the half-cycle policy's early wake
and direct arrival while reducing duplicated posterior work on large-demand
segments. Reject it if capture is lost, arrival exceeds the parent's
`19.751T`, the trajectory repeats either the `3.191L` high pass or the
range-gated broad orbit, action/load metrics do not improve on the sampled
half-cycle result, or the coherent alternating wake weakens. The new CFD
result is not available to this worker and is not claimed.

bookshelf_consulted: true
source_domain: Lighthill reactive-thrust allocation, sensor-modulated robotic-fish CPG steering, and response-released C-start redirection
source_mechanism: preserve a posterior phase-lagged propulsive wave, bias its useful half-cycle from observed yaw deficit, and redistribute only compatible slow curvature when a large route request remains unmet
transferable_invariant: keep the traveling bend and route loop closed; strengthen the helpful beat side while conserving total slow steering curvature and preserving opposing correction
nontransferable_details: analytical force coefficients, published gains, species envelopes, robot linkage geometry, dimensional frequencies, exact vortex phases, and task-specific routes
policy_translation: combine the existing normalized body-frame LOS/yaw-response half-cycle with sign-coherent curvature transfer gated by the existing large-response signal inside the two-joint state-feedback and physical acceleration contract
falsification: reject if capture or early wake coherence is lost, arrival exceeds `19.751T`, the high-pass or broad-orbit topology appears, or action and load do not improve relative to the sampled half-cycle policy

## Validation status

- The guidance semantic-delta check and solver edit-boundary check pass.
- The deterministic schema guard passes. A `10,000`-state equation audit
  confirms finite bounded actions, reflection equivariance to numerical zero,
  exact slow-curvature conservation, and allocation weight in `[0,1]`.
- The required Julia contract command passes after prefixing `PATH` with the
  available Aqua Julia wrapper directory; the first unprefixed attempt failed
  because `julia` was not on the default shell path. No CFD was run and no
  outcome for this candidate is claimed.
