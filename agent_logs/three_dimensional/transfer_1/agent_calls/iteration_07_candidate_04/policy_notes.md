# Wake-policy candidate diagnosis

## Evidence read before editing

- The sampled and inherited episodes are finite, self-propelled
  `left_domain` failures from direct-uniform still water with
  `U_infinity=[0,0,0]`, no cylinders, and no prewarm. Both top-down vorticity
  and oblique Lambda2 rows were inspected. The useful common feature is the
  coherent alternating wake from the `0.55T`, `28 deg` posterior-lag carrier;
  the phase-compensated and rate-cascade examples keep that wake but remain
  above the target at `3.0031L` and `3.1135L`.
- The terminal mean-curvature sample turns onto the lower route and retains
  about `50--52 deg` terminal joint excursion, but misses at `1.5454L` while
  its two actions occupy the acceleration envelope on about `70.0%/72.2%` of
  all rows. Replacing direct steering by static curvature is therefore not
  supported.
- The completed reserve-guarded half-cycle sample also retains about `50 deg`
  excursion yet reaches only `1.7708L` and exits below. Adding phase-aligned
  energy recovery improves the pass to `1.1444L`, but its sheet still shows a
  strong alternating terminal wake followed by the same lower exit. Restoring
  locomotor reserve is useful but is not the missing capture mechanism.
- The strongest inherited result is carrier-aligned steering: it preserves
  the carrier, reaches `0.95323L` at `18.755T`, and misses the `0.75L` capture
  disk by only `0.203L`. At closest approach the head is below-right of the
  target, body-frame target-normal velocity is about `+0.78L/T`, closing speed
  has fallen nearly to zero, and the course request is already saturated in
  the corrective sign. Its `70.9%/68.8%` overall and `74.8%/75.5%` sub-`4L`
  acceleration-envelope occupancy argue against more scalar route or steering
  gain. The observed failure is terminal cross-track inertia, not an absent
  route request or collapsed gait.

## Candidate mechanism and falsification

Preserve the complete carrier-aligned controller that produced the `0.95323L`
pass. In the terminal region only, measure target-normal velocity directly as
the normalized body-frame cross product of `target_body_L` and
`velocity_body_U`. While still closing, map this signed slip through a small
bounded posterior mean-tangent response. This adds an observed-response
wave-shape channel without changing cadence, increasing the existing course
gain, attenuating either carrier half, or using a clock or world route.

Expected test: behavior outside `3L` remains the inherited carrier-aligned
trajectory; during the close pass, the posterior response reduces the
below-target cross-track velocity early enough to move the head the remaining
`0.203L` into the capture disk while the alternating wake and roughly `50 deg`
joint excursion survive.

Falsification: reject if far-field closure changes, closest approach fails to
beat `0.95323L`, terminal cross-track velocity is not reduced, acceleration or
joint-speed saturation grows materially, wake/excursion collapses, or the same
lower-exit topology remains. Then avoid further additive curvature and test a
bounded carrier phase-lag response or an explicitly phase-compensated
line-of-sight-rate release.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish turning and terminal capture control
source_mechanism: preserve the propulsive rhythm while damping observed yaw or slip during the final approach
transferable_invariant: after broad route acquisition, terminal steering should respond to normalized target-normal motion without suppressing the traveling carrier
nontransferable_details: published gains, dimensional cadence, robot or species kinematics, prescribed CPG phase, exact vortex phases, and task-specific routes
policy_translation: inside a body-frame distance and positive-closing gate, map target-normal velocity into a small bounded posterior mean tangent while retaining carrier-aligned steering
falsification: reject if the sub-0.95323L pass, terminal slip, saturation, coherent wake, or lower-exit class does not improve

## Non-CFD verification

- Replaying only the new observation-to-tangent calculation over the inherited
  `0.95323L` trace confirms that it is identically zero outside `3L`. Across
  the recorded sub-`3L` segment it stays within `-0.70` to `+4.86 deg`; at
  closest approach, target-normal velocity is `+0.782L/T`, closing speed is
  `+0.012L/T`, and the closing gate reduces the bounded response to
  `+2.66 deg`. The edit therefore acts in the evidenced corrective sign and
  releases continuously as closure ends.
- The material-guidance check, independent static parameter-schema audit, and
  solver editable-boundary check pass. The mandated Julia smoke command could
  not run because no `julia` executable is installed in this workspace image;
  no runtime or CFD result is claimed.
