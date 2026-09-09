# Candidate diagnosis and hypothesis

## Evidence diagnosis

- All four sampled evaluations are valid direct-uniform still-water releases:
  `U_infinity=(0,0,0)`, no prewarm, no cylinders, and capture termination.
- Both rows of every combined keyframe sheet were inspected. The top-down row
  shows an alternating, coherent self-propelled wake rather than background
  advection, with a late C-shaped intercept near the target. The oblique
  Lambda2 row shows compact three-dimensional structures remaining attached to
  the traveling wake; there is no visible wake collapse, collision, or
  instability before capture.
- Metrics agree with the images. The sampled policies capture at
  `19.706--20.207T`, reduce distance from `12.328L` to about `0.747L`, and are
  stable. Two semantically identical LOS-lead/half-cycle policies span scores
  `-0.21598` and `-0.23090`, so that small scalar spread is not evidence for a
  gain-only edit.
- The inherited LOS-lead policy still arrives with a strong evolving turn:
  near `20.00T` its heading error is `-0.455 rad` while measured turn rate is
  `+0.531 rad/T`; the duplicate finishes with error `-0.539 rad` and turn rate
  `+0.389 rad/T`. The capture scaffold works, but its added redirect does not
  explicitly release when yaw is already responding. This is a plausible
  source of the visibly sharp terminal hook and a safer target than changing
  the coherent carrier.

## Policy hypothesis

Preserve the fore/aft-aware target map, distance/closing drive relief, LOS-led
velocity-course redirect, and joint-state half-cycle asymmetry. Add one bounded
response-release gate to only the extra redirect curvature: infer whether yaw
is responding in the requested direction from the product of the signed
redirect command and normalized recent turn rate, retain full redirect when
the response is absent or wrong-signed, and smoothly release part of it when
the response is aligned. This should soften the terminal hook without reducing
far-field propulsion or deleting the baseline route steering. Falsify the
candidate if it loses capture, worsens arrival or distance integral beyond the
observed repeat spread, increases joint/command-limit residence or force/moment
peaks, or disrupts top-down/oblique wake coherence.

bookshelf_consulted: true
source_domain: biological burst turning and sensor-modulated robotic-fish CPG control
source_mechanism: observed-response release of a bounded C-start-like redirect while retaining the rhythmic carrier
transferable_invariant: add curvature for a large course error, then continuously release only the extra redirect once measured yaw responds in the commanded direction
nontransferable_details: species kinematics, published CPG gains, dimensional burst timing, exact vortex phase, and task-specific routes
policy_translation: use LOS-led body-frame course error for redirect demand and normalized recent turn rate for an equivariant smooth release gate on both-joint redirect bias
falsification: reject if capture or approach integral regresses outside repeat variation, the terminal hook persists, or wake coherence, loads, joint margin, or command residence worsen
