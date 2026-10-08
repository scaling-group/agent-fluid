# Lateral-load-aligned target-ray half-cycle candidate

## Evidence-led visual diagnosis recorded before the policy edit

- All four sampled rollouts satisfy the frozen direct-uniform still-water
  contract: `U_infinity=(0,0,0)`, no cylinders or prewarm, finite dynamics,
  and capture termination. The assigned prefill is the best sample at score
  `-0.19994654`, mean distance `2.08505160L`, crossing distance
  `0.74379522L`, and `16.93205T` arrival. The duplicated moment-only response
  gate reaches `-0.19997658/2.08507586L/0.74382418L`; the alternative
  minimum-composed moment/force gate reaches
  `-0.19997473/2.08507437L/0.74382240L`.
- I inspected the combined sheets for the assigned parent and the duplicated
  moment-only policy as the strongest finite and most informative weaker
  samples. In both, the top-down row shows continuous target-directed motion
  and a coherent alternating red/blue street from release through capture;
  the oblique row shows compact caudal Lambda2 structures persisting into the
  capture sphere. Neither sheet shows passive advection, a held-joint coast,
  wake collapse, collision, boundary exit, or instability. The traces support
  that diagnosis: peak fish speed is `1.39123U`, while peak sampled local flow
  is only `0.03270U`.
- The parent and both weaker response variants have the same sampled maxima:
  approximately `258.93/259.20 deg/T` joint speeds, `0.59921 rad` posterior
  angle, `0.03693` force magnitude, and `0.01835` yaw-moment magnitude. Their
  arrival differs by less than `0.00001T`. The parent's small advantage is
  therefore evidence for better placement of terminal target-ray work, not
  stronger propulsion, a new route, or a different wake regime.
- The inherited parent log established that multiplying C1 adverse-moment and
  adverse-lateral-force response gates retains all 83 useful posterior-work
  interventions and `99.64%` of the moment-gated correction magnitude while
  improving all three distance-quality measures. The new sampled minimum-gate
  variant improves the moment-only score by only `0.00000185`, whereas the
  multiplicative parent improves it by `0.00003004`. This supports treating
  weak response concurrence as a release boundary; it does not support more
  carrier gain or a symmetric steering residual.

## Single-candidate policy hypothesis

Preserve the assigned parent's zero-centered anterior oscillator, lagged
posterior carrier, full body-frame velocity-course loop, one-sided
point-consistent target-ray correction, positive-posterior-work phase gate,
dual force/moment response gate, posterior acceleration reserve, C1 command
envelope, high-onset speed guards, signed work reallocation, receiver taper,
and stopping-risk projection. Refine only the terminal response projection by
requiring that adverse body-lateral force also occupy a sufficiently lateral
direction in the normalized body-frame force vector. A C1 direction-cosine
gate reaches full authority when the lateral component is `0.80` of the total
force magnitude. Thus a carrier-thrust-dominated load cannot be mistaken for
strong steering evidence, while the established adverse-force magnitude and
yaw-moment gates remain intact.

This is a new normalized observation mechanism, not a scalar carrier or
steering-gain change. It should leave the broad route and central parts of all
three established target-ray bursts intact while softening only their
streamwise-load-dominated edges. Expect capture, the alternating 3D wake, and
the sampled joint/load envelope to persist, with score, mean distance, or
crossing depth at least as good as the parent. Falsify the mechanism if it
loses capture, changes any state outside the existing `2.25L` terminal window,
removes a correction burst, worsens
`-0.19994654/2.08505160L/0.74379522L` without a mechanical benefit, touches a
joint limit, exceeds `0.5993 rad` posterior angle or `0.0370/0.0184` loads, or
disrupts the coherent wake.

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG turning and body-frame hydrodynamic response control
source_mechanism: preserve a coupled propulsive rhythm while normalized load feedback schedules target-compatible work on a useful posterior half-cycle
transferable_invariant: add bounded corrective work only in an evidenced joint-state phase and only when the direction of measured body response distinguishes lateral steering demand from streamwise carrier loading
nontransferable_details: published gains, dimensional beat rates, species-specific envelopes, duty ratios, full-body oscillator networks, exact vortex phases, capture radius, force thresholds, and task-specific routes
policy_translation: retain the body-frame target-ray increment and existing posterior-work plus force/moment response gates; multiply only that increment by a C1 gate on adverse lateral force divided by total body-frame force magnitude before the two-joint allocation and safety layers
falsification: reject if broad-route equivalence, capture, sublimit mechanics, or alternating three-dimensional shedding is lost; if any established correction burst disappears; or if distance quality, posterior angle, or force/moment loads regress without a new semantic or mechanical benefit
```

No formal CFD is run in this worker. The candidate rollout becomes evidence
only after this worker exits.

## Non-CFD gate-overlap check after the edit

Reconstructing the parent's target-ray and response gates over the 3,079-row
sampled trace finds 82 active logged-state rows (the one-row difference from
the inherited 83-row audit is consistent with the trace recording the evolved
state). The new direction factor changes 14 of those reconstructed rows,
retains `99.5803%` of their already force/moment-gated absolute turn increment,
and never falls below `0.9024`; every reconstructed correction run remains
active. The mechanism is structurally inactive wherever the inherited
target-ray residual is inactive, including outside `2.25L`. This establishes a
small but non-inert directional projection and does not evolve the fish or
fluid or predict the unevaluated CFD outcome.
