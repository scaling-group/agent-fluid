# Low-crossflow load-backup pose candidate

## Completed evidence and visual diagnosis before editing

- All four sampled rollouts are finite `capture` episodes from direct uniform
  quiescent initialization with `U_infinity=(0,0,0)`, no cylinders, and no
  prewarm.  Three byte-identical v38 rollouts reproduce score `-0.12649962`,
  capture at `18.232491 T`, total/observed distance integrals
  `2.012983/1.399804 L`, and final distance `0.749906 L`.  The v39 flow/load
  comparator captures `0.033001 T` earlier but has worse score `-0.12946617`
  and worse total/observed integrals `2.015906/1.402567 L`; its slightly deeper
  final sample does not compensate for the route-integral regression.
- I inspected the combined sheets from release through capture for a complete
  v38 reproduction (`solver_6536c01c9e7e`) and the v39 comparator
  (`solver_695764c2c201`), including both the top-down mid-plane vorticity row
  and oblique body/Lambda2 row.  Both fish visibly self-propel from still water
  along nearly identical smooth target-signed arcs.  Compact startup
  structures develop into a coherent alternating posterior vortex street in
  the top-down view and discrete three-dimensional Lambda2 structures in the
  oblique view.  Neither rollout shows passive advection, wake collapse,
  collision, domain exit, or numerical instability.  One of the other three
  v38 reproductions has an all-black oblique row, an evidence-rendering failure;
  the two complete reproductions establish that the policy itself retains the
  organized 3D wake.
- The trajectory and load traces reveal a semantic tradeoff that the terminal
  image cannot resolve.  Relative to v38, v39 is closer by `0.0016/0.0080 L`
  at `2/4 T`, then farther by `0.0263/0.0422/0.0619/0.0384/0.0101 L` at
  `6/8/10/12/14 T`, and closer again by `0.0102/0.0276 L` at `16/18 T`.
  Its maximum speed rises from `0.9519` to `0.9613 L/T`; acceleration-limit
  residence falls slightly from `41.54%` to `41.37%`, peak normalized force is
  unchanged at `0.03068`, and peak moment falls from `0.01579` to `0.01558`.
  Thus the extra load cue has a bounded late benefit but no route-integral or
  load-envelope advantage that justifies admitting it everywhere.
- V38's crossflow-only band-pass confidence averages `0.836/0.809/0.691` over
  `0-4/4-14/14-capture T`.  V39's soft union with lateral-load confidence
  raises those averages to `0.968/0.985/0.976`, effectively erasing the
  intended distinction between low/moderate carrier-coherent flow and large
  disturbance-like crossflow.  This matches the v39 middle-route regression:
  only `21.5%` of v38 middle-route samples have crossflow below the confidence
  peak, versus `64.4%` early and `67.8%` late.

## One-candidate policy hypothesis

Preserve v38's state-feedback traveling wave, posterior lag, completion-gated
redirect, mean-preserving whole-wave pose rejection, head-only route-rate
correction, raw half-cycle steering, response-released cadence, approach
schedule, bearing-divergence recovery, carrier-first rejected-steering
allocation, and componentwise acceleration bounds.

Add one bounded sensor-arbitration mechanism to proportional pose sensing.
Retain the proven crossflow band-pass as the primary confidence.  Let
band-passed lateral-load magnitude fill only its unused confidence headroom,
and multiply that backup by a smooth low-crossflow gate that decays quartically
once normalized crossflow reaches the trusted moderate-flow peak.  Observed
joint phase continues to provide the odd sign.  The load cue therefore can
cover a local-flow dropout during the early and late low-crossflow regimes but
cannot restore the near-constant authority that v39 applied through the
high-crossflow middle route.  It does not enter redirect selection, route-rate
feedback, the oscillator, or direct actuation.

On the frozen v38 trace, the proposed confidence averages
`0.952/0.840/0.956` over `0-4/4-14/14-capture T`, compared with v39-like soft
union `0.968/0.985/0.976`: it retains most early/late backup while remaining
near v38's `0.809` middle confidence.  This is a mechanism and boundedness
check, not a closed-loop outcome claim.  The candidate should preserve the
v38 middle-route lead and coherent wake while retaining the comparator's
low-flow early/late benefit.  Falsify it if capture or observed integral
regresses from `18.2325 T` or `1.399804 L`, if it remains farther than v38 over
`6-14 T` without a compensating integral improvement, or if maximum speed,
acceleration residence, normalized force, moment, or two-view wake coherence
materially exceeds the sampled v38-v39 envelope.

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and adaptive wake interaction
source_mechanism: preserve the rhythmic carrier while a small bounded sensor residual refines direction tracking, and separate carrier-correlated flow feedback from persistent route commands
transferable_invariant: a complementary hydrodynamic sensor may cover loss of a primary body-frame cue only while the primary observation is weak; it should not override the primary cue's disturbance-rejection boundary
nontransferable_details: published gains, species or robot kinematics, clocked CPG phase, exact vortex phase, dimensional flow/load thresholds, cylinder-wake synchronization, full-body envelopes, and prescribed routes
policy_translation: use normalized local body-frame crossflow band-pass confidence as primary, admit normalized lateral-load confidence only into unused headroom under a smooth low-crossflow gate, and use observed de-meaned joint phase as the bounded odd sign solely for proportional pose rejection
falsification: reject if middle-route closure, capture, or the coherent alternating wake regresses, or if speed, saturation, normalized force, or yaw moment exceeds the reproduced envelope without compensating distance-integral improvement
```

## Evidence boundary

All outcome claims above come from completed sampled CFD, the assigned parent,
and inherited optimizer logs.  The candidate introduced below will be formally
evaluated only after this worker exits; no same-worker CFD result is claimed.

## No-CFD implementation audit

- The single candidate policy SHA-256 is
  `e3b457f78de798b3863166235b1dba02d4c22f3d556707a3169f6b1e9b0a92fd`.
  Relative to reproduced v38, executable changes are confined to reading the
  normalized lateral body-force observation, calculating its band-pass
  confidence and low-crossflow backup gate, and adding that bounded backup to
  proportional carrier-pose confidence.  The rhythmic carrier, route and
  redirect laws, and final actuator projection are unchanged.
- A deterministic `212,625`-state sweep over distance, bearing, both joint
  angles and rates, closing response, crossflow, and lateral load returns two
  finite accelerations within the unchanged componentwise limit.  Omitting the
  force observation makes every swept action bit-identical to v38; finite load
  changes `45,164` swept states, so the new mechanism is active rather than a
  metadata-only edit.
- With peak normalized load confidence, combined pose confidence is
  `1.0000/0.9979/0.9882/1.0000/0.8118/0.6049/0.3248` at crossflow ratios
  `0/0.25/0.5/1/2/3/6`.  The backup contribution itself is only `0.0118`,
  `0.0049`, and `0.0005` at ratios `2`, `3`, and `6`, respectively, confirming
  that the secondary sensor cannot recreate v39's high-crossflow union.
- The schema audit covers all `63` direct `params.FIELD` references with fields
  returned by the `65`-field parameter object.  The material-guidance check,
  lightweight Julia public-contract check, and solver editable-boundary check
  pass.  The rendered `README.md` duplicated its one assigned-parent listing;
  removing that duplicate was required for the guidance checker to resolve the
  parent and pass.
- The prescribed `.codex/agents/check-runner.toml` was invoked, but its pinned
  `gpt-5.4-mini` model is unavailable for this ChatGPT account.  Its exact three
  no-CFD commands were run locally and separately and all pass.  No formal CFD
  was run.
