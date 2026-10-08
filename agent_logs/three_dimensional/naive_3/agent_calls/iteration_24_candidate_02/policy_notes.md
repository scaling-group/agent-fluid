# Soft carrier-envelope candidate

## Evidence-led visual diagnosis recorded before the policy edit

- All four sampled rollouts satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no cylinders, and no prewarm. Their combined sheets
  show a regular alternating top-down wake and compact oblique three-dimensional
  Lambda2 structures convecting behind the caudal region through capture. Peak
  body speed is `1.329--1.393U` while peak local flow is only
  `0.0315--0.0325U`, so the target approach is self-propelled rather than
  ambient advection.
- The prefilled fixed-width guard captures at `18.271T`, but joint 2 contacts
  exactly `-45 deg`; coincident whole-trace planar-force and yaw-moment peaks
  reach `0.17183` and `0.07699`. The two global stopping-risk samples capture
  at `18.276T`, remain near `-43.0 deg`, and reduce those peaks to
  `0.03716/0.01907`. The inherited logs also show that adding an in-policy
  hard clamp leaves the physical rollout unchanged: it cannot be counted as
  lower applied effort.
- The strongest sampled result adds a high-knee C1 soft shoulder before the
  same global stopping-risk projection. It captures at `16.943T`, improves
  mean distance from about `2.135L` to `2.090L`, raises peak speed from
  `1.329U` to `1.393U`, keeps joint 2 within `[-31.25,33.85] deg`, and lowers
  force/moment peaks again to `0.03609/0.01766`. Returned acceleration peaks
  are `29.85 rad/T^2`, below the owned `31.42` limit, instead of the baseline
  requests of `59.87/88.41 rad/T^2`. Its top-down and oblique sheets retain the
  useful alternating three-dimensional wake while taking a visibly different,
  more direct terminal arc.
- This positive result has a necessary boundary from the sampled inherited
  logs: a broad `0.30` linear-knee compression also removed raw clipping but
  reduced peak speed to `0.855U`, missed capture at `6.211L`, and exited left.
  Smooth bounding is not sufficient by itself; the identity region must leave
  ordinary carrier and steering structure intact.

## Policy hypothesis

Adopt the evaluated high-knee soft carrier envelope as the single candidate.
Preserve full-quadrant body-frame target/course feedback, the zero-centered
anterior state oscillator, posterior lag, near-target steering reserve, and
the target-independent kinetic stopping-margin projection. Add a C1 shoulder
to each assembled joint-acceleration request: commands below `0.80` of the
owned envelope pass unchanged, larger commands approach a `0.95` ceiling, and
the posterior viability projection remains downstream with full braking
authority. This is a mechanism transfer from clipped rhythmic control to a
bounded carrier, not scalar-only gain tuning.

The candidate should reproduce the sampled `16.943T` capture, alternating 3D
wake, zero returned-command saturation, broad posterior clearance, and no more
than `0.0361/0.0177` force/moment. Falsify the transfer if capture is lost,
arrival or mean distance regresses materially toward the `18.27T/2.135L`
family, the alternating wake weakens, either joint approaches a hard stop,
near-limit occupancy returns, or loads exceed the global-barrier baseline.

```text
bookshelf_consulted: true
source_domain: robotic-fish CPG control and classical elongated-body propulsion
source_mechanism: retain a low-dimensional state-feedback rhythm while bounding its command envelope and preserving posterior traveling-wave emphasis
transferable_invariant: a productive traveling bend can remain phase-coherent when excessive routine commands are compressed continuously while steering allocation and exceptional safety braking retain authority
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, linkage geometry, exact vortex phases, source actuator ratings, and task-specific routes
policy_translation: keep normalized target_body_L and velocity_body_U course feedback plus joint-state phase; apply a C1 acceleration shoulder expressed as fractions of the owned limit to both assembled carrier requests, then apply the posterior kinetic-margin projection downstream
falsification: reject if capture, the faster approach, alternating three-dimensional shedding, angle clearance, zero near-limit request occupancy, or the sampled load ceiling is lost
```
