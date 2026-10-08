# Multi-wake target-policy candidate notes

## Evidence-first visual diagnosis

- The sampled shared-prewarm sheets are byte-identical and show the fish held
  at the upper-right release pose while four staggered cylinder streets develop
  and merge around the target. This is the certified common initial condition,
  not a controller-specific effect.
- All four current samples are finite target captures, so there is no semantic
  failure sheet to invent. The most informative adverse current comparison is
  the `1675 deg/time^2` posterior-cap capture, supplemented by inherited
  negative boundaries: a 27-degree amplitude probe visibly fell behind, while
  mixed auxiliary feedback became unstable at `2.807`. Those failures argue
  against weakening propulsion or adding an uncalibrated feedback axis here.
- The `1600` and `1675` released sheets both show an initial target-facing turn,
  active diagonal swimming left and down under a dense alternating propulsive
  trail, late entry into the merged wake, and capture without visible cylinder
  approach, domain exit, or instability. At matched intermediate frames the
  `1600` fish is farther along the same route. Its mean velocity
  `(-0.3380,-0.1396)` differs materially from local flow
  `(-0.1822,-0.1953)`, especially in useful leftward progress, so the traverse
  is self-propelled rather than passive advection.
- CSV and JSON diagnostics agree with the pictures. Relative to the two exact
  `1650` samples, `1600` improves score from `0.189303` to `0.217528`, arrival
  from `33.027` to `32.202`, mean distance from `1.6831L` to `1.6541L`, command
  energy from `42310` to `40126`, and power from `3183` to `3010`; posterior
  excursion also falls from `0.4950` to `0.4736` rad. The active posterior
  ceiling changes from `28.798` to `27.925 rad/time^2` while the anterior
  acceleration envelope remains touched.
- Crucially, the earlier load-growth warning does not worsen proportionally at
  `1600`: relative-crossflow RMS falls from `0.2358` to `0.2321`, moment RMS is
  nearly flat at `860.25` versus `859.31`, and force RMS rises only from
  `63.93` to `64.77`. These remain within the inherited continuation boundary
  of `0.25/75/1000` for crossflow/force/moment, although one `1600` rollout is
  not replication or held-out robustness evidence.

## Single-candidate hypothesis

Continue only the posterior acceleration-bound sequence by one equal
`50 deg/time^2` step, from `1600` to `1550 deg/time^2`. Preserve the
`0.55`-period, 28-degree oscillator, lag `0.75`, damping `0.65`, bounded
body-frame bearing gain `1.7`, 12-degree steering limit, fraction-`0.35`
allocation, and observation set. The falsifiable hypothesis is that the active
cap remains the mechanism advancing the same safe diagonal route and reducing
effort, while the apparent load plateau at `1600` leaves room for this one
isolated continuation. This does not claim that tighter caps are generally
better or that they unload the fish.

The later CFD evaluation supports `1550` only if it preserves target capture
and the visible turn-then-diagonal topology and materially improves arrival,
mean distance, or effort beyond the `1600` anchor without materially regressing
the other navigation/effort measures. Loss of capture or route, collision,
exit, instability, failure to improve navigation/effort, posterior excursion
above `0.50` rad, relative crossflow above `0.25`, force RMS above `75`, or
moment RMS above `1000` rejects further tightening. Any positive result remains
specific to the certified wake phase and start pose until independently
replicated or tested on held-out wake conditions.
