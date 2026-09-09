# Wake-policy candidate notes

## Evidence diagnosis

All four sampled evaluations satisfy the experiment contract: direct uniform
still-water initialization with `U_infinity=(0,0,0)`, finite dynamics, and
capture termination. The combined keyframe sheets show self-propelled motion,
not advection: each top-down row develops a persistent alternating vortex
street from the posterior body and caudal fan, while the oblique row shows
compact alternating three-dimensional Lambda2 structures following the fish
through the moving window. No sheet shows wake collapse or a terminal
instability. The response-reversing half-cycle candidate preserves that wake
and reaches the target at `18.931T`, earlier than the acceleration-feasible
distributed-C-bend prefill at `19.234T`. Its trajectory is already lower and
closer by `16T` (`2.839L` versus `3.001L`).

The metric cross-check supports a steering improvement rather than a brute
force increase. Relative to the prefill, half-cycle tail emphasis changes
joint-action RMS only from `25.19/28.56` to `25.22/28.86 rad/T^2`, force RMS
from `0.01322` to `0.01357`, moment RMS from `0.00690` to `0.00707`, and local-
flow RMS from `0.01798U` to `0.01843U`. It nevertheless improves score from
`-0.17657` to `-0.15357` and arrival by `0.303T`. The two unbounded-output
samples arrive later (`19.585--19.888T`) and report raw posterior command RMS
of `67.98--71.09 rad/T^2`, so their apparent command histories are not a reason
to remove the explicit feasible-output projection.

The assigned-parent logs tighten the selection boundary. Its high-demand,
sign-coherent curvature allocator captures at `19.751T` with score `-0.21838`,
essentially no semantic improvement over that lineage's feasible C-bend run
at `19.739T` and `-0.20624`. The inherited near-range allocator is visibly
worse: after a `1.62L` pass its top-down and oblique rows show a broad orbit
and delayed `49.742T` capture. Removing posterior mean steering altogether
produces a weak early wake and a `11.995L` left-exit miss. These results argue
against another instantaneous allocator or posterior-route release. The
inherited notes also report one high-pass miss among otherwise successful
same-hash feasible-C-bend replications, so the half-cycle result is a promising
single-sample improvement that still requires replication, not a robustness
claim.

## Policy hypothesis

Adopt the sampled response-reversing posterior half-cycle mechanism intact on
the completed LOS-rate distributed C-bend. Infer wave side continuously from
the posterior traveling-wave target and multiply it by the phase-conditioned
yaw-rate error. This strengthens the currently helpful half-cycle and reverses
the preference when measured turning outruns route demand. Preserve the
anterior response recruitment, posterior mean curvature, carrier, and explicit
physical acceleration projection. This is one feedback-mechanism change from
the prefill, not scalar-only gain tuning.

bookshelf_consulted: true
source_domain: robotic-fish CPG control with asymmetric flapping for turning
source_mechanism: closed-loop half-cycle amplitude or duty-ratio asymmetry
transferable_invariant: a bounded propulsive half-cycle imbalance should follow the requested turn and reverse when the observed yaw response outruns that request
nontransferable_details: published duty ratios, gains, dimensional frequencies, clock phase, species kinematics, and task routes
policy_translation: use normalized body-frame LOS demand and recoil-conditioned yaw error for response direction, infer beat side from the two-joint posterior wave target, and apply a bounded odd scale only to that traveling-wave component
falsification: reject if capture does not replicate, arrival is not earlier than the `19.234--19.739T` feasible C-bend band, force or moment loads materially rise, or the alternating wake loses coherence

The new CFD result is intentionally not claimed here; it will become evidence
only after this worker exits.
