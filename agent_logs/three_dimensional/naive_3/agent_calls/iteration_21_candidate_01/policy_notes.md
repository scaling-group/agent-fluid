# Target-independent posterior viability-barrier candidate

## Completed evidence and visual diagnosis

- All four sampled evaluations used direct uniform still-water initialization
  with `U_infinity=(0,0,0)`, no cylinders, and no prewarm. Each captured at
  about `18.27T`. Their top-down sheets show a coherent alternating vorticity
  street from release through capture, and their oblique sheets show compact
  three-dimensional Lambda2 structures behind an actively undulating fish at
  `12T`, `16T`, and termination. Peak body speed is about `1.329U`, versus
  only `0.0315U` peak local flow, so this is self-propulsion rather than
  still-water advection or moving-window transport.
- The inherited `0.857L` left-exit rollout is the informative trajectory
  failure. Both views retain a strong wake, but the fish passes tangent to the
  capture circle and continues left. The later posterior acceleration-reserve
  controller turns that topology into capture while reducing posterior raw
  acceleration exceedance from about `67.5%` to `46.4%`; preserve its
  full-quadrant target ray, measured body-frame velocity course, zero-centered
  anterior oscillator, posterior traveling carrier, and steering reserve.
- The sampled fixed-width guard has the best scalar score (`-0.247735`) but is
  the mechanical failure: it still reaches exactly `-45 deg` posterior angle
  and produces coincident peak force/yaw moment of `0.17183/0.07699`. Both
  velocity-aware barriers preserve the visually unchanged capture route,
  limit posterior excursion to about `43 deg`, and restore the peak load
  envelope to `0.03716/0.01907`.
- The assigned parent's distance-gated continuous barrier and the sampled
  target-independent sibling have identical broad metrics: about `1.329U`
  peak speed, `51.3/46.4%` raw acceleration exceedance, `147/85` joint
  velocity-limit samples, and the same coherent wake. The independent sibling
  captures at `0.74863L`, avoids angle contact, and scores slightly better
  (`-0.248133` versus `-0.248270`). Its `0.60` risk onset was selected above
  the recorded ordinary-carrier maximum near `0.506`, so removing target
  distance from a mechanical safety decision does not alter the demonstrated
  route. This is a robustness improvement, not evidence of low-effort gait.

## Policy hypothesis written before the solver edit

Promote the sampled continuous viability barrier while preserving the assigned
parent through construction of the allocated posterior command. Use posterior
velocity to select the approached joint boundary, compare kinetic stopping
distance with remaining buffered angle margin, and continuously lower the
admissible acceleration in that direction after normalized risk exceeds the
evidence-separated `0.60` onset. Apply the constraint whenever mechanical risk
requires it, independent of distance to the target, and release it when motion
turns inward.

The expected signature is repeat capture near `18.28T`, the same broad route
and alternating 3D wake, posterior excursion below `44 deg`, and peak
force/yaw moment no worse than `0.0372/0.0191`. Falsify the promotion if it
loses capture, changes the broad carrier before risk appears, contacts the
posterior stop, exceeds that load envelope, or materially raises velocity or
acceleration-limit occupancy. The remaining high occupancy is explicitly not
claimed solved by this candidate.

```text
bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and terminal capture control
source_mechanism: sensor feedback continuously constrains a productive rhythmic carrier only when an observed mechanical boundary is dynamically threatened
transferable_invariant: preserve target-directed traveling-wave propulsion and project only dynamically unsafe joint motion toward a viable set, releasing the correction as measured risk clears
nontransferable_details: published gains, linkage geometry, species-specific envelopes, dimensional cadence, clock phase, exact vortex phase, source actuator ratings, and task-specific routes
policy_translation: retain normalized target_body_L versus velocity_body_U course feedback and the two-joint acceleration-reserve carrier; form posterior stopping risk from joint angle, joint velocity, and the owned acceleration envelope, then cap only acceleration toward the approached boundary without using target distance as a safety gate
falsification: reject if capture or coherent shedding is lost, broad-route commands change without joint risk, posterior contact returns, terminal force or moment exceeds the sampled safe-barrier ceiling, or actuator-limit occupancy worsens materially
```
