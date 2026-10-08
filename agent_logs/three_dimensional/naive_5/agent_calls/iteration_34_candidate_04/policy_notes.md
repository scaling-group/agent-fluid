# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- All four sampled evaluations satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, and inertial moving-window
  transport. All capture, so route progress, arrival, load/actuator exposure,
  and wake organization distinguish the policies more usefully than their
  common termination class.
- Both rows of every combined keyframe sheet were inspected from release to
  capture. The top-down rows show self-propulsion and an orderly alternating
  wake followed by a shallow target-side hook; the oblique rows retain compact
  coherent three-dimensional Lambda2 structures through capture. There is no
  passive advection, broad curl, wake breakup, boundary interaction, numerical
  instability, or moving-window-induced rotation. The current samples contain
  no semantic failure; the lowest-score force-commutated capture is therefore
  the informative weak comparison.
- The assigned parent (`solver_fb7bddf12f80`) captures at `0.748361L` and
  `26.1635T`, with mean distance `2.509866L`, zero actuator contacts, and peak
  planar force/yaw moment `0.01944/0.00987`. Its posterior course-slip
  vectoring improves the inherited upstream route and remains worth retaining.
- The course-triggered response-released redirect (`solver_c65157fcb0b0`) is
  the strongest sampled result: it captures at `0.749266L` and `25.9710T`,
  lowers mean distance to `2.498175L`, improves the `8/16/24T` distances from
  the parent's `10.4512/6.1888/1.8102L` to
  `10.4307/6.1023/1.7262L`, retains zero angle/rate/action contacts, and lowers
  peak planar force to `0.01885`. Both visual views show a real upstream route
  separation of about `0.29L` while preserving the coherent carrier.
- That result does not validate the redirect as course correction. Its path is
  displaced upward, away from the target's lateral coordinate, and its
  reconstructed projected miss at `20T` is about `2.90L`, versus `1.44L` for
  the parent; normalized course error is likewise about `0.74` versus `0.36`.
  The trigger first becomes strong while body bearing and velocity-to-target
  course error request opposite sides, so the score gain is better interpreted
  as propulsion/progress with an unresolved steering conflict. Its peak yaw
  moment also rises slightly to `0.01010`.
- The other samples bound the alternatives. Cross-joint conflict allocation
  (`solver_d10278aed649`) reduces the parent's `24T` projected miss from about
  `0.855L` to `0.666L`, but stays in the same visible route family and worsens
  mean distance slightly to `2.510405L`. Instantaneous force commutation
  (`solver_3065fba218c6`) arrives at `26.0920T` but worsens mean distance to
  `2.512198L`, scores `-0.609997`, and crosses only `0.000081L` inside the
  capture radius. Neither supports another allocation scalar or force-phase
  retune.

## Policy hypothesis

Preserve the assigned parent's state-feedback traveling bend, posterior
course-slip vectoring, translation-consistent target-line response,
capture-scale posterior modulation, coordinated acceleration projection, and
angle/rate viability guards. Add the sampled course-error/projected-miss
trigger to the established same-sign redirect, but qualify it with one smooth
sensory-consistency mechanism: while body bearing and translation-derived
course side strongly oppose each other, suppress only the new course-triggered
branch. Neutral or agreeing geometry admits it, and the inherited yaw/bend
response still releases it. The original bearing redirect is never vetoed.

This tests whether the sampled redirect's propulsive progress can survive
without its early route-side conflict. The falsifiable expectation is a
coherent, contact-free capture with lower mean distance or earlier arrival
than the assigned parent and improved middle-course geometry relative to the
unqualified redirect. Reject the mechanism if it loses capture or coherent
propulsion, does not materially separate the route, leaves the `20T` projected
miss near `2.90L`, creates any actuator contact, or exceeds the sampled
`0.01944/0.01010` planar force/yaw-moment envelope.

bookshelf_consulted: true
source_domain: biological burst turning and sensor-modulated robotic-fish closed-loop CPG steering
source_mechanism: large route error engages a temporary curvature mode, while sensory consistency and measured response govern whether it is admitted and released back into the propulsive rhythm
transferable_invariant: preserve a productive rhythmic carrier and admit bounded burst steering only when independent normalized geometric cues do not demand opposing turn sides
nontransferable_details: C-start body shapes, published gains, dimensional burst duration, species envelopes, robot linkage geometry, clock phase, exact vortex phase, and prescribed routes
policy_translation: normalized body-frame velocity-to-target course error and projected miss trigger the existing two-joint redirect; a smooth bearing/course conflict veto qualifies only that new branch, and phase-rejected yaw plus bend attainment retain response-based release
falsification: reject on lost or slower capture, unchanged adverse course geometry, loss of coherent three-dimensional propulsion, actuator contact, or force and yaw-moment exposure above the sampled envelope

## Non-CFD audit after the policy edit

- Every direct `params.FIELD` reference is owned by the returned 54-field
  parameter object. The prescribed public-contract state returns two finite
  accelerations. A deterministic 34,992-state grid spanning beyond-limit joint
  angles/rates, both target sides, lateral velocities, closing states, and
  target/body rotation rates remains finite and within `30 rad/T^2`; paired
  lateral reflections have zero numerical command error.
- On the reconstructed assigned-parent trace, the unqualified sampled trigger
  would be active on 1,774 rows. The cue-conflict mechanism fully vetoes 303
  and partially qualifies 111 of those rows, including the sustained opposing
  bearing/course interval at about `2--6T`; full sampled authority remains
  available once the cues agree from about `8T` onward.
- Re-evaluating the assigned parent and candidate on all 4,757 reconstructed
  parent states changes 1,184 post-guard command pairs, including 802 by more
  than `0.05 rad/T^2`. The maximum separation is `9.8432 rad/T^2`, the
  candidate's peak frozen-state command is `29.7229 rad/T^2`, and no state at
  or inside about `3.53L` changes. This establishes bounded, material upstream
  activation and exact terminal pass-through only; it is not CFD evidence.
- The configured check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable on this ChatGPT account. Its exact three non-CFD commands were
  therefore run directly: the material-guidance, Julia contract/schema, and
  solver editable-boundary checks pass. The guidance check first exposed a
  duplicated assigned-parent marker in the rendered workspace `README.md`;
  removing only that duplicate repaired it. No formal CFD was run.
