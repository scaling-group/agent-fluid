# Wake-policy candidate notes

## Evidence diagnosis

All four sampled evaluations are valid direct uniform still-water releases
(`U_infinity=(0,0,0)`) and terminate by capture in `19.162--19.398T`. The
combined sheets for the strongest finite sample (`solver_bf9554cfba28`) and
the weaker course-response sample (`solver_d9cd27837e6b`) show the same useful
topology in both views: the body self-propels rather than being advected, a
coherent alternating top-down vorticity street and three-dimensional Lambda2
structures develop behind the caudal region, the long transit is broadly
target-directed, and a smooth late hook ends in capture without collision,
domain exit, or visible wake breakdown. The scalar separation is therefore
not a distinct visual behavior class.

The two exact response-aware-policy samples (`solver_a47435301f18` and
`solver_bf9554cfba28`) span `19.338T/-0.18691/2.07622L` and
`19.162T/-0.18047/2.06924L` in capture time, score, and distance integral.
Their common early history exposes a more reproducible defect: at `0.5T` body-
frame forward speed is only about `0.0024 L/T` while lateral speed is about
`0.0917 L/T`; at `1T` forward/lateral speeds are about `0.0499/0.1891 L/T`.
Distance falls only from `12.328L` to `12.310L` by `1T`. By `4T`, forward
speed reaches `0.441--0.445 L/T` and a coherent propulsive wake is established.
Peak force/moment remain in the inherited finite class (about
`0.0254/0.0136`), but joint rates touch the `260 deg/T` hard limit and anterior
commands spend about `35.7--36.0%` of elapsed time above 90% of the smooth
command bound. This argues against a stronger/faster oscillator or a scalar
authority increase.

## Policy hypothesis

Keep the entire captured response-aware wave-handoff policy and add one
reflection-invariant startup allocation: derive a bounded steering-authority
gate from measured forward body speed `max(-velocity_body_U[1],0)`. At low
forward response, retain a nonzero steering floor but suppress most mean-bend
and half-cycle steering so the lagged two-joint carrier can establish forward
propulsion; continuously restore the inherited steering as forward speed
appears. The gate changes neither the oscillator amplitude/frequency nor the
terminal redirect, and it is inactive at established cruise speeds. Expected
evidence is greater correct-sign distance progress in the first `1--4T`
without changing the coherent capture topology or increasing rate-limit
residence, load peaks, or late path curvature. Falsify it if capture is lost,
early lateral/forward allocation does not improve beyond exact-policy spread,
or a held-out large initial bearing reveals delayed-turn understeer.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG steering and traveling-wave fish propulsion
source_mechanism: preserve a posterior-lagged propulsive rhythm while introducing target-driven turning asymmetry through observed locomotor response
transferable_invariant: separate propulsive carrier formation from steering allocation and restore steering continuously as measured forward response becomes useful
nontransferable_details: published CPG gains, dimensional gait frequencies, species envelopes, exact wake phases, and task-specific routes
policy_translation: gate the inherited body-frame target steering terms with bounded normalized forward body speed while retaining a nonzero floor and the existing two-joint state-feedback oscillator
falsification: reject if early distance progress and forward-to-lateral velocity allocation do not improve outside repeat variation, or if capture, command/rate margin, loads, wake coherence, or held-out large-bearing turning regress
