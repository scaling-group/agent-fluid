# Candidate diagnosis and hypothesis

The sampled evidence contains three byte-identical v27 course-preview captures
and one distinct v34 posterior-coast capture; all confirm direct uniform still
water with `U_infinity=0`.  In both combined keyframe sheets, the top-down row
shows self-propelled diagonal progress with an alternating, spatially coherent
vortex street and a bounded final redirect into the capture disk.  The oblique
row independently shows compact alternating Lambda2 structures trailing the
body without a visible three-dimensional instability.  The v34 terminal hook
remains in the same useful trajectory family rather than reproducing the broad
pass-and-turn topology of the inherited velocity-barrier failures.

The scalar and state histories support the visual reading.  Relative to the
v27 sample, v34 improves score from `-0.460673` to `-0.452083` and scored mean
distance from `2.360439L` to `2.352216L` while retaining capture.  Its inherited
posterior stopping-stroke reserve keeps sampled hard-stop occupancy at zero;
peak absolute body-frame force and yaw-moment coefficients remain in the low
`0.0244/0.0337/0.0162` class.  Most importantly for the new mechanism,
posterior exact-rate occupancy falls from the v32 inherited baseline of
`5.806%` to `4.586%`.  At v34's exact-rate samples, the new guard reduces the
velocity-increasing posterior command to numerical zero rather than applying
an inward impulse.  Anterior exact-rate occupancy remains `9.282%`, consistent
with deliberately leaving the phase anchor untouched.

The candidate therefore promotes the fully sampled v34 policy over the v27
prefill.  It keeps the course-preview route and stopping-stroke reserve, then
uses posterior joint rate and command sign to taper only redundant
velocity-increasing acceleration to zero over the owned actuator band.  The
hypothesis is already supported for this fixed episode: a non-braking,
posterior-only feasibility layer can improve the realized actuator waveform
without sacrificing capture or coherent propulsion.  Its applicability
boundary is equally important: do not infer that the analogous anterior or
inward-braking filter is safe.  Two inherited dual-joint barriers reduced rate
occupancy further but changed capture into left-boundary exits after
`0.933L/0.848L` near misses.

bookshelf_consulted: true
source_domain: elongated-body reactive swimming and coupled-oscillator robotic-fish control
source_mechanism: preserve a traveling-bend phase anchor while adapting the posterior follower through observed state
transferable_invariant: actuator-feasibility feedback should preserve the direction and phase organization of the propulsive wave, with the anterior oscillator anchoring phase and the posterior joint remaining a follower
nontransferable_details: published gains, species-specific envelopes, dimensional beat frequencies, full-body waves, and prescribed vortex phases or routes
policy_translation: retain the anterior state-feedback oscillator and apply the sampled sign-symmetric coast guard only to posterior velocity-increasing acceleration, using normalized joint rate and the owned rate/acceleration envelope; no literature gain is copied
falsification: reject extension beyond this fixed episode if capture, zero posterior hard-stop occupancy, the coherent wake, or the low-load class is lost, and specifically do not generalize the mechanism to anterior or inward-braking control without new evidence
