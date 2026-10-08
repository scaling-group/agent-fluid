# Candidate diagnosis and hypothesis

## Evidence read before editing

- The sampled rollouts satisfy the experiment contract: direct uniform still
  water at `U_infinity=(0,0,0)`, no prewarm snapshot, no cylinders, and a
  moving L64 window. The three stronger samples have byte-identical
  trajectories even though one policy adds a sign-only course-consistency
  veto. They capture at `24.6730T`, reach `0.748684L`, have mean distance
  `2.348256L`, and score `-0.448647`. The posterior pure-coast comparator
  captures later at `25.0635T`, reaches `0.749973L`, has mean distance
  `2.352216L`, and scores `-0.452083`.
- In both top-down sheets the fish self-propels along the same broad,
  target-directed arc and leaves a coherent alternating wake; the stronger
  residual policy is already at `0.9365L` by `24T`, versus `0.9855L` for pure
  coast. The oblique Lambda2 sheets show a compact three-dimensional chain of
  alternating structures without visible wake breakup or out-of-plane escape.
  The change needed is therefore local follower allocation, not replacement
  of the traveling-wave carrier or wake-disturbance rejection.
- The stronger capture still reaches the target during a strongly transverse
  terminal sweep: at capture its inertial velocity is approximately
  `(-0.371,0.637)U`, heading-rate observation is `2.180/T`, and heading error
  is `0.384 rad`. The binary course-consistency descendant produces the exact
  same CSV and keyframe hashes, so sign agreement supplies no selectivity on
  this route.
- Assigned-parent and inherited guidance bound the experiment: pure posterior
  coasting reduced follower rate occupancy while retaining capture; passing
  existing velocity-opposing steering improved arrival and mean distance but
  slightly increased exact-rate occupancy. Synthesizing reference-velocity
  follower acceleration was a concrete failure (`0.993L` minimum, left exit
  at `37.147T`) despite lower rate occupancy and low loads. The next edit must
  only attenuate an existing residual and must preserve the anterior phase
  anchor, braking reserve, coherent route, capture, zero posterior hard-stop
  occupancy, and low load class.

## Policy hypothesis

An initial continuous course-demand gate inside the posterior coast layer was
abandoned after a fixed-parent-trace audit. It changed only `2/4486` sampled
commands, both on the far approach (`8.137--12.204L`, first at `2.745T`), and
changed none in the intended terminal regime. This shows that the coast
layer's output minimum, not a missing continuous route predicate, determines
where the residual reaches the plant; keeping that proposal would have been a
nonlocal trajectory perturbation with no evidenced terminal leverage.

Instead, add one terminal approach-hold mechanism upstream of allocation.
Continuously reduce only the anterior and posterior carrier acceleration by a
small owned fraction when three normalized conditions coincide: the target is
near, measured closing remains positive, and the body-frame velocity/target
course error is large. Preserve all mean-curvature and half-cycle steering,
the anterior oscillator's state phase, posterior stroke braking, and the v35
coast residual. This addresses the visibly transverse high-yaw terminal sweep
without coasting early or synthesizing a follower/reference acceleration.

Falsification: reject the mechanism if it changes any command outside the
owned near-range gate, loses capture, delays capture beyond the pure-coast
`25.0635T` comparator, disrupts the coherent wake, reintroduces posterior
hard-stop occupancy, or increases rate occupancy or the low peak planar
force/yaw-moment class. A coupled rollout that simply delays the same sweep
without improving its course alignment is also a negative result.

bookshelf_consulted: true
source_domain: fish-swimming terminal capture and robotic-fish CPG path following
source_mechanism: continuous near-target drive relief while retaining closed-loop steering around a rhythmic carrier
transferable_invariant: preserve oscillator phase and steering while reducing excess carrier effort only under simultaneous near-range, positive-closing, and large-course-error evidence
nontransferable_details: published CPG gains, species kinematics, dimensional frequencies, prescribed paths, and exact vortex phases
policy_translation: multiply both existing carrier accelerations by one bounded hold scale derived from normalized range, closing speed, and body-frame velocity-to-target course error; leave steering and safety filters unchanged
falsification: reject if the far route changes, capture or wake coherence is lost, the same transverse terminal sweep is merely delayed, or hard-stop, rate, or load behavior regresses

## Non-CFD contract audit

- The final candidate loads and returns finite commands. On the evaluated v35
  state trace, its terminal-hold conjunction is active for `292/4486` rows and
  changes exactly those 292 commands. The first change is at `22.8305T` and
  `1.59963L`; no command outside the owned `1.60L` near gate changes.
- The sampled carrier scale remains in `[0.82,1.00]`, and the largest fixed-
  trace command difference is `4.985 rad/T^2`, well inside the owned
  `31.416 rad/T^2` acceleration envelope. This is a locality/materiality
  check only, not a claim about the unevaluated coupled CFD outcome.
