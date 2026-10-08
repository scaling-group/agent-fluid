# Wake-policy candidate notes

## Evidence diagnosis

- All four sampled rollouts satisfy the direct-uniform still-water contract and
  capture at the same `23.4410T` / 4,262-step sample. The top-down and oblique
  sheets show self-propelled target approach with a coherent alternating 3D
  wake; no sampled failure is available, and the useful comparator is the
  replicated lower-scoring full-observer capture.
- The prefilled terminal route handoff preserves the full observer's `6/3/2/1L`
  crossings (`15.3065/20.1410/21.6755/23.1055T`) and improves score, scoring
  mean distance, and final distance from
  `-0.501691/2.399184/0.746948L` to
  `-0.501134/2.398743/0.746369L`. This is a sub-step terminal-path change, not
  a new trajectory or arrival class.
- The trade is not a clean stabilization improvement. Inside `3L`, mean
  absolute yaw rises from `1.68733` to `1.68837 rad/T` and mean target-line
  cross-track speed from `0.22592` to `0.22619U`; peak moment rises about
  `3.1%`, from `0.013886` to `0.014319`. Joint-speed and projected-command
  exposure are unchanged. The largest moment occurs near `1.217L`, while the
  fish remains strongly target-closing; near capture its radial fraction stays
  positive even as cross-track motion grows.
- Inherited guidance establishes the carrier, same-sign redirect, smooth
  component projection, split observer, target-progress cadence reserve, and
  stabilization-envelope reserve handoff as useful. It rejects another scalar
  route-handoff variant, fast-signal gate, moment lead, raw-slip substitution,
  posterior relief, and command-boundary speed recovery.

## Candidate hypothesis

Keep the prefilled route observer/handoff, propulsive carrier, posterior lag,
steering allocations, terminal stabilizers, and smooth command projection.
Add one new approach mechanism: after `1.5L`, continuously reduce the whole
carrier frequency by at most `8%`, qualified by positive target-radial motion
and swimmer-speed confidence. This is a near-capture glide, not a larger or
smaller global cadence gain: far/middle behavior is exactly unchanged, base
steering remains active, and poorly aligned or near-stationary motion cannot
coast. The expected benefit is lower late command/load pressure and less
cross-track growth while inertia carries the already-established targetward
motion through capture.

Falsify the candidate if CFD changes any pre-`1.5L` trajectory, loses capture,
delays arrival by more than one `0.0055T` sample, worsens mean/final distance,
or fails to reduce the prefill's terminal peak moment and command/speed
exposure without disrupting the coherent alternating wake.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG control and terminal target capture
source_mechanism: sensor feedback continuously modulates rhythmic drive while preserving the oscillator's state-defined phase; excess drive is withdrawn only on an established near-target approach
transferable_invariant: preserve the traveling bend and steering coordinates while a bounded observation-qualified approach gate reduces propulsion demand
nontransferable_details: published CPG gains, clock phases, species kinematics, dimensional cadence, exact vortex timing, and source-task routes
policy_translation: use normalized distance, body-frame target-radial velocity fraction, and swimmer-speed confidence to taper only carrier frequency near capture; retain both joint feedback and all steering
falsification: reject if early progress changes, capture or wake coherence regresses, or terminal yaw, cross-track motion, load, and actuator exposure do not improve jointly enough to justify any arrival cost
