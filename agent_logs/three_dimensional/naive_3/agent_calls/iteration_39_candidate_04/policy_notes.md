# Dual-response target-ray half-cycle candidate

## Evidence-led visual diagnosis recorded before the policy edit

- All four sampled rollouts satisfy the frozen experiment contract: direct
  uniform initialization with `U_infinity=(0,0,0)`, no cylinders or prewarm,
  finite dynamics, and capture termination. Two samples reproduce the
  one-sided target-ray policy exactly at `16.93206T`, score `-0.19999072`, mean
  distance `2.08508726L`, and crossing distance `0.74383789L`; the older
  target-signed allocator captures at `16.93205T` with
  `-0.20004481/2.08513085L/0.74389035L`.
- The strongest sampled policy is the prefilled response-gated continuation.
  It retains capture and the same `16.93206T` arrival while improving score,
  mean distance, and crossing distance again, narrowly, to
  `-0.19997658/2.08507586L/0.74382418L`. This is a replicated-route terminal
  allocation improvement, not a new termination class or wake topology.
- I inspected the combined and view-specific sheets for the strongest sample
  and the older allocator. From release through capture, both top-down rows
  show continuous target-directed translation and a coherent alternating
  red/blue street. Both oblique rows show compact caudal Lambda2 structures
  through the capture sphere. Neither has held-joint coasting, passive
  advection, collision, boundary exit, wake collapse, or instability. Peak
  fish speed is about `1.391U`, while peak sampled local flow is only about
  `0.0327U`, supporting self-propulsion rather than background transport.
- The inherited symmetric target-ray residual and point-consistent carrier
  relief are the informative failures. They preserve the visible wake and
  arrive slightly earlier, but regress to
  `-0.204430/2.08866L/0.74814L` and
  `-0.206188/2.09007L/0.74984L`, respectively. Together with the failed
  instantaneous-yaw amplifier, these results reject terminal steering relief,
  carrier suppression, and generic scalar authority as explanations for the
  remaining crossing error.
- Replay of the completed sampled trajectories sharpens the positive
  mechanism. The one-sided target-ray parent has 86 posterior-positive-work
  interventions; the response-gated continuation retains 83. Every retained
  intervention occurs while both measured normalized yaw moment and body-
  lateral force oppose the correction. The three released interventions in
  the final `0.017T` are the only samples where both responses agree, and
  removing them improves all three distance-quality measures without changing
  arrival or whole-route visuals. A second response axis is therefore
  evidenced as a release condition, not as a new route command.

## Single-candidate policy hypothesis

Preserve the prefilled zero-centered anterior oscillator, lagged posterior
carrier, full body-frame velocity-course loop, one-sided point-consistent
target-ray correction, positive-posterior-work phase gate, signed yaw-moment
response gate, posterior acceleration reserve, C1 acceleration envelope,
high-onset positive-power speed guards, signed work reallocation, receiver
taper, and posterior stopping-risk projection. Refine only the terminal
target-ray residual with response consensus: compute normalized body-lateral
force in the direction of the incremental turn request and multiply the
existing yaw-response gate by a C1 adverse-force gate. Thus target-ray work is
added only while the propulsive half-cycle, yaw moment, and lateral force all
indicate that correction remains needed; either agreeing body response releases
the residual without weakening the base course loop.

The expected result is the inherited broad route, capture, coherent
alternating three-dimensional wake, and sublimit mechanics, with a terminal
intercept at least as good as the prefill and no extra load. Falsify the
mechanism if it loses capture, changes the route outside `2.25L`, suppresses
the three established high-value correction bursts, worsens
`-0.19997658/2.08507586L/0.74382418L` without a mechanical benefit, touches a
joint limit, exceeds the sampled `0.5993 rad` posterior excursion or
`0.0370/0.0184` force/moment envelope, or disrupts the alternating wake.

```text
bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG modulation and asymmetric flapping
source_mechanism: sensor feedback schedules target-compatible work on a useful propulsive half-cycle and releases it when measured body response agrees
transferable_invariant: preserve the coupled traveling rhythm while adding bounded corrective work only during a joint-state phase that performs useful work and only while independent normalized rotational and translational responses remain adverse
nontransferable_details: published gains, dimensional beat rates, species-specific envelopes, duty ratios, full-body oscillator networks, exact vortex phases, capture radius, and task-specific routes
policy_translation: retain the bounded body-frame target-ray increment and posterior positive-work gate; multiply its existing adverse normalized-yaw-moment response gate by a C1 adverse body-lateral-force gate before the two-joint allocation and mechanical-safety layers
falsification: reject if broad-route equivalence, capture, sublimit joints, or alternating three-dimensional shedding is lost; if useful sampled interventions are suppressed; or if score, mean/crossing distance, posterior angle, or force/moment loads regress without a new semantic or mechanical benefit
```

No formal CFD is run in this worker. The candidate rollout becomes evidence
only after this worker exits.

## Non-CFD gate-overlap check after the edit

Replaying only the new force-response projection over the sampled prefill's
3,079 recorded states retains all 83 existing phase/moment-gated target-ray
interventions. The force gate is fully open for 47 and smoothly attenuates 36
low-force edge samples; it preserves `99.64%` of the prior total absolute turn-
request increment and leaves the three high-value correction bursts unchanged.
Every retained sample has force opposing the increment, and no sample at or
beyond `2.25L` changes. This establishes a non-inert secondary response test
with substantial inherited overlap. It does not evolve the fish or fluid and
is not evidence for the unevaluated candidate's CFD outcome.
