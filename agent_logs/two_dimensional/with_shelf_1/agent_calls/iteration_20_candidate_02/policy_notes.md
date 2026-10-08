# Wake-policy diagnosis and candidate hypothesis

## Evidence read before the edit

- The shared prewarm sheet shows the fish held above and downstream of four
  developed, interacting vortex streets. It is the common initial condition,
  not evidence for a controller difference.
- The coherent bearing-window baseline and all three sampled hydrodynamic-cue
  variants visibly share one topology: a sharp down-left redirect, a coherent
  traveling bend, sustained self-propelled upstream motion through the mixed
  wake, and first-entry capture from downstream. Mean fish motion in the
  baseline is more upstream than the local flow (`-0.3132` versus `-0.2018`),
  so this is not passive advection. No sampled failure keyframe is present;
  inherited downward-exit, wrong-sign-exit, and unstable-carrier results are
  used only as textual boundaries against changing the carrier, steering sign,
  or acceleration-residual interface.
- Replacing bearing-window closure with targetward relative crossflow is the
  strongest useful prior. Against the baseline it improves arrival
  `34.7105 -> 33.9460`, mean distance `1.62283L -> 1.60066L`, total command
  energy `46985.9 -> 46092.2`, and score `0.25101 -> 0.27204`. The same route
  carries a load cost: force/moment RMS rise `68.96/1036.40 -> 85.04/1244.16`,
  while joint speed and both `30.0` command envelopes remain touched.
- The two new samples sharpen what not to add. Requiring co-signed lateral
  force to confirm targetward relative crossflow reaches only `0.2200` sooner
  and lowers total energy by `315.9`, but raises force/moment RMS another
  `10.1%/11.2%` to `93.64/1383.73`; it falsifies its intended load reduction.
  Replacing relative crossflow with local crossflow is slightly slower
  (`33.9900`), uses slightly more total energy (`46157.5`), and raises load to
  `94.55/1395.74`. Separating measured fluid motion from fish lateral response
  therefore provides no evidenced advantage on the shared wake phase.

## One candidate hypothesis

Preserve the relative-crossflow controller's oscillator, posterior lag,
raw-bearing mean steering and reserve, course-slip damping, base half-cycle
asymmetry, signed-moment response, and coherent two-joint speed release. Split
the signed relative-crossflow observation into two roles. Target-aligned
crossflow retains full credit as helpful wake/body response. Target-opposed
crossflow is not allowed to reverse or weaken route steering; instead, its
magnitude supplies a capped compliance release of only the optional redirect
burst. Base asymmetry and the full mean steering remain available, so the
controller yields surplus beat-side loading without turning the disturbance
into a route command.

The candidate is falsified if it loses capture, materially regresses arrival
or mean distance from the relative-crossflow prior without a meaningful load
benefit, or fails to reduce force/moment RMS from `85.04/1244.16`. Same-prewarm
success cannot establish wake-phase or layout robustness.

```text
bookshelf_consulted: true
source_domain: wake-interaction studies and sensor-modulated robotic-fish control
source_mechanism: separate persistent route error from fast alternating wake disturbance and avoid cancelling every fluid-induced lateral motion
transferable_invariant: body-frame target geometry owns mean steering, while a bounded fast disturbance cue may withdraw only surplus transient authority without changing the requested route
nontransferable_details: species kinematics, published gains and frequencies, exact vortex phase, single-cylinder organization, cylinder coordinates, and task-specific routes
policy_translation: keep the evidenced two-joint traveling carrier and target-aligned crossflow release; add a capped release of only optional half-cycle burst under target-opposed normalized relative crossflow
falsification: reject on lost capture, route or arrival regression without meaningful load reduction, or force/moment RMS not below the relative-crossflow prior
```
