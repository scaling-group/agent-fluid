# Low-speed oscillator-energy recovery candidate

## Evidence-led visual diagnosis recorded before the policy edit

- All four sampled solver evaluations satisfy the frozen direct-uniform
  contract: `U_infinity=(0,0,0)`, no cylinders, no prewarm, finite traces, and
  capture termination. They have the same policy hash, byte-identical
  trajectory, and identical combined keyframe sheet, so they constitute four
  replications of one assigned-parent behavior rather than four independent
  mechanisms. The replicated reference captures at `16.93205T`, scores
  `-0.20004481`, has `2.08513L` mean distance, and crosses at `0.74389L`.
- I inspected both rows of the replicated combined sheet from release through
  capture and compared them with the completed target-ray-rate terminal
  candidate. In both, the top-down row develops a continuous alternating
  red/blue street and shows target-directed translation; the oblique row shows
  compact three-dimensional Lambda2 structures following the caudal region
  into the capture sphere. Fish speed reaches about `1.391U` while sampled
  local flow remains below `0.033U`, so the motion is self-propelled rather
  than passive still-water advection. Neither rollout shows wake collapse,
  held-joint coasting, collision, or a boundary exit. The target-ray-rate
  candidate is nevertheless an informative control failure: its visually
  indistinguishable wake captures at `16.926T` but regresses to
  `-0.204430`, `2.08866L` mean distance, and `0.74814L` crossing distance.
- The inherited completed sequence now gives four consistent negative tests
  of terminal steering modification. Two collision-corridor steering-release
  policies score `-0.204337` and `-0.202941`, the agreement-gated yaw-rate
  increment scores `-0.200362`, and the target-ray-rate feedforward scores
  `-0.204430`, all worse than the replicated parent despite retaining capture
  and the same coherent wake. The course loop should therefore remain intact;
  another near-target steering scalar is not an evidence-backed next test.
- The parent trace instead exposes an earlier transient. At `4.004T`, head
  distance has fallen only from `12.3277L` to `12.1728L` and body speed is
  just `0.351U`; the first sheet frames likewise show only a nascent wake.
  Sustained closing and the mature alternating street appear after the
  initially small `8 deg` anterior state grows toward the established
  oscillator orbit. By `6.001T`, speed reaches `0.520U`, and the later route
  already demonstrates that the zero-centered carrier and course steering are
  useful. This supports testing state-dependent orbit recovery, not changing
  steady carrier frequency, amplitude, steering, or terminal behavior.

## Single-candidate policy hypothesis

Add one bounded low-speed oscillator-energy recovery mechanism to the
replicated parent. Form a normalized anterior phase-energy proxy from joint
angle and joint velocity. Only while measured body speed is low and the proxy
lies inside the established oscillator orbit, increase the existing
velocity-aligned Van der Pol pumping; taper the increment smoothly to zero as
either body speed or phase energy recovers. The joint state remains the only
carrier phase, and the inherited lagged posterior target converts the faster
anterior orbit formation into a traveling bend. Preserve body-frame course
steering, acceleration reserve, soft envelope, high-onset speed guards, both
base work transfers, the signed adverse-yaw residual, and stopping-risk
projection unchanged.

This is a feedback-scheduled gait-activation mechanism, not a new clock, a
fixed startup stage, or a scalar change to the steady carrier. It is also
reusable after a held-out low-speed stall because activation depends only on
normalized observed body speed and joint-state energy. Expect earlier
formation of the coherent wake and earlier distance reduction while retaining
capture and the parent's mature route. Falsify it if the alternating wake is
lost, capture or the broad route changes adversely, startup loads or limit
occupancy rise materially, the low-speed gate reactivates destructively during
turning, or arrival/mean distance fail to beat `16.932T/2.08513L`.

```text
bookshelf_consulted: true
source_domain: coupled-oscillator robotic-fish control and classical traveling-wave propulsion
source_mechanism: sensor-modulated rhythmic gait activation that preserves phase coupling and posterior wave lag
transferable_invariant: recover a propulsive oscillator orbit with bounded state feedback when both locomotor output and phase energy are low, then withdraw the extra pumping as measured motion recovers
nontransferable_details: published CPG gains, dimensional beat frequencies, species-specific amplitudes, prescribed startup duration, exact vortex phases, and task-specific routes
policy_translation: smoothly increase only the existing anterior velocity-aligned oscillator pumping from normalized body speed and joint-state phase energy; retain the lagged posterior carrier and every target and safety layer
falsification: reject if coherent alternating shedding, capture, or the mature route is lost; if startup or whole-trace actuator loads increase materially; or if arrival and mean distance do not improve beyond the replicated parent
```

No formal CFD is run in this worker. The candidate's rollout becomes evidence
only after this worker exits.

## Non-CFD gate-overlap check after the edit

Replaying only the new recovery formula over the replicated parent's 3,079
recorded states activates it in 961 samples from release through `5.660T` and
in zero samples after `6T`. Its maximum added pre-envelope acceleration is
`9.318 rad/T^2`, below one third of the inherited `31.416 rad/T^2` physical
limit, and the unchanged C1 command envelope remains downstream. This confirms
that the candidate is a behaviorally non-inert early orbit-recovery test rather
than another terminal steering or steady carrier edit. The replay does not
evolve the body or fluid and does not establish improved capture, wake, load,
or score.
