# Wake-policy candidate notes

## Evidence diagnosis

- The shared prewarm sheet shows the common held fish above four developed,
  interacting vortex streets; it is initial-condition evidence, not support for
  a candidate-specific phase rule.
- The three functionally identical `0.158830` samples show the same released
  topology: a zero-centered traveling bend drives a self-propelled diagonal
  transit into the useful wake region, followed by a large but productive
  lateral correction into the target. This interpretation agrees with
  `-11.055L` head displacement in x, mean body velocity x about `-0.241U`
  versus mean local flow x `-0.174U`, and `target_reached` at `45.612` with
  `1.722L` mean distance. Their identical outputs establish deterministic
  materialization under one prewarm snapshot, not robustness.
- The sampled all-sign course-feedback gate is visually almost
  indistinguishable, but the metrics reject it as a useful load gate: arrival
  regresses to `45.837`, mean distance to `1.730L`, and force/moment RMS rises
  from `453/4406` to `460/4433`. Its mistake is suppressing corrective
  posterior de-emphasis when bearing is getting worse as well as suppressing
  optional amplification when bearing is improving.
- The inherited step-11 positive-only course-gate result supplies the sharper
  boundary: it retains `target_reached`, arrives at `45.100`, holds mean
  distance to `1.723L`, and lowers force/moment RMS to `414/4104`, although its
  score `0.157432` does not beat the assigned parent's `0.158830`. This is a
  mixed but mechanism-level improvement worth isolating from another scalar
  gait edit.

## Policy hypothesis

Preserve the base traveling bend, target steering, normalized positive-closure
residual, and full negative course correction. Apply the existing normalized
yaw-magnitude gate only to the positive part of the bounded course-convergence
signal. Thus strong wake/body yaw can remove optional tail amplification while
course divergence still earns the full reduction of that small posterior
residual. Reject the mechanism if capture is lost, mean distance worsens
without a material load benefit, or the current diagonal topology changes into
the prior lower exit/collision family.

bookshelf_consulted: true
source_domain: wake interaction and sensor-modulated robotic-fish CPG control
source_mechanism: preserve the propulsive rhythm while applying the smallest bounded residual to separate route correction from fast wake-induced loading
transferable_invariant: remove optional propulsive effort under strong observed yaw without disabling feedback that corrects a worsening body-frame route
nontransferable_details: published gains, species-specific gait envelopes, exact vortex phases, cylinder coordinates, and task-specific routes
policy_translation: use normalized bearing times bearing-window rate to split improving from worsening course feedback, and apply the existing absolute normalized yaw-moment gate only to positive posterior amplification; leave the base two-joint wave and negative course suppression intact
falsification: reject if target capture or upstream propulsion is lost, if mean distance degrades without lower force/moment burden, or if load symptoms persist without the inherited arrival benefit
