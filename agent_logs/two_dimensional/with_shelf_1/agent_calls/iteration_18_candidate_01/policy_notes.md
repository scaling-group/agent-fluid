# Wake Policy Candidate Notes

## Evidence diagnosis

- The shared prewarm sheet shows the held fish above and downstream of four
  fully developed, interacting vortex streets. It is the common release state,
  not candidate-specific evidence.
- All four sampled solver results are exact successful replications: target
  capture at `34.7105`, mean distance `1.62283L`, total/mean command energy
  `46985.9/1353.65`, relative-crossflow RMS `0.24023`, and force/moment RMS
  `68.96/1036.40`. Their sheets show a sharp down-left redirect, a coherent
  high-amplitude posterior wave during a long self-propelled upstream traverse,
  and direct first entry into the `0.75L` target circle. Displacement
  `(-10.923,-4.166)L` against mean local flow `(-0.2018,-0.1721)` corroborates
  active propulsion rather than passive advection.
- The inherited previous-command-headroom child is the most informative
  one-mechanism negative contrast available as an image. Its sheet preserves
  the same visible route and capture, but it arrives later (`35.0185`), worsens
  mean distance (`1.63314L`) and total energy (`47340.0`), and slightly raises
  force/moment RMS (`69.66/1037.65`) relative to the replicated baseline. Both
  policies still touch the joint-speed and acceleration envelopes. Therefore
  another saturation proxy for releasing the optional burst is not supported.
- No sampled failure keyframe is present. The inherited textual failure
  boundary remains that bearing trend in persistent route steering exited
  after `18.304` with negative progress, while wholesale carrier replacement
  became unstable with force/moment RMS `16749.8/290421`. The carrier,
  raw-bearing route ownership, response-window burst, and base asymmetry must
  remain intact.

## Policy hypothesis

Add one bounded yaw-disturbance residual, separate from the persistent route
request. When absolute body-frame bearing is small, oppose normalized
`moment_z_L2`; smoothly fade this residual as bearing grows so it cannot weaken
the validated initial redirect. Apply the same residual through the established
two-joint acceleration interface, with the existing posterior steering share,
without changing the carrier, bearing-window response, signed assisting-moment
burst release, coherent joint-speed release, reserve, or course-slip feedback.
The moment transition scale remains `0.25`, close to the baseline moment RMS
after `L^2` normalization; the new residual is capped at one fifth of the
existing mean-steering authority. These are rollout-bracketed bounds, not
published gains.

Expected evidence is preserved capture and redirect/upstream topology with a
meaningful force/moment or route-distance reduction. Falsify the mechanism if
capture is lost, arrival or mean distance materially regresses, or load and
limit-contact diagnostics do not improve enough to justify the extra flow
feedback. Because the current sheets do not resolve fast moment/trajectory
correlations, a successful same-prewarm rollout still would not establish
wake-phase robustness.

bookshelf_consulted: true
source_domain: organized-wake adaptive swimming and sensor-modulated robotic-fish direction control
source_mechanism: separate persistent course commands from bounded rejection of fast wake-induced yaw while retaining the propulsive rhythm
transferable_invariant: target geometry owns the slow route, while a normalized body-frame disturbance may add a small opposing residual only when it cannot erase a required large redirect
nontransferable_details: published controller gains, species kinematics, clocked CPG phase, dimensional frequencies, exact vortex phase, cylinder coordinates, and task-specific routes
policy_translation: preserve the joint-state carrier and raw-bearing steering; smoothly gate a bounded opposing `moment_z_L2` acceleration residual by absolute bearing and share it coherently across the two joints
falsification: reject if target capture or coherent upstream propulsion is lost, or if arrival, distance integral, force, moment, and limit-contact evidence does not show a useful trade relative to the replicated baseline
