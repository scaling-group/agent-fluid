# Wake-policy candidate notes

## Evidence diagnosis before policy edit

All four sampled rollouts report direct uniform still-water initialization,
`U_infinity=[0,0,0]`, no cylinders, and no prewarm. The combined top-down and
oblique sheets therefore show self-propelled motion rather than imposed-flow
advection.

- The assigned prefill (`solver_11b4bfcdc026`) forms a strong alternating
  reverse-street wake and advances toward the target, but the path bends into
  a broad upward U-turn. It is closest at `7.186L` near `13.255T`, then leaves
  through the upper boundary at `15.648T`, `7.570L` away, with world velocity
  approximately `(-0.386, 0.503) L/T`. The terminal keyframes show coherent
  propulsion continuing while the centerline turns away; the failure is
  steering topology rather than missing thrust.
- The course-residual one-sided-relief policies (`solver_324d10ed189d` and
  `solver_c0ba6ee601b1`) retain similarly coherent top-down and oblique wakes
  and improve closest approach to `5.144L` and `5.086L`, respectively. Both
  nevertheless pass their closest point and leave through `y=15.20L` around
  `19T`; shrinking the anterior carrier during redirection does not change
  that termination class.
- The response-gated redirect (`solver_e44c6b14905f`) is the sole sampled
  semantic success. Its sheets show the carrier wake surviving a decisive
  downward course correction and a direct approach, and the metrics confirm
  capture at `16.291T` and `0.746L` rather than a visually plausible near
  miss. At capture its velocity is approximately `(-0.927,-0.608) L/T`.
  This success is actuator-heavy: at least one acceleration is clipped in
  about `79.3%` of trace samples, with posterior clipping in `60.4%`, so it is
  evidence for the redirect structure but not for energetic or load
  efficiency.

The inherited optimizer logs show a progression from `11.860L` and `11.465L`
upper exits to a `7.558L` exit and finally this capture. Together with the
sampled policies, that supports adopting the semantic mechanism change while
leaving its demonstrated cruise carrier intact.

## Policy hypothesis

Replace the prefill's speed-blended exact-course steering with the sampled
response-gated posterior redirect. Normalized forward body speed establishes
when course is reliable; a large body-frame target-versus-course residual then
opens a stronger bounded posterior mean bend and removes only the opposing
wave lobe. Closing the gate on measured course realignment preserves a
state-feedback release with no clock or route. The falsifiable expectation is
capture with a coherent alternating wake, not merely another lower-distance
upper exit. Failure to capture, loss of the traveling wake, or an unstable or
left-domain termination falsifies the candidate. The known high acceleration
limit residence remains a separate negative boundary for later efficiency or
robustness work.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG turning and direction tracking
source_mechanism: sensor feedback gates a bounded turn modulation around an existing rhythmic carrier
transferable_invariant: apply strong redirection only for a large observed target-response mismatch and release it continuously when measured course realigns
nontransferable_details: published gains, robot morphology, oscillator timing, species kinematics, and task-specific paths
policy_translation: use normalized body-frame forward speed and target-versus-course error to gate posterior mean curvature and attenuation-only opposing-lobe relief in the two-joint state-feedback policy
falsification: reject if the translated gate loses wake coherence, fails capture, becomes unstable, or reproduces the sampled upper-boundary overshoot
