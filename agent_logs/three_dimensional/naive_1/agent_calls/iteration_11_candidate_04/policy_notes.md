# Candidate diagnosis and policy hypothesis

## Evidence read before editing

- The assigned parent is the full-angle, distance-and-error-gated opposite-sign
  posterior rudder candidate. No inherited `logs/optimize/` artifact was present
  in this rendered workspace, so there is no unevaluated inherited claim to
  treat as evidence.
- All four sampled diagnostics report direct uniform initialization with
  `U_infinity=(0,0,0)`, no cylinders, and no prewarm snapshot. Motion is
  therefore self-propelled rather than background advection.
- The combined top-down and oblique sheets show a coherent alternating planar
  vortex street and three-dimensional Lambda2 structures for both the captured
  parent and the informative lower-exit failures. The failures remain actively
  propelled but pass below the target and carry their wake to the lower virtual
  boundary; they do not fail through a collision or a visibly collapsed gait.
- The assigned parent is the only sampled semantic success: it captures at
  `24.3375T`, improves `12.3277L` to `0.749625L`, and has mean distance
  `2.2243L`. Its top-down trajectory first passes below the target, then bends
  target-side while the oblique row retains an alternating wake through
  capture. The raw trace remains within the sampled load envelope
  (`max |Fy|=0.02838`, `max |Mz|=0.01638`) but spends about `69.1/29.4%` of
  samples beyond the external anterior/posterior acceleration cap before
  clipping; this candidate must not add an unbounded acceleration residual.
- Reconstructed normalized body-frame geometry shows that the parent's
  posterior rudder first exceeds `0.01 rad` at `10.818T`, `7.330L`, and full
  target error `0.519 rad`; it exceeds `0.20 rad` by `12.969T`, `6.202L`, and
  `0.792 rad`. This pre-miss recruitment is materially earlier than the sampled
  same-sign C-bend, which begins near `19.83T/3.733L` and still exits low.
  From `20--24T` the parent has anterior/posterior mean angles about
  `+0.227/-0.360 rad` and mean yaw rate `-0.141 rad/T`, demonstrating that the
  opposite-sign posterior load supplies the useful turn pathway without
  erasing the carrier. Instantaneous target-signed yaw is already strong near
  `16--20T`, yet later reverses within the beat; a response-dependent release
  can therefore be tested without weakening authority when the response is
  absent or wrong-signed.

## One-candidate hypothesis

Preserve the captured parent's oscillator, anterior slip-aware center,
full-angle gate, half-cycle redistribution, and opposite-sign posterior rudder.
Add only a bounded measured-response release: normalize `state.heading_rate`,
detect yaw whose sign is already reducing the target-side turn request, and
smoothly use that response to (a) release a small fraction of the static rudder
and (b) restore the same small fraction of the relieved posterior carrier.
Wrong-signed or vanishing yaw produces zero release and immediately recovers
the complete captured-parent rudder. This is intended to convert established
curvature into propulsion rather than stack more steering acceleration.

Falsify the mechanism if formal CFD loses capture, arrives later than
`24.3375T`, weakens the coherent terminal wake, exceeds the sampled
`0.0284/0.0164` force/moment envelope, or materially increases command or
rate-cap occupancy. A retained or earlier capture with stronger closing speed
after correct yaw and no load growth supports the transfer.

bookshelf_consulted: true
source_domain: biological burst redirection and closed-loop robotic-fish CPG turning
source_mechanism: release strong bounded curvature into the propulsive rhythm after sensed heading response
transferable_invariant: maneuver authority should be state-gated by target geometry and measured turn response, then return continuously toward the traveling carrier
nontransferable_details: species-specific C-start shapes, published oscillator gains, dimensional yaw rates, exact beat phases, and task-specific routes
policy_translation: use full normalized body-frame target sign and normalized observed heading rate to partially exchange posterior rudder offset for carrier recovery only during correct-sign yaw
falsification: reject if capture is lost or delayed, the alternating wake weakens, wrong-sign yaw persists, or saturation and hydrodynamic loads rise beyond the sampled parent envelope
