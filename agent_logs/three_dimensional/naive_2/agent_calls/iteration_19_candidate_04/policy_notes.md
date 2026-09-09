# Candidate diagnosis and hypothesis

## Evidence diagnosis

- All sampled and inherited episodes use direct uniform still water
  (`U_infinity=(0,0,0)`, no cylinders, no prewarm). In the combined top-down
  and oblique sheets, the three sampled captures remain self-propelled behind
  compact alternating vorticity and localized Lambda2 structures. They reach
  `0.7472--0.7500L` at `15.98--16.01T`, with no logged joint dwell beyond
  `40 deg` and only `0.034--0.037 / 0.017--0.019` peak normalized planar
  force/moment. The prefilled approach-drive-relief policy instead curls away,
  reaches both `45 deg` joint stops, peaks at `0.620 / 0.261` in the available
  trajectory, and exits high/left after only a `4.650L` closest pass.
- The assigned parent's inherited rollout is the stronger robustness test.
  Its policy hash `c8459795...` is exactly the response-gated predicted-miss
  candidate that captured in two sampled executions, yet this replay passed
  below the target, reached only `1.216L` at `16.08T`, and exited the lower
  boundary at `27.19T` with final distance `9.348L`. It retained the compact
  wake and low `0.035 / 0.018` load envelope, so the miss is not thrust
  collapse or joint lock. Small trajectory separation accumulated before the
  terminal pass; after closing speed changed sign, the inherited posterior
  pulse explicitly vanished with its closing-alignment gate and the controller
  had no distinct re-acquisition actuator.
- Thus an exact replay of a two-of-three capture policy is too close to the
  `0.75L` boundary to count as robust. The useful invariant is the traveling
  carrier plus geometry-gated mean/pulse steering; the concrete missing state
  transition is a bounded recovery response when a near-target pass stops
  closing.

## Policy hypothesis

Start from the sampled response-gated predicted-miss carrier and leave its
far-field, closing approach, mean bend, and half-cycle channels unchanged. Add
one posterior-only recovery pulse when three normalized observations agree:
the target is in the terminal neighborhood, head-target distance is no longer
closing, and line-of-sight error is material. Apply it only during observed
head-joint mid-stroke and fade it as closing resumes. A successful sampled
trajectory should therefore be essentially unchanged before capture, while a
grazing replay like the inherited `1.216L` pass receives a target-signed burst
instead of continuing to the boundary. The candidate's CFD result is not
claimed here; it becomes evidence only after this worker exits.

bookshelf_consulted: true
source_domain: sensor-feedback robotic-fish CPG steering and burst redirects
source_mechanism: preserve the propulsive rhythm while recruiting a bounded posterior wave-shape correction only when sensed target response is inadequate
transferable_invariant: a failed closing response should gate a short state-based steering burst and release it when targetward response returns
nontransferable_details: published gains, dimensional beat frequency, species envelope, exact vortex phase, full-body waveform, task coordinates, and prescribed route
policy_translation: combine normalized `distance_L`, `closing_speed_L`, full-circle body-frame line of sight, and joint-state mid-stroke phase to add a bounded posterior target pulse without braking the symmetric carrier
falsification: reject if capture is lost, the inherited lower/left post-miss topology remains, pre-capture translation changes materially, or wake coherence, joint angles, and the sampled low-load envelope degrade
