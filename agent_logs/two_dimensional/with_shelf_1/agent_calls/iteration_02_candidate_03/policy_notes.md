# Wake-policy candidate notes

## Visual and metric diagnosis

- The common held-fish sheet shows four developed, interacting vortex streets
  between the target and the released fish, so every candidate starts from the
  same asymmetric wake state. The target-blind seed visibly self-propels on a
  posterior-lagged traveling bend, but turns into a steep lower-domain exit:
  it reaches only `8.615L`, displaces its head `(-3.545,-13.300)L`, and exits
  after `50.127` released time units.
- The sampled direct-acceleration steering policy is the only semantic
  success. Its keyframes show a large initial redirect followed by coherent
  left/down swimming through the wake corridor and first entry into the
  `0.75L` target circle. It reaches in `62.304` time units with mean distance
  `2.460L`, head displacement `(-10.922,-4.153)L`, RMS relative crossflow
  `0.222`, RMS lateral force `27.25`, and RMS moment `525.79`.
- Steering placement separates that success from the two informative
  failures. Centering the original fast oscillator on a `10 deg` normalized
  target-lateral bias drives the fish initially away from the target and out
  of the domain in `13.915` time units. The assigned-parent bearing-centered,
  slower/lower-amplitude oscillator survives longer and uses less mean command
  energy, but barely approaches (`9.238L` minimum), then develops RMS relative
  crossflow `1.138`, RMS force `16749.8`, RMS moment `290421`, and terminates as
  `unstable_dynamics` at `121.517`.
- The successful controller does touch both speed and acceleration envelopes,
  so it is not evidence that saturation is harmless in general. It is,
  however, much lower-load and semantically superior to the centered variants.
  The compact evidence does not calibrate the sign or event timing of a flow,
  force, moment, or bearing-rate residual, so adding one would confound the
  mechanism that already succeeds.

## Policy hypothesis

Restore the evidenced `0.55`-period state-feedback traveling-bend carrier and
apply one smooth, bounded body-frame bearing command directly to both joint
accelerations, with a smaller posterior share. This keeps target feedback
outside the oscillator state and posterior lag instead of moving the
oscillator equilibrium. The expected outcome is the sampled useful topology:
a prompt targetward redirect, sustained left/down propulsion, finite loads,
and first crossing of the capture circle. The candidate is falsified if a
repeat loses target reach, repeats either lower-domain exit, or develops the
assigned parent's crossflow/load escalation. Future refinement should first
obtain signed histories before attempting wake or yaw-rate rejection.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop direction tracking and mean-curvature turning
source_mechanism: bounded target-error steering superposed on a posterior-lagged propulsive rhythm
transferable_invariant: persistent body-frame target error should create a bounded same-sign turning asymmetry while joint-state phase and posterior lag continue to generate propulsion
nontransferable_details: published gains, dimensional frequencies, species-specific curvature envelopes, clocked phases, exact vortex phases, and prescribed routes
policy_translation: map normalized body-frame bearing through `tanh` to additive anterior and smaller posterior joint-acceleration commands while leaving the state-feedback carrier centered and unchanged
falsification: reject if target reach is lost, the lower-domain exit returns, propulsion collapses, or crossflow and loads escalate toward the unstable centered-bias result
