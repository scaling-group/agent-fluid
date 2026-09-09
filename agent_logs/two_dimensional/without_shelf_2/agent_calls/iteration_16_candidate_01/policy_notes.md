# Multi-wake candidate diagnosis

## Evidence read before the policy edit

- The shared prewarm sheet shows the fish held at the common upper-right
  release pose while the four staggered-cylinder streets develop and interact
  around the second-row target. It is common initial-condition evidence, not a
  candidate-specific phase signal, route, or justification for coordinates or
  timing logic.
- All four current sampled policies reach the target without collision, domain
  exit, horizon miss, or instability. Three are executable replications of the
  prefilled `tail_steering_gain=0.65` controller: their released sheets and all
  physical diagnostics are identical apart from wall time. They take a compact
  down-left route through the developed wake and turn into the capture circle
  from the right in `72.160` release units, with `2.4638L` mean distance,
  `0.06732` upstream-relative x speed, `51284` total command energy,
  `0.13603` RMS relative crossflow, and `25.32/420.32` RMS force/moment.
- The score-leading sample changes only posterior sharing to
  `tail_steering_gain=0.70`. Its keyframes retain the same bounded diagonal
  topology and useful wake entry, with no visible coil, loop, obstacle contact,
  or wasteful lateral excursion. It enters the target from slightly lower on
  the right and improves mean distance to `2.4541L` and score from `-0.56561`
  to `-0.55577`. Arrival is modestly slower at `72.457`, total command energy
  rises to `51842`, and upstream-relative x speed eases to `0.06620`, so it is
  a route-quality improvement rather than a speed or effort optimum.
- The `0.70` change also reverses the `0.65` sample's small load penalty: RMS
  relative crossflow falls to `0.13063`, force/moment to `23.85/408.89`, and
  both peak joint speeds fall to `3.086/3.293`; peak anterior angle falls to
  `0.500 rad`, posterior angle remains bounded at `0.438 rad`, and both
  acceleration commands still touch the unchanged `28 rad/time^2` guard.
  Against the inherited `0.60` anchor, it is also faster (`72.46` versus
  `73.86`), closer on average (`2.454L` versus `2.480L`), slightly more
  self-propelled (`0.06620` versus `0.06565` upstream-relative x speed), and
  lower-loaded (`23.85/408.89` versus `24.94/410.68`), at nearly equal total
  effort (`51842` versus `51797`). Thus the two isolated `0.05` increases give
  evidence for bounded continuation, while not proving a monotone response.
- No current sampled sheet is a semantic failure. The most informative
  visually available failed optimization hypothesis is the assigned parent's
  static `oscillator_energy_gain=2.075` interpolation: its sheet takes a deeper
  lower correction and its metrics regress to `77.264` arrival, `2.551L` mean
  distance, `53643` energy, and `31.45/454.27` force/moment. This corroborates
  keeping the evaluated static `2.1` restoration law rather than combining the
  posterior-share direction with another propulsion or restoration change.
  The inherited reversed-sign instability remains a safety boundary, but no
  unavailable visual detail is inferred from that older result.

## Single candidate hypothesis

Preserve the evaluated `0.75` period, `22 deg` oscillator, static `2.1`
restoration, bounded positive-bearing `0.75/10 deg` anterior steering, `0.55`
posterior lag, `0.65` damping, and common `28/28 rad/time^2` guard. Change only
`tail_steering_gain` from the prefilled `0.65` to `0.75`, one equal `0.05`
continuation beyond the newly evaluated `0.70` result. Because it acts on the
existing `10 deg`-bounded steering center, this adds at most `0.5 deg` of
posterior mean-curvature target beyond `0.70`; it adds no observation,
coordinate, route, clock, wake probe, switching surface, or new command
authority.

The falsifiable expectation is preservation of finite compact capture with a
further reduction in mean distance below `2.4541L`, while retaining roughly
`0.0662` upstream-relative x propulsion and the lower crossflow/load regime of
the `0.70` sample. Reject the continuation if it selects a visibly deeper or
looping route, loses capture, slows arrival materially beyond `72.46`, raises
total effort materially beyond `51842`, or raises RMS force/moment without a
corroborating distance improvement. Even a positive same-snapshot result would
remain falsifiable under held-out wake phase, inflow, geometry, and target
placement; no CFD outcome for this new candidate is claimed here.
