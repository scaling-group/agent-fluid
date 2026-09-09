# Phase-separated terminal-geometry candidate

## Visual and metric diagnosis before editing

All four sampled evaluations satisfy the frozen rollout contract: direct
uniform initialization in still water with `U_infinity=(0,0,0)`, no cylinders,
and no prewarm. I inspected both rows of the combined keyframe sheets for the
highest-score finite capture and the informative `left_domain` failure. The
capture is self-propelled on a nearly direct down-left route: its top-down row
retains a compact, body-connected alternating vorticity street and its oblique
row shows localized paired Lambda2 structures through capture. It reaches
`0.74998L` at `15.983T`, with maximum joint angles below `38 deg`, about `17%`
occupancy per joint in the last `10 deg/T` of the rate envelope, and sampled
peak planar force/moment magnitudes of `0.0342/0.0173`.

The failure begins with an organized self-generated wake, so it is neither
passive advection nor missing propulsion. Its continuous near-target carrier
relief then lets steering/static deformation dominate: the top-down path curls
sharply, shed structures broaden, and the oblique body folds into the loop
before a left-boundary exit at `24.518T`. It reaches only `2.703L`, finishes
`7.056L` away, dwells at both `45 deg` angle stops, and peaks at
`0.7132/0.2998` planar force/moment. The three sampled predicted-miss policies,
by contrast, all preserve the direct compact-wake class and capture at
`15.983--16.016T` with `0.7472--0.7500L` final distance. This evidence rejects
broad approach braking on the established carrier.

The assigned parent and inherited optimizer logs establish a narrower
robustness problem. The same response/pulse composite has both repeated
captures and inherited `1.01564--1.21644L` misses followed by left exits, while
a no-pulse sibling also captured; pulse presence and release are not reliable
causal separators. In the parent's offline replay of three captures, raw
terminal bearing changed sign five times and the blended request six times in
the final `2.5T`. Removing the joint-angle-domain integral of the existing
carrier-yaw-rate model reduced request variation by about one third and left
two brief crossings. That replay is diagnostic evidence only, not CFD
validation of this candidate.

## Single candidate hypothesis

Preserve the full state-feedback traveling-bend carrier, far-field
pursuit/course blend, constant-course time-to-closest and signed predicted
miss, terminal mean bend, response-gated half-cycle handoff, and posterior
mid-stroke pulse. Change one feedback mechanism only: remove the observable
two-joint carrier-yaw component from target bearing before forming the
terminal pursuit request. Far-field navigation and course prediction remain
raw, so the evaluated direct route and propulsive wake are unaffected until
the existing terminal fallback is recruited. Persistent target geometry,
rather than beat-correlated body yaw, should then determine terminal steering
sign.

Support requires repeated capture or a closer non-capture than the inherited
`1.0--1.22L` band while retaining the direct compact-wake route, zero dwell
beyond `40 deg`, comparable far-field translation, and roughly
`0.037/0.019` or lower sampled planar force/moment. Falsify on a worse closest
pass, unchanged left-exit topology, route-class change, persistent terminal
sign switching, wake loss, greater joint/load occupancy, or loss of boundedness
or reflection equivariance.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and biological redirect-to-cruise transitions
source_mechanism: separate slow directional error from fast rhythm-correlated body response before handing steering authority around a preserved propulsive rhythm
transferable_invariant: persistent target geometry after removal of the observable carrier component should set terminal steering sign while the established traveling bend remains active
nontransferable_details: published CPG gains, clock phase, robot linkage geometry, species-specific redirect timing and curvature, dimensional frequency, exact vortex phase, and task-specific routes
policy_translation: use normalized body-frame target geometry and the two observed joint angles to remove the angle-domain carrier-yaw estimate only from terminal pursuit; retain the joint-rate residual for response gating and leave far-field prediction and carrier drive unchanged
falsification: reject if capture or closest approach and termination do not improve together, or if direct routing, wake coherence, joint reserve, normalized load scale, boundedness, or reflection equivariance degrades

The candidate's CFD evaluation occurs only after this worker exits. All
rollout and replay outcomes above are inherited or sampled prior evidence.
