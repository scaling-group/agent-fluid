# Candidate diagnosis and hypothesis

All four sampled observations confirm `uniform_direct` initialization with
background velocity `[0,0,0]` and no prewarm snapshot. In both the top-down
mid-plane and oblique Lambda2 rows, the LOS-rate failure is self-propelled and
retains an alternating three-dimensional wake, but it follows a long high pass:
minimum distance is `3.369L`, target-x crossing is near `y=12.994L`, and it
exits left at `30.12T`. The two distributed-anterior-C-bend variants preserve
the coherent wake and small local-flow RMS (`about 0.018U` streamwise) while
changing the termination to capture at `19.59T` and `19.78T`. Their different
response-demand and collision-course recruitment gates produce essentially
the same useful topology, so bounded distributed curvature is the supported
mechanism; neither exact gate has unique evidentiary support.

The stronger response-triggered winner captures at `0.7487L`, with lower
force/moment RMS than the LOS-rate failure, but its raw acceleration commands
still exceed the actuator envelope in `39.5%/71.6%` of all rows and in
`0.0%/59.2%` of rows inside `3L`. Reconstructing its normalized body-frame
geometry shows a terminal control conflict: by `18.0T`, at `1.865L`, closing
speed is `0.740U` and the constant-velocity predicted miss is only `0.332L`,
yet the route command remains `0.470 rad/T`; at capture it is saturated at
`0.500 rad/T` even though predicted miss is `0.494L`, inside the `0.75L`
capture corridor. The combined views show no wake collapse or external
advection that would justify retaining this late hard redirect.

Policy hypothesis: preserve the evaluated carrier, LOS-rate response, and
distributed C-bend exactly outside the terminal corridor. Add one continuous
safe-intercept release computed from normalized range, positive closing speed,
and constant-velocity miss distance. When all three indicate that the current
course crosses an inner capture corridor, blend both desired yaw and the
posterior mean-curvature residual toward zero, leaving the propulsive traveling
carrier; if the predicted miss grows, steering returns without a hidden stage
or clock. Center the range gate at `2L`, where the sampled winner has
already established the `0.332L` predicted miss, rather than perturbing its
successful mid-approach. Offline replay across all winner states confirms
finite outputs, bounded weights, and reflection equivariance, but it cannot
predict the changed closed-loop state or loads. Expect capture to survive with
less terminal mean turn and test earlier arrival as the score-level outcome.
Falsify on loss of capture, later arrival, larger force/moment or acceleration-
envelope occupancy, or repeated on/off route excursions near the gate.

bookshelf_consulted: true
source_domain: biological burst redirects and sensor-modulated robotic-fish CPG turning
source_mechanism: response-gated C-start release into cruise or approach
transferable_invariant: strong mean curvature should release continuously once observed geometry and motion show that the redirect has established a safe approach
nontransferable_details: species kinematics, published CPG gains, dimensional timing, exact vortex phase, and source-task routes
policy_translation: use body-frame range, closing speed, and predicted miss to blend desired yaw and mean residual curvature to zero inside an inner intercept corridor while preserving the two-joint traveling bend
falsification: reject if capture is lost or delayed, terminal loads or envelope occupancy rise, or the memoryless release chatters instead of restoring steering when miss grows
