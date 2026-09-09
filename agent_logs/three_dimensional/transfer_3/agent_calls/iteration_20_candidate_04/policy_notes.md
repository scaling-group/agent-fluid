# Wake-policy candidate notes

## Evidence diagnosis before the edit

- The assigned parent is the prefilled `saturation_recruited_tail_phase_v1`
  policy. It captures from direct uniform still water at `18.79899T`, with the
  best sampled score (`-0.14330`) and mean score distance (`2.03111L`). The
  half-cycle-only, delayed prior-action gate, and always-on phase variants also
  capture, respectively at `18.93099T`, `18.89249T`, and `18.99699T`.
- In both the parent's combined top-down/oblique sheet and the weakest sampled
  always-on comparator, the fish is visibly self-propelled: an alternating,
  coherent wake grows behind the moving body from a quiescent release, and the
  body follows a smooth target-directed path rather than being advected. The
  target is approached without collision, domain exit, or a terminal loop.
  The sheets are nearly identical at their sparse keyframe cadence; the
  trajectory data resolves the parent's useful difference by `6T` and shows it
  maintaining about `0.13--0.15L` less range from `8T` through `18T`.
- Metrics support that visual reading. Local-flow RMS is only
  `0.01816--0.01843U` for all four captures. The parent retains the lower
  phase-variant load band (`0.01315` force RMS, `0.00684` moment RMS) and
  `41.54%/73.96%` anterior/posterior acceleration-limit occupancy. Thus the
  candidate should not add wake rejection, carrier effort, a static route
  bias, or near-target coasting. The controlled ablation instead says phase
  recruitment timing is the remaining useful lever: current predicted demand
  beats both continuous recruitment and recruitment delayed until the prior
  applied action is near its limit.

## Policy hypothesis

Preserve the parent's normalized body-frame LOS-rate C-bend,
response-reversing half-cycle steering, coefficient-norm-preserving posterior
phase rotation, and componentwise feasibility projection. Add one bounded
lead mechanism to the phase gate: compare current baseline posterior demand
with a one-step secant projection formed from current demand and the observed
previous applied posterior action, and recruit against the larger magnitude
only when that projection is moving farther from zero. This uses no clock or
mutable state; it should start the already successful phase response slightly
before a rising clipping flank without extending it across the falling flank.

Falsify the lead mechanism if the next evaluation loses capture, arrives no
earlier than the parent (`18.79899T`), breaks the coherent wake, exceeds the
half-cycle-only load/occupancy bounds (`0.01357` force RMS, `0.00707` moment
RMS, `44.77%/76.09%` acceleration-limit occupancy), or merely reproduces the
always-on phase trajectory. In any of those cases, retain current-demand
recruitment and do not tune the lead scalar.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and phase-lag/wave-shape steering
source_mechanism: preserve a rhythmic propulsive carrier while bounded feedback recruits phase modulation only when the observed control need appears
transferable_invariant: separate the stable traveling-wave carrier from a small state-feedback phase correction, and release that correction with the measured response
nontransferable_details: published CPG gains, clock phase, robot morphology, species kinematics, dimensional frequencies, and source-task routes
policy_translation: use normalized two-joint state, previous feasible posterior action, and current predicted posterior demand to lead the existing bounded phase gate on rising actuator demand
falsification: reject if capture or wake coherence is lost, arrival does not beat 18.79899T, or load and saturation exceed the sampled half-cycle-only bounds
