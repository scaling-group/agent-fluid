# Candidate diagnosis and hypothesis

## Assigned-parent evidence

The only sampled solver result is `solver_19f251537923`, so there is no
successful or near-miss sibling available for a cross-example comparison in
this workspace. It is nevertheless a finite, informative failure. The
diagnostics confirm direct uniform initialization in still water
(`U_infinity=(0,0,0)`), no cylinders, and a functioning moving window.

Both visual views show self-propulsion rather than advection. The top-down row
shows a coherent alternating wake and sustained forward travel, while the
oblique Lambda2 row confirms a planar vortex train without visible 3D loss of
the body or wake. Target approach initially works: distance falls from
`12.328L` to `6.138L` near `17T`. It then reverses while the fish keeps swimming
downward, ending at `10.460L` and `left_domain` at `26.147T`. Thus propulsion is
useful, but target-aligned mean yaw control does not survive the beat-scale yaw
oscillation.

The trajectory cross-check sharpens the failure. Heading oscillates at roughly
`+/-2 rad/T` while bearing grows toward `1.5 rad` near closest approach. The
unclipped policy command exceeds the `1800 deg/T^2` envelope in 3346/4754
anterior and 3656/4754 posterior samples. The inherited 2D controller is
therefore mostly tested through acceleration clipping; adding more gains to
its dense steering stack would not establish more usable authority.

## Policy hypothesis

Retain a posterior-lagged state-feedback oscillator, but put its nominal drive
inside the 3D acceleration envelope and replace the inherited multi-branch 2D
steering stack with one response-gated mean-curvature mechanism. A normalized
body-frame target angle requests a bounded mean tail bend; recent measured yaw
rate opposes and releases the request once the fish turns. This should preserve
the visible propulsive wake while producing a stable correct-sign mean turn,
instead of alternating clipped corrections. The mechanism is falsified if the
fish does not sustain decreasing distance beyond the parent's `6.138L`
minimum, if it again exits the lower boundary, if mean turn has the wrong sign,
or if action saturation remains persistent.

bookshelf_consulted: true
source_domain: robotic-fish turning and closed-loop CPG modulation
source_mechanism: bounded mean-curvature bias released by observed heading response
transferable_invariant: persistent target error biases the propulsive rhythm, while measured turn response reduces the bias to avoid overshoot
nontransferable_details: published gains, species-specific envelopes, clocked CPG phases, exact vortex phases, and task-specific routes
policy_translation: map normalized body-frame bearing and target-vector angle to a bounded tail-tangent bias, opposed by normalized recent yaw rate, around a two-joint state-feedback oscillator
falsification: reject if correct-sign mean yaw and target progress do not improve, coherent propulsion collapses, load or action clipping stays persistent, or the same lower-boundary exit recurs
