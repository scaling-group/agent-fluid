# Candidate wake-policy notes

## Evidence diagnosis

All four sampled rollouts satisfy the direct-uniform still-water contract
(`U_infinity=0`) and terminate in capture.  The assigned prefill
`solver_d1fa01b2365d` and the proximity-extended recovery control
`solver_33ad1bc593b3` are trajectory-identical at `22.154001T`,
`2.105583L` mean distance, and score `-0.210952`; the latter therefore shows
that another preview-path extension does not supply a useful mechanism.
`solver_fb6f1126a48d`, without the previewed posterior half-cycle envelope,
is slightly weaker at `22.159500T`, `2.105808L`, and `-0.211168`.

The best finite sample, `solver_6062f0878b7b`, changes only the selector for
the existing capped posterior half-cycle asymmetry from anterior rate to
centered anterior bend.  It advances capture to `22.027504T`, lowers mean
distance to `2.100432L`, and improves score to `-0.206239`.  Recomputed trace
envelopes also improve: mean/inside-`1.5L` action norm changes from
`59.932/46.393` to `59.552/46.197`, and peak normalized force/moment changes
from `0.030897/0.015839` to `0.030199/0.015463`.  Anterior/posterior exact-rate
cap occupancy remains finite at about `11.74/6.37%` versus `11.49/6.41%`.

The combined top-down sheets show self-propelled target approach rather than
advection: an alternating vorticity street forms by `4T`, remains attached to
the S-shaped route through `20T`, and is still active at capture.  The assigned
parent and `solver_fb6f1126a48d` have complete oblique rows showing discrete
three-dimensional Lambda2 structures through the same carrier route.  The
bend-selector and trajectory-inert recovery-preview samples have blank oblique
rows, so they provide no independent 3D-wake confirmation; preservation of the
parent's complete two-view wake is a required falsification boundary.

## Policy hypothesis

Adopt the sampled bend-state half-cycle selector exactly as the one controller
change.  Use target-side-signed, normalized centered anterior angle to choose
which half-cycle receives the already bounded posterior carrier asymmetry.
Keep target prediction on its evidenced envelope, and retain anterior-rate
phase only for the separately validated terminal rudder relief.  This should
reproduce the earlier capture and lower action/load result without increasing
authority or disturbing launch, route, or terminal response allocation.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning and classical asymmetric swimming
source_mechanism: observed-phase half-cycle amplitude asymmetry superposed on a traveling propulsive rhythm
transferable_invariant: select the target-helping load half-cycle from normalized oscillator state and body-frame target side while preserving the carrier and bounded mean authority
nontransferable_details: published duty ratios and gains, robot or species kinematics, actuator geometry, clock phase, exact vortex phase, and task-specific trajectories
policy_translation: replace only the posterior carrier asymmetry selector with `tanh(geometric_turn * carrier_q1 / amplitude)`; keep all envelopes and the rate-based terminal-relief selector unchanged
falsification: reject if capture is later than `22.027504T`, mean distance exceeds `2.100432L`, the preterminal route changes, complete two-view wake evidence is lost, or action, rate-cap occupancy, force, or moment exceeds the sampled parent envelopes

The current candidate receives no same-worker CFD claim; its formal rollout is
performed after this worker exits.
