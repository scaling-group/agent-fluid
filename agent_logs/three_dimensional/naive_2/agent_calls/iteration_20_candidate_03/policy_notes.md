# Phase-separated terminal-bearing candidate

## Visual and metric diagnosis before editing

All four sampled episodes report direct uniform still-water initialization at
'U_infinity=(0,0,0)', with no cylinders and no prewarm. I inspected every
combined keyframe sheet in both its top-down mid-plane vorticity row and
oblique body/Lambda2 row. The three captures travel down-left on nearly the
same direct route behind a compact, body-connected alternating wake whose
localized three-dimensional structures remain visible through the capture
sphere. The informative failure also self-propels and sheds an organized wake,
but curls upward, reaches only '4.64998L', and exits the upper boundary.
Moving-window advection and missing propulsion are therefore rejected;
steering geometry and terminal response distinguish the outcomes.

The exact prefilled policy captured twice in the sampled set at
'15.9830--15.9940T' and '0.74723--0.74998L'. A response-released version of
only its posterior pulse also captured at '16.0160T' and '0.74859L'. Across
those runs, peak normalized planar force/moment remained
'0.0332--0.0367/0.0166--0.0185', neither joint dwelled above '40 deg', and
each joint occupied more than 95% of its rate envelope for about '18%' of
samples. Thus response-releasing the pulse preserved the trajectory but did
not materially alter arrival, load, or rate use. The failure instead touched
the joint-angle limits, reached '0.620/0.261' peak normalized force/moment,
and retained a wrong-side route despite a coherent wake.

The assigned-parent guidance and inherited optimization log add the essential
repeat boundary: the byte-identical prefilled composite later missed at
'1.01564L', '1.12140L', and '1.21644L' before exiting left, while a no-pulse
sibling also captured. Posterior pulse presence or release is therefore not a
supported explanation for reliable capture. In the inherited replay of the
three direct captures, raw terminal bearing changed sign five times and the
blended terminal request six times during the final '2.5T'; subtracting the
angle-domain integral of the existing joint-rate carrier-yaw model reduced
request deviation by about one third and left two brief crossings. This replay
is diagnostic evidence, not a CFD evaluation of the proposed change.

## Single candidate hypothesis

Preserve the complete traveling-bend carrier, pursuit/course blend,
constant-course predicted-miss gate, bounded mean bend, response-gated
half-cycle handoff, and posterior pulse. Change one feedback mechanism:
subtract the joint-angle carrier-yaw estimate from target bearing only when
forming terminal pursuit. Far-field pursuit and course prediction remain raw,
so the direct sampled route is unchanged until the existing terminal gate
recruits its fallback. This should make persistent normalized body-frame
target geometry, rather than beat-correlated body yaw, determine the terminal
steering sign.

Support requires repeated capture rather than another '1.0--1.22L'
left-domain miss, with the same direct compact-wake route, no '>40 deg' joint
dwell, comparable far-field translation, and normalized force/moment no worse
than roughly '0.037/0.019'. Falsify on a worse closest pass, changed route or
termination class, persistent terminal sign switching, wake loss, material
joint/load growth, loss of boundedness, or loss of reflection equivariance.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and biological redirect-to-cruise transitions
source_mechanism: separate slow directional error from fast rhythm-correlated body response before handing steering authority between a propulsive beat and a redirect
transferable_invariant: let persistent target geometry after removal of the observable carrier contribution set terminal steering sign while preserving the established traveling rhythm
nontransferable_details: published CPG gains, clock phase, robot linkage geometry, species-specific C-start timing and curvature, dimensional frequencies, exact vortex phases, and task-specific routes
policy_translation: use normalized body-frame target geometry and the two observed joint angles to remove the angle-domain carrier-yaw estimate only from terminal pursuit; retain the joint-rate residual for response gating and leave far-field prediction unchanged
falsification: reject if repeat capture, closest approach, or termination does not improve together, or if the direct route, compact wake, joint reserve, normalized load scale, boundedness, or reflection equivariance degrades

## Dry validation only

The mandated guidance-materiality, lightweight Julia contract, deterministic
parameter-schema, and editable-boundary checks pass. An additional 181,440
reflected state-pair audit spanning normalized target geometry, body-frame
course, both joint angles and rates, and measured yaw response produced finite
commands strictly inside the smooth '30 rad/T^2' envelope (maximum magnitude
'29.999999999995'), with all 28 direct parameter references owned and exact
left/right reflection error '0.0'. These checks establish executable
semantics, boundedness, schema ownership, and symmetry only. The candidate's
capture reliability, trajectory, wake, joint use, and loads remain downstream
CFD falsifiers.
