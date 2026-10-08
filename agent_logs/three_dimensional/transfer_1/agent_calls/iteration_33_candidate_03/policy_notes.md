# Approach-retained partitioned posterior-turn candidate

## Completed evidence and visual diagnosis before editing

- All four sampled evaluations are finite `capture` episodes initialized
  directly from uniform still water with `U_infinity=(0,0,0)`, no cylinders,
  and no prewarm snapshot.  The two byte-identical v47 contraction-release
  samples reproduce capture at `17.53399 T`, score `-0.06405`, and
  total/observed distance integrals `1.949721/1.333721 L`.
- I inspected every combined sheet from release through capture.  The readable
  v47 duplicate and both v48 variants show active self-propulsion on smooth
  target-signed arcs: compact startup vorticity grows into an organized
  alternating posterior street, and the readable oblique rows retain compact
  paired caudal Lambda2 structures.  One byte-identical v47 sheet has a black
  oblique row after frame 000; that is a rendering/evidence failure, so it is
  not used for a comparative 3D-wake claim.  The top-down behavior and the
  other readable v47 reproduction establish that no sampled controller earns
  its route difference from passive advection or a new wake topology.
- The assigned-parent v48 `4.0 L` distance arbitration does not recover the
  hypothesized late response advantage.  It is identical to v47 at the
  `2-14 T` checkpoints, leads by only `0.00133 L` at `16 T`, and captures just
  one solver step earlier at `17.52849 T`; its total integral and score worsen
  to `1.950718 L` and `-0.06531` even though observed integral changes by only
  `-0.000077 L`.  Its unchanged `0.97314 L/T` maximum speed and
  `0.032252/0.016092` peak normalized force/moment scale confirm that this was
  a release-selection failure, not a load or carrier change.
- The geometry-partitioned v48 sibling is a meaningfully different useful
  trajectory despite its lower scalar score.  It improves observed integral
  to `1.331907 L`, captures `0.0550 T` earlier at `17.47899 T`, is
  `0.02289/0.03053 L` closer at `8/16 T`, lowers maximum speed from
  `0.97314` to `0.96017 L/T`, and lowers any-joint acceleration-limit
  residence from `42.75%` to `40.15%`, while retaining the same
  `0.032252/0.016092` peak force/moment scale and coherent two-view wake.  It
  trails v47 at `10-14 T`, however, and crosses the capture boundary at only
  `0.749953 L` rather than `0.746974 L`; the resulting terminal-hold increase
  from `0.616000` to `0.618869 L` overwhelms its observed-integral gain and
  worsens total integral/score to `1.950776 L` and `-0.06581`.
- Inherited optimizer logs already rule out reopening carrier cadence,
  approach thrust, or base route authority: four earlier approach-local
  changes worsened total integral while changing observed integral by less
  than about `0.000062 L`.  The completed partitioned result instead isolates
  a useful route release and a terminal boundary: correct-sign yaw is useful
  outside the centerline window, but it is not sufficient evidence that the
  supplementary target-signed curvature should remain released at capture.

## One-candidate policy hypothesis

Preserve v47's normalized body-frame sensing, state-feedback carrier,
posterior lag, selective crossflow pose confidence, base route/redirect
steering, launch response, carrier-first spillover, half-cycle steering, and
componentwise actuator projection.  Partition only release of the existing
phase-even posterior turn-shape residual as in the completed v48 sibling:
inside the centerline window, use de-gaited bearing contraction; outside it,
use correct-sign de-gaited yaw response.  Add one approach-priority invariant:
multiply the yaw-release branch by the already owned normalized
`far_drive_gate`, so the sampled route behavior is unchanged at distances
above `2.1 L` and the supplementary target-signed curvature returns smoothly
as capture geometry becomes immediate.  This reverses the failed inherited
far-to-near yaw handoff; it does not add thrust, retune a gain, or alter the
base route controller.

The next CFD evaluation should retain the partitioned sibling's observed-route
gain, `8 T` and `16 T` leads, earlier arrival, coherent two-view wake, and
lower speed/saturation envelope while crossing more decisively than
`0.749953 L`, thereby reducing terminal hold enough to beat the v47 total
integral and score.  Falsify the mechanism if the pre-approach trajectory is
not reproduced, capture or target-signed curvature is lost, the `10-14 T`
regression grows, the terminal crossing is no deeper, switching becomes
beat-sensitive, or speed, limit residence, force, or moment exceeds the
sampled v47 envelope.  Formal CFD occurs only after this worker exits.

```text
bookshelf_consulted: true
source_domain: biological burst-turn response release and terminal capture control
source_mechanism: release supplementary curvature after observed redirection, but let immediate target geometry regain authority in the capture regime without stopping the propulsive rhythm
transferable_invariant: an observed correct-sign yaw can release extra steering on the broad route, yet that release should yield continuously to normalized target geometry near capture while carrier and base steering remain active
nontransferable_details: published gains, dimensional maneuver timing, species-specific curvature envelopes, full-body kinematics, clocked CPG phase, exact vortex phase, and task-specific routes
policy_translation: partition the existing phase-even posterior residual between body-frame bearing contraction and de-gaited yaw response, then multiply only the yaw-release branch by the existing normalized approach/far gate so target-signed posterior curvature returns inside the capture approach
falsification: reject if the completed partitioned route lead or coherent wake is lost, capture is delayed or shallower, the middle-route regression grows, reflection symmetry fails, or speed, saturation, normalized force, or moment materially exceeds the sampled envelope
```

## Evidence boundary

All rollout and visual claims above come from the assigned parent guidance,
sampled solver evidence, and inherited optimizer logs.  The approach-retained
partition is a single unevaluated policy hypothesis; no same-worker CFD result
is claimed.

## No-CFD implementation audit

- The sole materialized candidate is
  `dogfish_target_control_v49_approach_retained_partitioned_posterior_turn`.
  All `68` distinct direct `params.FIELD` references resolve among the `70`
  fields returned by `target_policy_params()`.
- A deterministic `3,072`-state comparison against the completed partitioned
  v48 controller gives exactly zero action difference outside the approach
  region and a finite nonzero posterior-action difference inside it.  The new
  yaw-release value matches `far_drive_gate` times the v48 yaw release to
  floating-point tolerance, and that distance factor is unchanged under
  mirrored observations.  Every tested output is finite and within the
  componentwise acceleration envelope.
- The required configured check-runner was invoked but could not start because
  its pinned `gpt-5.4-mini` model is unavailable for this account.  Its three
  exact checks were then run locally and separately: material guidance/notes,
  the lightweight Julia policy contract, and the solver editable boundary all
  pass.  The guidance check first exposed a duplicated assigned-parent marker
  in the rendered workspace `README.md`; removing only that duplicate made the
  semantic parent comparison pass.  No formal CFD was run.
