# Global posterior viability-barrier candidate

## Evidence and visual diagnosis

- All four sampled evaluations report direct uniform still-water initialization
  with `U_infinity=(0,0,0)`, no cylinders, and no prewarm snapshot. All four
  capture at about `18.27T`. The combined sheets show a regular alternating
  top-down vorticity street through approach and compact three-dimensional
  Lambda2 structures at `12T`, `16T`, and capture. Their route and wake are
  visually indistinguishable at sheet resolution. This is self-propulsion, not
  still-water advection: peak fish speed is about `1.329U`, versus only
  `0.0315U` peak local flow.
- The highest scalar score, `-0.247735`, belongs to the prefilled fixed-width
  guard, but that run is the informative mechanical failure. Its posterior
  joint still reaches exactly `-45 deg`, stops substantial outward velocity,
  and produces whole-trace force/yaw-moment coefficient peaks of about
  `0.1718/0.0770`. Its raw posterior acceleration exceeds the physical
  envelope in about `46.42%` of samples, so the smaller collision spike than
  the earlier unguarded capture is not evidence of a viable joint trajectory.
- Both sampled stopping-distance barriers preserve capture and the broad
  route while avoiding posterior contact: their posterior minima are about
  `-43.0 deg`, their force/yaw-moment peaks fall to about `0.0372/0.0191`, and
  peak speed remains `1.329U`. The target-distance-gated `0.50` risk onset and
  the globally active `0.60` onset finish within `0.006T` and `0.00054L` of
  one another. The inherited optimizer notes explain that `0.60` lies above
  the observed nonterminal risk band, allowing the mechanical constraint to
  remain independent of task distance without perturbing the productive
  carrier. The global barrier also has the slightly better sampled score
  (`-0.248133` versus `-0.248270`).

## Policy hypothesis written before the solver edit

Preserve the captured controller through construction of its allocated
posterior command: the wrapped body-frame target-ray/velocity-course error,
zero-centered anterior oscillator, lagged posterior carrier, and terminal
steering reserve all remain unchanged. Replace only the prefilled fixed-width
angle brake with the sampled continuous viability projection. Select the
approached posterior boundary from joint velocity, divide kinetic stopping
distance by remaining buffered angle margin, and continuously lower the
admissible acceleration toward that boundary when the normalized risk exceeds
the evidence-separated onset. Do not gate this mechanical constraint by target
distance; a held-out route must not be able to disable joint protection.

The expected signature is capture near `18.28T`, the same broad approach and
alternating three-dimensional wake, posterior clearance of roughly `2 deg`,
and force/yaw-moment peaks no worse than `0.0372/0.0191`. Falsify the selected
mechanism if capture or the sub-`1L` approach is lost, if the carrier changes
without joint risk, if posterior contact returns, or if terminal loads regain
the fixed-width guard's spike. Raw acceleration exceedance is not claimed
solved by this candidate and should be tested as a separate allocation problem,
not hidden by further stopping-risk gain tuning.

```text
bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and terminal capture control
source_mechanism: sensor feedback modulates a productive rhythmic carrier only when an observed mechanical constraint requires correction
transferable_invariant: preserve the propulsive rhythm and continuously project only dynamically unsafe joint motion toward a bounded viable set, releasing correction when measured risk clears
nontransferable_details: published gains, linkage geometry, species-specific kinematics, dimensional cadence, clock phase, exact vortex phase, source actuator ratings, and task-specific routes
policy_translation: retain normalized target_body_L versus velocity_body_U course feedback and the two-joint carrier; form posterior stopping risk from joint angle, joint velocity, and the owned acceleration envelope, then cap only acceleration toward the approached boundary without a task-distance safety gate
falsification: reject if capture or coherent shedding is lost, broad-route commands change without joint risk, posterior contact returns, or force and yaw-moment peaks exceed the sampled velocity-barrier ceiling
```
