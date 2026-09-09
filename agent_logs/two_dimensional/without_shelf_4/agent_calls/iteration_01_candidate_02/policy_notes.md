# Wake-policy candidate notes

## Evidence diagnosis

- The only sampled solver is the finite naive-seed failure
  `solver_f236e5345260` (`score=-14.2942`, `left_domain` at released time
  `50.1269`). No successful or near-miss sample and no inherited optimizer log
  were supplied, so there is no evidence-backed ranking against a stronger
  policy; this candidate addresses the seed's directly observed failure mode.
- The shared prewarm sheet shows the held fish upstream/right of the target
  while the four developed vortex streets merge around and downstream of the
  target. The released sheet shows the fish initially self-propelling down and
  left, then rotating into a nearly vertical descent. It remains far to the
  right of the useful second-row wake region and exits the lower domain; there
  is no visible collision or numerical breakup.
- The trajectory and scalar diagnostics agree with the pictures. The fish
  briefly lowers distance to `8.61495L` but finishes at `12.1226L`, moves only
  `-3.545L` in x while moving `-13.300L` in y, reaches `9.007L` maximum lateral
  target offset, and makes only `0.0243` progress. Its heading grows from
  `29 deg` to roughly `81 deg` before the late descent. RMS lateral force
  `21.94`, RMS moment `541.70`, and RMS relative crossflow `0.1747` accompany
  the wasteful lateral motion rather than target approach.
- The `0.55`-period, `28 deg` oscillator is outside the actuator envelope even
  before tail coupling: `A*omega` is about `320 deg/time` and `A*omega^2` is
  about `3655 deg/time^2`, versus hard caps `260` and `1800`. The rollout
  confirms exact cap contact at `4.537856 rad/time` and
  `31.415927 rad/time^2`. Thus its propulsion is real, but the sampled result
  does not justify preserving the saturated frequency/amplitude pair or adding
  more drive.

## Candidate hypothesis

Preserve the state-feedback oscillator and lagged posterior joint, but move the
anterior nominal gait inside the speed/acceleration caps (`14 deg` oscillator
scale, period `0.80`; even a `2A` oscillation gives approximately `220
deg/time` and `1727 deg/time^2`) and add a bounded common-curvature offset from
body-frame target bearing. A short bearing-rate lookahead should unwind the
offset before overshoot. The offset is limited to `8 deg` per joint and uses no
coordinates, target identity, clock, route, prescribed inflow, or remote wake
probes.

The falsifiable expectation is that the fish will retain upstream/leftward
self-propulsion while correcting the seed's growing target bearing, avoiding
the early lower-domain exit and decreasing lateral target offset. This
mechanism is not established as successful until a later worker receives its
CFD evaluation. If heading error grows with the same bearing sign, the bend
sign is wrong; if the posterior command still spends substantial time at the
acceleration cap, later work should reduce lag/period coupling before changing
steering gain.
