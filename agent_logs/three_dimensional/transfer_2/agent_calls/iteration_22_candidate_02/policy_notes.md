# Evaluated terminal course-continuity selection

## Visual diagnosis before the policy edit

- All four sampled solver examples satisfy the frozen direct-uniform still-water
  contract: `U_infinity=[0,0,0]`, no cylinders, no prewarm, and an L64 moving
  storage window.  The two v35 samples and the prefilled v36 sample have
  byte-identical `4486`-row trajectories and capture at `24.6730T` and
  `0.748684L`, with distance integral `2.348256L` and score `-0.448647`.
- The combined top-down and oblique sheets for the strongest v38 sample and
  the v35/v36 comparator were inspected from release through capture.  Both
  show self-propelled diagonal progress, a coherent alternating mid-plane
  vortex street, compact three-dimensional Lambda2 structures, and the same
  bounded terminal hook.  Their top-down keyframe sheets are byte-identical;
  the oblique sheets differ only at terminal precision.  The wake is neither a
  prewarm artifact nor evidence of passive advection or instability.
- V38 continuously carries the existing velocity-course request across
  body-axis passage only while range is inside `2.10L` and closing remains
  positive.  In coupled CFD it changes `113/4486` trajectory rows, beginning
  at `24.0570T` and `0.9254L`, with a maximum center displacement of only
  `0.00207L`.  It retains the same capture tick, zero posterior hard-stop
  occupancy, `73.473%` raw acceleration-envelope exposure, and the same
  low-load class.  Its score improves by only `0.0000364`, from
  `-0.4486466` to `-0.4486102`, because final distance improves by
  `0.0000430L`; observed distance integral actually rises slightly from
  `1.7842945L` to `1.7842991L`.
- The intended terminal-alignment mechanism does not survive the evidence.
  At capture, normalized velocity-course error increases from `0.85347` to
  `0.85567` and heading error from `0.38351` to `0.38441 rad`; recent heading
  rate falls only from `2.17957/T` to `2.17019/T`.  Peak lateral force rises
  slightly from `0.03087` to `0.03156`, while anterior rate-boundary exposure
  also rises by about `0.022` percentage point.  The sampled images cannot
  visually distinguish this terminal perturbation.
- The inherited terminal carrier experiments are consistent negative
  comparators.  Scaling both carriers below `1.60L` captures at `24.6620T`
  but worsens distance integral/score to `2.348972L/-0.449580`; scaling only
  the posterior carrier captures later at `24.6840T` and also worsens distance
  integral/score to `2.348385L/-0.448786`.  Both retain coherent visual wake
  topology, so slowing either carrier allocation is not supported as terminal
  course alignment.  No sampled keyframe sheet contains the earlier
  `0.993L` pass-and-left-exit failure; that comparison is therefore limited
  to inherited audited metrics rather than an invented visual claim.

## Policy hypothesis

Replace the prefilled v36 no-op course-veto candidate with the byte-for-byte
completed v38 terminal course-continuity policy.  This is a conservative
evidence selection, not a claim that terminal alignment improved: v38 is the
only sampled policy with a higher score than the assigned parent, it preserves
the successful carrier, route, safety filters, capture tick, and coherent 3D
wake, and its edit remains confined to the final approach.  Do not amplify its
course bridge, tune another terminal carrier fraction, or stack a new binary
veto without a held-out trajectory that can expose a new semantic behavior.

Expected post-exit evidence is deterministic reproduction of capture near
`24.6730T`, score near `-0.448610`, zero posterior hard-stop occupancy, and
the established low-load wake class.  Falsify the selection if the new
evaluation loses capture, changes the route outside the final approach, or
materially regresses distance integral, rate exposure, force, moment, or wake
coherence.  The new CFD outcome is not available to this worker and is not
claimed here.

bookshelf_consulted: true
source_domain: terminal capture control and sensor-modulated coupled-oscillator robotic-fish control
source_mechanism: preserve a propulsive traveling bend while bounded sensory course feedback remains active until the observed intercept is complete
transferable_invariant: separate body-axis passage from route completion while preserving the anterior phase anchor, posterior lag, and bounded state feedback
nontransferable_details: published gains, dimensional cadence, species-specific kinematics, prescribed paths, exact vortex phases, Strouhal targets, and task-specific routes
policy_translation: select the completed v38 body-frame course-continuity bridge as the best measured local variant, retain every carrier and safety parameter, and decline a new unevidenced primitive after its alignment hypothesis failed
falsification: do not amplify the bridge if course error, load class, and rate exposure fail to improve; reject the selected replay if capture, route locality, or coherent wake is not reproduced

## Pre-evaluation validation

- The single candidate is byte-identical to the completed v38 sample (LF
  SHA-256 `af644f1ff4c30e6622c05ba38976d83edbd7c6454c8ded5c3cc89dc9e6f01887`).
  This is evidence selection from a completed sampled rollout, not same-worker
  CFD evidence.
- The configured `.codex/agents/check-runner.toml` was invoked, but its pinned
  `gpt-5.4-mini` model is unavailable on this account.  Its three declared
  no-CFD checks were then run directly and separately.  The reusable-guidance
  check passes after removing a duplicated assigned-parent marker from the
  rendered workspace `README.md`; the exact Julia public-contract probe
  returns two finite accelerations; and the solver editable-boundary check
  passes.
- The deterministic schema audit finds all `84` direct `params.FIELD`
  references among the `86` fields returned by `target_policy_params()`.
  No formal CFD was run.
