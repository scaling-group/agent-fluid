# Axis-selective energy-governed posterior-launch candidate

## Completed evidence and visual diagnosis before editing

- All four sampled policies complete finite `capture` episodes from direct
  uniform still water with `U_infinity=(0,0,0)`, no cylinders, and no prewarm.
  The assigned v41 parent captures at `17.918999 T`, score `-0.093208`, and
  total/observed distance integrals `1.979413/1.365311 L`.
- The strongest completed sample is v42's phase-insensitive posterior-energy
  deficit.  It captures at `17.809002 T`, score `-0.088403`, and integrals
  `1.974148/1.358239 L`.  It improves first-`2 T` closure from v41's
  `0.09643 L` to `0.10193 L`, leads v41 by `0.0147/0.0304/0.0626/0.0538 L`
  at `4/6/8/10 T`, remains ahead by `0.0226/0.0482 L` at `12/16 T`, and
  lowers any-joint acceleration-limit residence from
  `43.92%` to `42.90%`.  Mean/max speed is `0.7162/0.9590 L/T` versus
  `0.7128/0.9675 L/T`; peak normalized planar force/moment rises modestly from
  `0.03182/0.01608` to `0.03225/0.01657`.
- Releasing the whole posterior launch from positive forward body-axis speed
  is independently positive but slightly weaker: the axial-response sample
  captures at `17.831001 T` with `1.974682/1.360029 L` integrals.  It is
  `0.0197/0.0122/0.0301/0.0520 L` closer than v41 at `4/6/12/16 T`, while its
  first-`2 T` closure is essentially unchanged.  This indicates that early
  sway does prematurely suppress useful launch authority, but does not justify
  replacing the completed energy governor wholesale.
- Outstroke phase allocation is the informative mechanism underperformance.
  It keeps v41's `17.918999 T` arrival and slightly worsens first-`2 T`
  closure, while improving total/observed integrals only to
  `1.976091/1.362683 L`; its any-joint acceleration-limit residence rises to
  `44.72%`.  The result does not support concentrating more launch authority
  on a selected beat phase.
- I inspected every combined keyframe sheet from release through capture.  All
  top-down rows show active self-propulsion on a smooth target-directed arc,
  with compact startup vorticity developing into an organized alternating
  posterior street and no reversal, collision, domain exit, or wake collapse.
  The phase-allocated sample has the only readable oblique row: it shows
  compact alternating Lambda2 structures remaining attached to the same
  target-directed trajectory.  The energy, axial, and v41 oblique rows are
  black rendering failures, so they cannot support a comparative 3D-wake
  claim.  Similar top-down wakes and the phase variant's weak route result
  reinforce that the useful difference is response allocation, not a visibly
  new wake topology.
- Inherited logs establish the mechanism boundary: route-wide lateral-load
  confidence, raw-crossflow dropout bridging, and whole-wave route-rate
  projection regressed closure or caused a wrong-sign high-load exit.  The
  response-released posterior launch was the first large launch improvement,
  and its completed v42 descendants now isolate response axis, observed wave
  energy, and beat phase without changing route steering.

## One-candidate policy hypothesis

Materialize the completed v42 energy-governed policy as the single candidate.
Keep its validated base posterior launch on total body-speed response, and
change only the additional energy-deficit residual: release that small term by
positive forward body-axis speed rather than total speed.  Thus lateral sway
cannot masquerade as axial propulsion when the observed two-joint posterior
wave is still underdeveloped, but the larger base launch is not stacked with
the axial variant.  The residual remains bounded by the existing gain, is even
under mirrored gait phase, preserves route/redirect means, and vanishes with
posterior wave energy, productive closing, approach, or steering load.

The intended signature is to retain v42-energy's `0.10193 L` first-`2 T`
closure while exploiting the axial sibling's evidence that sway should not
release an energy-deficit residual: capture
before `17.809 T` and total/observed integrals below `1.97415/1.35824 L`, with
an organized top-down wake, a readable future oblique wake, any-joint
acceleration-limit residence near `42.9%`, and no material increase beyond
`0.959 L/T`, `0.03225`, and `0.01657` maximum speed/force/moment.  Formal CFD
occurs only after this worker exits; none of those intended outcomes is claimed
here.

```text
bookshelf_consulted: true
source_domain: Lighthill elongated-body reactive thrust and sensor-modulated robotic-fish CPG amplitude control
source_mechanism: posterior wave development produces reactive thrust, while closed-loop amplitude emphasis should release when the relevant propulsive response and oscillation are observed
transferable_invariant: lateral body speed is not axial propulsion; a bounded posterior-energy residual should persist only while observed posterior wave energy and positive forward body-frame response remain deficient
nontransferable_details: published gains, dimensional frequency or amplitude, species and robot kinematics, full-body envelopes, exact vortex phase, and task-specific routes
policy_translation: preserve the completed total-speed-gated base launch, but gate only its phase-insensitive posterior-energy residual with normalized positive forward body-axis speed plus the existing closing, distance, and turn-load feedback
falsification: reject if first-2T closure, middle-route checkpoints, capture, or distance integrals regress; if posterior saturation becomes persistent; if readable two-view evidence loses the organized wake; or if speed and normalized force/moment materially exceed the completed energy-governed envelope
```

## Evidence boundary

All completed outcomes and visual claims above come from the assigned parent,
sampled solver results, inherited optimizer notes, and inherited durable
guidance.  The candidate below has no same-worker CFD evidence.

## No-CFD implementation audit

- The single candidate SHA-256 is
  `c00e51c0d87f9cc26071bbb3dd42160d28f50eeb1323e87e839c3717a4b6459b`.
  All `65` direct `params.FIELD` names resolve against the `67` fields returned
  by `target_policy_params()`.
- A deterministic comparison with completed v42 confirms that pure axial
  response or an already developed posterior wave yields byte-equal actions.
  In the intended low-axial/high-sway state, total- and forward-speed gates are
  `0.5533/0.9556`; the anterior action remains exactly unchanged and only the
  posterior energy residual changes (`-1.62565` to `-1.73061 rad/T^2`).  All
  tested outputs remain finite inside the componentwise acceleration limit.
  This is a structural check, not a closed-loop result.
- The configured check runner was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable for this account.  After removing the duplicated assigned-
  parent marker from the rendered `README.md`, its material-guidance check,
  lightweight Julia policy contract, and solver editable-boundary check all
  pass locally and separately.  No formal CFD was run.
