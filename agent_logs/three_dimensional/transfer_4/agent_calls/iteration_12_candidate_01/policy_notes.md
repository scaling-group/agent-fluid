# Low-energy posterior-wave reserve candidate

## Evidence and visual diagnosis before editing

- The four sampled solver results all satisfy the frozen flow contract: direct
  uniform still water with `U_infinity=(0,0,0)`, no cylinders or prewarm, and
  stable capture at `17.7265T`. Three policies are byte-identical to the
  assigned prefill and the fourth differs only by whitespace, so their exact
  `-0.08139542` score and `0.747287L` terminal distance establish one
  deterministic baseline rather than four mechanisms.
- I inspected the release-to-capture top-down vorticity and oblique Lambda2
  sheets for that baseline. The fish self-propels from rest, forms a coherent
  alternating mid-plane street by `3T`, retains compact three-dimensional
  posterior structures, follows a short route, and reaches the target without
  wake breakup, passive advection, collision, or out-of-plane instability.
  The current carrier, odd steering polarity, error-qualified far/middle
  route residual, and its release before approach therefore should remain.
- No termination failure is present in the sampled or recent inherited
  evidence. The most informative negative control is the assigned parent's
  progress-qualified approach-drive child. Its two views are visually
  indistinguishable from the baseline and it reaches capture on the same
  `17.7265T` step, but the extra terminal cadence raises capture speed from
  `0.898U` to `0.905U`, lowers course alignment from `0.601` to `0.587`, and
  crosses more shallowly at `0.749986L`. Mean score-distance worsens from
  `1.967391L` to `1.969622L` and score from `-0.08140` to `-0.08417`.
  Together with inherited terminal-course and posterior-relief regressions,
  this rules out another approach propulsion or steering intervention.
- The remaining visible and measured deficit is establishment of the carrier,
  not its mature wake. During the first `3T`, baseline mean speed is only
  `0.240U` and mean target-course alignment is `0.487`; the normalized
  anterior phase-plane energy proxy reconstructed from joint angle/rate and
  the public envelope rises only from about `0.11` at release to `0.26` at
  `0.5T` and `0.64` at `1.5T`. Once the carrier is established, the route and
  approach evidence is already the strongest finite result.

## One policy hypothesis

Preserve the entire sampled controller and add one bounded, state-qualified
posterior-wave reserve inside the existing drive module. Smoothly increase the
lagged posterior target only while the already computed normalized anterior
phase-plane energy is below its established envelope; make the reserve vanish
at the envelope and leave cadence, mean curvature, half-cycle steering,
route/approach gates, and both direction-selective rate governors unchanged.
This translates posterior thrust emphasis into an observed-energy recovery
mechanism rather than using elapsed time or a scalar-only global gain. It is
active at release and after a genuine carrier-energy loss, but not as a hidden
startup schedule.

Expected evidence is earlier useful translation and lower distance integral
over the first `2--3T`, followed by baseline-like path, approach alignment,
capture, and two-view wake once the reserve releases. Falsify it if the energy
gate remains materially active during the mature gait, early closure does not
improve, the posterior acceleration/rate envelope worsens without an arrival
or distance benefit, route/capture degrades, or either visual view loses the
coherent posteriorly lagged wake.

bookshelf_consulted: true
source_domain: Lighthill-style elongated-body propulsion and low-dimensional state-feedback robotic-fish oscillators
source_mechanism: posterior kinematics supply much of reactive thrust while oscillator energy feedback establishes and restores a traveling bend
transferable_invariant: allocate a bounded posterior reserve only when normalized observed carrier energy is deficient, then release it continuously once the stable traveling wave is established
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, exact vortex phases, target coordinates, task routes, and clock-driven startup schedules
policy_translation: smoothly gate extra posterior lagged-wave target by the existing anterior angle-rate phase-plane energy and leave the odd body-frame target steering path unchanged
falsification: reject if early target closure and distance integral do not improve without chronic gate activity, extra limit residence, route or capture regression, reflection loss, or degraded top-down and oblique wake coherence
