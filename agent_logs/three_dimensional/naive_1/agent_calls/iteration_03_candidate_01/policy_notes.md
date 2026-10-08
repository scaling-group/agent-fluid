# Candidate diagnosis and hypothesis

All four sampled episodes report direct uniform still-water initialization
(`U_infinity=0`) without prewarm.  The top-down and oblique sheets therefore
show self-propulsion rather than imposed advection: each policy builds an
alternating posterior wake, with the vortices and three-dimensional Lambda2
structures becoming strongest late in the episode.  The useful propulsion is
nevertheless coupled to a common failure.  Every trajectory turns past the
target bearing, curls toward increasing world `y`, and exits the upper virtual
boundary near `8.5--9.0T`.

The anterior positive-work half-cycle law is the strongest sampled result.  It
keeps a coherent wake and improves minimum distance from the seed's `12.078L`
to `11.782L`, with final distance `11.797L`; its mean world-x velocity is also
more target-directed (`-0.166U` versus `-0.108U`).  It still exits at
`y=15.202L`, after target bearing has changed from about `+0.15rad` to a large
negative value.  Posterior amplitude modulation reaches only `12.006L` and
ends at `12.205L`, while the shared anterior/posterior residual reaches only
`12.140L` and ends at `12.686L`.  Thus phase-selective steering can preserve
propulsion, but the tested amplitude/residual forms do not arrest the
wrong-way curl; merely increasing their gains would be scalar tuning and the
best law already spends about five percent of samples at each joint-rate cap.

Policy hypothesis: change the steering actuator, not the carrier gains.  Make
the anterior state-feedback oscillator dwell longer on the bend side requested
by normalized body-frame bearing and traverse the opposite side faster.  This
duty-ratio asymmetry retains both zero crossings and the inherited posterior
traveling-wave target, so it should create mean turning without the static
joint equilibrium seen in prior mean-curvature laws.  Heading-rate unloading
reduces the dwell bias while yaw is already responding.  The evaluation should
show a still-alternating wake, less upper-boundary curl after bearing crosses
zero, and a closest approach below `11.782L`; otherwise the mechanism is
falsified for this regime.

bookshelf_consulted: true
source_domain: robotic-fish CPG control and asymmetric flapping
source_mechanism: duty-ratio asymmetry for turning within a rhythmic gait
transferable_invariant: unequal residence time on the two bend half-cycles can bias turning while preserving an alternating propulsive carrier
nontransferable_details: published gains, clock-driven CPG phase, robot geometry, species kinematics, and task-specific routes
policy_translation: modulate anterior restoring frequency by observed joint side times bounded body-frame bearing with yaw-rate unloading; retain the state-derived posterior lag
falsification: reject if oscillation collapses, joint saturation materially exceeds the sampled laws, closest approach does not beat 11.782L, or the fish retains the upper-boundary-exit topology
