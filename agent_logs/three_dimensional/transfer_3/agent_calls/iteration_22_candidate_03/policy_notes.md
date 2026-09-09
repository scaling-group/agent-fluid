# Side-selective amplitude-to-phase handoff candidate

## Evidence diagnosis recorded before the policy edit

- All four sampled rollouts satisfy the frozen-flow contract: direct uniform
  `U_infinity=(0,0,0)` initialization, no cylinders or prewarm snapshot,
  finite dynamics, and capture. No failed visual sheet is present in this
  batch, so the slowest capture and the inherited high-pass miss are negative
  comparators rather than being mislabeled as sampled failures.
- The best actuator-consistent and slowest headroom-allocated combined sheets
  tell the same broad visual story. From release through capture, the top-down
  rows develop coherent body-led alternating vortex streets, while the
  oblique rows show compact three-dimensional Lambda2 structures following
  the swimmer. Both trajectories are smooth and target-directed, with
  tail-beat-scale waviness but no passive advection, wake collapse, collision,
  loop, boundary approach, or numerical instability. Their low local-flow RMS
  (`0.01809U` and `0.01837U`) agrees with that visual diagnosis.
- The assigned-parent demand-lead gate captures at `18.78799T`, scores
  `-0.14000`, and has mean distance `2.02833L`. Among the sampled candidates,
  requiring raw posterior demand and previous feasible action to remain on the
  same actuator side is decisively best: it is already closer at `6T`, keeps
  the lead through `18T`, captures at `18.67250T`, and scores `-0.13362` with
  mean distance `2.02129L`. Current-demand recruitment and instantaneous
  headroom allocation capture later at `18.79899T` and `18.83199T`.
- Inherited completed results sharpen the tradeoff. Adding an unrealized-
  demand deficit to the successful same-side gate slows capture to
  `18.98049T` and worsens mean distance to `2.04403L`; future workers should
  not suppress phase merely because the feasible action has already reached
  the current raw-demand magnitude. A full complementary handoff from
  half-cycle amplitude to phase is more useful: it captures at `18.74950T`,
  earlier than the parent, while lowering posterior near-limit occupancy from
  the fastest case's `76.14%` to `74.16%` and force/moment RMS from
  `0.01350/0.00703` to `0.01336/0.00696`. But its score (`-0.14192`) and mean
  distance (`2.02989L`) are worse, so releasing amplitude on both beat sides
  gives away some of the persistent route advantage.

## Policy hypothesis recorded before editing

Start from the fastest actuator-consistent policy, preserving its normalized
body-frame bearing and LOS-rate guidance, recoil-conditioned yaw response,
distributed C-bend, coherent carrier, response-reversing half-cycle path,
persistent same-side phase gate, fixed-norm posterior phase rotation, and
componentwise physical projection.

Retain the evaluated amplitude-to-phase handoff only on the steering-aligned
posterior stress flank. The signed product of normalized raw posterior demand
and bounded yaw-response direction identifies this flank without a clock: it
is positive when carrier acceleration already points with the requested yaw
correction and reverses twice under reflection, so the gate is invariant.
When recruited phase and aligned carrier stress would stack steering into the
same near-limit command, release amplitude continuously. On the opposing
flank, retain half-cycle amplitude because it reduces opposition rather than
stacking saturation. This tests beat-side authority allocation, not a scalar
gain change.

Support requires capture no later than the assigned parent (`18.78799T`) and
mean distance no worse than `2.02833L`, with posterior near-limit occupancy or
force/moment load below the fastest case's `76.14%` and
`0.01350/0.00703`. Falsify the mechanism if capture is lost, arrival exceeds
the replicated half-cycle bound near `18.931T`, the coherent alternating wake
weakens, or it reproduces the full-handoff route loss without material load
relief. Disturbance rejection remains unclaimed because the sampled local flow
is only about `0.018U`.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and asymmetric-flapping turning
source_mechanism: sensory feedback hands steering authority between half-cycle amplitude and posterior timing while preserving a traveling propulsive rhythm
transferable_invariant: allocate overlapping rhythmic steering mechanisms by observed beat side so they do not stack on one actuator flank while useful opposition-reducing authority remains on the other
nontransferable_details: published gains, clock phase, robot geometry, species-specific kinematics, dimensional frequency, exact vortex phase, and task-specific routes
policy_translation: use normalized body-frame yaw response, two-joint state, previous feasible action, and normalized raw posterior demand to retain the same-side phase gate and release amplitude only on the steering-aligned stress flank
falsification: reject if capture is slower than 18.78799T without material saturation or load relief, mean distance exceeds 2.02833L, or wake coherence degrades

The new candidate's CFD result is not claimed here; it becomes evidence only
after this worker exits.
