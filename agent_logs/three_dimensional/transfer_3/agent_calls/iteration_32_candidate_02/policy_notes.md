# Carrier-demodulated helpful-response relief

## Evidence diagnosis recorded before the policy edit

- All four sampled evaluations satisfy the frozen experiment: direct uniform
  `U_infinity=(0,0,0)` initialization, no prewarm, no cylinders, finite
  dynamics, and capture at `18.6560--18.6890T`. There is no failed termination
  in the assigned sample, so the informative counterexample is the slowest and
  lowest-scoring capture rather than a fabricated failure class.
- I inspected the combined keyframe sheets for the best finite sample
  (`solver_ed121cf46867`, score `-0.132185`) and the informative one-sided-
  residual sample (`solver_a0b9574d8727`, score `-0.135248`) from release to
  capture. Their top-down rows show body-led translation, continuous target
  turning, and coherent alternating vorticity by `4T`; their oblique rows show
  compact Lambda2 structures shed behind the body through closure. Neither
  view shows passive advection, growing wasteful sway, wake breakup, boundary
  approach, collision, or instability. Local-flow RMS is `0.01816U` and
  `0.01808U`, confirming self-propulsion in direct still water. The visual
  topology is therefore evidence to preserve the carrier, not evidence that
  either instantaneous moment allocator is better.
- The exact prefilled actuator-consistent policy has two current same-hash
  captures at `18.6725T`. Across them, posterior acceleration-limit occupancy
  is `75.46--76.11%`, action RMS is `24.70--24.95 / 28.77--28.85 rad/T^2`,
  force/moment RMS is `0.01331--0.01350 / 0.00693--0.00703`, and mean distance
  is `2.02018--2.02129L`. That repeat is the stable route reference.
- Helpful raw-moment amplitude relief has a favorable sampled run at
  `18.6560T`, score `-0.133208`, with `75.74%` posterior occupancy and
  `0.013277/0.006912` force/moment RMS. The inherited exact-policy repeat is
  much slower at `18.9915T`, score `-0.157720`, and mean distance `2.04616L`.
  Thus raw helping moment does not provide a replicated route benefit; its
  joint-carrier content remains a plausible confounder.
- One-sided carrier-demodulated opposing-response recruitment also fails to
  reproduce a stable effort advantage. The inherited first result reached
  `18.8980T` with `74.24%` posterior occupancy and `0.01306/0.00680` loads,
  but its next exact-policy repeat reached `18.8045T` with `75.93%` and
  `0.01352/0.00704`. The current sample reaches `18.6890T` with `75.34%`,
  action RMS `24.64/28.75`, and `0.013286/0.006917`; this is favorable against
  the worse baseline replicate but not outside the baseline/load spread.
  More opposing-response recruitment or residual-scale tuning is unsupported.

## Policy hypothesis recorded before editing

Keep the normalized body-frame bearing-plus-LOS-rate route, recoil-conditioned
yaw response, distributed C-bend, state-feedback traveling carrier,
response-reversing half-cycle steering, persistent same-side stress gate,
coefficient-norm-preserving posterior phase recruitment, and componentwise
feasibility projection unchanged. Change one response semantic: subtract the
sampled joint-phase carrier estimate from normalized yaw moment, and permit
only a helping residual to relieve at most a bounded fraction of the redundant
half-cycle amplitude as recoil-conditioned yaw error approaches closure. The
residual cannot suppress the carrier, mean-curvature route, or posterior phase
actuator. This distinguishes physical-response allocation from raw carrier
phase without another gain-only variant.

Support requires capture inside the inherited successful
`18.6725--19.0080T` band with coherent wakes in both views and no larger mean
distance than the slower baseline repeat's `2.02129L`. A reusable effort
benefit additionally requires posterior acceleration occupancy below the
lower same-hash baseline bound (`75.46%`) and force/moment RMS below
`0.01331/0.00693`. Falsify the mechanism if capture is lost, arrival leaves
the band, either wake weakens, route cost rises, or effort remains inside the
baseline spread; later workers should then avoid instantaneous yaw-moment
allocation entirely until a genuinely beat-scale response observation is
available.

bookshelf_consulted: true
source_domain: wake-interaction control and sensor-feedback modulation of rhythmic robotic-fish control
source_mechanism: preserve productive rhythmic propulsion while the smallest bounded residual channel avoids duplicating helpful fluid-induced response
transferable_invariant: retain the traveling carrier and slow normalized route loop, remove self-generated carrier content from a physical cue, and allocate only redundant steering authority using the remaining response
nontransferable_details: published gains, dimensional frequencies, robot or species kinematics, full-body waveforms, exact vortex phases, organized-wake synchronization, and source-task routes
policy_translation: keep body-frame LOS guidance and observed two-joint phase primary; subtract the sampled joint-phase moment carrier, then use reflection-invariant alignment of the residual and requested yaw response only to reduce bounded half-cycle amplitude near yaw closure
falsification: reject if capture is lost, arrival leaves 18.6725--19.0080T, either wake loses coherence, mean distance exceeds 2.02129L, or posterior occupancy and force/moment RMS do not fall below 75.46% and 0.01331/0.00693

The current candidate's CFD outcome is not available in this worker and is not
claimed as evidence; it becomes evidence only after this worker exits.
