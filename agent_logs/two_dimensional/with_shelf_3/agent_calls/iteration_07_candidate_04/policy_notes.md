# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before the policy edit

- The assigned parent guidance identifies the `0.55`-period, `28 deg`
  posterior-lagged traveling bend, circular body-frame bearing filter, and
  bounded `12 deg` total-curvature schedule as the reachability scaffold. The
  inherited bearing-window-rate failure is the necessary contrast: its sheet
  shows almost no developed body wave before downstream exit, while diagnostics
  report only `0.140/0.163 rad` peak joint excursions, `8.64` mean command
  energy, displacement `(+2.175,-0.874)L`, and no approach inside `12.424L`.
  Low effort there is propulsion collapse, so this candidate does not add route
  derivatives or weaken the oscillator.
- The common prewarm sheet shows the held fish above four interacting,
  developed vortex streets. All four current released sheets instead show
  active, posterior-lagged bending, an immediate targetward redirect, compact
  diagonal self-propulsion across the wakes, and direct first entry into the
  `0.75L` capture circle. They show no collision precursor, passive downstream
  drift, late overshoot, or repeated wake-driven loss of turn sign that would
  justify force, moment, or crossflow cancellation.
- Two samples are deterministic replays of the phase-invariant
  bearing-conditioned posterior-allocation controller: both capture at
  `35.0625`, with `1.73388L` mean distance, `50,174.96` total command energy,
  `56.57` lateral-force RMS, and `793.76` moment RMS. Their identical equations
  and outcomes count as one mechanism result.
- The assigned prefill moves a small share of the fixed steering-center budget
  toward the posterior joint on the turn-congruent half-cycle. It remains
  successful and lowers force/moment RMS to `50.01/741.22`, but is slower
  (`35.431`), has worse mean distance (`1.75151L`), and spends more total
  command energy (`50,815.23`) than the simpler phase-invariant allocation.
  Thus phase-dependent center redistribution is useful load/navigation
  tradeoff evidence, not the best target policy in this sample.
- The structurally distinct strongest sample instead preserves the successful
  mean centers and strengthens only the target-helping posterior wave
  half-cycle by at most `8%`. It reaches at `32.472`, improves mean distance to
  `1.64761L`, and lowers total command energy to `46,287.66`. The cost is higher
  lateral-force and moment RMS (`68.70/931.60`), and both joints still touch the
  velocity and acceleration envelopes. This supports a transient navigation
  mechanism, not efficiency, actuator headroom, or load attenuation.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: robotic-fish CPG turning by asymmetric flapping, interpreted through elongated-body posterior reactive propulsion
source_mechanism: apply a small turn-signed asymmetry to the useful half-cycle of a directional posterior traveling wave
transferable_invariant: after persistent body-frame target error sets bounded mean curvature, joint-state phase may strengthen only the target-helping posterior half-cycle while preserving the base traveling bend and recovering it continuously at alignment
nontransferable_details: published gains, duty ratios, dimensional frequencies, species or robot kinematics, exact vortex phases, actuator envelopes, and source-task routes
policy_translation: retain the filtered bearing-to-total-curvature schedule and infer posterior wave phase from current anterior angle and velocity; multiply only the helpful posterior half-cycle by a small owned bound gated by bearing magnitude
falsification: reject if capture is lost or later than 35.0625, mean distance is not below 1.73388L, the direct diagonal topology curls or drifts downstream, or the observed force and moment increase occurs without a material arrival or distance gain

## Candidate hypothesis

Produce exactly one evidence-selected candidate by promoting the completed
half-cycle-asymmetry sample without extrapolating its gains. Persistent filtered
bearing retains sole ownership of route steering through the existing bounded
mean-curvature and `40/60 -> 35/65` allocation schedule. Current joint state
infers the posterior traveling-wave component; an owned `0.08` bound smoothly
strengthens only the turn-helping half-cycle and vanishes with target alignment.

The candidate deliberately removes the prefill's phase-dependent center
redistribution rather than combining two half-cycle mechanisms. Its expected
reference behavior is the already sampled `32.472`-time direct capture and
`1.64761L` mean distance. The downstream evaluation of this materialized
candidate remains future evidence; later workers must compare both navigation
benefit and the explicit force/moment cost.
