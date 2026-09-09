# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before the policy edit

- The shared prewarm sheet shows the held fish above and downstream of four
  developed, interacting vortex streets. It is the common initial condition,
  not candidate-specific evidence. The released sheets for both distinct
  sampled mechanisms show active posterior traveling bends, prompt targetward
  rotation, a compact diagonal wake crossing, and direct first entry into the
  `0.75L` capture circle. No sampled sheet shows collision approach, a terminal
  near miss, or a wake-induced turn reversal that would justify cancelling
  local crossflow.
- The bearing-conditioned `40/60 -> 35/65` curvature-allocation sample reaches
  at `35.0625` released time with `1.73388L` mean distance, `50,174.96` total
  command energy, `56.57` lateral-force RMS, and `793.76` moment RMS. It is the
  lower-load successful reference and confirms that posterior redistribution
  can preserve the propulsive scaffold.
- The assigned posterior-wave half-cycle parent keeps that scaffold and applies
  at most `8%` additional gain to the target-helping posterior half-cycle. Its
  visibly tighter redirect improves capture to `32.4720`, mean distance to
  `1.64761L`, and total command energy to `46,287.66`. The gain is not load
  relief: lateral-force RMS rises to `68.70` and moment RMS to `931.60`, while
  both joints still touch the `260 deg/time` speed and `1800 deg/time^2`
  acceleration limits.
- Three completed sampled policies contain the same half-cycle equations and
  reproduce the same arrival, distance, effort, force, and moment values. They
  establish deterministic materialization at the shared wake snapshot, not
  three independent semantic improvements. The next candidate therefore adds
  one observable response gate instead of replaying the mechanism or changing
  a scalar gain.
- The inherited alternative that gates curvature allocation by beat side still
  captures but regresses to `35.4310` arrival and `1.75151L` mean distance while
  lowering force/moment RMS to `50.01/741.22`. Thus half-cycle placement is a
  real actuator-structure choice: the faster posterior-wave asymmetry and the
  lower-load curvature asymmetry are not interchangeable.
- The inherited bearing-trend failure lost the traveling bend, moved downstream,
  exited after about `16.96`, and never approached inside `12.424L`, with only
  `0.140/0.163 rad` peak joint excursions. This candidate does not feed a route
  derivative into either oscillator center and never suppresses the base
  posterior traveling wave.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: biological burst redirect and sensor-modulated robotic-fish CPG control
source_mechanism: apply strong bounded steering while direction error persists, then release the extra steering contribution as observed targetward heading response develops
transferable_invariant: target-relative geometry should request the turn while measured body response should prevent a transient steering boost from remaining fully active after the requested rotation is already occurring
nontransferable_details: C-start timing, published feedback gains, dimensional turn rates, species or robot kinematics, exact vortex phases, fixed routes, and source actuator layouts
policy_translation: preserve the filtered body-frame bearing, bounded shared curvature, oscillator, posterior lag, and state-inferred helpful half-cycle; normalize heading rate by oscillator frequency and smoothly relieve only the extra posterior half-cycle gain when its sign is already reducing the bearing error
falsification: reject the response gate if direct capture is lost or later than the `32.472` parent, mean distance worsens, force and moment RMS do not fall, the early targetward redirect weakens materially, or held-out wake conditions reveal the assumed bearing/heading-response sign to be wrong

## Candidate hypothesis

Produce exactly one response-gated posterior half-cycle candidate. The
completed parent's `0.55`-period, `28 deg` oscillator, filtered bearing,
`12 deg` total-curvature request, bearing-conditioned allocation, posterior
lag, and `8%` maximum turn-helping half-cycle boost remain intact. The only new
mechanism is a smooth feedback release: the extra boost is unchanged when the
fish is not yet rotating targetward and is relieved by at most one half as
targetward heading rate becomes appreciable relative to the oscillator rate.
The base traveling wave and mean-curvature command are never relieved.

The downstream evaluation should retain the parent's fast compact capture
while reducing its force/moment penalty and saturation residence. Arrival,
mean distance, load RMS, command effort, and trajectory topology must be read
together; no new CFD result is claimed by this worker.
