# Posterior harmful-half-cycle notch candidate

## Evidence diagnosis

- All four sampled rollouts report direct uniform initialization with
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, and finite `left_domain`
  termination. The visible displacement is therefore self-propulsion rather
  than advection.
- I inspected both rows of the combined keyframe sheets for the strongest
  finite sample (`solver_0620d96874f3`, minimum/scored-mean distance
  `2.326/8.424L`) and the informative weaker differential-S-bend sample
  (`solver_5140ef46529a`, `2.469L` minimum), and checked the other sampled
  scores and traces. In both views the wake grows from quiescent release into a
  long, coherent alternating top-down vortex street and discrete oblique
  Lambda2 structures. It remains coherent after closest approach; neither
  wake collapse, collision, nor numerical instability immediately precedes
  failure. The body trajectory instead rotates toward the lower edge while
  continuing to shed a powered wake.
- The four sampled mechanisms occupy the same failure basin: the yaw-selected
  posterior brake reaches `2.385L`, anterior duty reaches `2.433L`, a static
  differential S-bend reaches `2.469L`, and posterior phase-lag modulation
  reaches `2.326L`; all exit low after roughly `31--32T` with final distance
  about `9.19--9.21L`. At the phase candidate's closest approach (`17.908T`)
  speed is still `0.687U` and target-ray/course error is `1.088 rad`. Inside
  `3L`, mean speed remains `0.686U` and mean absolute course error is
  `1.560 rad`; total anterior/posterior acceleration-clamp residence is about
  `0.749/0.355`. Thus more command limit or scalar drive tuning is unsupported.
- Joint phase offers a direct actuator selector: across the phase trace,
  anterior joint velocity and measured yaw rate are strongly anticorrelated
  (`r=-0.941`), and their signs disagree on `98%` of states inside `3L`.
  Consequently, when the signed lateral target error is positive, the
  `qd1<0` half-cycle is the one associated with wrong-way positive yaw. This
  supports a phase-selective authority change without using elapsed time.
- The assigned parent proposed posterior phase rather than another anterior
  duty edit. The sampled phase result is a real but non-semantic improvement;
  inherited completed logs then remain in the same `left_domain` class at
  `2.390L` and `2.684L`. The evidence closes simple radius/amplitude retuning
  and motivates a different oscillatory-authority allocation.

## Policy hypothesis

Preserve the evidenced bearing-curvature cruise controller, yaw-selected
posterior brake, and proximity-localized phase-lag modulation. Add one new
terminal mechanism: attenuate posterior traveling-wave amplitude only on the
joint half-cycle correlated with yaw away from the lateral target, and only
when normalized lateral target displacement is large and measured closing
response is failing. The opposite half-cycle remains propulsive. This should
create a bounded targetward impulse while shedding excess lateral drive,
instead of adding another persistent equilibrium bend or reducing both
half-cycles. The candidate is rejected if it loses the coherent cruise wake,
raises clamp/load residence, curls tightly, worsens mean distance, or again
produces the same lower exit without materially beating `2.326L` or forming a
target-return leg.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG control and asymmetric flapping for turning; fish-swimming terminal approach control
source_mechanism: sensory feedback selectively modulates a propulsive rhythm's harmful half-cycle while retaining useful rhythmic authority
transferable_invariant: use persistent relative geometry and response loss to gate a bounded phase-selective action rather than biasing or braking the whole gait
nontransferable_details: published gains, physical robot tail layout, clock-driven CPG phase, species kinematics, exact vortex phase, and prescribed routes
policy_translation: normalized body-frame lateral target fraction and closing speed gate a joint-state-selected posterior-wave amplitude notch on the existing two-joint phase-lag scaffold
falsification: reject on degraded far-field progress or wake coherence, increased saturation/load residence, tight curling, worse scored mean distance, or the same powered lower exit without a material closest-approach or return-leg improvement
