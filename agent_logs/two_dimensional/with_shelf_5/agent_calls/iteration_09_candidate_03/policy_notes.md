# Multi-wake target-policy candidate notes

## Evidence-first visual diagnosis

The common prewarm sheet shows the held fish above and downstream of four
mature interacting wakes, so it is fixed initial-condition evidence rather
than a policy difference. The three byte-identical sampled carrier rollouts
all show an immediate targetward redirect, a coherent posterior traveling
bend, and a compact upstream-left diagonal through the developed wake. They
reach the `0.75L` target boundary after `43.9505`, with `2.1391L` mean
distance. Mean fish velocity `(-0.2471,-0.1020)` differs materially from mean
local flow `(-0.1342,-0.1556)`, confirming active upstream swimming rather
than passive advection.

No sampled solver is a semantic failure, so the useful contrast is the direct
capture against the inherited right-domain exit. The exit sheet never forms a
traveling targetward bend; it moves `(+2.175,-0.869)L`, terminates after
`16.7914`, and has negative progress `-0.1471`. Its mean streamwise motion
differs from local flow by only `0.0154U`. Globally weakening the carrier or
adding target-independent curvature would therefore risk restoring the
advection-dominated topology.

The assigned parent's alignment-gated posterior outward-rate projection is a
partial positive. Its released sheet preserves the same direct trajectory and
reaches the target after `44.0220`, only `0.0715` later than the carrier. RMS
relative crossflow falls from `0.21115` to `0.21016`, RMS lateral force from
`49.44` to `44.86` (about `9.3%`), and RMS moment from `701.26` to `663.89`
(about `5.3%`). The late body/wake excursion is also visibly calmer. However,
mean command falls only from `1207.78` to `1206.57`, and both joints still
reach the `260 deg/time` rate and `1800 deg/time^2` acceleration caps. Thus the
rate projection has a useful load effect but does not establish cap or effort
relief. The sampled response-conditioned half-cycle release is a negative
control: its `43.8955` capture raises mean command to `1216.2` and force/moment
to `55.12/764.85`, so target-directed half-cycle steering must remain intact.

## Policy hypothesis before the edit

Retain the evaluated parent mechanism: the joint-state oscillator, bounded
body-frame bearing-to-curvature command, target-favored posterior half-cycle,
posterior lag, approach taper, and alignment-gated projection of posterior
outward rate drive. Add one small compatible wake-disturbance residual. Once
the existing normalized bearing gate indicates alignment, oppose measured
`state.moment_z_L2` with a smooth bounded mean-curvature bias shared through
the existing head/tail steering path. Large bearing error leaves this residual
exactly zero, while the half-cycle route command and every posterior reversal
remain unchanged.

The residual scale is anchored to the observed direct-carrier RMS moment,
`701.26 / 64^2 = 0.1712`, rather than a published gain. Its authority is kept
small relative to the proven `8 deg` route bias. Expected evidence is the same
compact direct capture and `44.022`-class arrival with lower RMS moment and
force than the assigned parent, without increased command effort. Falsify the
new residual if the initial redirect or route topology changes, target capture
is delayed materially or lost, force/moment or command rises, or joint/action
histories show alternating feedback chatter. Because the new CFD runs only
after exit, none of those outcomes is claimed here.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish direction tracking and adaptive swimming in cylinder wakes
source_mechanism: preserve a state-feedback traveling-wave carrier and separate slow target steering from a small bounded sensor-feedback yaw-disturbance residual
transferable_invariant: large body-frame direction error retains full posterior propulsion and steering, while small direction error permits bounded opposition to measured body-frame yaw load without cancelling the rhythmic carrier or helpful translation
nontransferable_details: published gains, dimensional frequencies, robot or species kinematics, exact vortex phase, cylinder coordinates, prescribed routes, and source-task timing
policy_translation: retain the evaluated joint-state carrier and posterior outward-rate guard; use normalized bearing to gate a bounded bias opposing `moment_z_L2` through the existing two-joint curvature path
falsification: reject if the direct redirect or target capture weakens, arrival regresses materially, measured force/moment or command effort rises, or fast alternating moment feedback creates joint/action chatter

## Pre-evaluation verification

The required semantic-guidance check, exact Julia policy-contract assertions,
and solver editable-boundary check all pass. Static schema inspection found all
`17` direct `params.FIELD` references among the `17` fields returned by
`target_policy_params()`, and the editable 2D lane contains exactly one
non-empty candidate. A deterministic Julia sweep of `11,340` combinations
spanning approach distance, both bearing signs, zero and extreme normalized
moments, both joint-angle limits, and both joint-rate limits returned finite
two-joint actions. It also verified zero action at zero state, exact removal of
moment feedback at large bearing error, and signed symmetry for opposite
moments after alignment. No formal CFD was run.
