# Candidate diagnosis and hypothesis

## Evidence read before editing

- All four sampled evaluations use direct uniform `U_infinity=(0,0,0)`
  initialization, have no cylinders or prewarm, remain numerically stable, and
  terminate by capture at `0.7480--0.7494L` after `18.20--18.75T`.
- The combined top-down/oblique sheets for the strongest finite sample
  (`intercept_guarded_speed_reserve_v1`, score `-0.15140`) and the lowest-score
  contrast with the same policy bytes (`-0.15733`) show self-propulsion rather
  than advection: a coherent alternating reverse street grows behind the fish
  from release through capture, and the oblique Lambda2 row retains bilateral
  shed structures without terminal carrier collapse. The terminal body pose
  and wake phase differ, but neither sheet supports changing cadence or
  suppressing the traveling bend.
- Trace metrics agree with the images. The two sampled baseline captures peak
  at `0.9215--0.9230L/T`, force coefficient `0.03116--0.03120`, and yaw moment
  coefficient `0.01618--0.01627`; head/tail action clipping remains about
  `68.45--68.48%/70.62--70.64%`, with speed-limit residence about
  `10.41%/11.30--11.49%`. Capture therefore coexists with a coherent wake but
  still leaves little actuator reserve.
- The sampled fixed unsafe-terminal tail-to-head steering transfer is a
  compatibility result, not an allocation improvement. It captures at
  `0.74923L` but arrives later (`18.7495T`), while head/tail clipping rises to
  `68.76%/70.75%` and speed-limit residence to `10.74%/11.62%`; its peak speed,
  force, and moment remain in the baseline envelope. Unconditional transfer is
  therefore not retained.
- The prefilled posterior wave-shape pulse captures in the current sample, but
  inherited exact-repeat evidence is `2/3`, including a coherent-wake lower
  miss at `1.2589L`. It is removed rather than gain-tuned. Other inherited
  logs record that bounded target-bearing recovery and a wider response veto
  also retained propulsion yet missed below at `1.8004L` and `1.3725L`, so the
  assigned parent's unevaluated bearing-qualifier direction does not survive
  the broader sampled evidence.

No current solver sample is a semantic failure, so the informative visual
contrast is the lowest-score exact-baseline capture; failure topology is taken
only from inherited completed evaluations whose guidance records inspection of
both wake views. This candidate does not claim its own unevaluated mechanism as
evidence.

## Policy hypothesis

Restore the repeat-backed achieved-course, intercept-guarded speed-reserve
baseline. Preserve its carrier, raw route observation, response gate, total
additive steering share, and far-field behavior. Inside the existing unsafe
terminal region only, transfer a bounded part of additive steering from the
posterior joint to the anterior joint when all of these state conditions hold:

1. normalized posterior current-speed/previous-action pressure exceeds the
   anterior pressure;
2. the requested steering acceleration would push the posterior joint farther
   along its current motion; and
3. the anterior actuator has pressure margin.

The transfer is identically zero outside the existing terminal/intercept gate,
when the posterior residual is restoring, or when the anterior is no less
burdened. This tests actuator-role separation rather than another scalar gain
or route observer. The expected useful effect is to retain posterior traveling-
wave propulsion while realizing terminal redirection with otherwise unused
anterior reserve.

bookshelf_consulted: true
source_domain: Lighthill elongated-body propulsion and closed-loop robotic-fish CPG steering
source_mechanism: posterior kinematics primarily sustain reactive thrust while bounded sensor feedback assigns anterior curvature for direction control
transferable_invariant: preserve a lagged propulsive carrier and spatially allocate only the steering residual according to observed actuator burden
nontransferable_details: published gains, species-specific envelopes, dimensional frequencies, full-body waves, exact phases, and task-specific routes
policy_translation: use normalized joint speed, previous action, body-frame interception gates, and steering direction to conserve total two-joint steering while conditionally moving burden anteriorly
falsification: reject if capture is lost or remains repeat-variable, the lower-pass branch persists, either wake weakens, far-field closure changes, or speed, clipping, force, and moment leave the sampled speed-reserve envelope

## Evaluation boundary

Formal CFD occurs only after this worker exits. A later worker should compare
exact repeats with the baseline's current mixed record, and should inspect
whether the conditional transfer actually activates during posterior-only
burden rather than judging it from score or aggregate clipping alone.
