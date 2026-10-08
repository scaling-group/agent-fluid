# Candidate wake-policy diagnosis

## Evidence read before the edit

All four sampled diagnostics report direct-uniform initialization in still
water, zero imposed velocity, no cylinders or prewarm snapshot, and finite
`left_domain` termination. Their combined top-down and oblique sheets show
self-propulsion rather than advection: an alternating mid-plane vortex street
and tail-connected three-dimensional Lambda2 structures develop by about
`4T` and remain coherent through exit. The common defect is planar route
control. Every fish passes above the target and eventually crosses the upper
virtual boundary; the wake does not collapse first.

The sampled `3 deg` transient anterior course redistribution
(`c0a67102cc0a`) is the strongest raw-score route carrier. It preserves the
full lagged wave, survives to `23.260T`, and reaches `4.419L` before receding
to `6.383L`. The assigned parent's distance-scheduled amplitude relief
(`4482d3d05d9c`) is a negative controlled comparison: it reaches only
`5.126L`, recedes to `5.885L`, and exits earlier at `20.861T`, while both
joints still touch the `4.538 rad/T` velocity limit and either action remains
above 95% of the soft limit for `70.3%` of samples. The sibling `4 deg`
course-misalignment damping result (`a763085dcb98`) is independently negative,
reaching only `6.397L` before its `16.830T` upper exit. Thus neither reducing
limit-cycle amplitude nor adding approach damping is supported as the next
terminal-capture mechanism.

The informative `4 deg` approach-redistribution rollout (`27482c381d38`)
retains the coherent full wake and achieves the best sampled minimum,
`3.135L`, at `18.249T`; it then recedes to `10.210L` before exiting at
`30.113T`. At closest approach the head is approximately `(9.471,12.600)L`,
still `3.10L` above the target, with speed `0.852U`, body-frame target bearing
`-0.965 rad`, target-to-velocity course angle about `-1.410 rad`, and positive
body-frame lateral velocity about `0.367U`. The top-down row agrees: leftward
translation remains productive, but the velocity path does not rotate
downward soon enough. Its distance-only approach gate gives the transient
anterior course lever little authority until the miss is already developed;
at about `8T` and `12T`, the reconstructed course errors are already about
`-0.59` and `-0.82 rad` while distance is still `10.01L` and `6.66L`.

## Single candidate hypothesis

Use the `27482c381d38` controller as the carrier: preserve its joint-state Van
der Pol oscillator, complete posterior lag, body-frame bearing and relative-
crossflow route feedback, centerline course brake, recent-yaw term, `12 deg`
posterior mean-curvature bound, distance-gated `4 deg` anterior course
redistribution, and smooth action limit. Add one predictive interception
mechanism to the existing transient redistribution, without changing total
posterior endpoint curvature or carrier energy.

From normalized body-frame target displacement and velocity, compute closing
speed and the constant-course predicted miss distance
`abs(target x velocity) / speed`. While the fish is closing and that predicted
miss is appreciable, smoothly open the anterior course-response gate even
outside the old near-target distance window. The signed course response still
sets bend direction and releases the shift when velocity aligns; the existing
distance gate retains corrective authority after closest approach. This is a
response-gated burst redirect rather than a static bend or scalar gain edit.
It should begin rotating the productive leftward velocity downward before the
fish passes several body lengths above the target.

Falsify the mechanism if it fails to beat the sampled `3.135L` minimum or to
improve the receding upper-exit topology, if the early alternating wake or
leftward progress weakens toward the failed static-bend regime, or if joint
limit residence, peak force (`0.0337`) or peak moment (`0.0175`) materially
exceed the sampled `27482c381d38` carrier. The new CFD result is unavailable
to this worker and is not claimed as evidence.

bookshelf_consulted: true
source_domain: terminal fish capture control and response-gated burst redirection
source_mechanism: preserve the propulsive traveling wave while closing behavior and projected lateral miss trigger a bounded transient curvature redirect
transferable_invariant: when a coherent swimmer is closing quickly but its current velocity predicts a miss, route authority must act before distance alone declares the terminal regime and must release with observed course alignment
nontransferable_details: published gains, species-specific burst shapes, dimensional capture distances, source-platform kinematics, exact vortex phases, and task-specific routes
policy_translation: derive normalized closing speed and predicted miss distance from body-frame target and velocity observations, use them only to open the existing bounded anterior course-response gate, and preserve posterior lag, endpoint curvature, and oscillator energy
falsification: reject if closest approach does not beat 3.135L, the same receding upper exit persists, the full alternating 3D wake or transit progress degrades, or actuator and load excursions materially grow
