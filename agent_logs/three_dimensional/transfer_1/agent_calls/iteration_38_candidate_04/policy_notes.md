# Candidate diagnosis and hypothesis

## Evidence read before editing

- All four sampled observations are valid direct-uniform still-water rollouts
  (`U_infinity=(0,0,0)`) with no prewarm or cylinders. The exact speed-reserve
  baseline bytes in `solver_33d16cad6362` and `solver_6b0e320e2f55` capture at
  `0.74953L/18.4525T` and `0.74939L/18.6010T`; the sampled fixed steering
  transfer and unsupported-bearing qualifier also cross the threshold, but the
  inherited evidence reports no actuator benefit and a failed exact qualifier
  repeat at `1.18462L`.
- In the combined sheets, the fish moves under its own power from quiescent
  water. Both the strongest sampled finite result and the informative
  alternative retain a regular alternating top-down vortex street from `4T`
  through termination and bilateral oblique Lambda2 structures around the
  posterior body and caudal fan. There is no visible wake collapse, static bend,
  passive advection, or instability immediately before capture. The sheets are
  nearly identical in wake topology, so the unresolved variation is terminal
  trajectory response rather than propulsion quality.
- Cross-checking the sheets with the traces and inherited guidance shows
  approximately `0.82--0.86L/T` terminal self-propulsion, continued joint
  oscillation, action clipping near `68.5--71%`, and force/moment peaks inside
  the established baseline envelope. Captures enter `2.75L` with projected
  closest-pass miss near `0.60--0.88L`; three coherent-wake lower exits are
  already separated at about `1.37--1.95L` there.
- The assigned parent proposed a post-pass progress-loss redirect, but sampled
  sibling guidance and the inherited `solver_ce96329e2851` result now provide
  its negative outcome: the redirect missed at `1.1608L`, exited below, and
  merely reduced clipping. Its evaluator did not expose the requested
  eight-row closure field, so it silently used one-step closure. This does not
  justify retuning or stacking another recovery bend.
- The full inherited failure sheets agree with that diagnosis. The redirect
  and the latest exact-baseline repeat (`1.0260L`) both retain the organized
  street through the first pass, then turn onto the lower-exit branch without
  forming a second target approach by `24--34T`. Their direct-uniform traces
  remain stable, so the new intervention must precede this geometric branch;
  it must not replace the carrier or wait for post-pass recovery.

## Policy hypothesis

Preserve the exact speed-reserve carrier, cadence, actuator allocation, and
inner intercept geometry. Replace the inner-only response-release qualifier
with a progressively weighted projected-capture certificate over the existing
terminal response region. A compatible projected miss and positive target/
velocity alignment may release steering; an already divergent projection must
retain bounded achieved-course steering. This changes a feedback decision, not
a scalar carrier gain, and remains inactive in the far field. It should separate
the evidenced `2.75L` failure branch before the closest pass without weakening
the coherent traveling wake.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG control and response-conditioned fish burst turning
source_mechanism: sensory feedback releases a bounded steering maneuver only after the desired directional response while rhythmic propulsion continues
transferable_invariant: preserve the propulsive oscillator and condition steering release on observed interception response rather than elapsed time or open-loop phase
nontransferable_details: published CPG gains, species-specific burst kinematics, dimensional turn rates, exact phases, and prescribed routes
policy_translation: use normalized body-frame target and velocity projections already available to the two-joint controller; progressively require projected-corridor and approach compatibility before terminal steering can release, while leaving the carrier and joint allocation unchanged
falsification: reject if exact repeats lose capture, the lower-exit topology persists, far-field closure changes, either wake weakens, a static bend or coasting appears, or clipping, speed-limit residence, force, or moment leaves the repeat-backed envelope
