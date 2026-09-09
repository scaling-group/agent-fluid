# Wake-policy diagnosis and candidate hypothesis

## Evidence read before the edit

- The shared prewarm sheet confirms a common held-fish initial condition above
  and downstream of four fully developed, interacting vortex streets. It is
  not evidence for a controller difference.
- The three coherent bearing-window-release samples are exact successes. Their
  released sheets show a sharp down-left redirect, a coherent traveling bend,
  sustained self-propelled upstream motion through the mixed wake, and direct
  first-entry capture in `34.7105`. Their aggregate metrics are `1.62283L`
  mean distance, `46985.9` total command energy, `0.24023` RMS relative
  crossflow, and `68.96/1036.40` force/moment RMS.
- The assigned relative-crossflow parent preserves the same visible route but
  reaches sooner in `33.9460`, improves mean distance to `1.60066L`, lowers
  total command energy to `46092.2`, and raises score `0.25101 -> 0.27204`.
  This semantic improvement comes with higher mean command energy (`1357.81`)
  and materially higher force/moment RMS (`85.04/1244.16`); joint speed still
  reaches `4.53786 rad/time` and both commands still touch `30.0`.
- No sampled solver has a failure termination, so no failure keyframe exists
  for a visual success/failure comparison. The inherited textual failures
  bound the edit: target-blind propulsion exited downward, opposite-sign
  steering exited with negative progress, and wholesale carrier replacement
  became unstable with extreme load. The carrier, steering sign, raw-bearing
  route ownership, base asymmetry, and acceleration-residual interface remain
  unchanged.
- The assigned parent's inherited log shows that direct heading-rate release
  gained only `0.0385` in arrival while raising force/moment RMS to
  `91.30/1389.74`. A sampled sibling's direct lateral-force credit also
  regressed the coherent baseline: arrival `34.9415`, mean distance
  `1.63256L`, total energy `47284.7`, and force/moment RMS `73.70/1106.47`.
  Thus neither yaw rate nor force is an evidenced replacement for the useful
  relative-crossflow response.

## Visual diagnosis and policy hypothesis

The successful sheets do not resolve a topological route difference, but the
metrics do: body-relative crossflow is the first direct wake cue in this branch
to improve arrival, distance integral, total effort, and scalar score together,
yet it is not a load-release cue. Because relative crossflow subtracts the
fish's lateral body velocity from local flow, it mixes measured fluid motion
with the maneuver response that the optional burst itself creates.

Candidate hypothesis: preserve the complete validated controller and replace
only the optional redirect burst's body-relative-crossflow response with local
body-frame crossflow at the head. Targetward local flow receives bounded credit
as wake transport already supporting the requested redirect; opposing flow
removes no authority. Use the observed current local-crossflow RMS (`0.2933`)
as an order-one normalization scale (`0.29`). This clean comparison should
retain capture and the redirect-and-upstream topology while determining whether
the parent's route/effort gain survives after removing explicit body-slip
contamination. Reject it if capture is lost, arrival or mean distance regresses
to the bearing-window baseline without a meaningful load benefit, load rises,
or limit contact remains with no semantic improvement.

bookshelf_consulted: true
source_domain: organized-wake adaptive swimming and sensor-modulated robotic-fish control
source_mechanism: separate persistent route error from fast measured wake response while preserving useful fluid-induced motion
transferable_invariant: target geometry should own mean steering, while a bounded body-frame wake cue may modulate only surplus maneuver actuation
nontransferable_details: Karman-gait phase locking, single-cylinder organization, species kinematics, published gains and frequencies, exact vortex phase, cylinder geometry, and task-specific routes
policy_translation: keep the two-joint traveling-bend carrier and all target steering fixed; replace only targetward relative-crossflow credit with targetward local-flow credit in the optional response-gated burst
falsification: reject on lost capture, route or arrival regression without a meaningful load benefit, increased force or moment RMS, or unchanged limit contact with no semantic gain; do not infer changed-phase robustness from this shared prewarm
