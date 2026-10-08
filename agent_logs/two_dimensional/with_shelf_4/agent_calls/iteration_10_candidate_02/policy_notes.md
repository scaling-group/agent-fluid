# Multi-wake candidate diagnosis

## Evidence read before the edit

- The shared prewarm sheet shows the fish held above and to the right of the
  target while four developed vortex streets overlap around the second-row
  corridor. This is a common release condition, not evidence for a fixed route
  or reusable vortex phase.
- Three sampled copies of the progress-qualified incumbent reproduce the same
  finite behavior: a decisive initial redirect, a persistent alternating
  posterior-lagged bend, self-propelled upstream entry into the interacting
  wakes, and target capture after `137.357` released units. Their matching
  metrics are `4.18356L` mean distance, `-10.9139L` upstream displacement,
  `90228.38` total command energy, `0.12955` RMS relative crossflow, and
  `14.75/303.02` RMS lateral force/yaw moment. This establishes a deterministic
  common-snapshot baseline, not changed-wake robustness.
- The otherwise identical rate-only sample also reaches the target, but after
  `149.605` units with `4.35835L` mean distance, `96932.99` total energy, and
  higher RMS crossflow/force/moment (`0.13206/15.49/308.48`). Its keyframes
  retain the same broad targetward topology but redirect and enter the wake
  corridor later. This controlled comparison supports preserving positive
  closing-speed qualification of bearing-rate damping: body rotation should
  release the redirect only when it also produces targetward translation.
- The incumbent remains actively propelled rather than advected: it travels
  about `10.91L` upstream despite mean local streamwise flow `-0.0542`, and
  its keyframes retain alternating bends through the wake corridor. The route
  nevertheless contains pronounced direction changes during the initial
  redirect and later corridor entry. Anterior acceleration already reaches
  `30.846 rad/time^2` against the `31.416` cap, so another positive-half-cycle
  gain or faster gait is not supported.
- Inherited one-change extensions all retain capture but regress this route.
  Circular bearing-history averaging takes `149.853` units; a lateral-target
  residual takes `159.302`; an opposing relative-crossflow residual takes
  `154.110` while raising force/moment; and bearing-dependent posterior-lag
  suppression takes `158.147`. Two posterior half-cycle steering allocations
  independently delay capture to `172.095` and `199.980` units, the latter
  raising mean distance to `6.189L`. Avoid another broad route filter,
  unconditioned additive residual, or posterior steering allocation on this
  scaffold.

## Policy hypothesis

Make one bounded mechanism change from the incumbent. During large persistent
body-frame bearing error that has not yet produced positive target closing,
attenuate only the anterior half-cycle whose sign opposes the requested turn.
Keep the already evidenced strengthened half-cycle unchanged, so the mechanism
adds no positive-side acceleration demand at the incumbent's near-cap anterior
peak. Release the extra attenuation continuously as alignment produces closing
progress, returning exactly to the incumbent half-cycle oscillator for the
successful wake crossing and approach. Preserve instantaneous bearing,
progress-qualified bearing-rate damping, the direct normalized moment
residual, oscillator gait, posterior lag, and tail tracking unchanged.

This is a state- and response-gated redirect primitive, not a scalar-only gain
change or hidden time stage. The formal test is retained capture and upstream
translation with a shorter initial redirect or smaller distance integral and
no higher anterior acceleration peak. Falsify it if reduced counter-turn
propulsion delays or loses capture, raises mean distance or loads, destroys the
alternating bend, increases cap contact, or recreates a loop or boundary exit.
The new candidate is evaluated only after this worker exits, so these are
expectations rather than same-worker evidence.

bookshelf_consulted: true
source_domain: nonsteady fish redirect control and closed-loop robotic-fish turning by asymmetric flapping
source_mechanism: apply stronger left-right cycle asymmetry during a large unresolved redirect, then release it when observed target response becomes useful translation
transferable_invariant: large normalized body-frame target error without closing progress can gate a bounded counter-turn half-cycle attenuation while state-encoded phase and the zero-request traveling bend are preserved
nontransferable_details: published gains, dimensional beat settings, species-specific C-start envelopes, robot linkage geometry, clock phase, exact vortex phases, cylinder layout, and source-task routes
policy_translation: preserve the incumbent two-joint feedback loops and strengthened anterior half-cycle, and smoothly attenuate only the opposing anterior half-cycle as a function of absolute bearing and positive normalized closing progress
falsification: reject if capture or upstream translation is lost or delayed, distance integral or loads rise, actuator contact increases, the alternating posterior-lagged wave collapses, or a loop or boundary exit returns
