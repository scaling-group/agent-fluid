# Posterior predictive-wave-headroom candidate

## Evidence diagnosis before editing

- All four sampled policies captured from direct uniform still water with no
  cylinders or prewarm. They have the same `16.043510T` arrival,
  `0.746962L` final/minimum distance, `-0.058311` score, and byte-identical
  non-action trace hash. Thus none is an informative failed trajectory; the
  useful comparison is the causally inert controller variant within these
  successful samples.
- The top-down sheets show self-propelled leftward translation rather than
  advection, with a coherent alternating wake established by `4T` and retained
  through capture. The oblique Lambda2 sheets confirm finite three-dimensional
  vortical structures and no visible instability. The body makes a smooth
  target-directed correction and still carries a strong traveling bend at the
  first crossing.
- Exact speed-boundary anti-windup changed only the requested actions: mean
  absolute anterior/posterior commands fell from `23.452/25.514` to
  `23.294/24.871 rad/T^2`. The wake, state trajectory, arrival, and score did
  not change because the episode integrator already discarded those outward
  increments. This rules out another exact-boundary cleanup as a navigation
  edit.
- On the inherited capture, posterior speed is at least `0.95` of its physical
  limit for `11.07%` of samples, an outward posterior command coincides with
  that band for `7.27%`, and the posterior sits at the exact speed limit for
  `5.79%`. Posterior command also reaches the acceleration boundary for
  `22.73%` of samples. There is therefore an evidenced pre-boundary interval in
  which a state-dependent wave allocation can alter feasible motion.

## Policy hypothesis

Keep the captured anterior oscillator, carrier-phase residual gate, raw
redirect direction, approach law, and mean posterior curvature unchanged. Add
one continuous posterior-velocity headroom gate: above `0.95` of the normalized
joint-speed envelope, smoothly attenuate only the posterior wave-acceleration
component when that component pushes velocity farther outward. The mean
redirect component and every inward/unloading wave command retain full
authority. Unlike exact-boundary anti-windup, this acts early enough to change
the realized joint state; unlike global drive relief, it preserves the
traveling bend over the rest of the cycle.

Expected useful result: earlier posterior reversal creates usable acceleration
headroom for the next lobe while retaining the coherent wake and captured
route, reducing speed-boundary residence without delaying the `8/6/4/2L`
crossings or capture. Falsify the candidate if capture is lost or delayed, the
alternating wake weakens, early x progress falls, mean redirect is clipped, or
load/instability diagnostics worsen. A lower command statistic alone is not a
positive result.

A joint-only replay with the recorded body observations held exogenous was
used as a bounded implementation check, not CFD evidence. At the selected
`0.95` onset it changed posterior angle by `0.83 deg` RMS, retained a
`31.12 deg` maximum versus the sampled `31.45 deg`, and reduced estimated
`>=0.99` speed residence from `7.34%` to `0.10%`. This supports a conservative
mechanism test but does not predict capture; only the later coupled rollout can
accept the hypothesis.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and elongated-body propulsion
source_mechanism: use measured oscillator state to reshape the posterior wave while preserving phase lag and tail-dominant thrust
transferable_invariant: adapt only the propulsive wave component with normalized joint-state feedback while preserving the distinct mean-turn channel
nontransferable_details: published gains, clock phase, species envelopes, full-body kinematics, exact Strouhal targets, and task-specific routes
policy_translation: smoothly suppress only outward posterior wave acceleration near the normalized speed boundary; retain inward wave action and mean target-directed curvature
falsification: reject if the inherited capture or coherent wake is lost, crossings slow, mean steering authority is reduced, or physical loads become unstable
