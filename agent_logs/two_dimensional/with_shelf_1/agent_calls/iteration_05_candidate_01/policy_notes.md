# Candidate wake-policy notes

## Evidence diagnosis

- The common prewarm sheet shows a fully developed, interacting four-cylinder
  street before release, with the fish initially above and to the right of the
  target. This is shared initial-condition evidence, not a policy result.
- Every sampled released policy reaches the `0.75L` capture boundary. Their
  sheets show self-propelled motion: after a sharp clockwise redirect, the
  fish maintains a coherent left/down traveling bend, crosses the downstream
  wake, and approaches the target from the right. There is no sampled failure
  sheet in this workspace; the assigned-parent seed and wrong-sign exits are
  retained only as inherited historical controls.
- The prefilled fixed-reserve policy arrives in `49.142` with mean distance
  `2.1560L`, total/mean command energy `62522/1272.3`, and RMS lateral
  force/moment `39.05/617.13`. Its diagnostics touch the `30.0` candidate
  acceleration envelope and the episode joint-speed limit on both joints.
- Adding body-frame course-slip feedback alone arrives in `48.032`, while RMS
  force/moment fall to `37.92/605.38`; this establishes the sign of a small
  motion-response correction, although mean command energy rises to `1299.7`.
- Scheduling more steering reservation at large absolute bearing is the
  strongest sampled route result: `46.035` arrival, `2.0695L` mean distance,
  and `56948/1237.1` total/mean command energy. Its cost is higher RMS
  force/moment (`51.40/761.46`) and larger joint excursions, so bearing-only
  reservation appears to over-command some already-productive lateral motion.
- Maximum lateral target offset is effectively identical (`4.293L`) across
  the three distinct successes, and relative-crossflow RMS varies only from
  `0.2290` to `0.2353`. These aggregate diagnostics do not establish the sign
  or scale for force/crossflow rejection, so this candidate does not add one.

## Policy hypothesis

Preserve the evaluated oscillator, posterior lag, correct-sign bounded bearing
residual, `30.0` command envelope, and the fastest candidate's continuous
bearing-scheduled allocation. Replace raw bearing in both the steering
residual and allocation schedule with a response-conditioned error:

```text
course_slip = lateral body velocity / (body speed + soft scale)
redirect_error = bearing - small_gain * course_slip
```

This is one compact closed-loop redirect mechanism: large uncorrected bearing
still receives extra reserved steering authority, while lateral motion already
carrying the fish toward the target releases part of that authority. It should
retain the fast initial redirect, then reduce redundant curvature and lateral
load during the long upstream traverse. It is not distance-, time-, route-,
cylinder-, or wake-phase scheduled.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish direction tracking and asymmetric rhythmic turning
source_mechanism: sensor feedback modulates a propulsive oscillator so strong turn authority is released as the observed motion aligns with the requested direction
transferable_invariant: separate persistent target-direction error from the body's already-achieved lateral response, and continuously return from redirect authority toward cruise
nontransferable_details: published CPG gains, duty ratios, species kinematics, actuator dynamics, world-frame routes, and exact vortex phases
policy_translation: use normalized body-frame velocity to subtract a bounded course-slip response from bearing, then drive both the existing steering residual and its bounded reserve schedule from that error
falsification: reject the combination if it loses target capture or leftward propulsion, arrives slower than the `49.142` fixed-reserve baseline, or fails to improve the `51.40/761.46` force/moment cost of bearing-only scheduling; changed-phase robustness remains unclaimed

## Scope of this unevaluated candidate

The new CFD result will only exist after this worker exits. The candidate is a
test of the combined response-conditioned redirect, not evidence that the
combination improves arrival, loads, saturation duty cycle, or phase
robustness.
