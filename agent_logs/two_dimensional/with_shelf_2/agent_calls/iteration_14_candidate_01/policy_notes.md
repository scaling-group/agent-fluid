# Wake-policy candidate notes

## Evidence diagnosis before edit

- The shared prewarm sheet is byte-identical across all four sampled solvers.
  It shows the same held fish near the downstream boundary while four developed,
  interacting vortex streets fill the target corridor; it is common initial
  condition evidence, not evidence for a candidate.
- The released sheets show a strongly self-propelled, zero-centered traveling
  bend rather than passive downstream advection. The fish turns down and left,
  crosses the outer wake into the inter-street region, and reaches the target
  without cylinder contact or a domain exit. The three prefilled-policy sheets
  are byte-identical. The best sampled sheet preserves the same diagonal route
  topology, so the evidence supports a local terminal route-response change,
  not a new route or a change to the base wave.
- The prefilled candidate reaches at `45.2595` with mean/final distance
  `1.71529/0.74937L`, score `0.165009`, command-energy mean `1030.54`, and
  force/moment RMS `438.82/4341.50`. The best sampled candidate caps the
  heading-response projection by distance divided by observed body speed and
  reaches at `45.2210` with `1.71458/0.74854L`, score `0.165860`, energy mean
  `1030.39`, and load RMS `439.16/4344.77`. This is a small but matched positive
  distance/arrival result with essentially unchanged effort and slightly higher
  load, not evidence of wake robustness.
- No sampled solver in this workspace is a failure; all four reach the target.
  The available failure boundary is inherited guidance: increasing optional
  propulsion can pass below capture and collide at `58.93` after a `1.872L`
  closest approach, while target-distance gating in the posterior allocator
  worsened distance and loads. Therefore this candidate leaves propulsion and
  its yaw/rate gates untouched.

## Policy hypothesis

Adopt exactly one mechanism on the successful scaffold: continuously shorten
the heading-rate prediction horizon only when normalized target distance is
small relative to observed body-speed magnitude. Far from the target the
existing response-aware steering is unchanged; near capture it does not
extrapolate a current wake/body turn past the remaining time-to-go. Preserve
the oscillator, half-cycle steering, yaw-magnitude steering gate, positive
closure residual, and asymmetric course allocator verbatim.

Expected evidence: retain `target_reached` and the sampled diagonal topology,
with arrival and mean distance at least matching the prefilled candidate and no
material effort increase. Reject the mechanism if it loses capture, changes the
route topology, worsens arrival or mean distance beyond replay-scale variation,
or causes a meaningful force/moment or command-effort increase.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish direction tracking and terminal target capture
source_mechanism: approach hold by scheduling turn-response prediction from observed time-to-go
transferable_invariant: preserve the propulsive rhythm while reducing terminal overprediction of an already observed turn as normalized remaining range shrinks relative to body speed
nontransferable_details: published gains, species-specific kinematics, exact vortex phases, cylinder or target coordinates, capture radius, and task-specific routes
policy_translation: cap the existing body-frame heading-response horizon by `distance_L / max(hypot(velocity_body_U...), body_speed_floor)` while leaving the two joint-state-feedback accelerations and propulsion allocation unchanged
falsification: reject if capture or diagonal topology is lost, arrival or mean distance regresses beyond deterministic replay variation, or load or command effort rises materially
