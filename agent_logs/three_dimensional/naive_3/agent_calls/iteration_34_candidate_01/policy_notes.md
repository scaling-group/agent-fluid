# Candidate diagnosis and hypothesis

The assigned parent already establishes a captured, coherent traveling-bend
carrier with soft acceleration envelopes, phase-local speed protection,
posterior stopping-margin protection, and a target-signed measured-yaw
residual. The strongest sampled finite rollout (`solver_db2418f56ce7`) is one
of three exact replicas of that signed allocator: it captures at `16.932T`,
scores `-0.200045`, has `2.08513L` mean distance, remains below the joint-speed
limits at `258.93/259.20 deg/T`, and peaks at `0.03693/0.01835` force/yaw
moment. Its direct-uniform still-water contract is valid (`U_infinity=0`, no
prewarm, no cylinders), and peak local flow is only `0.03270U` versus
`1.391U` fish speed.

The informative contrasting rollout (`solver_292735cefd5b`) mirrors the
adverse-yaw rule onto the anterior-to-posterior transfer. It still captures
slightly earlier at `16.926T`, but worsens score to `-0.200966`, mean distance
to `2.08585L`, and crossing distance to `0.74483L`; its posterior excursion is
unchanged near `0.5992 rad`. The top-down sheets show coherent alternating
vorticity and continued target-directed self-propulsion in both cases. The
oblique rows likewise retain compact three-dimensional Lambda2 structures
through the final approach. There is no visual or metric evidence that the
mirrored load selector improves wake coherence, stability, or actuator use.
It should therefore be removed rather than elaborated.

The replicated winner's instantaneous closing geometry suggests a distinct
terminal opportunity. At about `16T`, the head is `1.936L` from the target,
closing at about `1.20U`, and its constant-course projected miss is only
`0.183L`, well inside the `0.75L` capture neighborhood. Yet the controller
continues to request target-ray mean steering while the propulsive carrier
already supplies a viable intercept. The candidate will preserve the
replicated signed allocator and introduce exactly one new control mechanism: a
continuous body-frame capture-cone gate. Only near the target, only with
positive closing motion, and only when the projected velocity line lies
comfortably inside a parameter-owned miss radius, it relieves redundant mean
steering. It never gates the carrier, safety projections, or the established
signed adverse-yaw work allocation. The expected result is capture with less
terminal curvature/work and a no-worse distance integral, while the broad
route remains identical until the near-target gate overlaps it.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish direction tracking and terminal capture scheduling
source_mechanism: continuously schedule approach authority from observed target geometry while retaining the propulsive CPG carrier
transferable_invariant: when measured closing motion is already on a collision course with the capture neighborhood, reduce redundant steering without suppressing the traveling wave
nontransferable_details: published CPG gains, robot or species kinematics, duty ratios, dimensional approach distances, and exact task routes
policy_translation: form a normalized body-frame projected-miss signal from `target_body_L` and `velocity_body_U`; combine it with distance and positive-closing gates to attenuate only the mean posterior steering request
falsification: reject if capture is lost, the alternating top-down or compact 3D wake degrades, the route changes before the terminal gate, arrival or mean distance worsens beyond the mirrored sample, joint limits return, or force/moment peaks exceed the replicated winner
