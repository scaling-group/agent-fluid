# Wake-policy candidate notes

## Evidence read before the edit

- The shared prewarm sheet shows four developed, interacting cylinder streets
  and the held fish above and downstream of them. The assigned parent
  (`solver_7bf9f4934d4b`) then makes a sharp targetward redirect and swims
  diagonally upstream through the merged wake into the `0.75L` capture disk.
  Its compact tail street and `(-10.923,-4.166)L` head displacement support
  active propulsion rather than passive lateral advection. It reaches in
  `34.7105`, with `1.62283L` mean distance, `46985.9` total command energy,
  `0.24023` RMS relative crossflow, and `68.96/1036.40` force/moment RMS.
- Three sampled parent-equivalent policies reproduce those values exactly.
  The strongest sampled child (`solver_59916694ccf2`) changes only the optional
  redirect-burst response cue from bearing closure to targetward relative
  crossflow. Its five-frame route is visually the same redirect-and-traverse,
  but it reaches sooner (`33.9460`), lowers mean distance (`1.60066L`) and total
  energy (`46092.2`), and raises force/moment RMS to `85.04/1244.16`. Thus the
  crossflow cue is useful route/arrival evidence but not yet a load benefit.
- The inherited optimizer logs add two controls: a heading-rate replacement
  reaches in `34.6720` but worsens mean distance to `1.62669L` and raises load
  to `91.30/1389.74`; another inherited child reaches in `34.9415` with
  `1.63256L`, `47284.7` energy, and `73.70/1106.47` load. Earlier inherited
  failures (target-blind downward exit, wrong-sign redirect exit, and a
  wholesale slower-carrier instability) make changing the carrier, route sign,
  or mean steering unsupported.
- No sampled failure keyframe is present in this rendered workspace. The
  required failure contrast is therefore metric/log based; no visual claim is
  made about those failed trajectories beyond the inherited diagnoses.

## Visual diagnosis and policy hypothesis

The remaining opportunity is confined to the transient redirect. Replacing
bearing closure wholesale with crossflow improves the same useful route, but
the load increase is consistent with keeping the extra burst active when the
fish is already closing bearing but instantaneous crossflow is neutral or
opposing. Preserve the sampled crossflow credit and restore the parent's
kinematic closure credit as a smooth union: surplus burst remains only while
neither targetward bearing response nor targetward relative crossflow is
present. Both joints share that one response release, while the established
carrier, raw-bearing mean steering/reserve, base asymmetry, assisting-moment
credit, and coherent maximum-joint-speed release remain fixed.

Expected evidence after evaluation: retain target capture and the recognizable
redirect/upstream route; improve on the parent's `34.7105` arrival or
`1.62283L` mean distance while reducing the crossflow-only child's
`85.04/1244.16` load. Reject the mechanism if capture is lost, mean distance
regresses beyond the parent, or force/moment remain at the crossflow-only level
without a meaningful arrival benefit. The current worker does not claim this
unevaluated candidate has met those criteria.

bookshelf_consulted: true
source_domain: biological burst turning, closed-loop robotic-fish modulation, and wake-adaptive swimming
source_mechanism: release a strong transient turn when observed directional response appears, while separating slow route error from fast wake response
transferable_invariant: keep persistent target geometry in charge of mean steering and withdraw only surplus redirect authority when either kinematic closure or assisting environmental motion is observed
nontransferable_details: species-specific C-start shapes, published gains and frequencies, full-body kinematics, exact vortex phase, cylinder geometry, and task-specific routes
policy_translation: form bounded response credits from normalized body-frame bearing-window rate and relative crossflow; combine them as a smooth union and apply it only to the shared optional two-joint half-cycle burst
falsification: reject if target reach or route compactness is lost, or if the union fails to lower load relative to the crossflow-only child without preserving a meaningful arrival or distance benefit over the parent
