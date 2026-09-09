# Step 31 wake-policy diagnosis and hypothesis

## Evidence read before editing

- All four sampled rollouts use direct uniform still-water initialization with
  `U_infinity=(0,0,0)` and terminate in capture. The three executable-identical
  half-cycle envelope-redistribution samples capture at `18.6505--18.8815T`,
  with mean-distance scores `2.08855--2.09222L`; this repeat spread is not a
  reason for scalar gain tuning.
- In both the strongest finite sample (`solver_649d7e789a5a`) and the distinct
  broadside-reserve comparison (`solver_de4c121e5685`), the top-down row shows
  sustained alternating shedding behind a body that bends toward the target,
  and the oblique row shows compact bilateral/caudal Lambda2 structures from
  release through capture. Translation is self-propelled rather than ambient
  advection. Neither view shows wake collapse, collision, domain exit, or
  instability immediately before termination.
- The broadside-reserve sample captures at `18.7055T` but has mean distance
  `2.09386L`, outside the best redistribution band. It also retains essentially
  the same high demand (`60.84%/73.04%` acceleration contact and
  `10.91%/14.73%` rate contact) and slightly higher peak lateral load/moment
  (`0.0292/0.0170`) than the redistribution repeats (`0.0279--0.0288` and
  `0.0160--0.0166`). A visually energetic wake and fast endpoint therefore do
  not make another redirect reserve an improvement.
- The redistribution captures still contact the acceleration envelope on
  about `60.85--61.00%`/`72.97--73.27%` of samples. Pointwise rate barriers,
  common carrier scaling, posterior-wave allocation during redirect, raw
  velocity residuals, and stacked recovery gates already have completed
  negative evidence in inherited guidance. Those mechanisms are not reopened.
- The actual moving-window adapter keeps only seven prior solver rows, about
  `0.04T` here. Its short-window bearing rate cannot honestly stand in for a
  slow route estimator, so no history-based route filter is proposed.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: Taylor/Lighthill traveling-wave propulsion and closed-loop robotic-fish CPG gait modulation
source_mechanism: posterior phase lag supplies a directed traveling bend and may be modulated separately from target-owned mean curvature
transferable_invariant: preserve the anterior steering carrier while allowing a bounded posterior-lag change only when normalized body-frame target geometry identifies cruise alignment
nontransferable_details: published gains, dimensional frequencies, species envelopes, exact vortex phase, clock-driven CPG phase, and source-task routes
policy_translation: retain the replicated target-signed curvature, correcting-yaw release, half-cycle steering, and common-envelope redistribution; smoothly add at most a small posterior lag fraction inside a normalized lateral-alignment band, returning exactly to the parent lag as redirect demand grows
falsification: reject if capture is lost, mean distance leaves the replicated `2.0886--2.0922L` band, either wake row loses coherence, acceleration/rate or planar-load contact worsens materially, or the route develops the inherited downward-exit topology

## Single candidate hypothesis

The sampled controller already has reliable steering and a coherent traveling
wave, so the missing test is not more curvature. A smooth cruise-only posterior
phase-lag modulation can test whether slightly stronger aligned reactive thrust
improves the distance integral without competing with redirect allocation. The
gate is derived only from `target_body_L[2]/distance_L`, is continuous and
bounded, has no clock or route memory, and becomes zero under substantial
lateral demand. The `6%` ceiling and `0.35` normalized lateral band are local
experimental bounds, not transferred literature values. Formal CFD occurs only
after this worker exits; this note makes no claim about the new outcome.
