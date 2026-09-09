# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- All four sampled evaluations use direct uniform still-water initialization
  with `U_infinity=(0,0,0)`, no cylinders, and no prewarm snapshot. I inspected
  both the top-down vorticity and oblique body/Lambda2 rows in every combined
  sheet. The fish are self-propelled and retain long alternating three-
  dimensional wakes; none of the sampled failures is passive advection, wake
  collapse, or numerical instability.
- The prefilled alignment-gated carrier remains the strongest completed
  example. It reaches `2.443L` at `17.869T`, retains about `0.685U` speed there,
  then follows a powered nearly vertical track to the lower boundary at
  `31.097T`. The distance-relief comparator keeps the same coherent wake and
  route but reaches only `2.845L`. The full-direction gate (`2.494L`) and
  slip-gated phase modulation (`2.822L`) likewise preserve the lower-exit
  topology. Thus the visible miss is a course-control failure after useful
  propulsion, not evidence for changing carrier frequency, amplitude, or
  scalar terminal power.
- The assigned-parent and inherited logs further falsify more late steering
  effort as a general remedy. Closing-gated `7--12 deg` curvature reaches
  `2.729L`; a larger response-gated C-bend reaches `2.468L` but worsens final
  distance to `9.657L`; response-release reverses the useful route and reaches
  only `12.267L`; posterior half-cycle asymmetry reaches `3.661L`; a target-ray
  lead reaches `3.167L`; and a wrong-side posterior course guard reaches
  `2.697L`. None captures or changes the lower-exit class usefully.
- The strongest sampled carrier clamps anterior acceleration for `0.746` of
  logged samples but posterior acceleration for only `0.354`. The other three
  sampled traces show the same asymmetry (`0.724--0.746` anterior versus
  `0.300--0.334` posterior). Adding curvature through the already clipped
  anterior equilibrium is therefore weakly identifiable, while the posterior
  joint has measured command reserve. This supports testing control allocation
  rather than another gain or another geometric error signal.

## Policy hypothesis

Preserve the prefilled bearing/yaw steering request, `7 deg` curvature cap,
joint-state oscillator, posterior lag, alignment gate, and command limit. Add
one mechanism: sign-aware steering allocation based on the current anterior
carrier's directional command headroom. When the zero-mean carrier has room in
the acceleration direction required by the target bend, the anterior joint
keeps the parent's curvature equilibrium. When that carrier phase is already
using the relevant command reserve, continuously move only the unallocated
mean bend to the posterior equilibrium. Oscillation phase remains in measured
joint state, the allocator mirrors under lateral reflection, and no drive gain,
clock, route, world coordinate, or wake phase is introduced.

Expected evidence is the parent's coherent far-field wake with lower anterior
clamp residence and a shallower powered lower-side pass because target steering
is not repeatedly discarded at joint 1's command clamp. Falsify the mechanism
if early progress or wake coherence deteriorates, posterior clamp residence or
loads rise materially, the fish curls tightly, or it retains the same lower
exit and `2.4--2.9L` closest-approach band without a useful trajectory change.

```text
bookshelf_consulted: true
source_domain: Lighthill-style posterior reactive-thrust emphasis and sensor-modulated robotic-fish direction control
source_mechanism: preserve a traveling propulsive bend while assigning bounded steering modulation to a posterior actuator with available authority
transferable_invariant: retain the measured joint-state propulsion rhythm and route a persistent body-frame turn request through actuator headroom instead of increasing a saturated anterior command
nontransferable_details: published gains, species-specific amplitude envelopes, dimensional frequencies, robot geometry, exact vortex phases, open-loop CPG timing, and task-specific routes
policy_translation: use the signed headroom of the current anterior carrier command to split the existing bounded mean-curvature request between the anterior equilibrium and posterior mean under the two-joint state-feedback contract
falsification: reject on degraded early progress or wake coherence, wrong-sign steering, a tight curl, increased posterior clamp or load residence, no reduction in anterior clipping, or the same powered lower-boundary near miss
```

## Implemented candidate and pre-CFD sanity

The implemented candidate adds only the headroom-aware allocation described
above. It computes the zero-mean anterior carrier demand, assigns as much of the
existing curvature equilibrium as fits the command direction, and adds the
unallocated mean to the posterior equilibrium. The parent's oscillator,
curvature request, alignment gate, lagged wave, and command limit are unchanged.

Replaying the strongest completed trace's observations through both policy
maps is not a hydrodynamic rollout, but it checks activation and scale. The
allocator changes the mean absolute anterior/posterior commands by about
`0.003/0.796 rad/T^2`; total command change is about `0.357 rad/T^2` beyond
`5L` and `1.579 rad/T^2` inside `5L`. On that fixed trace, predicted clamp
fractions change from `0.745/0.354` to `0.734/0.346`, so the mechanism neither
raises the command ceiling nor merely transfers clipping to joint 2.
Synthetic reflected bearing, yaw, joint-angle, and joint-rate states produce
exactly sign-reflected finite commands. The required guidance-difference,
policy-contract, parameter-schema, and editable-boundary checks pass. Formal
CFD evaluation remains deferred to EvE.
