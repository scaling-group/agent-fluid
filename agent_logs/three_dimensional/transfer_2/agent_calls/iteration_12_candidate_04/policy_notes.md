# Wake-policy candidate notes

## Evidence diagnosis

All four sampled rollouts are valid direct-uniform still-water evaluations
(`U_infinity=0`) and terminate in capture. Three identical v27 samples capture
at `24.580T` and `0.74697L`; the assigned v28 parent captures at `24.618T` and
`0.74872L`. The combined sheets show the same self-propelled trajectory in both
top-down vorticity and oblique Lambda2 views: a coherent alternating wake is
maintained through the long approach and tight terminal bend, with no passive
background advection or visible 3D instability. No sampled image is a failure,
so v28 is the most informative contrasting capture; inherited failure evidence
supplies the earlier `1.076L` upper-exit boundary.

The v28 stroke-aware priority release is a useful load-control mechanism even
though its scalar score is `0.00208` lower than v27. Relative to v27 it retains
semantic capture while reducing posterior `45 deg` hard-stop occupancy from
`23.38%` to `12.60%`, peak normalized lateral force from `0.178` to `0.118`,
and peak normalized yaw moment from `0.143` to `0.089`. Raw acceleration
exceedance (`72.84%` to `72.65%`) and joint-rate limiting (`15.15%` to `15.10%`)
barely change. The trajectories first diverge only at `18.5625T`, `4.102L`,
when posterior angle passes the `36 deg` guard. Thus the evidenced approach and
course-preview capture mechanism are dormantly preserved upstream.

The remaining defect is specifically anti-windup, not missing turn magnitude:
v28 still holds the posterior joint at `-45 deg` for 564 samples, and `99.65%`
of those hard-stop samples command acceleration farther outward. More sector
gain, another recapture term, or another scalar change to the priority gate is
therefore unsupported.

## Candidate hypothesis

Retain v28's successful course preview, bounded steering priority, and
stroke-aware gate. Add one posterior stroke-phase release after allocation:
inside the existing `36--44 deg` guard, leave inward commands untouched, but
continuously replace only the outward command by the bounded inward component
of the traveling-wave carrier plus a small proportional return reserve. The
release uses observed posterior angle and current state-feedback carrier only;
it is reflection-equivariant, has no time/route state, cannot increase the
acceleration envelope, and is exactly dormant before the evidenced `4.102L`
divergence point.

Expect this to preserve capture and the coherent far wake while shortening the
remaining hard-stop plateau and avoiding an outward command against the stop.
Falsify it if formal CFD loses capture, changes the far path, fails to reduce
v28's `12.60%` hard-stop occupancy, raises v28's `0.118/0.089` peak
lateral-force/yaw-moment class, or materially worsens the `24.618T` arrival and
`2.362L` score-integral distance.

bookshelf_consulted: true
source_domain: Lighthill elongated-body propulsion and robotic-fish CPG phase-lag modulation
source_mechanism: posterior lag sustains a directional traveling bend, while persistent mean curvature that removes the returning half-cycle degrades propulsion
transferable_invariant: preserve a bounded inward posterior carrier phase instead of continuing to drive a saturated tail farther outward
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, full-body waves, and exact wake or vortex phase
policy_translation: use normalized posterior joint-stroke proximity and the existing two-joint state-feedback carrier to project only outward tail acceleration into a bounded inward release
falsification: reject if capture or far-path dormancy is lost, or if hard-stop occupancy and peak load class do not improve over v28
