# Replicated response-triggered C-bend candidate

## Evidence diagnosis recorded before the policy edit

- Every inspected rollout uses direct uniform `U_infinity=(0,0,0)`
  initialization, no cylinders, and no prewarm. In the best sampled sheet and
  the inherited delayed-capture sheet, the top-down rows show body-led motion
  and alternating shed vorticity; the oblique rows show corresponding compact
  three-dimensional Lambda2 structures. The fish is self-propelled rather
  than advected by background flow or moving-window transport.
- The strongest sampled policy is the response-triggered distributed C-bend
  with an explicit componentwise acceleration projection. Its identical
  policy hash captures twice at `19.2335T` and `19.2830T`, with scores
  `-0.17657` and `-0.18218`. The stronger replication has mean distance
  `2.065L`, body-speed RMS `0.696U`, local-flow magnitude RMS `0.0180U`,
  force-magnitude RMS `0.01322`, and moment RMS `0.00690`. Its top-down wake
  remains alternating through the direct approach, and the oblique row shows
  finite, compact lateral structures rather than a wake collapse.
- The assigned collision-course-gated parent also captures, but later at
  `19.7835T`, with a worse score (`-0.20824`) and mean distance (`2.098L`).
  Its predicted-miss gate therefore adds no sampled semantic benefit over
  sustained response-conditioned anterior route closure.
- Two allocation results bound the tempting load-reduction transfer. Moving
  only sign-coherent posterior mean curvature forward without changing total
  slow curvature captures at `20.0200T` and lowers action RMS from
  `25.19/28.56` to `15.71/18.97 rad/T^2`, but worsens score to `-0.26977` and
  weakens the late wake. Restricting that transfer to a smooth near-range gate
  is a stronger negative result: the fish passes at `1.62L` near `20T`, loops
  out to `7.35L`, and captures only at `49.742T` (score `-1.38708`, mean
  distance `3.337L`, 687 moving-window shifts). Its top-down and oblique rows
  show a broad turn away from the target after the first pass, not a terminal
  hold. The longer route also raises local-flow magnitude RMS to `0.0278U`.
- Explicit policy projection is retained as contract clarity, not credited as
  the cause of the replicated timing difference: the episode applies the same
  componentwise limit. The sampled bounded policy still spends about
  `44.9--47.8%` of anterior rows and `73.6--74.9%` of posterior rows at that
  boundary, so this selection is a route-reliability baseline rather than an
  efficiency claim.

## Policy hypothesis recorded before editing

Replace the weaker collision-course gate with the twice-sampled,
response-triggered distributed C-bend exactly as evaluated. Keep the
joint-state oscillator, posterior lag, normalized body-frame bearing and LOS
rate, phase-conditioned yaw response, sustained anterior oscillator-center
shift, posterior mean correction, and explicit physical acceleration
projection. Do not add another distance or predicted-miss gate: current
evidence shows that memoryless terminal allocation can turn the first close
pass into a long orbit even while conserving instantaneous total curvature.

Expected evidence is another finite capture near the replicated
`19.23--19.28T` band, a direct target approach, and a coherent alternating
wake. Reject the selection as a robust baseline if it loses capture, arrives
later than the parent's `19.7835T`, or materially exceeds the sampled
force/moment and acceleration-boundary bands. Later load reduction should use
a mechanism that is response-aware across a beat or preserves the evaluated
route, not another instantaneous normalized-range allocation gate.

bookshelf_consulted: true
source_domain: Lighthill reactive-thrust allocation, sensor-modulated robotic-fish CPG steering, and continuous terminal-approach control
source_mechanism: retain posterior phase-lagged propulsion while modulating slow steering from observed route response without opening terminal closure
transferable_invariant: preserve the coherent traveling bend and keep observed target-response steering closed through interception; actuator allocation is acceptable only when route behavior, not merely instantaneous curvature, is preserved
nontransferable_details: analytical force coefficients, published gains, species envelopes, robot linkage geometry, dimensional frequencies, exact vortex phases, and task-specific routes
policy_translation: use normalized body-frame bearing and LOS rate to sustain the evaluated anterior center shift and posterior correction within the two-joint state-feedback carrier and physical acceleration envelope; reject the falsified near-range allocator
falsification: reject if capture is lost, arrival is later than `19.7835T`, the direct approach becomes a broad orbit, wake coherence degrades, or loads and acceleration-boundary occupancy leave the sampled finite band

## Validation status

- The guidance material-delta check and solver edit-boundary check pass.
- The mandated lightweight Julia contract probe passes. Static schema checking
  confirms every direct `params.FIELD` reference is returned by
  `target_policy_params()`.
- A deterministic 1,000-state audit confirms finite bounded outputs,
  reflection equivariance, and a finite fallback for non-finite observations.
- No CFD is run in this workspace; the new candidate's outcome is not claimed.
