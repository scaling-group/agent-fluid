# Multi-wake target-policy candidate notes

## Inherited evidence diagnosis

- The assigned parent guidance describes a fresh lineage whose naive seed has
  joint-state propulsion but no target observation. No separate inherited
  optimizer notes are present in this workspace, so the sampled seed rollout
  `solver_a328086a43ca` is the only completed candidate evidence.
- The common held-fish prewarm sheet shows a developed, interacting
  four-cylinder wake and the fish initially outside its main core. The released
  sheet then shows the fish pitching nose-down almost immediately and following
  a steep, nearly monotone descent while its joints continue beating. It never
  enters the useful target/wake corridor; domain exit, rather than collision or
  numerical instability, ends the rollout.
- The metrics support that visual diagnosis: release lasts only `50.1269`, head
  displacement is `(-3.5452, -13.3003)L`, mean translation is dominated by
  lateral/downward velocity (`-0.2633` in y versus `-0.0725` in x), target
  progress is only `0.0243`, and distance improves transiently to `8.6150L`
  before ending at `12.1226L`. Both joints reach the `260 deg/time` velocity
  cap and `1800 deg/time^2` acceleration cap, alongside RMS lateral force
  `21.94` and RMS moment `541.70`. This is active target-blind propulsion plus
  uncontrolled yaw/advection, not weak propulsion that warrants more drive.
- The sampled result is the sole candidate sheet, so there is no positive
  policy example to rank against it. The shared prewarm supplies the common
  finite initial-condition comparison; it is not treated as evidence that a
  second policy succeeds.

## Policy hypothesis

Preserve the seed's joint-state traveling bend, but center it on a bounded
mean curvature obtained from the body-frame target bearing. Split the mean
curvature across the two incremental joints while retaining the posterior
anti-phase/lag term, so steering does not replace propulsion. Use an oscillator
period/amplitude combination whose nominal speed and acceleration fit within
the documented envelope, and soft-limit both acceleration commands so this
mechanism is tested without the seed's persistent hard clipping.

Expected evidence after evaluation: the fish should reverse the early
nose-down divergence as target bearing changes, remain inside the domain
longer than `50.1269`, and improve mean/final distance without new collision or
unstable termination. Reject the mechanism or revisit its sign if the same
monotone downward topology persists; reduce curvature authority if it creates
an alternating oversteer trajectory or destroys posterior wave propagation.

bookshelf_consulted: true
source_domain: robotic-fish direction tracking and classical fish turning by tail-beat mean bias
source_mechanism: sensor-driven target error modulates bounded mean curvature around a propulsive rhythm
transferable_invariant: persistent body-frame target-bearing error should create a bounded average bend while the posterior joint preserves a lagged traveling component
nontransferable_details: published gains, species and robot geometry, dimensional beat frequencies, full-body envelopes, exact wake phase, and task-specific routes
policy_translation: map normalized body-frame bearing through a smooth saturation to a total curvature bias, split it across the two joint equilibria, and retain state-only oscillation plus posterior lag
falsification: reject or reverse the translation if bearing feedback preserves the seed's downward domain exit; reduce or replace it if target progress improves only through hard saturation, thrust collapse, collision, or unstable load growth
