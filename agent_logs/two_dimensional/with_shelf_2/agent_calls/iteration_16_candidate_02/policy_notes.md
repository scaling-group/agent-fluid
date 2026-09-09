# Wake-policy candidate notes

## Evidence diagnosis before edit

- The shared prewarm sheet shows the common held-fish initial condition: four
  developed, interacting vortex streets occupy the target corridor while the
  fish is held near the upper-right boundary. It is not candidate-specific
  phase or route evidence.
- The prefilled time-to-go policy and the strongest sampled policy both use a
  zero-centered traveling bend to swim actively down-left through the merged
  wakes and capture without approaching a cylinder. Their mean upstream body
  velocities (`-0.242` and `-0.247L/time`) exceed the corresponding local-flow
  magnitudes (`-0.177` and `-0.185`), while their heads move about `-11L` in x;
  the useful diagonal route is self-propelled rather than passive advection.
- The sampled course-mismatch damper is a matched positive result over the
  prefill: it changes `45.221/1.71458L/0.165860` arrival, mean distance, and
  score to `44.121/1.70618L/0.173450`. It also lowers force/moment RMS from
  `439/4345` to `389/3909`, though mean command energy rises from `1030.39` to
  `1036.49`. Its released sheet preserves the same broad diagonal topology and
  shows a slightly less deep terminal excursion before capture.
- The informative low-load comparison instead adds a line-of-sight-rate
  forecast. It still captures, but the sheet shows a large early downward
  detour and late hooked turn; arrival and mean distance worsen to
  `70.790/2.71465L` even as force/moment RMS falls to `200/2132`. This rejects
  aggregate load reduction as a sufficient reason for a route-response edit.
  No sampled rollout is a semantic failure. The inherited failure boundary is
  the more propulsive allocator that passed below the target and collided at
  `58.93` after a `1.872L` closest approach with `537/4995` loads, so this
  candidate does not change propulsion allocation.

## Policy hypothesis

Adopt exactly the sampled course/slip approach residual on the successful
prefilled scaffold. Compute body-course angle from normalized body-frame
velocity, compare it with target bearing, and subtract a bounded fraction of
that mismatch from predicted bearing. A smooth distance gate confines the
residual to approach and a speed-confidence gate suppresses direction noise
near zero motion. Preserve the oscillator, posterior lag, half-cycle steering,
yaw-magnitude gate, positive-closure/course allocator, time-to-go horizon cap,
and soft acceleration limiter.

Expected evidence is deterministic recovery of the sampled diagonal capture,
with arrival, mean distance, and load no worse than the prefill. Reject the
mechanism if capture or route topology is lost, terminal crossing is not
reduced, or load/effort increases without the matched tracking benefit. Success
on the fixed prewarm snapshot is not evidence of changed-wake robustness.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and terminal approach control
source_mechanism: preserve the rhythmic gait while bounded sensor feedback damps approach course error
transferable_invariant: keep the propulsive rhythm intact and damp measured body-frame velocity-direction mismatch with the target line of sight only as normalized range shrinks
nontransferable_details: published gains, dimensional approach ranges, species-specific kinematics, exact vortex phases, cylinder or target coordinates, capture radius, and task-specific routes
policy_translation: smoothly gate body-course-minus-bearing by normalized distance and speed confidence, then subtract the bounded residual before the unchanged two-joint half-cycle steering law
falsification: reject if capture or diagonal topology is lost, terminal course crossing persists, arrival or mean distance regresses beyond replay variation, or load or effort rises without a tracking benefit
