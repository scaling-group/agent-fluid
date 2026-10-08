# Smooth high-demand carrier-projection candidate

## Evidence and visual diagnosis

- All four sampled rollouts satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no cylinders, and no prewarm snapshot. All capture at
  about `18.27T`. In both the top-down and oblique rows, the fixed-width guard
  and global stopping-risk barrier show the same curved approach, regular
  alternating vorticity street, and compact three-dimensional Lambda2
  structures through capture. Peak fish speed is about `1.329U`, while peak
  local flow is only `0.0315U`; the route is self-propelled rather than an
  artifact of still-water advection.
- The slightly higher scalar score (`-0.247735`) is mechanically misleading.
  Its fixed-width posterior guard reaches exactly `-45 deg` and coincides with
  force/yaw-moment coefficient peaks of `0.1718/0.0770`. The inherited global
  stopping-risk barrier preserves capture and the visible route, stops near
  `-43.0 deg`, and lowers those peaks to about `0.0372/0.0191`. Preserve that
  target-independent viability projection; scalar rank does not justify
  restoring joint contact.
- The sampled final-clamp variant is an informative negative result. It clips
  both returned accelerations to the same envelope already imposed by the
  episode. After removing only the two commanded-action columns, its complete
  trajectory CSV has the same SHA-256 as the unclipped global-barrier rollout,
  and both have exactly the same score, capture time, wake sheet, joint trace,
  route, and loads. Its command peaks change from about `59.87/88.41` to
  `31.42/31.42 rad/T^2`, but limit occupancy remains about `51.3/46.4%`.
  Therefore final clamping is telemetry cleanup, not a controller mechanism.
- A static counterfactual over the inherited raw command trace supports a
  small, testable departure from that no-op. A continuous soft knee beginning
  at half the physical acceleration envelope would reduce command RMS by only
  about `3.0%/2.7%`, while reducing samples at or above `99%` of the envelope
  from about `51.5/47.2%` to `22.8/27.4%`. This is not CFD evidence and does
  not predict the closed-loop route; it only establishes that the proposed
  projection changes the applied waveform without broadly rescaling the
  carrier.

## Policy hypothesis written before the solver edit

Keep the evidenced wrapped body-frame target-ray/velocity-course observation,
zero-centered anterior oscillator, posterior traveling lag, distance-scheduled
steering reserve, and global stopping-risk barrier. Add one actuator-allocation
mechanism: pass only high-demand carrier commands through a continuous odd soft
knee before the episode's hard clip. Apply it to the anterior carrier and the
far-field unallocated posterior carrier; blend back to the already evidenced
posterior steering-reserve allocator as the target becomes terminal. Apply the
posterior viability projection after this soft knee so mechanically necessary
inward braking can still use the full physical envelope.

The expected signature is capture with the same alternating three-dimensional
wake and roughly the inherited `18.27T` route, posterior clearance near
`2 deg`, force/moment peaks no worse than `0.0372/0.0191`, and materially fewer
near-limit applied commands. Falsify the mechanism if capture or the sub-`1L`
approach is lost, cadence or wake coherence visibly degrades, posterior contact
returns, terminal loads rise, or near-limit occupancy does not fall. Because
the new CFD result arrives only after this worker exits, no improvement from
this candidate is claimed here.

```text
bookshelf_consulted: true
source_domain: low-dimensional robotic-fish CPG modulation and residual path-following control
source_mechanism: preserve an explicit rhythmic carrier while bounded feedback and actuator allocation modify only the control demand that available authority can realize
transferable_invariant: keep the evidenced traveling rhythm and target-course residual, but shape high-demand acceleration continuously inside the physical envelope instead of relying on a downstream hard clip
nontransferable_details: published gains, linkage geometry, species-specific kinematics, dimensional cadence, duty ratios, exact vortex phases, source actuator ratings, and task-specific routes
policy_translation: retain normalized target_body_L versus velocity_body_U course feedback and joint-state phase; soft-project only high-demand anterior and far posterior carrier acceleration, retain the terminal posterior steering reserve, and let the joint-state viability barrier override the soft projection when inward braking is mechanically required
falsification: reject if capture or coherent alternating shedding is lost, the sub-1L approach disappears, posterior clearance or load ceilings worsen, or applied near-limit occupancy is not lower than the global-barrier reference
```
