# Multi-wake policy diagnosis and hypothesis

## Evidence diagnosis before the edit

- The shared prewarm sheet shows the held fish above and downstream of four
  fully developed, interacting cylinder streets. The released sheets show
  active self-propulsion rather than passive advection: all sampled policies
  first redirect clockwise from the upper-right start, then maintain a long
  diagonal-left traverse through the interleaved wakes and cross the `0.75L`
  target boundary behind the second row. None of the sampled sheets is a
  semantic failure, collision, or domain exit, so the strongest finite run is
  compared with the weakest finite run rather than inventing a failure class.
- The assigned parent reaches in `34.9415`, with mean distance `1.62905L`,
  total/mean command energy `47298/1353.64`, relative-crossflow RMS `0.24288`,
  and force/moment RMS `71.86/1064.16`. It suppresses the extra redirect burst
  when the instantaneous signed yaw moment appears to assist the requested
  turn.
- The response-only sibling, which removes yaw moment from that burst
  scheduler and changes nothing else, is the strongest sampled run: it reaches
  in `34.8205`, lowers mean distance to `1.62700L` and total command energy to
  `47151`, and slightly lowers relative crossflow to `0.24143`. Its tradeoff is
  higher force/moment RMS (`77.09/1142.74`) and nearly unchanged mean command
  energy (`1354.13`).
- Two magnitude-based yaw-load gates preserve capture but do not improve the
  route. The partial absolute-load relief reaches in `34.9965`; the stronger
  squared gate is the weakest sampled run at `35.0350`, mean distance
  `1.63506L`, relative-crossflow RMS `0.24482`, and force/moment RMS
  `78.35/1216.43`. Its keyframes retain the same broad topology but end with
  slightly more downward displacement (`-4.353L` versus `-4.248L` for the
  response-only run). Instantaneous moment/load is therefore not evidenced as
  a reliable release signal for this transient redirect burst.
- Inherited optimizer logs provide the earlier control boundary: localizing
  recent bearing response to the extra half-cycle burst improved the fixed
  half-cycle controller from `36.471` to `34.821` arrival, whereas injecting a
  predictive bearing trend into persistent route steering exited after
  `18.304` with negative progress. Persistent raw-bearing steering and reserve
  ownership should remain unchanged.

## Candidate hypothesis

Preserve the parent's oscillator, posterior lag, course-slip steering
residual, raw-bearing reserve allocator, base half-cycle asymmetry, and command
envelope. Remove only instantaneous yaw-moment suppression from the optional
redirect burst. Raw normalized body-frame bearing determines burst need, and
recent body-frame bearing closure releases that burst. This reproduces the
one-mechanism sibling already evidenced to retain capture while modestly
improving arrival, distance integral, and total effort over the assigned
parent; it explicitly accepts the observed load tradeoff rather than claiming
load reduction.

bookshelf_consulted: true
source_domain: biological C-start redirects and sensor-modulated robotic-fish CPG turning
source_mechanism: strong bounded curvature for large heading error, released when observed heading response appears
transferable_invariant: a transient redirect should be scheduled by persistent body-frame target error and released by measured course response while the propulsive carrier remains intact
nontransferable_details: species-specific C-start shape and duration, robotic CPG gains, dimensional frequencies, exact vortex phases, and task-specific routes
policy_translation: use raw body-frame bearing to request only the extra joint-state half-cycle asymmetry and recent bearing-window closure to release it; do not modify the mean steering residual, reserve allocator, oscillator, or posterior lag
falsification: reject if formal CFD loses target capture, no longer improves arrival or mean distance over the assigned parent, or raises load without retaining an arrival, route, or total-effort benefit; changed wake phase is required before claiming robustness

