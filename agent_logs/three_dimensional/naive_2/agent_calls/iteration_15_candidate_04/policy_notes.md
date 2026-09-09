# Multi-wake target-policy candidate

## Evidence diagnosis

All four sampled rollouts report direct uniform quiescent initialization with
`U_infinity=(0,0,0)` and no prewarm, so their motion and wakes are attributable
to the policy rather than imposed advection. The combined sheets were inspected
in both the top-down vorticity row and oblique body/Lambda2 row.

- The finite best sample `solver_aa2570fe3d2e` maintains a compact alternating
  reverse-street-like wake while curving its track down and left into the
  target. Metrics agree with the visual result: capture occurs at `16.011T`,
  distance decreases monotonically to `0.748L`, and the final head is at
  `(9.656,9.140)L`. This is self-propulsion, not advection; mean inertial
  velocity is approximately `(-0.679,-0.298)L/T` in still water.
- The prefilled approach-hold sample `solver_1fbf1e40b119` initially produces
  an organized alternating wake and useful leftward translation, but its
  wake/body path broadens into a large curl after the closest pass. It reaches
  only `2.703L` at `17.434T`, about `2.702L` above the target, then reverses
  lateral response and exits left at `24.518T` with distance `7.056L`.
  Joint-rate near-limit occupancy is `18.9%` and acceleration near-limit
  occupancy is `36.8%`, so reducing symmetric drive did not create effective
  terminal steering reserve.
- The other response/redirect variants retain strong self-propulsion but the
  same high-side miss and left-exit topology: `solver_ec81137f627b` reaches
  `4.650L` and `solver_6acb145d7f64` reaches `3.312L`. Their top-down and
  oblique sheets show coherent early shedding followed by a turn/curl away
  from capture, consistent with their final upward velocity and boundary
  exits rather than a numerical instability.
- Inherited optimizer logs likewise show three later completed left-domain
  rollouts with closest passes `3.204L`, `0.963L`, and `0.810L`. The latter two
  demonstrate that position-only late corrections can almost enter the tight
  `0.75L` radius yet still overshoot and finish `9.671--10.560L` away.

## Policy hypothesis

Replace the prefilled continuous drive relief with the captured sample's
course-residual carrier and predicted-miss terminal curvature. Body-frame
target/velocity dot and cross products separate persistent course error from
beat-scale yaw. When the measured course predicts a near-horizon cross-track
miss, a bounded mean bend is introduced before closest approach while the
traveling bend remains active; ordinary distance gating remains a fallback.
This is one compact terminal interception mechanism layered on the evidenced
propulsive carrier, not scalar-only tuning. The direct evidence expectation is
capture near `16T` with a compact alternating wake; reject it if evaluation
loses capture, produces a high-side pass, or turns the wake into the broad
post-pass curl seen in the prefill.

```text
bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG turning and reduced-order terminal capture
source_mechanism: target-feedback mean curvature superposed on a traveling propulsive rhythm
transferable_invariant: a slow predicted cross-track miss should recruit bounded curvature before closest approach while joint-state phase preserves propulsion
nontransferable_details: published gains, dimensional frequencies, species-specific envelopes, exact wake phases, and world-frame routes
policy_translation: normalized body-frame target and velocity dot/cross products gate a small mean bend across both joints while course-residual half-cycle steering and the two-joint traveling carrier remain active
falsification: reject if capture is lost, closest approach worsens, the trajectory keeps the high-side/left-exit topology, or wake coherence and load histories degrade together
```
