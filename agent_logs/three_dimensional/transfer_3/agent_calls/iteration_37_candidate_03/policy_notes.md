# Anticipatory joint-speed feasibility candidate

## Visual and metric diagnosis recorded before the policy edit

- All four sampled rollouts satisfy the frozen-flow contract: direct uniform
  `U_infinity=(0,0,0)` initialization, no cylinders or prewarm, finite
  dynamics, and capture at `18.6560--18.7330T`. I inspected the combined
  top-down and oblique sheets for the best-score exact parent, the sampled
  joint-rate anti-windup branch, and the fastest helpful-moment branch from
  release through capture. Each fish translates under its own body motion,
  establishes a coherent alternating caudal-vorticity street by `4T`, and
  sheds compact body-attached then downstream Lambda2 structures. None shows
  passive advection, growing lateral waste, wake breakup, collision, domain
  approach, or instability. The near-identical paths and low inherited
  `0.01804--0.01822U` local-flow RMS make this an actuator-feasibility test,
  not a wake-survival or route-sign intervention.
- The prefilled actuator-consistent policy is the assigned parent and appears
  in three current evaluations. It captures at `18.6725T` twice and
  `18.7330T` once, with mean distance `2.01959--2.02129L`, posterior action
  RMS `28.72--28.77 rad/T^2`, posterior acceleration-limit occupancy
  `75.22--76.11%`, and force/moment RMS no greater than
  `0.01350/0.00703`. Its score spread (`-0.13362-- -0.13142`) and timing
  spread are repeat variability, not evidence for another scalar or
  instantaneous fluid-response allocator.
- The sampled one-sided hard joint-rate anti-windup branch is the useful
  positive control. It captures at `18.7000T`, retains `0.536U` speed at `4T`
  and both coherent wakes, and lowers posterior action RMS to
  `28.24 rad/T^2` and posterior acceleration-limit occupancy to `73.97%`.
  However, inherited analysis reports unchanged rate-limit residence and
  overlapping `0.01333/0.00694` force/moment RMS. Blocking infeasible outward
  work only after the rate boundary therefore cleans the returned command but
  does not keep the joint out of saturation.
- Helpful-moment amplitude relief captures at `18.6560T`, only `0.0165T`
  ahead of the fastest exact-parent runs and inside exact-policy variability.
  Its nearly indistinguishable wake and overlapping effort/load metrics do
  not establish a physical-response advantage. The inherited terminal
  carrier-contraction result is the informative failure absent from this
  all-capture quartet: despite lower posterior occupancy/load and a coherent
  wake, it delays capture to `18.8705T`, raises mean distance to `2.04281L`,
  and shifts occupancy anteriorly. Productive carrier energy must not be
  withdrawn as a range or closing-speed schedule.

## Policy hypothesis recorded before the policy edit

Produce exactly one candidate by preserving the normalized bearing-plus-LOS
route, distributed C-bend, traveling two-joint carrier, persistent same-side
posterior phase recruitment, and componentwise acceleration limit. Replace
the boundary-only rate anti-windup idea with one anticipatory feasibility
projection: within the final normalized `4%` of joint-speed headroom, smoothly
contract only acceleration whose signed product with observed joint velocity
is positive. Acceleration away from the limit remains unchanged, and all
opposite-sign braking remains available. While this projector deliberately
attenuates a persistent outward posterior action, use the continuing raw
same-side demand as the feasible-action witness so cleanup does not silently
turn off the evaluated phase actuator.

The `4%` band is a narrow normalized scope choice, not a transferred gain or a
gain sweep. Offline replay of the projector alone on the two sampled exact
traces changes about `4.2--4.5%` of anterior rows and `8.2--8.5%` of posterior
rows, while mapping posterior action RMS from `28.72--28.77` to about
`27.96--27.97 rad/T^2`. That replay verifies locality only and does not predict
the altered CFD trajectory.

Support in a later evaluation requires capture no later than the inherited
`19.052T` route bound, mean distance no greater than `2.02129L`, coherent
self-propelled wakes in both views, force/moment RMS no greater than
`0.01350/0.00703`, posterior action RMS below `28.24 rad/T^2`, and a measurable
decrease in joint-rate-limit residence. Falsify the mechanism on lost or
delayed capture, reduced early propulsion, impaired braking or phase reversal,
weaker wake coherence, upstream effort transfer, load growth, or effort-only
cleanup with unchanged rate residence. In that case restore the sampled hard
one-sided projection rather than widening or gain-tuning the guard band. The
new candidate's CFD runs only after this worker exits and is not evidence here.

## Structured bookshelf transfer

bookshelf_consulted: true
source_domain: reactive fish-swimming theory and sensor-modulated robotic-fish CPG control
source_mechanism: preserve a directed posterior-emphasized traveling bend while bounded joint-state feedback keeps rhythmic actuation inside its feasible envelope
transferable_invariant: constraint feedback should remove only infeasible outward work and preserve the posterior-lagged carrier plus immediate reverse braking
nontransferable_details: published gains, dimensional frequencies, species or robot kinematics, full-body waveforms, exact vortex phases, hardware-specific limits, and task-specific routes
policy_translation: retain normalized body-frame LOS feedback and the two-joint phase actuator; use observed joint velocity, a parameter-owned normalized guard band, and a reflection-equivariant signed-product test to taper only outward acceleration near the rate limit
falsification: reject if capture leaves the replicated route band, either wake weakens, early speed or phase reversal degrades, load exceeds the sampled envelope, or joint-rate residence fails to fall despite the anticipatory projection
