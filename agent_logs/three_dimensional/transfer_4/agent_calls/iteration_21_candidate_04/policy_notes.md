# Candidate diagnosis and hypothesis

## Evidence read before editing

- All four sampled rollouts are valid direct-uniform still-water evaluations
  (`U_infinity=0`) and terminate in capture. The current prefill and samples
  `solver_378cb42ebf34` and `solver_9b4854c8a255` are byte-identical and
  trajectory-identical: score `-0.06459894`, arrival `18.01250T`, mean distance
  `1.9508226L`, and path `13.23303L`. Sample `solver_a75510758521` changes only
  the reserve-work phase reference inside `2.10L` and exactly reproduces that
  rollout, showing that the closure-qualified reserve is effectively inactive
  as a terminal stabilizer.
- Both top-down vorticity and oblique Lambda2 rows show self-propulsion from
  quiescent water, a coherent alternating traveling wake through capture, and
  no visible wake breakup or numerical instability. The route remains mildly
  curved and the body continues a pronounced lateral/yaw cycle at the capture
  circle. There is no sampled termination failure in this batch; the most
  informative negative intervention is the output-equivalent terminal phase
  partition above.
- `solver_f5d69a1ef633` applies an active alignment/yaw-qualified posterior-wave
  envelope. It preserves the two-view wake and capture while reducing path
  `13.23303 -> 13.21113L`, RMS yaw `2.06601 -> 2.05183 rad/T`, RMS force/moment
  `0.015840/0.008187 -> 0.015766/0.008151`, posterior acceleration-ceiling
  residence `66.05 -> 65.70%`, and posterior 96%-rate residence
  `6.02 -> 5.68%`. Final course alignment improves `0.06785 -> 0.18179` and
  final yaw magnitude falls `1.08915 -> 0.42001 rad/T`. The tradeoff is a small
  arrival regression `18.01250 -> 18.02349T` and lower crossing speed
  `0.89016 -> 0.85110U`; the mean-distance/score change is only
  `1.9508226/-0.0645989 -> 1.9508014/-0.0645445`.
- Across the current rollout's `394` samples inside `2.10L`, posterior
  acceleration has the same sign as body yaw rate `93.4%` of the time and is
  strongly correlated with it (`0.953`), while yaw and posterior angle are
  strongly anticorrelated (`-0.995`). The active envelope slightly softens the
  oscillation, but a symmetric reduction also gives up useful crossing speed.
  The inherited step-18/20 `-0.073525` repeats and the step-19
  `-0.064599` result agree with the inherited warning that phase-reference
  partitioning is exhausted; the actuator path itself must be conditioned.

## Policy hypothesis

Start from the sampled active posterior-wave envelope, preserving all
far/middle guidance, anterior carrier, mean steering, odd curvature mapping,
cadence, and rate governor. Add a bounded posterior-only acceleration that
opposes the residual between measured body yaw rate and the target-directed
yaw-rate request. Gate it continuously by normalized approach distance and by
residual magnitude. Unlike another symmetric amplitude reduction, this should
withdraw tail action preferentially when it reinforces excess yaw while
retaining a target-consistent turn and the propulsive rhythm.

Expected result: retain capture, pre-approach trajectory, and the coherent
two-view wake; improve final alignment/yaw and posterior ceiling residence
without losing more arrival time or crossing speed than the sampled envelope.
Falsify the candidate if it moves the trajectory before `2.10L`, loses capture,
increases mean distance or arrival materially, merely transfers saturation to
the anterior joint, or degrades either wake view.

bookshelf_consulted: true
source_domain: robotic-fish CPG control and sensor-feedback direction tracking
source_mechanism: preserve the rhythmic carrier while a measured tracking residual modulates a bounded steering actuator; combine with continuous near-target yaw damping
transferable_invariant: locomotor rhythm and target-directed turning can remain intact while feedback selectively opposes excess turning rather than uniformly suppressing propulsion
nontransferable_details: published CPG gains, oscillator clocks, robot linkage geometry, species kinematics, duty ratios, dimensional rates, and prescribed routes
policy_translation: use normalized body-frame target geometry to form the existing desired yaw rate, subtract it from observed recent yaw rate, and admit a smooth distance-gated bounded posterior brake only when the current posterior acceleration would reinforce that residual
falsification: reject if pre-approach closure changes, capture or mean distance regresses materially, crossing speed falls further without alignment benefit, saturation migrates, reflection symmetry fails, or the coherent top-down/oblique wake deteriorates

## Static validation after editing

- The new envelope and brake are identically inactive at and beyond `2.10L`.
  The brake is bounded by `6 rad/T^2`, is odd in reflected yaw/target residual,
  and its one-sided command gate cannot create a counter-stroke: it is zero
  when the posterior command already opposes excess yaw, while matching brake
  gain and command scale makes the admitted withdrawal no larger than the
  reinforcing raw command. A geometry-only reconstruction over the prior
  `394` approach samples confirms that the distance/residual request is nonzero
  and remains inside its bound; this is an activity check, not a prediction of
  the unevaluated CFD outcome.
- The deterministic static schema scan finds all `65` direct `params.FIELD`
  references in `target_policy_params()`, one public params function, one
  public policy function, balanced delimiters, and no explicit time, step,
  random, file-I/O, or mutable-global mechanism. The solver boundary check
  passes. The prescribed Julia execution check could not run because this
  worker image has no `julia` executable; formal CFD remains intentionally
  deferred to EvE.
