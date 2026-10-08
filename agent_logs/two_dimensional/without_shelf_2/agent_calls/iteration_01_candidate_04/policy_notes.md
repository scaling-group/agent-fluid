# Multi-Wake Candidate Diagnosis

## Evidence used

- The assigned parent is the prefilled guidance in
  `guidance_examples/optimizer_e78dbe103512`; the live guidance initially
  matched it exactly. No inherited optimizer log is present in this workspace.
- The only sampled rollout, `solver_82b05fa0d389`, is therefore both the best
  finite sample and the informative failure available for comparison. It
  scored `-14.294201` and terminated by domain exit after `50.1269` released
  time units without a collision or numerical instability.
- The shared prewarm sheet shows the common held fish above the fully developed
  four-cylinder streets, with the target centered in the downstream overlap
  region. This is common initial-condition evidence, not policy evidence.

## Visual and metric diagnosis

The released keyframes show vigorous bending followed almost immediately by a
clockwise-looking pivot into a steep downward track. The head stays well to the
right of the target/wake corridor and crosses the lower boundary; there is no
visible target-directed recovery, cylinder approach, or productive wake
entry. The yellow path and body poses indicate large turning/lateral motion,
not a collision precursor.

The scalar diagnostics support that reading. Head displacement is only
`-3.545 L` in x but `-13.300 L` in y. Distance briefly falls from about
`12.42 L` to `8.615 L`, then worsens to `12.123 L`, so the small positive
progress is a transient crossing geometry rather than controlled approach.
Mean fish velocity `(-0.0725,-0.2633)` is close to mean local flow
`(-0.0414,-0.2414)`; despite dramatic joint motion, the mean flow-relative
translation is only about `(-0.0311,-0.0219)`. Thus the actuation does not buy
useful self-propulsion toward the target and the fish is largely carried along
its misdirected local-flow track. The `0.55`-time-unit oscillator is also
`32.83` times the estimated shedding frequency, both joint velocities reach
the `260 deg/time` cap, and both accelerations reach the `1800 deg/time^2` cap.
The accompanying RMS lateral force `21.94`, moment `541.70`, and mean command
energy `1496.25` make stronger target-blind drive an unsupported response.

## Candidate hypothesis

Keep the seed's state-only traveling-bend mechanism, but center it on a
bounded curvature command derived from target bearing. Add normalized
body-frame lateral-velocity, recent-turn-rate, and normalized-moment feedback
to resist the one-way rotation visible in the failure. Use a `1.0` control
period and a `12 deg` oscillator scale, with a bounded `12 deg` steering
center, so the gait should remain inside the angle envelope and reduce
persistent velocity/acceleration clipping while retaining enough propulsion
for the `300`-unit horizon. Tail steering is kept weaker than anterior steering
so the traveling wave remains the primary propulsive structure.

This hypothesis is falsified if evaluation still exits laterally without a
material decrease in the lateral-to-streamwise displacement ratio, if the
minimum/final distance topology does not improve, or if joint velocity and
acceleration remain persistently capped. Because the new CFD runs only after
this worker exits, no improvement from this candidate is claimed here.
