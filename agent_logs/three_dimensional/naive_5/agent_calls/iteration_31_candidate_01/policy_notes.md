# Wake-policy candidate notes

## Evidence diagnosis

- All four sampled evaluations are valid direct-uniform still-water rollouts:
  `U_infinity=(0,0,0)`, no prewarm snapshot, no cylinders, and moving-window
  transport active. They all capture between `26.213T` and `26.362T` with
  terminal distances between `0.748338L` and `0.749076L`.
- Both the top-down vorticity and oblique Lambda2 rows show self-propulsion,
  not advection: a coherent alternating wake persists from release through the
  late hook into the target. The four sheets are nearly indistinguishable at
  their sampling cadence; none shows wake collapse, wasteful broad curling,
  collision, domain exit, or numerical instability. The weakest sampled score
  (`solver_730e610b0618`, `-0.616770`) is the carrier-relief test, while the
  strongest (`solver_8e7135ef9173`, `-0.616147`) changes line-of-sight side
  allocation but retains the same visible route. These are finite tie-breaks,
  not semantic improvements over the assigned parent
  (`solver_e07c5232a21a`, `-0.616154`).
- The parent trace localizes the remaining inefficiency before the terminal
  hook. At `8.00T` its normalized velocity/target cross product is about
  `+0.690` and the velocity ray misses the target by about `7.22L`, although
  folded body bearing is only `-0.061 rad`; at `16.00T` the corresponding
  values remain `+0.514`, `3.21L`, and `-0.181 rad`. Thus the bearing-triggered
  redirect is weak precisely while translational geometry reports the largest
  route error. By `22T` and `24T`, projected miss has fallen to about `1.09L`
  and `0.64L`; the coherent carrier should therefore be preserved rather than
  relieved or terminally retuned. The parent finally crosses from above-left
  at roughly `0.642L/T`, with course-error magnitude about `0.906`, confirming
  a transverse capture rather than a settled arrival.
- Sampled allocation edits, carrier relief, and the inherited step-28--30
  scalar results all preserve capture but add no new termination class or
  meaningfully different useful trajectory. This satisfies the structured
  re-consultation condition; the fish-control shelf was therefore read after
  the visual and metric evidence.

## Policy hypothesis

Add one course-acquisition mechanism upstream of the existing controller:
when translation is observable, closing is positive, normalized course error
is large, and the velocity-projected miss is well outside the capture corridor,
blend into the existing same-sign two-joint redirect even if folded bearing is
small. Retain the redirect's measured yaw/bend release, the traveling-bend
carrier, posterior capture modulation, course-priority arbitration, and every
viability projection. This is an observation-to-mechanism change rather than a
scalar gain retune. It should create one response-released early curvature
burst, align the velocity vector sooner, then become exactly inactive before
the sampled middle/terminal corridor.

Falsify the hypothesis if the candidate loses capture, disrupts the coherent
alternating wake, reaches the angle/rate/action envelope, increases force or
yaw-moment exposure, or fails to improve early distance progress/arrival with
a visibly different useful route. Also reject it if frozen-trace auditing
shows the new gate remains active once projected miss has entered the sampled
middle corridor.

```text
bookshelf_consulted: true
source_domain: biological C-start and sensor-modulated robotic-fish turning
source_mechanism: large observed route error triggers bounded curvature and measured turn response releases back into the propulsive rhythm
transferable_invariant: use observed geometric error to engage a temporary turn mode, and release on observed response rather than elapsed time
nontransferable_details: species kinematics, published gains, dimensional burst duration, exact vortex phase, and any task-specific route
policy_translation: normalized body-frame course error, projected miss, closing speed, and translation confidence gate the existing two-joint redirect; joint state and phase-rejected yaw retain its release
falsification: no earlier target-directed progress, loss of capture or wake coherence, greater actuator/load exposure, or redirect persistence inside the established middle corridor
```
