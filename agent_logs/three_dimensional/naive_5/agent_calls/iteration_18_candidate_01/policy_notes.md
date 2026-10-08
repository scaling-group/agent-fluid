# Candidate diagnosis and hypothesis

## Evidence read before editing

- All four sampled evaluations report direct-uniform quiescent initialization
  (`U_infinity=0`) and capture. Three are byte-identical executions of the
  prefilled line-of-sight-response policy: `0.749769L` at `27.6045T`.
- In both the top-down vorticity row and oblique Lambda2 row, that baseline
  self-propels with an organized alternating wake, keeps a continuous
  target-directed route, then bends sharply into the capture circle. The
  moving storage window follows rather than visibly advecting the fish.
  However, the trace contains three posterior contacts at `45 deg`, 1,183 of
  10,038 joint-speed samples at the speed cap, 1,878 of 10,038 actions at the
  policy acceleration clamp, and peak planar force/yaw moment of about
  `0.03397/0.01548`.
- The sampled stopping-margin guard preserves the same coherent topology in
  both views and still captures (`0.749992L` at `27.7695T`), while removing all
  angle contacts, reducing speed-cap samples to 1,124 of 10,098 and
  acceleration-clamp samples to 1,700 of 10,098, and lowering peak planar
  force/yaw moment to about `0.02212/0.01041`. Its small score increase from
  `-0.710392` to `-0.709920` is secondary to those safety improvements.
- No sampled failure keyframe is present in this workspace: every available
  combined sheet is a capture, and three sheets are duplicates. The inherited
  failure comparison is therefore limited to its curated visual/metric digest
  and score logs. Those show coherent terminal traveling-bend and recoil
  variants missing at `0.83--0.88L` and exiting left, so altering the evidenced
  target-line response or adding another terminal waveform is unsupported.
  The inherited parent log also reports another capture (`0.749430L`), but
  provides no trajectory, policy, or load evidence from which to infer a
  mechanism.

## Policy hypothesis

Adopt the sampled reflection-equivariant stopping-margin guard on both joints
without changing the carrier, target steering, line-of-sight response, or
posterior allocation. For an outward-moving joint only, use observed angle,
speed, and available acceleration to estimate the remaining stopping
excursion, then smoothly restrict its command toward inward braking as the
hard angle envelope becomes unreachable. This should reproduce the sampled
removal of posterior contact and lower load/clamp exposure while retaining
capture and the coherent multi-wake route. Reject the mechanism if formal CFD
loses capture, alters the unguarded wake/route, restores angle contact, or
increases speed/acceleration residence or loads. The new evaluation happens
after this worker exits and is not claimed here.

bookshelf_consulted: true
source_domain: classical reactive fish propulsion and closed-loop rhythmic robotic-fish control
source_mechanism: retain a directed traveling body bend with posterior timing, and modulate a rhythmic command only from observed state
transferable_invariant: preserve the productive traveling-wave carrier except where measured joint state makes the physical envelope nonviable
nontransferable_details: published gains, dimensional frequencies, species-specific envelopes, exact phases, and task routes
policy_translation: keep the body-frame line-of-sight controller unchanged and apply a symmetric angle-speed stopping-margin filter independently to each of the two joint accelerations
falsification: reject if the filter changes unguarded phases, loses capture or coherent propulsion, permits contact, or raises cap residence or hydrodynamic loads
