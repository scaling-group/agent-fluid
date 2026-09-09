# Candidate wake-policy notes

## Evidence diagnosis before the policy edit

- All four sampled solver episodes and the assigned parent's completed
  step-10 episode satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm snapshot, finite moving-window
  shifts, stable dynamics, and `capture` termination. The sampled family
  captures in `19.706--20.207T`; there is no current semantic failure to infer
  from a scalar alone.
- Both rows of the strongest sampled combined sheet and the slowest sampled
  capture were inspected. Their top-down rows show self-propelled, alternating
  wakes and smooth target-directed arcs; their oblique rows retain compact
  three-dimensional Lambda2 structures through capture. The assigned parent's
  sheet preserves the same visual class. Metrics agree: peak planar-force and
  yaw-moment coefficients remain near `0.023/0.013`, maximum joint angles stay
  below about `0.61 rad`, and no collision, boundary exit, wake collapse, or
  instability precedes capture.
- The LOS-led redirect is the strongest sampled mechanism: it scores
  `-0.21598`, captures at `19.706T`, and has mean distance `2.10594L`. The
  no-lead prefill scores `-0.22712`, captures at `20.207T`, and has mean
  distance `2.11794L`. Course-gated drive relief and response release applied
  to the entire redirect remain captures but regress to `19.949T/-0.22666`
  and `19.850T/-0.22093`, respectively.
- The assigned parent's attempt to phase-scale posterior redirect curvature
  also remains a coherent capture, but regresses to `20.168T`, score
  `-0.24199`, and mean distance `2.13279L`. It does not buy meaningful command
  relief: mean absolute commands are about `(17.97,16.93) rad/T^2` versus
  `(18.20,17.02)` for the stronger LOS-led sample, while posterior near-bound
  residence is slightly higher (`33.2%` versus `32.7%`). Posterior redirect
  phase allocation therefore does not survive as a positive lesson.
- The inherited full-redirect response release reduced both anterior bias and
  posterior curvature together. Its modest regression does not isolate the
  bookshelf's burst-release invariant: releasing the whole steering channel
  also removes the posterior contribution that sustains the useful redirect.

## One-candidate hypothesis

Start from the evidenced LOS-led, half-cycle route controller. Preserve its
carrier, full signed body-frame target geometry, distance/closing allocator,
course error, line-of-sight lead, posterior redirect curvature, and smooth
command bounds. Add one reflection-invariant response gate from signed redirect
demand times normalized recent turn rate, but apply it only to the extra
anterior redirect bias. This releases the mean anterior C-bend into the
posterior-lagged beat once yaw responds without weakening or phase-scaling the
posterior redirect.

Expected signature: retain capture and both coherent visual wake rows, match or
improve the sampled `19.706T`/`2.10594L` arrival class, and avoid increasing
command residence, joint limits, or the `0.023/0.013` load class. Falsify the
mechanism if capture is lost; arrival/mean distance regresses outside the
sampled LOS family; the path develops a late outward curl; or wake, command,
joint, force, or moment histories worsen.

bookshelf_consulted: true
source_domain: biological burst turning and sensor-modulated robotic-fish CPG control
source_mechanism: response-gated release of an anterior C-bend into a posterior-lagged propulsive rhythm
transferable_invariant: add bounded curvature for observed course error, then release the transient anterior bias continuously once measured yaw responds while retaining the posterior traveling-wave contribution
nontransferable_details: published gains, dimensional burst timing, duty ratios, clock phase, species-specific kinematics and envelopes, exact vortex phases, and task-specific routes
policy_translation: form LOS-led redirect demand from normalized body-frame target and velocity observations, detect aligned response from redirect demand times recent turn rate, and gate only the anterior redirect bias within the two-joint state-feedback contract
falsification: reject if capture timing or distance integral regresses, the terminal trajectory curls away, coherent propulsion weakens, or command, joint, force, and moment limits worsen
