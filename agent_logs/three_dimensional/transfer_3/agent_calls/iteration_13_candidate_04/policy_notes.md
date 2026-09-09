# Response-gated anterior steering allocation candidate

## Evidence diagnosis recorded before the policy edit

- All four sampled rollouts report direct uniform initialization with
  `U_infinity=(0,0,0)`, no cylinders, and no prewarm. The top-down mid-plane
  and oblique Lambda2 sheets show self-propelled motion with an alternating
  three-dimensional wake, rather than imposed advection or a moving-window
  artifact.
- The assigned-parent prefill's collision-course-gated distributed C-bend
  captures at `19.7835T` with score `-0.20824`. The sampled response-triggered
  distributed C-bend is the stronger finite result: it preserves the same
  coherent carrier, captures at `19.5855T` with score `-0.20397`, and has lower
  force/moment RMS and lower raw acceleration-envelope occupancy (`39.5%` and
  `71.6%`) than the prefill (`41.5%` and `72.9%`). Its local-flow RMS is only
  about `0.0176U` streamwise and `0.0049U` lateral, supporting controlled
  swimming rather than local-flow transport.
- The later safe-intercept release is a concrete negative result. Although
  both visual rows retain a coherent wake, releasing yaw and posterior mean
  curvature inside the proposed terminal corridor loses capture, crosses the
  target station about `1.76L` high, reaches only `1.712L`, then accelerates to
  `1.22U` and exits left at `28.90T`. It also raises raw acceleration-envelope
  occupancy to `60.6%/76.4%`. Steering must therefore remain closed through
  capture; terminal coasting is not supported by these rollouts.
- In the successful response-triggered rollout, anterior raw acceleration is
  inside the envelope in every sample within `3L`, while posterior raw
  acceleration exceeds it in `59.2%` of those samples. The anterior C-bend is
  also the mechanism that changed the inherited high pass into capture,
  whereas the posterior mean-curvature loop already existed in the noncapture
  LOS-rate baseline. This supports changing actuator allocation rather than
  weakening route feedback or tuning the carrier.

## Policy hypothesis recorded before editing

Start from the evaluated response-triggered C-bend, including its normalized
body-frame bearing and LOS-rate request, phase-conditioned yaw residual,
`28 degree`/`0.55T` traveling carrier, and continuously active anterior
redirect. Add one allocation semantic: as the existing response/bearing gate
recruits anterior mean curvature, smoothly reduce only the posterior *mean
steering* curvature. Preserve the posterior anti-phase and velocity-lag terms
unchanged, so this is not terminal release and does not remove propulsion or
route closure.

The expected result is the proven capture topology with less duplicated slow
bend at the posterior joint, lower posterior envelope occupancy and load, and
no later arrival than `19.5855T`. Reject the allocation if capture is lost, if
the target-station pass moves outside the `0.75L` corridor, if posterior
occupancy or force/moment load does not fall, or if weakening the posterior
route share visibly degrades the alternating wake.

bookshelf_consulted: true
source_domain: Lighthill reactive-thrust allocation and sensor-modulated robotic-fish CPG steering
source_mechanism: use anterior mean curvature for bounded direction control while preserving posterior phase-lagged motion for reactive thrust
transferable_invariant: when a distributed anterior redirect is observably active, avoid duplicating the same slow steering bend at the propulsive posterior joint while retaining the traveling wave and closed-loop route request
nontransferable_details: analytical force coefficients, published gains, species envelopes, robot linkage geometry, dimensional frequencies, exact vortex phases, and task-specific routes
policy_translation: use the existing normalized body-frame bearing/LOS response gate to reduce only posterior mean route curvature, leaving anterior redirect, posterior anti-phase, velocity lag, and damping in the two-joint state-feedback contract
falsification: reject if capture is lost or delayed, posterior acceleration and load occupancy do not improve, or the coherent alternating wake weakens
