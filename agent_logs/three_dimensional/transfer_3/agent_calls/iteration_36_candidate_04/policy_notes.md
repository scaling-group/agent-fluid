# Candidate diagnosis and hypothesis

## Sampled evidence

- All four sampled rollouts use direct uniform still-water initialization with
  zero background velocity and terminate in capture at `18.6560--18.7330T`.
  The top-down rows show a continuous alternating reverse wake and a shallow,
  target-directed arc; the oblique rows show body-attached three-dimensional
  Lambda2 structures convecting behind the fish through capture. There is no
  visible passive-advection, wake-collapse, collision, exit, or instability
  failure in this sample.
- The strongest scalar sample, the actuator-consistent policy at `18.7330T`,
  and its exact-policy repeat at `18.6725T` span scores
  `-0.13142-- -0.13219` and mean distance `2.01959--2.02018L`. This same-policy
  spread is larger than the apparent timing advantage of helpful-moment
  relief (`18.6560T`), so the latter is not robust evidence for another
  instantaneous fluid-response allocator.
- The assigned prefill's joint-rate anti-windup policy captures at `18.7000T`
  with mean distance `2.02103L`, coherent wake, force/moment RMS
  `0.01333/0.00694`, and local-flow RMS `0.01809U`; all are inside or adjacent
  to the baseline repeat band. Its semantic effect is nevertheless clear:
  posterior outward-at-rate-limit action falls from `7.02--7.33%` to `0.94%`,
  posterior action RMS from `28.72--28.77` to `28.24 rad/T^2`, and posterior
  acceleration-limit occupancy from `75.19--75.46%` to `73.91%`, without
  changing the successful route class. The remaining `7.35%` posterior
  rate-limit occupancy shows that acting only after the hard boundary cannot
  prevent arrival at that boundary.

## Policy hypothesis

Keep the normalized LOS-rate C-bend, anterior state-feedback oscillator,
posterior traveling-wave lag, persistent same-side phase recruitment, command
clamps, and reverse braking exactly intact. Replace the exact-boundary
anti-windup switch with a one-sided smooth speed-headroom projection: outward
acceleration is unchanged below a normalized joint-speed onset, fades
continuously across the final part of the feasible speed envelope, and is zero
at or beyond the hard limit; acceleration opposing joint motion is never
attenuated. This tests anticipatory actuator feasibility rather than another
route gain or fluid-response signal.

Expected signature: retain capture, the shallow approach arc, and the coherent
alternating wake while reducing posterior rate-limit occupancy below `7.0%`
and outward-at-limit action below `0.94%`, without raising mean distance above
`2.02129L` or force/moment RMS above `0.01350/0.00703`. Falsify the mechanism
if capture leaves the inherited `18.6725--19.0520T` band, early propulsion or
wake spacing weakens, reverse braking is delayed, or the rate-limit occupancy
does not fall. CFD evaluation occurs after this worker exits; these are
hypotheses, not claimed outcomes.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG modulation and classical traveling-wave propulsion
source_mechanism: sensor feedback modulates a low-dimensional rhythm while retaining inter-joint wave coordination and posterior emphasis
transferable_invariant: preserve the propulsive traveling bend and apply bounded state feedback only to the infeasible residual channel
nontransferable_details: published CPG gains, clock phases, species kinematics, dimensional rates, gait envelopes, and task-specific routes
policy_translation: use normalized joint-speed headroom to fade only outward acceleration near the hard rate boundary while leaving LOS guidance, oscillator phase, posterior lag, and reverse braking intact
falsification: reject if capture or coherent self-propulsion is lost, arrival leaves 18.6725--19.0520T, mean distance exceeds 2.02129L, force or moment RMS exceeds 0.01350/0.00703, or posterior rate-limit occupancy does not fall below 7.0 percent
