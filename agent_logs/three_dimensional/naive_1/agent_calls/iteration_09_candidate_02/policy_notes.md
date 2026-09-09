# Candidate diagnosis and hypothesis

The four sampled evaluations satisfy the direct-uniform still-water contract
(`U_infinity=[0,0,0]`, no prewarm) and all capture. The strongest finite sample,
the terminal body-lateral-velocity lead, captures at `0.7470L` in `19.019T`
with mean distance `2.1154L`. The most informative failure-to-improve sample,
the progress-qualified release, captures at `0.7492L` in `19.168T` with mean
distance `2.1259L`. Their combined sheets show the same physical class: genuine
self-propulsion, a target-directed trajectory, a coherent alternating
top-down vortex street, and compact paired caudal Lambda2 structures. There is
no collision, domain exit, or visible wake breakdown before capture.

The metrics narrow the opportunity. Across the sampled family, joint-rate
contact remains about `11.1--11.3%` anterior and `14.3--15.0%` posterior, while
the projected policies keep public acceleration at `31.416 rad/T^2`. Loads and
head-sampled flow are also closely matched. The strongest sample's terminal
body-lateral speed and target-side fraction alternate with the tail beat, so
its instantaneous slip lead acts partly as an implicit phase modulation; its
small score/timing difference does not isolate a reusable terminal predictor.
The inherited negative result for a line-of-sight transverse-velocity residual
also warns against giving instantaneous course error authority over the route.

Policy hypothesis: retain target geometry as the persistent route authority,
the opposite-sign anterior/posterior mean-curvature package, yaw-based bounded
release, and exact final acceleration projection. Remove the terminal slip
lead and add one explicit half-cycle steering allocation: use normalized
posterior joint displacement to strengthen posterior mean curvature on the
half-cycle already aligned with the requested turn and relax it on the
opposing half-cycle. This should preserve the propulsive carrier while making
useful steering hydrodynamically coherent instead of letting beat-scale
lateral velocity perturb route magnitude.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning and asymmetric flapping
source_mechanism: target-conditioned half-cycle amplitude asymmetry
transferable_invariant: allocate a bounded extra share of steering to the observed beat half-cycle whose bend already agrees with the requested turn
nontransferable_details: published gains, clock phase, robot geometry, species kinematics, dimensional frequency, and task-specific route
policy_translation: normalize posterior displacement by the owned oscillator amplitude; multiply only the posterior target-side curvature share by a bounded alignment gate while body-frame target geometry retains sign authority
falsification: reject if capture is lost, arrival or mean distance is not meaningfully better than the sampled capture band, the alternating wake loses coherence, or joint-rate contact and loads materially worsen

Dry contract probes confirm finite envelope-bounded outputs for both target
sides and exact sign reversal under a mirrored target, joint state, and yaw
rate. No CFD result is claimed here; capture and wake effects remain the next
evaluation's falsification test.
