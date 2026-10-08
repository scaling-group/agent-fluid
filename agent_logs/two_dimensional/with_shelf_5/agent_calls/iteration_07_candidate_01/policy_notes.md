# Multi-wake target-policy candidate notes

## Evidence-led visual diagnosis

- The shared prewarm sheet shows the common held fish above and downstream of
  four developed, interacting vortex streets. It is common initial-condition
  evidence and does not distinguish policies.
- The informative inherited `left_domain` failure remains near the upper-right
  boundary in all three released frames and never starts a useful traverse. It
  terminates after `16.7914` time with negative progress, final distance
  `14.251L`, and head displacement `(2.175,-0.869)L`; this continues to rule
  out a global drive increase or persistent curvature as the next edit.
- The taper-on fast samples (`solver_09b5b834b2ae`,
  `solver_a64551a56856`, and `solver_5049b3347a65`) visibly turn onto a direct
  diagonal and reach after `43.9505` time. They have mean distance `2.139L`,
  command energy `5.308e4`, and RMS lateral force/moment `49.44/701.26`.
  Mean body velocity `(-0.2471,-0.1020)` versus mean local flow
  `(-0.1342,-0.1556)` confirms substantial self-propelled upstream motion.
- The exact no-taper ablation (`solver_a520b6aa6665`) has the same six-frame
  trajectory topology and the same `43.9505` arrival. Mean distance (`2.141L`),
  command energy (`5.308e4`), RMS force (`49.45`), and RMS moment (`701.31`)
  are effectively unchanged. Thus the terminal amplitude schedule is not
  needed for the fast route or first-crossing capture.
- The inherited large-error, zero-mean posterior contrast variant
  (`solver_b2abb45b5081`) preserves the direct diagonal and capture but delays
  arrival to `46.101`, raises command energy to `5.763e4`, and raises mean
  command effort to `1250.18`. Its lower RMS force/moment (`43.93/652.21`) is a
  real load tradeoff, not a speed or effort improvement; joint-rate and
  acceleration caps remain active.

## Policy hypothesis

Promote the evaluated no-taper controller as the single candidate. It retains
the `0.55`-period, `28 deg` anterior state oscillator, bounded body-frame
bearing bias, posterior velocity lag, and target-favored posterior half-cycle
steering, while deleting two terminal scheduling parameters and the associated
distance-dependent envelope. This is a causal consolidation: the sampled
ablation already shows equal semantic success and arrival without the taper,
whereas adding a large-error contrast produces a slower, more costly route.

Expected evidence is the same direct early redirect, coherent traveling body
wake, and target capture near `43.9505` time without a terminal range mode.
Falsify the consolidation if the new rollout restores a broad dogleg, loses or
delays capture materially, or shows materially worse effort or loads than the
prior no-taper sample. Do not interpret the inherited contrast result as a
reason to tune its magnitude unless the objective explicitly prioritizes load
reduction over arrival and command effort.

bookshelf_consulted: true
source_domain: robotic-fish asymmetric CPG turning and elongated-body reactive propulsion
source_mechanism: target-favored posterior half-cycle steering on a lagged traveling bend
transferable_invariant: bounded steering asymmetry can preserve cycle-average curvature and posterior wave thrust when turn sign comes from body-frame target geometry and phase comes from observed joint state
nontransferable_details: published gains, dimensional frequencies, species envelopes, exact duty ratios, prescribed vortex phases, and source-task routes
policy_translation: retain the normalized bearing-to-curvature request and joint-state half-cycle gate under the two-joint feedback contract, while removing the unsupported range-only amplitude schedule
falsification: reject if the consolidated controller loses the direct diagonal or capture, materially delays the prior 43.9505 arrival, or worsens effort and load relative to the evaluated no-taper ablation
