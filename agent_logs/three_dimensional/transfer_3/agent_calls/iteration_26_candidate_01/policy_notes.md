# Carrier-demodulated residual-allocation candidate

## Evidence diagnosis recorded before the policy edit

- All four sampled rollouts satisfy the frozen evaluation contract: direct
  uniform `U_infinity=(0,0,0)` initialization, no cylinders or prewarm, finite
  dynamics, and capture at `18.6560--18.7440T`. There is no sampled termination
  failure in this workspace. The informative comparison is therefore the best
  finite sample against the lowest-score physical-response sample and the
  assigned parent, with the inherited `1.845L` high-pass/left-exit result as
  the failure boundary.
- I inspected the combined sheets for the best finite amplitude-relief sample,
  the phase-demodulated residual sample, and the assigned parent. In every
  top-down row the fish translates under its own body wave and leaves a
  coherent alternating posterior vorticity street from release through
  capture. The corresponding oblique rows show compact paired three-dimensional
  Lambda2 structures shed behind the body, without passive advection, wake
  collapse, collision, looping, boundary exit, or instability. Local-flow RMS
  of `0.01807--0.01815U` and monotone capture progress agree with this visual
  reading; the sparse wake views do not support ranking these close allocators
  by appearance.
- The assigned-parent stress-confirmed raw-moment relief captures at
  `18.7440T`, score `-0.13364`, mean distance `2.02198L`, posterior
  acceleration-limit occupancy `75.44%`, and force/moment RMS
  `0.01343/0.00699`. The unchanged persistent same-side phase allocator
  captures at `18.6725T` with `76.11%` posterior occupancy and
  `0.01350/0.00703` loads. These outcomes lie inside the inherited identical-
  hash arrival spread of `18.6725--19.0080T`; the parent's extra stress gates
  establish neither a route-speed gain nor a material effort reduction.
- Carrier-demodulated moment modulation of posterior phase captures at
  `18.7165T`, also inside that timing spread, while lowering posterior occupancy
  to `74.14%`, action RMS to `24.46/28.56 rad/T^2`, and force/moment RMS to
  `0.01309/0.00682`. It has the cohort's highest mean distance (`2.02337L`), so
  the evidence supports load relief but not better route control. Conversely,
  raw helpful-moment relief of only half-cycle amplitude is the best finite
  sample at `18.6560T`, mean distance `2.02115L`, with the primary phase path
  intact, but its `75.74%` posterior occupancy and `0.01328/0.00691` loads do
  not match the demodulated sample's effort reduction.

## Policy hypothesis recorded before editing

Preserve the evaluated normalized body-frame bearing/LOS-rate route,
recoil-conditioned yaw response, continuous C-bend, state-feedback traveling
carrier, response-reversing half-cycle steering, persistent same-side
actuator-consistent phase gate, coefficient-norm-preserving posterior phase
rotation, and componentwise physical projection.

Test one bounded residual-allocation mechanism: estimate and subtract the
joint-phase-correlated carrier component from normalized yaw moment, then let a
helpful residual relieve only half-cycle amplitude after the primary phase
channel is already recruited and yaw error is closing. Unlike the sampled
phase-residual controller, the fluid residual cannot suppress or boost the
primary posterior phase actuator. Unlike the assigned parent, carrier moment
cannot masquerade as useful fluid response, and no additional stress-product
gate is needed to identify the already-redundant amplitude channel. The product
of the odd yaw-response direction and odd moment residual is reflection
invariant; all gates are bounded and use only normalized body/joint state.

Support requires capture no later than the replicated half-cycle bound near
`19.052T`, coherent wake in both views, posterior occupancy below `75.74%`,
and force/moment RMS no greater than `0.01328/0.00691`. A result within known
timing spread is useful only if it retains the phase-demodulated load relief;
an earlier scalar alone is unresolved. Falsify the mechanism if capture is
lost, mean route distance worsens beyond `2.02337L`, either wake view degrades,
or effort/load fails to improve over amplitude relief. No disturbed-wake
robustness is claimed from this low-flow still-water evidence.

bookshelf_consulted: true
source_domain: wake-interaction studies and sensor-modulated robotic-fish CPG control
source_mechanism: preserve a propulsive rhythmic carrier while measured fluid response modulates only a small redundant steering residual
transferable_invariant: separate slow body-frame route guidance and joint-phase carrier response from a bounded fast fluid residual, and preserve the primary rhythmic actuator while relieving only redundant authority
nontransferable_details: published gains, dimensional frequencies, species or robot kinematics, exact vortex phases, organized-wake synchronization, and task-specific routes
policy_translation: subtract the sampled two-joint phase estimate from normalized yaw moment and use its reflection-invariant alignment with recoil-conditioned yaw error to reduce only half-cycle asymmetry after persistent phase recruitment
falsification: reject if capture exceeds 19.052T, mean distance exceeds 2.02337L, coherent top-down or oblique wakes weaken, posterior occupancy is not below 75.74%, or force/moment RMS exceeds 0.01328/0.00691

The current candidate's CFD outcome is not claimed here; it becomes evidence
only after this worker exits.
