# Wake-policy candidate notes

## Evidence diagnosis

- The four sampled solver examples are exact same-prewarm reproductions: their
  released keyframe sheets have the same hash and all reach the `0.75L` target
  in `34.7105`, with `1.62283L` mean distance and head displacement
  `(-10.923,-4.166)L`. No sampled failure keyframe sheet is available in this
  workspace, so the target-blind downward exit, wrong-sign early exit, and
  unstable low-effort carrier are used only as inherited textual boundaries.
- The shared prewarm sheet shows the fish held at the upper-right while four
  interacting vortex streets develop. After release, the successful sheet
  shows a sharp down-left redirect, followed by a coherent leftward traverse
  into the developed wake and capture behind the second row. Mean world-frame
  streamwise fish velocity is `-0.3132`, compared with mean local flow
  `-0.2018`, so the leftward progress is not passive advection alone.
- The useful traverse coexists with substantial alternating disturbance and
  actuator pressure: RMS relative crossflow is `0.24023`, force/moment RMS is
  `68.96/1036.40`, both joints reach the `260 deg/time` speed limit, and both
  commands reach the policy's `30.0` envelope. The visible path does not show
  a persistent wrong-sign turn that would justify changing mean steering.
- Recent inherited alternatives sharpen the boundary. Replacing bearing-window
  closure with direct heading rate arrived only `0.0385` sooner and used less
  total effort, but worsened mean distance and raised force/moment RMS to
  `91.30/1389.74`. A second previous-command pressure gate retained capture but
  regressed arrival, route, effort, crossflow, and loads. Therefore this
  candidate preserves the carrier, raw-bearing route request, course-slip
  damping, base half-cycle asymmetry, bearing-window closure, signed-moment
  credit, and coherent two-joint speed release.

## Policy hypothesis

Add one semantically direct hydrodynamic-assistance cue to the optional redirect
burst only. A targetward normalized lateral body force is fast evidence that
the fluid/body interaction is already producing useful lateral response. Fold
a capped force credit into the existing signed-moment response, so useful force
releases only surplus half-cycle burst; opposing force retains the established
authority, and propulsion, mean steering, reserve, and base asymmetry cannot be
removed. This should preserve capture and the redirect-and-traverse topology
while reducing redundant burst action and lateral/yaw load or limit contact.
The force scale is `1.0`: the sampled world-frame lateral-force RMS divided by
`L=64` is approximately `1.08`, so this is an order-one normalization rather
than a published gain. Force credit is capped at `0.50` so it supplements,
rather than replaces, the already evidenced signed-moment response.

Reject the mechanism if capture is lost, the route or arrival materially
regresses, force/moment load does not improve meaningfully, or the force cue
merely tracks self-generated beat load and causes premature burst withdrawal.
A changed wake phase is still required before making any robustness claim.

bookshelf_consulted: true
source_domain: Karman-gait and wake-adaptive swimming; sensor-modulated robotic-fish control
source_mechanism: preserve beneficial wake-induced motion and modulate only a residual maneuver channel with measured hydrodynamic response
transferable_invariant: separate the persistent target request from fast disturbance response, and yield optional effort when a bounded body-frame load already assists the requested motion
nontransferable_details: species kinematics, published gains, exact vortex phase, single-cylinder synchronization, full-body waveforms, and task-specific routes
policy_translation: retain the proven two-joint carrier and target steering; add a capped targetward `force_body_L[2]` credit beside signed moment when releasing only the extra response-gated half-cycle burst
falsification: reject if target reach or route compactness is lost, if force/moment or limit contact does not improve, or if changed wake phase exposes mistimed release
